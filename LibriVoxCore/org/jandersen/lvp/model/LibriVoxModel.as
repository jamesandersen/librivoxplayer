package org.jandersen.lvp.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	
	import mx.collections.ArrayCollection;
	
	import org.jandersen.lvp.components.AudioControl;
	import org.jandersen.lvp.model.EnvironmentFactory;

	[Bindable]
	public class LibriVoxModel implements ModelLocator
	{
		protected static var _instance:LibriVoxModel = new LibriVoxModel(SingletonLock);
		public static function get instance():LibriVoxModel{
			return _instance;
		}
		public static var searchState:SearchPanelState = SearchPanelState.SIMPLE_SEARCH;
		
		public var newItems:ArrayCollection;
		public var searchResults:ArrayCollection;
		public var currentChapters:XMLList;
		public var currentImageURL:String;
		public var environment:IEnvironment;
		public var audioControl:AudioControl;
		
		public function LibriVoxModel(lock:Class){
			// Verify that the lock is the correct class reference.
	   		if ( lock != SingletonLock )
	   		{
	    		throw new Error( "Invalid Singleton access.  Use Model.instance." );
	    	}
			
			newItems = new ArrayCollection();
			searchResults = new ArrayCollection();
			environment = EnvironmentFactory.getInstance();
		}
		
				
	}
	
}

class SingletonLock{
}
