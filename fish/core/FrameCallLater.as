package fish.core
{
	import fish.logging.log;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class FrameCallLater implements ICalllater
	{
		private static var instance:FrameCallLater = new FrameCallLater();
		
		public static function call(method:Function):void
		{
			instance.callLater(method);
		}
		
		public static function registStage(value:Stage):void
		{
			if(value != null && value is Stage) {
				instance.stageDict[value] = true;
				value.addEventListener(Event.ENTER_FRAME, instance.callLaterHandler);
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