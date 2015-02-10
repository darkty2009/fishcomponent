package fish.utils
{
	import flash.text.TextFormat;

	public class TextFormatFactory
	{
		public static function create(options:Object):TextFormat
		{
			var format:Object = new TextFormat();
			for(var key:String in options) {
				format[key] = options[key];
			}
			return format as TextFormat;
		}
	}
}