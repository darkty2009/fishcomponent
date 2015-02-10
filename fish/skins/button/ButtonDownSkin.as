package fish.skins.button
{
	import fish.skins.ISkin;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class ButtonDownSkin extends starling.display.Sprite implements ISkin
	{
		public var _image:Image;
		
		public function update(widthValue:Number = -1, heightValue:Number = -1):ISkin
		{
			widthValue < 0 && (widthValue = width);
			heightValue < 0 && (heightValue = height);
			
			if(_image != null) {
				if(_image.width == widthValue && _image.height == heightValue)
					return this;
			}
			
			var shape:Shape = new Shape();
			with(shape.graphics) {
				beginFill(0x787878, 0.5);
				drawRect(0, 0, widthValue, heightValue);
				endFill();
			}
			
			var bitmapData:BitmapData = new BitmapData(widthValue, heightValue, true);
			bitmapData.draw(shape);
			
			var texture:Texture = Texture.fromBitmapData(bitmapData, true, true);
			if(_image == null) {
				_image = new Image(texture);
				addChild(_image);
			}else {
				_image.texture = texture;
			}
			
			_image.width = widthValue;
			_image.height = heightValue;
			
			_image.dispose();
			
			return this;
		}
	}
}