package fish.core
{
	import fish.logging.log;
	import fish.manager.DragDropManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	public class FrameCallLater implements ICalllater
	{
		private static var instance:FrameCallLater = new FrameCallLater();
		
		private static var frames:int = 0;
		
		public static const REAL_TIME:int = 1;
		public static const HIGH:int = 2;
		public static const LOW:int = 4;
		public static const PROCESS:int = 8;
		
		public static function setRate(count:int):void
		{
			frames = count;
		}
		
		public static function call(name:String, method:Function):void
		{
			instance.callLater(name, method);
		}
		
		public static function registStage(value:Stage):void
		{
			if(value != null && value is IEventDispatcher) {
				instance.stageDict[value] = true;
				value.addEventListener(Event.ENTER_FRAME, instance.callLaterHandler);
				
				DragDropManager.stage = value;
			}
		}
		
		public static function unregistStage(value:Stage):void
		{
			if(value != null) {
				value.removeEventListener(Event.ENTER_FRAME, instance.callLaterHandler);
				delete instance.stageDict[value];
			}
		}
		
		protected var stageDict:Dictionary;
		protected var methods:Dictionary;
		
		private var isCallRelease:Boolean = false;
		
		public function FrameCallLater()
		{
			stageDict = new Dictionary(true);
			methods = new Dictionary();
		}
		
		public function callLater(name:String, method:Function):void
		{
			methods[name] = method;
		}
		
		public var count:Number = 0;
		public function callLaterHandler(event:Event):void
		{	
//			count++;
//			if(count % frames != 0) {
//				return;
//			}
//			count = 0;
			
			isCallRelease = true;
			
//			while(methods.length > 0) {
//				(methods.shift() as Function)();
//			}
			
			for(var key:String in methods) {
				(methods[key] as Function)();
				methods[key] = null;
				delete methods[key];
			}
			
			isCallRelease = false;
			
			for(var stage:Object in stageDict) {
				Stage(stage).invalidate();
			}
		}
	}
}