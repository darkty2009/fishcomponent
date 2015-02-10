package fish.util
{
	import flash.utils.ByteArray;

	public class ObjectUtil
	{
		public static function recover(source:Object, value:Object):Object
		{
			if(value != null) {
				var keys:Array = [];
				
				var dyn:Object = clone(source);
				
				for(var key:* in dyn) {
					if(value.hasOwnProperty(key) && key != "id") {
						source[key] = value[key];
					}
				}
			}
			
			return source;
		}
		
		public static function clone(source:Object):*
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(source);
			bytes.position = 0;
			var ni:* = bytes.readObject();
			
			return ni;
		}
	}
}