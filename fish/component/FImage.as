package fish.component
{
	import fish.display.FSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	public class FImage extends FSprite
	{
		public function FImage(value:*=null, isAdd:Boolean=true)
		{
			super(value, isAdd);
			
			this.cache = true;
		}
		
		public function load(data:*):void
		{
			if(data is String) {
				loadByURL(data as String);
			}
			if(data is BitmapData) {
				loadByBitmapData(data as BitmapData);
			}
			if(data is Bitmap) {
				loadByBitmap(data as Bitmap);
			}
			
			this.data = data;
		}
		
		protected function loadByURL(url:String):void
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _loaderComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _loaderError);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _loaderProgress);
			_loader.load(new URLRequest(url), context);
		}
		
		private function _loaderComplete(event:Event):void
		{
			_bitmapData = new BitmapData(_loader.content.width, _loader.content.height, true);
			_bitmapData.draw(_loader.content);
			loadByBitmapData(_bitmapData);
			this.dispatchEvent(event);
		}
		
		protected function loadByBitmapData(data:BitmapData):void
		{
			loadByBitmap(new Bitmap(data, "auto", true));
		}
		
		protected function loadByBitmap(data:Bitmap):void
		{
			_bitmap = data;
			
			_bitmap.width = target.width;
			_bitmap.height = target.height;
			
			target.addChild(_bitmap);
		}
		
		private function _loaderError(event:IOErrorEvent):void
		{
			this.dispatchEvent(event);
		}
		
		private function _loaderProgress(event:ProgressEvent):void
		{
			this.dispatchEvent(event);
		}
		
		private var _loader:Loader;
		private var _bitmapData:BitmapData;
		private var _bitmap:Bitmap;
		
		public var context:LoaderContext = new LoaderContext();
		
		public var data:*;
		
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
	}
}