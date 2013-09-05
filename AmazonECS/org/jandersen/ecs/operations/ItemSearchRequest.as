package org.jandersen.ecs.operations
{
	import org.jandersen.ecs.util.SearchIndex;
	
	public class ItemSearchRequest extends AWSRestRequestBase
	{
		
		public var index:SearchIndex;
		public var keywords:String;
		public var title:String;
		
		
		public function ItemSearchRequest(i:SearchIndex){
			super("ItemSearch");
			index = i;
		}
		
		protected override function addParameters(params:Object):void{
			super.addParameters(params);
			params['Keywords'] = keywords;
			params['SearchIndex'] = index.toString();
			params['Title'] = title;
		}
		
	}
}