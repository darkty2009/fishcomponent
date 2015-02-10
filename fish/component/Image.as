package fish.component
{
	import fish.core.AbstractComponent;
	import fish.logging.log;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.IOErrorEvent;
	import starling.events.ProgressEvent;
	import starling.textures.Texture;
	
	public class Image extends AbstractComponent
	{
		protected var _source:starling.display.Image;
		protected var _loader:Loader;
		protected var _bitmap:BitmapData;
		protected var _data:*;
		
		public function Image(data:* = null, width:Number = 1, height:Number = 1)
		{
			super();
			
			super.width = width;
			super.height = height;
			
			this._data = data;
		}
		
		override public function added(event:starling.events.Event=null):void
		{
			super.added(event);
			
			fromObject(this._data);
		}
		
		override public function removeAll(event:* = null):void
		{
			super.removeAll();
			
			clearLoader();
			
			_bitmap && _bitmap.dispose();
			_source && _source.dispose();
			
			_source = null;
		}
		
		public function fromObject(data:Object = null):void
		{
			if(data != null) {
				if(data is String) {
					fromURL(data as String);
				}
				if(data is BitmapData) {
					fromBitmapData(data as BitmapData);
				}
				if(data is Bitmap) {
					fromBitmap(data as Bitmap);
				}
				if(data.hasOwnProperty("bitmapData") && data.bitmapData is BitmapData) {
					fromBitmapData(data.bitmapData as BitmapData);
				}
				if(data is Texture) {
					fromTexture(data as Texture);
				}
			}
		}
		
		public function fromURL(url:String):void
		{
			if(_loader == null) {
				_loader = new Loader();
			}else {
				clearLoader();
			}
			
			_loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderComplete);
			_loader.contentLoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS, progressHandler);
			_loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, errorHandler);
			
			_loader.load(new URLRequest(url));
		}
		
		public function fromBitmap(bitmap:Bitmap):void
		{
			var texture:Texture = Texture.fromBitmap(bitmap);
			fromTexture(texture);
		}
		
		public function fromBitmapData(bitmapData:BitmapData):void
		{
			var texture:Texture = Texture.fromBitmapData(bitmapData);
			fromTexture(texture);
		}
		
		public function fromTexture(texture:Texture):void
		{
			if(_source == null) {
				_source = new starling.display.Image(texture);
				_source.name = this.name;
				_background.visible = false;
				_foreground.addChild(_source);
			}else {
				_source.texture = texture;
			}
			
			dispatchEvent(new starling.events.Event(starling.events.Event.COMPLETE));
		}
		
		protected function loaderComplete(event:flash.events.Event):void
		{
			var widthValue:Number = _loader.width;
			var heightValue:Number = _loader.height;
			
			var data:BitmapData = new BitmapData(super.width, super.height, true);
			var matrix:Matrix = new Matrix();
			if(_loader.width != super.width || _loader.height != super.height) {
				matrix.scale(super.width / _loader.width, super.height / _loader.height);
			}
			
			data.draw(_loader, matrix);
			
			clearLoader();
			
			fromBitmapData(data);
		}
		
		protected function progressHandler(event:flash.events.ProgressEvent):void
		{
			dispatchEvent(starling.events.ProgressEvent.fromEvent(event) as starling.events.Event);
		}
		
		protected function errorHandler(event:flash.events.IOErrorEvent):void
		{
			fish.logging.log(1, "loader error", event.type);
			dispatchEvent(starling.events.IOErrorEvent.fromEvent(event) as starling.events.Event);
		}
		
		private function clearLoader():void
		{
			if(_loader == null)
				return;
			
			_loader.unload();
			
			_loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, loaderComplete);
			_loader.contentLoaderInfo.removeEventListener(flash.events.ProgressEvent.PROGRESS, progressHandler);
			_loader.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		override public function set name(value:String):void
		{
			this._name = value;
			if(_source && _source.hasOwnProperty("name")) {
				_source.name = value;
			}
		}
		
		public function get foreground():DisplayObjectContainer
		{
			return _foreground;
		}
	}
}