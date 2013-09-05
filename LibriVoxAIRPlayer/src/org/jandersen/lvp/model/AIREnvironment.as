package org.jandersen.lvp.model
{
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	import mx.rpc.http.HTTPService;

	public class AIREnvironment implements IEnvironment
	{
		public function get HTTPServiceClass():Class
		{
			return HTTPService;
		}
		
		public function get filesystemEnabled():Boolean
		{
			return true;
		}
		
		public function getSound(url:String):Sound
		{
			return new Sound(new URLRequest(url));
		}
		
	}
}