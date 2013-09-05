package org.jandersen.lvp.model
{
	import flash.media.Sound;
	
	public interface IEnvironment
	{
		function get HTTPServiceClass():Class;
		
		function get filesystemEnabled():Boolean;
		
		function getSound(url:String):Sound;
	}
}