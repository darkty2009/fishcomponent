package fish.action
{
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	[Action(event="mouseClick", callback="clickHandler")]
	
	public class StateAction extends ButtonAction
	{		
		protected var _currentState:Boolean = false;
		
		public function StateAction(value:Object=null)
		{
			super(value);
		}
		
		public function clickHandler(event:MouseEvent):void
		{
			_currentState = !_currentState;
			
			if(_currentState) {
				target.currentState = _states["checked"];
				return;
			}
			if(!_currentState) {
				target.currentState = _states["over"];
			}
		}
		
		override public function overHandler(event:MouseEvent):void
		{
			if(!_currentState) {
				super.overHandler(event);
			}
		}
		
		override public function outHandler(event:MouseEvent):void
		{
			if(!_currentState) {
				super.outHandler(event);
			}
		}
		
		override public function downHandler(event:MouseEvent):void
		{
			if(!_currentState) {
				super.downHandler(event);
			}
		}
		
		override public function upHandler(event:MouseEvent):void
		{
			if(!_currentState) {
				super.upHandler(event);
			}
		}
	}
}