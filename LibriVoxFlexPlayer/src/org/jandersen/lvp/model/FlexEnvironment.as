package org.jandersen.lvp.model
{
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import org.jandersen.lvp.services.ProxyHTTPService;
	
	public class FlexEnvironment implements IEnvironment
	{
		public function get HTTPServiceClass():Class
		{
			return ProxyHTTPService;
		}
		
		public function get filesystemEnabled():Boolean
		{
			return false;
		}
		
		public function getSound(url:String):Sound{
			return new Sound(new URLRequest(ProxyHTTPService.PROXY_PATH + "?url=" + escape(url)));
		}
		
	}
}