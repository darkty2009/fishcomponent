package fish.utils
{
	import fish.core.IComponent;

	public class UniqueUtil
	{
		private static var _uniqueId:Number = 0;
		
		public static function getUnique():Number
		{
			return _uniqueId++;
		}
	}
}