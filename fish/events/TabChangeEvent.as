package fish.events
{
	import fish.component.FToggleButton;
	
	import flash.events.Event;
	
	public class TabChangeEvent extends Event
	{
		public function TabChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var tab:FToggleButton;
		public var index:Number;
		
		public static const CHANGE:String = "tabChange";
	}
}