package fish.utils
{
	public class Font
	{
		public static function from(fontFamily:String = "Microsoft YaHei", fontSize:Number = 14, fontColor:Number = 0x222222, bold:Boolean = false):Font {
			return new Font(fontFamily, fontSize, fontColor, bold);
		}
		
		public static function fromObject(options:Object = null):Font {
			if(options) {
				return new Font(options.fontFamily, options.fontSize, options.fontColor, options.bold);
			}else
				return new Font();
		}
		
		public function Font(fontFamily:String = "Microsoft YaHei", fontSize:Number = 14, fontColor:Number = 0x222222, bold:Boolean = false) {
			this.fontFamily = fontFamily;
			this.fontColor = fontColor;
			this.fontSize = fontSize;
			this.bold = bold;
		}
		
		public var fontFamily:String;
		public var fontSize:Number;
		public var fontColor:Number;
		public var bold:Boolean;
	}
}