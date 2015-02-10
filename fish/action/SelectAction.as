package fish.action
{
	import fish.display.FMovieClip;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class SelectAction extends Action
	{
		public function SelectAction(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		override public function regist():IAction
		{
			target.addEventListener(MouseEvent.CLICK, clickHandler);
			return this;
		}
		
		override public function unregist():IAction
		{
			target.addEventListener(MouseEvent.CLICK, clickHandler);
			return this;
		}
		
		protected var _selected:Boolean = false;
		
		protected function clickHandler(event:MouseEvent):void
		{
			FMovieClip(target).gotoAndStop(_selected?"selected":"unselected");
			_selected = !_selected;
		}
	}
}