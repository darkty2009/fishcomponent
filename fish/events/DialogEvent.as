package fish.events
{
	import flash.events.Event;
	
	public class DialogEvent extends Event
	{
		public function DialogEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static const SHOW:String = "show";
		public static const HIDE:String = "hide";
		public static const SHOW_COMPLETE:String = "showComplete";
		public static const HIDE_COMPLETE:String = "hideComplete";
		public static const CLOSE:String = "onClose";
		public static const SUBMIT:String = "onSubmit";
		public static const CANCEL:String = "onCancel";
		public static const CREATION_COMPLETE:String = "creationComplete";
	}
}