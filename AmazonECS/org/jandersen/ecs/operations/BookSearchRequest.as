package org.jandersen.ecs.operations
{
	import org.jandersen.ecs.util.SearchIndex;
	
	public class BookSearchRequest extends ItemSearchRequest
	{
		
		public var author:String;
		
		public function BookSearchRequest(){
			super(SearchIndex.BOOKS);
			
		}
		
		protected override function addParameters(params:Object):void{
			super.addParameters(params);
			params['Author'] = author;
		}
	}
}