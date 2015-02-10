package fish.events
{
	import flash.events.Event;
	
	public class DataChangeEvent extends Event
	{
		public var oldValue:*;
		public var newValue:*;
		
		public function DataChangeEvent(type:String, oldValue:*, newValue:*)
		{
			super(type, false, false);
			this.oldValue = oldValue;
			this.newValue = newValue;
			
			if(this.oldValue == this.newValue) {
				this.stopImmediatePropagation();
			}
		}
		
		override public function clone():Event {
			var event:DataChangeEvent = new DataChangeEvent(type, oldValue, newValue);
			return event;
		}
	}
}