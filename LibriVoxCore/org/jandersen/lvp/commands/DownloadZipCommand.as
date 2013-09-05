package org.jandersen.lvp.commands
{
	import org.jandersen.lvp.model.LibriVoxItem;
	import com.adobe.cairngorm.control.CairngormEvent;
	import mx.controls.Alert;
	
	public class DownloadZipCommand extends AbstractLVCommand
	{
		
		public override function execute(event:CairngormEvent):void{
			if(event.data is LibriVoxItem){
				Alert.show(LibriVoxItem(event.data).zipURL);
			}
		}
	}
}