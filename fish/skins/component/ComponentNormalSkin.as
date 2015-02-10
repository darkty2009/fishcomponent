package fish.skins.component
{
	import fish.logging.log;
	import fish.skins.ISkin;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class ComponentNormalSkin extends Sprite implements ISkin
	{	
		public var shape:Quad;
		
		public function update(widthValue:Number = -1, heightValue:Number = -1):ISkin
		{
			widthValue < 0 && (widthValue = width);
			heightValue < 0 && (heightValue = height);
			
			if(shape != null) {
				if(shape.width == widthValue && shape.height == heightValue)
					return this;
			}
			
			if(isNaN(widthValue) || isNaN(heightValue)) {
				return this;
			}
			
			if(shape == null) {
				shape = new Quad(widthValue, heightValue);
				addChild(shape);
				
				shape.setVertexColor(0, 0xffffff);
				shape.setVertexAlpha(0, 0);
			}
			
			shape.width = widthValue;
			shape.height = heightValue;
			
			return this;
		}
	}
}