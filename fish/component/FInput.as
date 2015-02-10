package fish.component
{
	import fish.display.FTextField;
	
	import flash.events.Event;
	import flash.text.TextFieldType;
	
	public class FInput extends FTextField
	{
		public function FInput(value:String=null, useShadow:Boolean=false)
		{
			super(value, useShadow);
			
			type = flash.text.TextFieldType.INPUT;
			mouseEnabled = mouseWheelEnabled = true;
		}
		
		override public function create(event:Event=null):void
		{
			super.create();
		}
	}
}