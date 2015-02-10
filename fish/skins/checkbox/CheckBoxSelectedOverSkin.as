package fish.skins.checkbox
{
	import fish.skins.ISkin;
	
	import flash.display.Shape;
	
	public class CheckBoxSelectedOverSkin extends Shape implements ISkin
	{
		public function update(widthValue:Number=-1, heightValue:Number=-1):ISkin
		{
			widthValue < 0 && (widthValue = width);
			heightValue < 0 && (heightValue = height);
			
			var radius:Number = (heightValue - 2) / 2;
			if(radius < 2) {
				radius = 2;
			}
			
			with(graphics) {
				clear();
				beginFill(0x000000, 0);
				drawRect(0, 0, widthValue, heightValue);
				endFill();
				beginFill(0x888888, 1);
				drawCircle(radius + 1, radius + 1, radius);
				drawCircle(radius + 1, radius + 1, radius - 1);
				drawCirCle(radius + 1, radius + 1, radius - 2);
				endFill();
			}
			
			return this;
		}
	}
}