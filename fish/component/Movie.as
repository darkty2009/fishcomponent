package fish.component
{
	import fish.core.AbstractComponent;
	
	import flash.media.Sound;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.events.ProgressEvent;
	import starling.events.PropertyChangeEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class Movie extends AbstractComponent
	{
		public static const AUTO_PLAY:String = "autoPlay";
		public static const HOVER:String = "hover";
		public static const MANUAL_PLAY:String = "manualPlay";
		
		protected var _source:MovieClip;
		protected var _playType:String;
		
		public function Movie()
		{
			super();
			
			this._background.visible = false;
		}

		public function get source():MovieClip
		{
			return _source;
		}
		
		public function set source(value:MovieClip):void
		{
			dispatchEvent(starling.events.PropertyChangeEvent.createUpdateEvent(this, "source", _source, value));
			_source = value;
			if(_source != null && _source is DisplayObject) {
				if(!this._foreground.contains(_source)) {
					this._foreground.addChild(_source);
				}
			}
		}
		
		public function setFrameTexture(index:Number, texture:Texture):void
		{
			if(source) {
				source.setFrameTexture(index, texture);
			}
		}
		
		public function setFrameSound(index:Number, sound:Sound):void
		{
			if(source) {
				source.setFrameSound(index, sound);
			}
		}

		public function get playType():String
		{
			return _playType;
		}

		public function set playType(value:String):void
		{
			_playType = value;
			
			if(_source == null)
				return;
			
			starling.core.Starling.juggler.add(source);
			if(playType == AUTO_PLAY) {
				source.play();
			}
			if(playType == HOVER) {
				source.stop();
				source.currentFrame = 0;
				source.addEventListener(starling.events.TouchEvent.TOUCH, touchHandler);
			}
		}
		
		protected function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(source);
			if(touch && touch.phase == starling.events.TouchPhase.HOVER) {
				source.play();
			}else {
				source.stop();
				source.currentFrame = 0;
			}
		}

	}
}