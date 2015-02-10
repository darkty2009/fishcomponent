package fish.util
{
	import flash.utils.Dictionary;

	public class ArrayUtil
	{
		public static function excludeDuplicate(array:Array):Array
		{
			if(array && array.length > 1) {
				var result:Array = [];
				var table:Dictionary = new Dictionary();
				var item:*;
				for(var i:Number = 0;(item = array[i]) != null; i++) {
					if(!table[item]) {
						result.push(item);
						table[item] = true;
					}
				}
				
				return result;
			}else {
				return array;
			}
		}
		
		public static function trim(array:Array):Array
		{
			for(var i:Number = 0;i<array.length;i++) {
				if(array[i] == null || (array[i].hasOwnProperty("length") && array[i].length == 0)) {
					array.splice(i, 1);
					i--;
				}
			}
			
			return array;
		}
	}
}