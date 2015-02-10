package fish.events
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class ResizeEvent extends Event
	{
		public static const RESIZE:String = "resize";
		public static const CHILD_RESIZE:String = "childResize";
		
		public var oldValue:Rectangle;
		public var newValue:Rectangle;
		public var child:DisplayObject;
		
		public function ResizeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:ResizeEvent = new ResizeEvent(type, bubbles, cancelable);
			event.oldValue = oldValue;
			event.newValue = newValue;
			event.child = child;
			return event;
		}
	}
}