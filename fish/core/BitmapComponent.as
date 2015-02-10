package fish.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class BitmapComponent extends Bitmap implements IDrawable
	{
		public function BitmapComponent(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}
		
		public function set level(value:uint):void
		{
		}
		
		public function get level():uint
		{
			return 0;
		}
		
		public function redraw():void
		{
		}
	}
}