package fish.manager
{
	import fish.display.FBitmap;
	import fish.display.FSprite;
	
	public class DragProxy extends FSprite
	{
		public function DragProxy(value:*=null, isAdd:Boolean=true)
		{
			super(value, isAdd);
		}
		
		public var source:DragSource;
		public var container:*;
	}
}