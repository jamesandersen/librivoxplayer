package org.jandersen.lvp.model
{
	public class SearchPanelState
	{
		public static const SIMPLE_SEARCH:SearchPanelState = new SearchPanelState("");
		public static const ADV_SEARCH:SearchPanelState = new SearchPanelState("advSearch");
		public static const RESULTS:SearchPanelState = new SearchPanelState("searchResults");
		
		[DefaultProperty] [Bindable]
		public var name:String;
		public function SearchPanelState(n:String){
			name = n;
		}
	}
}