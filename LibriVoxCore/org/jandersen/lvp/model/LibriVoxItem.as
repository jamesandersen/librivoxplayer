package org.jandersen.lvp.model
{
	import flash.events.EventDispatcher;
	

	public class LibriVoxItem extends EventDispatcher
	{
		
		
		
		public var itemXML:XML;
		public var title:String;
		public var description:String;
		public var guid:String;
		public var author:String;
		public var selected:Boolean;
		public var zipURL:String;
		public var zipMB:Number;
		
		protected var _detailsLoaded:Boolean = false;
		
		public function LibriVoxItem(xml:XML = null){
			itemXML = xml;
			if(itemXML != null){
				guid = itemXML.guid;
				description = itemXML.description;
				var re:RegExp = /(.*) by (.*)/;
				var result:Object = re.exec(itemXML.title);
				if(result == null){
					title = itemXML.title;
				}else{
					title = result[1];
					author = result[2];
				}
			}
			
		}
		
		public function isFullyLoaded():Boolean{
			return _detailsLoaded;
		}
		
		public function loadFromHTML(html:String):void{
			var result:Object = /"([^"]*)">\s*[zZ]ip.*(|<\/a>)\s*\(([^\)]*?)([GMB]{1,2})\)/.exec(html);
			if(result != null){
				zipURL = result[1];
				zipMB = parseFloat(result[3]);
				if(String(result[4]).indexOf("G") > -1) zipMB *= 1024;
			}
			
			_detailsLoaded = true;
		}
		
		private static function extractString(re:RegExp, str:String, matchIndex:int = 0):String{
			var result:Object = re.exec(str);
			if(result != null){
				return result[matchIndex];
			}else{
				return null;
			}
		}
	}
}