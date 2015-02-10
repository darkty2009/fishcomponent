package fish.skins.component
{
	import fish.logging.log;
	import fish.skins.ISkin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class ComponentNormalSkin extends Shape implements ISkin
	{
		public function update(widthValue:Number = -1, heightValue:Number = -1):ISkin
		{
			widthValue < 0 && (widthValue = width);
			heightValue < 0 && (heightValue = height);
			
			with(graphics) {
				clear();
				beginFill(0xededed, 0.1);
				drawRect(0, 0, widthValue, heightValue);
				endFill();
			}
			
			return this;
		}
	}
}