package fish.metadata
{
	import flash.utils.Dictionary;

	public class TypeCache
	{
		public static const BASIC:String = "basicProperties";
		public static const ADVANCED:String = "advancedProperties";
		public static const DESCRIBE:String = "describeInfomation";
		
		private static var _typeCacheDict:Dictionary = new Dictionary();
		
		public static function setCache(className:*, type:String, value:*):void
		{
			componentInstance(className)[type] = value;
		}
		
		public static function getCache(className:*, type:String):*
		{
			return componentInstance(className)[type];
		}
	
		private static function componentInstance(value:String):ClassType
		{
			if(_typeCacheDict[value] == null) {
				_typeCacheDict[value] = new ClassType();
			}
			
			return _typeCacheDict[value];
		}
	}
}

class ClassType {
	private var _basicProperties:Array;
	private var _advancedProperties:Array;
	private var _describeInfomation:XML;
	
	public function get describeInfomation():XML
	{
		return _describeInfomation;
	}

	public function set describeInfomation(value:XML):void
	{
		_describeInfomation = value;
	}

	public function get advancedProperties():Array
	{
		return _advancedProperties;
	}

	public function set advancedProperties(value:Array):void
	{
		_advancedProperties = value;
	}

	public function get basicProperties():Array
	{
		return _basicProperties;
	}

	public function set basicProperties(value:Array):void
	{
		_basicProperties = value;
	}
}