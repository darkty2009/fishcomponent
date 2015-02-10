package fish.util
{		
	public class RGB {
		
		private var color:uint;
		private var red:int;
		private var green:int;
		private var blue:int;
		
		public function RGB(r:Number=0, g:Number=0, b:Number=0, color:uint = 0) {
			if(color != 0) {
				this.color = color;
			}else {
				Red = r;
				Green = g;
				Blue = b;
			}
		}
	
		public function get Red():int {
			return color >> 16;
		}
		public function get Green():int {
			return (color >> 8) & 0xFF;
		}
		public function get Blue():int {
			return color & 0x00FF;
		}
		
		public function set Red(Value:int):void {
			red = (Value>255)? 255 : ((Value<0)?0:Value);
			color=getHex(red,green,blue);
		}
		public function set Green(Value:int):void {
			green = (Value>255)? 255 : ((Value<0)?0:Value);
			color=getHex(red,green,blue);
		}
		public function set Blue(Value:int):void {
			blue = (Value>255)? 255 : ((Value<0)?0:Value);
			color=getHex(red,green,blue);
		}
		
		public function get Hex():uint {
			return color;
		}
		public function set Hex(Value:uint):void {
			color=Value;
		}
		
		public function toHSL():HSL {
			var hsl:HSL = new HSL();
			var r:Number = Red/255;
			var g:Number = Green/255;
			var b:Number = Blue/255;
			
			var max:Number = Math.max(r, g, b);
			var min:Number = Math.min(r, g, b);
			
			if(max == min) {
				hsl.Hue = 0;
			}
			else if(max == r && g>=b) {
				hsl.Hue = 60*(g-b)/(max-min) + 0;
			}
			else if(max == r && g<b) {
				hsl.Hue = 60*(g-b)/(max-min) + 360;
			}
			else if(max == g) {
				hsl.Hue = 60*(b-r)/(max-min) + 120;
			}
			else if(max == b) {
				hsl.Hue = 60*(r-g)/(max-min) + 240;
			}
			
			hsl.Luminance = (max+min)/2;
			
			if(hsl.Luminance == 0 || max == min) {
				hsl.Saturation = 0;
			}
			else if(hsl.Luminance > 0 && hsl.Luminance <= 0.5) {
				hsl.Saturation = (max-min)/(2*hsl.Luminance);
			}
			else if(hsl.Luminance > 0.5) {
				hsl.Saturation = (max-min)/(2-2*hsl.Luminance);
			}
			
			return hsl;
		}
		
		public static function getHex(r:int, g:int, b:int):uint{
			return (r<<16)|(g << 8)|b;
		}
		
		public static function getHexString(r:int, g:int, b:int):String {
			var rS:String = r.toString(16);
			var gS:String = g.toString(16);
			var bS:String = b.toString(16);
			return "0x"+(rS.length<2?"0"+rS:rS)+(gS.length<2?"0"+gS:gS)+(bS.length<2?"0"+bS:bS);
		}
	}
}