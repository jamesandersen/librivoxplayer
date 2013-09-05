package org.jandersen.lvp.services
{
	import mx.rpc.http.HTTPService;
	import mx.rpc.AsyncToken;
	import mx.controls.Alert;

	public class ProxyHTTPService extends HTTPService
	{
		public static const PROXY_PATH:String = "http://wh.jandersen.org/cw/Proxy.php";
		
		/*
		public override function send(parameters:Object=null):AsyncToken{
			var tmpURL:String = url;
			url = PROXY_PATH;
			if(parameters == null) parameters = new Object();
			parameters.url = tmpURL;
			//Alert.show(parameters.url);
			var call:AsyncToken = super.send(parameters);
			url = tmpURL;
			return call;
			
		}
		*/
	}
}