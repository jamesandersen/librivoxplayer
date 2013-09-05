package org.jandersen.lvp.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import mx.rpc.IResponder;
	import com.adobe.cairngorm.commands.ICommand;
	import org.jandersen.lvp.model.LibriVoxModel;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;

	public class AbstractLVCommand implements ICommand, IResponder
	{
		protected var _model:LibriVoxModel;
		protected var _cgDispatcher:CairngormEventDispatcher;
		
		public function AbstractLVCommand(){
			_model = LibriVoxModel.instance;
			_cgDispatcher = CairngormEventDispatcher.getInstance();
		}
		
		public function execute(event:CairngormEvent):void
		{
		}
		
		public function result(data:Object):void
		{
		}
		
		public function fault(info:Object):void
		{
		}
		
	}
}