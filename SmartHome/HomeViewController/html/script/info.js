var INFO_QUERY_JOINT = 0;

var QUERY_STAUTS = 0; // 0: idle  1:working  2:garbage

var selectCache = {};
function select( name ){
	var result;
	if ( selectCache[ name ] ) {
		return selectCache[ name ];
	}
	result = $(name);
	if(result.length > 0){
		return selectCache[ name ] = result;
	}

	return  selectCache[ name ] = $("iframe").contents().find(name);
}

function queryAllInfo() {
    QUERY_STAUTS = 1;
    $.ajax({
        url: /*ldInfo.devip+*/'cgi-bin/info.cgi',
        data:({
            joint_info: INFO_QUERY_JOINT,
            cur_time: new Date().getTime()
        }),

        dataType: 'json',
        success: function(data) {
         
            // joint number
            if (data && data.joint) {
                item = data.joint;
                for (i = 0; i < item.items.length; i++) {
                    joint = item.items[i];

                    if (joint.type == "1") {
                        // digital joint number
                        node = select("#JND_" + joint.joinnum);
                        if (node.size() > 0) {
                            node.attr("class", "JND_" + joint.joinnum + "_" + joint.value);
                        } else {
                            // About the Legend
                            node = select("#JNL_" + joint.joinnum + "_0");
							if (node.size() > 0) {
                                modeoff = select("#JNL_" + joint.joinnum + "_0");
								modeon = select("#JNL_" + joint.joinnum + "_1");
								if (joint.value == "1") {
                                    modeon.show();
                                    modeoff.hide();
                                } else {
                                    modeoff.show();
                                    modeon.hide();
                                }
                            } else {
                                // About the SubPage
                                modeon = select("#JNP_" + joint.joinnum);
                                if (modeon.size() <= 0) modeon = select("#JNS_" + joint.joinnum);
                                if (modeon.size() > 0) {
                                    if (joint.value == "1") modeon.show();
                                    else modeon.hide();
                                } else {
                                    if (pages[joint.joinnum] && joint.value == "1") {

                                        if (top.location.toString().indexOf(pages[joint.joinnum]) < 0) top.location = pages[joint.joinnum];
                                    }
                                }
                            }
                        }
                    } else if (joint.type == "2") {
                        // analog joint number
                        node = select("#JNAD_" + joint.joinnum);
                        if (node.size() > 0) {
                            // About the Decimal Gauge
                            node.html(joint.value);
                        } else {
                            node = select("#JNAH_" + joint.joinnum);
                            if (node.size() > 0) {
                                num = Number(joint.value);
                                // About the Hex Gauge
                                node.html(num.toString(16));
                            } else {
                                node = select("#BJNH_" + joint.joinnum);
                                if (node.size() > 0) {
                                    // About the Horzitiontal Gauge
                                    if (!bjnhs[joint.joinnum]) {
                                        var span = $('div', node);
                                        span.css('width', joint.value * node[0].offsetWidth / 65535);
                                    }
                                } else {
                                    node = select("#BJNV_" + joint.joinnum);
                                    if (node.size() > 0) {
                                        // About the Vertical Gauge
                                        if (!bjnvs[joint.joinnum]) {
                                            var span = $('div', node);
                                            span.css('height', node[0].offsetHeight - joint.value * node[0].offsetHeight / 65535);
                                        }
                                    } else {
                                        node = select("#SLH_" + joint.joinnum);
                                        if (node.size() > 0) {
                                            if (!slhs[joint.joinnum]) {
                                                var span = $('span', node);
                                                span.css('left', joint.value * node.width() / 65535 - (span.width() / 2 | 0) + 'px');
                                            }

                                        } else {
                                            node = select("#SLV_" + joint.joinnum);
                                            if (node.size() > 0) {
                                                if (!slvs[joint.joinnum]) {
                                                    var span = $('span', node);
                                                    span.css('top', (65535 - joint.value) * node.height() / 65535 - (span.height() / 2 | 0) + 'px');
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else if (joint.type == "3") {
                        if (!(noDtext.noDtext)) {
                            node = select("#DTEXT_" + joint.joinnum);
                            //node.html( joint.value );
                            node.html(joint.value.replace(/ /g, "&nbsp;").replace(/\n/g, "<br>").replace(/\t/g, "&nbsp;&nbsp;&nbsp;&nbsp;"));

                        }
                    }
                }
            } // end of joint      
        },

        complete: function(data) {
            // reset timer
            QUERY_STAUTS = 0;
            // setTimeout("queryAllInfo()", 500);      
        }

    });

}