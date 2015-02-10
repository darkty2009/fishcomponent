package fish.util
{
	public class ColorUtil
	{
		public static function format(color:String):RGB
		{
			return new RGB(0, 0, 0, uint("0x"+color));
		}
	}
}