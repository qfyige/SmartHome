var SupportsTouches = ("createTouch" in document); //判断是否支持触摸
StartEvent = SupportsTouches ? "touchstart": "mousedown",
MoveEvent = SupportsTouches ? "touchmove": "mousemove",
EndEvent = SupportsTouches ? "touchend": "mouseup";
preventDefault = function(ev) { //阻止浏览器默认事件
    if (ev) ev.preventDefault();
    else window.event.returnValue = false;
}
function stopPropagation(e) { //阻止浏览器事件传递
    if (e && e.stopPropagation) e.stopPropagation();
    else window.event.cancelBubble = true;
    return false;
}
//防止正在操作滑动条的同步而设置的一个标识，当此值为真时，不会更新滑动条
if ( window.frameElement ) {
	slvs = window.parent.slvs;
	slhs = window.parent.slhs;
	bjnhs = window.parent.bjnhs;
	bjnvs = window.parent.bjnvs;
	noDtext = window.parent.noDtext;
} else {
	slvs = {};
	slhs = {};
	bjnhs = {};
	bjnvs = {};
	noDtext = {
		noDtext: false
	};
}


//为普通button添加通用事件
var elemBtns = document.getElementsByTagName('button');
if (SupportsTouches) {

    for (var i = 0,
    l = elemBtns.length; i < l; i++) {
        var num = elemBtns[i].id.substring(4);
        var click = $(elemBtns[i]).attr('onclick'); //获取按钮的onclick属性
        if (click) {
            click = click.indexOf('top.location') < 0 ? null: elemBtns[i].onclick; //如果按钮具有跳转页面功能，则获取她的跳转代码（通过她的onclick属性）
        };
        elemBtns[i].onclick = null; //将按钮的onclick设置null，目前改用按下 和 抬起事件，弃用了点击事件
        (function(num, click) {
            elemBtns[i].ontouchstart = function(e) {
                num && sendJoinNumberDown(parseInt(num));
                preventDefault(e);
				stopPropagation(e);
			
            };
            elemBtns[i].ontouchend = function(e) {
                num && sendJoinNumberUp(parseInt(num));
                var audio = this.getElementsByTagName('audio')[0]; //需找按钮下是否有audio标签，如果有抬起事件时播放这个组件
                if (audio) {
                    audio.play();
                }
                click && click(); //有过有跳转代码，则跳转
				stopPropagation(e);
				
            };
        })(num, click);
    };
} else {
    for (var i = 0,
    l = elemBtns.length; i < l; i++) {
        var num = elemBtns[i].id.substring(4);
        var click = $(elemBtns[i]).attr('onclick');
        if (click) {
            click = click.indexOf('top.location') < 0 ? null: elemBtns[i].onclick;
        };
        elemBtns[i].onclick = null; (function(num, click) {
            elemBtns[i].onmousedown = function(e) {
                num && sendJoinNumberDown(parseInt(num));
				stopPropagation(e);
				
            };
            elemBtns[i].onmouseup = function(e) {
                num && sendJoinNumberUp(parseInt(num));
                var audio = this.getElementsByTagName('audio')[0];
                if (audio) {
                    audio.play();
                }
                click && click();
				stopPropagation(e);
				
            };
        })(num, click);
    };
}
//滑动条事件定义
//横版
$("div[id ^= SLH]").each(function() {
    var slider = this;

    var span = this.getElementsByTagName("span")[0];
    slider['on' + StartEvent] = function(e) {
        preventDefault(e);
        slhs[parseInt(slider.id.substring(4))] = true;
        this.mid = parseInt(e.pageX - this.offsetLeft);
        if (this.mid >= 0 && this.mid <= this.offsetWidth) span.style.left = this.mid - (span.offsetWidth / 2 | 0) + 'px'; //滑块的中间为原点
        if (!this.timing) this.timing = setInterval(function() {
            sendJoinNumberAnalog(parseInt(slider.id.substring(4)), parseInt((span.offsetLeft + (span.offsetWidth / 2 | 0)) * 65535 / slider.offsetWidth));
        },
        200);
        this['on' + MoveEvent] = function(e) {
            preventDefault(e);
            this.mid = e.pageX - this.offsetLeft;
            if (this.mid >= 0 && this.mid <= this.offsetWidth) span.style.left = this.mid - (span.offsetWidth / 2 | 0) + "px";
            stopPropagation(e);
        }
    }
    slider['on' + EndEvent] = function(e) {
        clearInterval(this.timing);
        this.timing = null;
        this.onmousemove = null;
        sendJoinNumberAnalog(parseInt(this.id.substring(4)), parseInt((span.offsetLeft + (span.offsetWidth / 2 | 0)) * 65535 / this.offsetWidth));
        setTimeout(function() {
            slhs[parseInt(slider.id.substring(4))] = false;
        },
        100);
    }
});
//竖版
$("div[id ^= SLV]").each(function() {
    var slider = this;

    var span = this.getElementsByTagName("span")[0];
    slider['on' + StartEvent] = function(e) {
        preventDefault(e);
        slvs[parseInt(slider.id.substring(4))] = true;
        this.mid = parseInt(e.pageY - this.offsetTop);
        if (this.mid >= 0 && this.mid <= this.offsetHeight) span.style.top = this.mid - (span.offsetHeight / 2 | 0) + 'px';
        if (!this.timing) this.timing = setInterval(function() {
            sendJoinNumberAnalog(parseInt(slider.id.substring(4)), 65535 - parseInt((span.offsetTop + (span.offsetHeight / 2 | 0)) * 65535 / slider.offsetHeight));
        },
        200);
        this['on' + MoveEvent] = function(e) {
            preventDefault(e);
            this.mid = e.pageY - this.offsetTop;
            if (this.mid >= 0 && this.mid <= this.offsetHeight) span.style.top = this.mid - (span.offsetHeight / 2 | 0) + "px";
            stopPropagation(e);
        }

    }
    slider['on' + EndEvent] = function(e) {
        clearInterval(this.timing);
        this.timing = null;
        this.onmousemove = null;
        sendJoinNumberAnalog(parseInt(this.id.substring(4)), 65535 - parseInt((span.offsetTop + (span.offsetHeight / 2 | 0)) * 65535 / this.offsetHeight));
        setTimeout(function() {
            slvs[parseInt(slider.id.substring(4))] = false;
        },
        100);
    }
});
//进度条事件定义
//横版
$("div[id ^= BJNH]").each(function() {
    this.onclick = null;
    var slider = this;

    var span = this.getElementsByTagName("div")[0];
    slider['on' + StartEvent] = function(e) {
        bjnhs[slider.id.substring(5)] = true;
        preventDefault(e);
        this.mid = e.layerX;
        if (this.mid >= 0 && this.mid <= this.offsetWidth) span.style.width = this.mid + 'px';
        this['on' + MoveEvent] = function(e) {
            preventDefault(e);
            this.mid = e.layerX;
            if (this.mid >= 0 && this.mid <= this.offsetWidth) span.style.width = this.mid + "px";
            stopPropagation(e);
        }
    }
    slider['on' + EndEvent] = function(e) {
        this.onmousemove = null;
        sendJoinNumberAnalog(parseInt(this.id.substring(5)), parseInt((span.offsetWidth) * 65535 / this.offsetWidth));
        setTimeout(function() {
            bjnhs[slider.id.substring(5)] = false;
        },
        100);
    }

});
//竖版
$("div[id ^= BJNV]").each(function() {
    this.onclick = null;
    var slider = this;

    var span = this.getElementsByTagName("div")[0];
    slider['on' + StartEvent] = function(e) {
        bjnvs[slider.id.substring(5)] = true;
        preventDefault(e);
        this.mid = e.layerY;
        if (this.mid >= 0 && this.mid <= this.offsetHeight) span.style.height = this.mid + 'px';

        this['on' + MoveEvent] = function(e) {
            preventDefault(e);
            this.mid = e.layerY;
            if (this.mid >= 0 && this.mid <= this.offsetHeight) span.style.height = this.mid + "px";
            stopPropagation(e);
        }
    }
    slider['on' + EndEvent] = function(e) {
        this.onmousemove = null;
        sendJoinNumberAnalog(parseInt(this.id.substring(5)), parseInt((this.offsetHeight - span.offsetHeight) * 65535 / this.offsetHeight));
        setTimeout(function() {
            bjnvs[slider.id.substring(5)] = false;
        },
        100);
    }
});
//动态文本显示

var tagStart = /<(\w+)\s*\/?>/g,
tagEnd = /<\/(\w+)\s*>/g,
space = /&nbsp;/g;
$('p[id ^= DTEXT]').each(function() {
    this.onfocus = function() {
        noDtext.noDtext = true;
    }
    this.onblur = function() {
        var num = this.id.substring(6);
        //sendJoinNumberSeral( parseInt(num), $(this).text() );
        sendJoinNumberSeral(parseInt(num), $(this).html().replace(tagStart, "\n").replace(tagEnd, "").replace(space, " "));
        noDtext.noDtext = false;
    }
});