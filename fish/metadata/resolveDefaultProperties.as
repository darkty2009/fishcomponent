package fish.metadata
{	
	import fish.logging.log;
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import starling.events.PropertyChangeEvent;
	import starling.events.EventDispatcher;
	
	public function resolveDefaultProperties(instance:Object, callback:Function):void
	{
		instance = instance as EventDispatcher;
		
		var className:String = getQualifiedClassName(instance);
		var xml:XML = TypeCache.getCache(className, TypeCache.DESCRIBE) as XML;
		var needSetCache:Boolean = false;
		if(xml == null) {
			xml = flash.utils.describeType(flash.utils.getDefinitionByName(className));
			TypeCache.setCache(className, TypeCache.DESCRIBE, xml);
			needSetCache = true;
			
			// 后期测试一下，将properties也一并保存后，是否会有较大的性能提升
		}
		
		var properties:XMLList = xml.factory.accessor.*.(@name == "Property");
		var basicArray:Array = [];
		var advancedArray:Array = [];
		for each(var metadata:XML in properties) {
			instance[metadata.parent().@name] = Number(metadata.arg.(@key == "value").@value);
			if(needSetCache) {
				if(metadata.arg.(@key == "level").@value == TypeCache.BASIC) {
					basicArray.push(metadata.parent().@name + "");
				}
				if(metadata.arg.(@key == "level").@value == TypeCache.ADVANCED) {
					advancedArray.push(metadata.parent().@name + "");
				}
			}
		}
		
		if(needSetCache) {
			TypeCache.setCache(className, TypeCache.BASIC, basicArray);
			TypeCache.setCache(className, TypeCache.ADVANCED, advancedArray);
		}
	}
}