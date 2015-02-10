package fish.core
{
	import fish.logging.log;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	public class FrameCallLater implements ICalllater
	{
		public static const REAL_LEVEL:Number = 1;
		public static const HIGH_LEVEL:Number = 4;
		public static const LOW_LEVEL:Number = 8;
		public static const THREAD_LEVEL:Number = 16;
		
		public static var level:Number = HIGH_LEVEL;
		
		private static var instance:FrameCallLater = new FrameCallLater();
		private static var levelCount:Number = 0;
		
		public static function call(method:Function):void
		{
			instance.callLater(method);
		}
		
		public static function registStage(value:IEventDispatcher, levelInt:Number = 4):void
		{
			if(value != null && value is IEventDispatcher) {
				level = levelInt;
				levelCount = 0;
				instance.stageDict[value] = true;
				value.addEventListener(Event.ENTER_FRAME, instance.callLaterHandler);
			}
		}
		
		public static function unregistStage(value:IEventDispatcher):void
		{
			if(value != null) {
				value.removeEventListener(Event.ENTER_FRAME, instance.callLaterHandler);
				delete instance.stageDict[value];
			}
		}
		
		protected var stageDict:Dictionary;
		protected var methods:Array;
		
		private var isCallRelease:Boolean = false;
		
		public function FrameCallLater()
		{
			stageDict = new Dictionary(true);
			methods = [];
		}
		
		public function callLater(method:Function):void
		{
			if(isCallRelease) return;
			
			methods.push(method);
		}
		
		public function callLaterHandler(event:Event):void
		{
			levelCount++;
			levelCount %= level;
			if(levelCount != 0) {
				return;
			}
			isCallRelease = true;
			
			var need:Boolean = methods.length>0?true:false;
			while(methods.length > 0) {
				(methods.shift() as Function)();
			}
			
			isCallRelease = false;
			
			if(need) return;
			
			for(var stage:Object in stageDict) {
				(stage as Stage).invalidate();
			}
		}
	}
}