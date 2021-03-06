package fish.metadata
{
	import fish.logging.log;
	
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public function resolveListener(instance:IEventDispatcher, isRemove:Boolean = false):void
	{
		var className:String = getQualifiedClassName(instance);
		var xml:XML = TypeCache.getCache(className, TypeCache.DESCRIBE) as XML;
		var needSetCache:Boolean = false;
		if(xml == null) {
			xml = flash.utils.describeType(flash.utils.getDefinitionByName(className));
			TypeCache.setCache(className, TypeCache.DESCRIBE, xml);
			needSetCache = true;
		}
		
		var listeners:XMLList = xml.factory.metadata.(@name == "Listener");
		
		var extend:XMLList = xml..extendsClass;
		for each(var item:XML in extend) {
			className = item.@type.toString().replace("::", ".");
			if(className.indexOf("fish.")<0)
				continue;
			
			xml = TypeCache.getCache(className, TypeCache.DESCRIBE) as XML;
			if(xml == null) {
				xml = flash.utils.describeType(flash.utils.getDefinitionByName(className));
				TypeCache.setCache(className, TypeCache.DESCRIBE, xml);
			}
			
			var extendListeners:XMLList = xml.factory.metadata.(@name == "Listener");
			listeners += extendListeners;
		}
		
		for each(var metadata:XML in listeners) {
			if(isRemove) {
				instance.removeEventListener(metadata.arg.(@key == "event").@value, instance[metadata.arg.(@key == "callback").@value] as Function);
			}
			if(!isRemove) {
				instance.addEventListener(metadata.arg.(@key == "event").@value, instance[metadata.arg.(@key == "callback").@value] as Function);
			}
		}
	}
}