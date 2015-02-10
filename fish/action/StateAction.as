package fish.action
{
	import flash.utils.Dictionary;
	
	import starling.events.TouchEvent;
	
	[Action(event="mouseClick", callback="clickHandler")]
	
	public class StateAction extends ButtonAction
	{		
		protected var _currentState:Boolean = false;
		
		public function StateAction(value:Object=null)
		{
			super(value);
		}
		
		public function clickHandler(event:TouchEvent):void
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
		
		/*
		override public function overHandler(event:TouchEvent):void
		{
			if(!_currentState) {
				super.overHandler(event);
			}
		}
		
		override public function outHandler(event:TouchEvent):void
		{
			if(!_currentState) {
				super.outHandler(event);
			}
		}
		
		override public function downHandler(event:TouchEvent):void
		{
			if(!_currentState) {
				super.downHandler(event);
			}
		}
		
		override public function upHandler(event:TouchEvent):void
		{
			if(!_currentState) {
				super.upHandler(event);
			}
		}
		*/
	}
}