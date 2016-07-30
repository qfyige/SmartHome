function sendJoinNumber(jn) {
    callWithJoinNumber(1, jn, 2);
}

function sendJoinNumberDown(jn) {
    callWithJoinNumber(1, jn, 1);
}

function sendJoinNumberUp(jn) {
    callWithJoinNumber(1, jn, 0);
}

function sendJoinNumberAnalog(jn, val) {
    callWithJoinNumber(2, jn, val);
}

function sendJoinNumberSeral(jn, val) {
    callWithJoinNumber(3, jn, val);
}

function callWithJoinNumber(type, jn, value) {
    if( window.parent.ldInfo.netenv == 'internet'){ //网络环境为互联网
          window.parent.ws.send(JSON.stringify({
            "seckey": window.parent.ldInfo.ws.seckey,
            "method":"send2D",
            "toid": window.parent.ldInfo.ws.devid,
            "infopackage":{
              "operation":{
                type:type,
                joinnum:jn,
                value:value,
                },"userId": window.parent.ldInfo.ws.user}
              }));
      }
    else if( window.parent.ldInfo.netenv == 'lan'){ //局域网通过Ajax通信，服务器加一个cross header来解决跨域问题
        $.ajax({
            url: window.parent.ldInfo.devip+'cgi-bin/jn.cgi',
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: ({
                t: type,
                n: jn,
                v: value,
                cur_time: new Date().getTime()
            }),
            success: function(data) {}
        });  
      }
      else if( window.parent.ldInfo.netenv =='denet'){//网络环境为无网络
        console.log('no net'); //无网络
      }
}