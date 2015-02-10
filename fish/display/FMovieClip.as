package fish.display
{
	import fish.core.FrameCallLater;
	import fish.core.IComponent;
	import fish.core.IDrawable;
	import fish.core.ValidateLevel;
	import fish.metadata.resolveDefaultProperties;
	import fish.metadata.resolveListener;
	import fish.util.UniqueUtil;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FMovieClip extends FSprite
	{
		public function FMovieClip(value:* = null, isAdd:Boolean = true)
		{
			super(value, isAdd);
			
			name = "FMovieClip"+fish.util.UniqueUtil.getUnique();
		}
		
		override public function redraw():void
		{
			if(level > ValidateLevel.NESTLEVEL_BASIC) {
				if(_lastCallback != null) {
					if(_lastArguments != null)
						target[_lastCallback](_lastArguments);
					else
						target[_lastCallback]();
				}
				
				_lastCallback = null;
				_lastArguments = null;
			}
			
			super.redraw();
		}
		
		/**
		 * MovieClip Special Function
		 */
		[Bindable]
		protected var _lastCallback:String;
		protected var _lastArguments:Object;
		
		public function gotoAndPlay(frame:Object, scene:String=null):void
		{
			_lastCallback = "gotoAndPlay";
			_lastArguments = frame;
			level = ValidateLevel.NESTLEVEL_ALL;
		}
		
		public function gotoAndStop(frame:Object, scene:String=null):void
		{
			_lastCallback = "gotoAndStop";
			_lastArguments = frame;
			level = ValidateLevel.NESTLEVEL_ALL;
		}
		
		public function nextFrame():void
		{
			_lastCallback = "nextFrame";
			level = ValidateLevel.NESTLEVEL_ALL;
		}
		
		public function prevFrame():void
		{
			_lastCallback = "prevFrame";
			level = ValidateLevel.NESTLEVEL_ALL;
		}
		
		public function play():void
		{
			_lastCallback = "play";
			level = ValidateLevel.NESTLEVEL_ALL;
		}
		
		public function stop():void
		{
			_lastCallback = "stop";
			level = ValidateLevel.NESTLEVEL_ALL;
		}
		
		public function get currentFrameLabel():String
		{
			return MovieClip(target).currentFrameLabel;
		}
	}
}