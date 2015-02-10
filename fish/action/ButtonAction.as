package fish.action
{	
	import fish.display.FMovieClip;
	import fish.events.DataChangeEvent;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class ButtonAction extends Action
	{
		public function ButtonAction(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		override public function regist():IAction
		{
			addEvent();
			
			try {
				target["target"].buttonMode = true;
				target["target"].mouseEnable = true;
			}catch(e:Error) {}
			
			FMovieClip(target).gotoAndStop("out");
			
			return this;
		}
		
		override public function unregist():IAction
		{
			removeEvent();
			
			try {
				target["target"].buttonMode = false;
				target["target"].mouseEnable = false;
			}catch(e:Error) {}
			
			return this;
		}
		
		protected function addEvent():void
		{
			target["target"].addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			target["target"].addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			target["target"].addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			target["target"].addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			target.addEventListener("enableChange", changeHandler);
		}
		
		protected function removeEvent():void
		{
			target["target"].removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			target["target"].removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			target["target"].removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			target["target"].removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			target.removeEventListener("enableChange", changeHandler);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			if(target["enable"])
				try {
					FMovieClip(target).gotoAndStop("over");
				}catch(e:Error) {}
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			if(target["enable"])
				try {
					FMovieClip(target).gotoAndStop("out");
				}catch(e:Error) {}
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			if(target["enable"])
				try {
					FMovieClip(target).gotoAndStop("down");
				}catch(e:Error) {}
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			if(target["enable"])
				try {
					FMovieClip(target).gotoAndStop("over");
				}catch(e:Error) {}
		}
		
		public function changeHandler(event:DataChangeEvent):void
		{
			if(event.newValue == true) {
				try {
					FMovieClip(target).gotoAndStop("disable");
				}catch(e:Error) {}
			}else {
				try {
					FMovieClip(target).gotoAndStop("out");
				}catch(e:Error) {}
			}
		}
	}
}