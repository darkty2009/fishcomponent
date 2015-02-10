package fish.metadata
{	
	import fish.logging.log;
	
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.PropertyChangeEvent;
	
	public function resolveDefaultProperties(instance:IEventDispatcher):void
	{
		var className:String = getQualifiedClassName(instance);
		var xml:XML = TypeCache.getCache(className, TypeCache.DESCRIBE) as XML;
		var needSetCache:Boolean = false;
		if(xml == null) {
			xml = flash.utils.describeType(flash.utils.getDefinitionByName(className));
			TypeCache.setCache(className, TypeCache.DESCRIBE, xml);
			needSetCache = true;
		}
		
		var properties:XMLList = xml.factory.accessor.*.(@name == "Property");
		var basicArray:Array = [];
		var advancedArray:Array = [];
		for each(var metadata:XML in properties) {
			if(metadata.arg.(@key == "value").@value == "null") {
				instance[metadata.parent().@name] = null;
			}else
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