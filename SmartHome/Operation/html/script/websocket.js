 /*wss服务器地址及其参数*/
 var wssAddr='ws://101.201.209.42:8080/ldnet/evermobws';
 var wssConnect={
 	fromid:ldInfo.ws.user,
 	fromtype:'m',
	version:'1.0.8',
	clientmodel:'XXX',
	clienttype:'ddd',
	authkey:'0B51D241121C19364C9D0EC3BC8CA417',
	appid:'appid0001'
 }
 var wssUrl=wssAddr+'?'+json2str(wssConnect);

 //startWebsocket(); //启动websocket
/*将json数据转换为字符串*/
function json2str(json){
	var str='';	
	for(var name in json){
 		str+=name+'='+json[name]+'&';
	}
	return str.substring(0,str.length-1);
}
/*启动websocket程序，如果网络状态为无网络，重新检查*/
/* function startWebsocket(){
 	 if(ldInfo.netenv == 'internet'){
 		ldWebSocket();
 	}
	else if(ldInfo.netenv == 'denet'){
		startWebsocket();
	}
 }*/

 function ldWebSocket(){
	ws=new WebSocket(wssUrl); //创建WebSocket通道连接
	ws.onopen=function(){ //连接成功，APP登录服务器
		console.log('连接服务器成功'); 
		ws.send(JSON.stringify({
			"seckey":"",
			"method":"login",
			"infopackage":{
				"userId":ldInfo.ws.user,
				"password":ldInfo.ws.password,
				"mobile":"",
				"mobModel":"",
				"mobBrand":""}
			}
		))
   	}
   	/*处理中控反馈信息*/
	ws.onmessage=function(event){
		var dataPackage=JSON.parse(event.data);
		if('deviceId' in dataPackage){ //查找是否有deviceId 绑定的中控设备给发送的信息
			var items=dataPackage.feedback.items;
		 	var node=null;
			for(var i=0; i<items.length; i++)
			{
			 	if(items[i].type =='1'){  //数字量
			 		if(select("#JND_"+items[i].joinnum).size()>0){//按钮
			 			node=select("#JND_"+items[i].joinnum);
			 			node.attr("class", "JND_" + items[i].joinnum + "_" + items[i].value);
			 		
			 		}
			 		else if(select("#JNL_"+items[i].joinnum+'_0').size()>0){ //Legend
			 			var legendShow=select("#JNL_"+items[i].joinnum+'_1');
			 			var legendHide=select("#JNL_"+items[i].joinnum+'_0');
			 			if(items[i].value=='1'){
			 				legendShow.show();
			 				legendHide.hide();
			 			}else{
			 				legendShow.hide();
			 				legendHide.show();
			 			}

			 		}
			 		else if(select("#JNP_"+items[i].joinnum).size()>0){ //页面
			 			node=select("#JNP_"+items[i].joinnum);
			 			if(items[i].value == '1'){
			 				node.show();
			 			}else{
			 				node.hide();
			 			}

			 		}
			 		else if(select("#JNS_"+items[i].joinnum).size()>0) {//子页面
			 			node=select("#JNS_"+items[i].joinnum);	
			 			if(items[i].value == '1'){
			 				node.show();
			 			}else{
			 				node.hide();
			 			}
			 		}
			 		else if(select("#JND_"+items[i].joinnum+'_0').size()>0){//滑动页面 滑动到其他页面
			 			 if (pages[items[i].joinnum] && items[i].value == "1") {
		                    if (top.location.toString().indexOf(pages[items[i].joinnum]) < 0) top.location = pages[items[i].joinnum];
		                 }
			 		}
			 	} //end of items[i].type ==1
			 	else if(items[i].type =='2'){ //模拟量
			 		if(select("#JNAD_" + items[i].joinnum).size()>0){  //十进制
		                node=select("#JNAD_" + items[i].joinnum);
		                node.html(items[i].value);
			 		}else if(select("#JNAH_" + items[i].joinnum).size()>0){ //十六进制
			 			node=select("#JNAH_" + items[i].joinnum);
			 			node.html(Number(items[i].value).toString(16));

			 		}else if(select("#BJNH_" + items[i].joinnum).size()>0){ //水平标尺
			 			 if (!bjnhs[items[i].joinnum]){
			 			 	node=select("#BJNH_" + items[i].joinnum);
				 			var oSpan = $('div', node);
			                oSpan.css('width', items[i].value * node[0].offsetWidth / 65535);
			 			 }
			 		}else if(select("#BJNV_" + items[i].joinnum).size()>0){ //垂直标尺
			 			if (!bjnvs[items[i].joinnum]){
			 				node=select("#BJNV_" + items[i].joinnum);
				 			var oDiv = $('div', node);
			                oDiv.css('height', node[0].offsetHeight - items[i].value * node[0].offsetHeight / 65535);
			 			}
			 		}else if(select("#SLH_" + items[i].joinnum).size()>0){ //水平滑动条
			 			if (!slhs[items[i].joinnum]){
			 				node=select("#SLH_" + items[i].joinnum);
				 			var oSpan = $('span', node);
			                oSpan.css('left', items[i].value * node.width() / 65535 - (oSpan.width() / 2 | 0) + 'px');
			 			}
			 		}else if(select("#SLV_" + items[i].joinnum).size()>0){ //垂直滑动条
			 			if (!slvs[items[i].joinnum]){
			 				node=select("#SLV_" + items[i].joinnum);
				 			var oSpan = $('span', node);
			                oSpan.css('top', (65535 - items[i].value) * node.height() / 65535 - (oSpan.height() / 2 | 0) + 'px');
			 			}
			 		}

			 	} //end of items[i] == 2
			 	else if(items[i].type =='3'){ //串行量
			 		if(select("#DTEXT_" + items[i].joinnum).size()>0){  //动态文本
			 			 if (!(noDtext.noDtext)){
			 			 	node=select("#DTEXT_" + items[i].joinnum);
			 				node.html(items[i].value.replace(/ /g, "&nbsp;").replace(/\n/g, "<br>").replace(/\t/g, "&nbsp;&nbsp;&nbsp;&nbsp;"));
			 			 }
			 		}
			 	} //end of items[i] == 3
			}//end of for
		}else if('method' in dataPackage){ //查找是否有method
			switch(dataPackage.method){
				case 'login':
				if(dataPackage.result == '1004'){
					ldInfo.ws.seckey=dataPackage.backinfo[0].seckey;
					console.log('用户登录成功');
					console.log(ldInfo.ws.seckey);

				}else if(dataPackage.result == '4010'){
					console.log('用户ID不存在');
				}
				break;
				case 'send2D':
				if(dataPackage.result == '1001'){
					console.log('给中控发送信息成功');
				}
				else if(dataPackage.result == '4013'){
					console.log('设备和用户不存在绑定关系');
				}
				else if(dataPackage.result == '4005'){
					console.log('该设备不在线');
				}
				break;
				default:
				break;
			}
		}
		console.log(dataPackage);
	 
	} //end of ws onmessage
    
    /*监听连接通道断开事件，通道断开重新连接服务器*/
	ws.onclose = function(){ 
	      console.log("Connection is closed..."); 
	      setTimeout(ldWebSocket,3000);
	} // end of onclose    

	ws.onerror=function(){
		console.log('wss服务发生错误');
	}

};//end of ldWebSocket




				