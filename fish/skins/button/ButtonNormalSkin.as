package fish.skins.button
{
	import fish.skins.ISkin;
	
	import flash.display.Shape;
	
	public class ButtonNormalSkin extends Shape implements ISkin
	{       
		public function update(widthValue:Number=-1, heightValue:Number=-1):ISkin
		{
			widthValue < 0 && (widthValue = width);
			heightValue < 0 && (heightValue = height);
			
			with(graphics) {
				clear();
				beginFill(0x333333, 1);
				drawRect(0, 0, widthValue, heightValue);
				endFill();
				beginFill(0x888888, 1);
				drawRect(1, 1, widthValue - 2, heightValue - 2);
				endFill();
			}
			
			return this;
		}
	}
}