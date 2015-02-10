package fish.metadata
{
	import fish.action.Action;
	import fish.logging.log;
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public function resolveActionListener(instance:Action, target:Object, isRemove:Boolean = false):void
	{
		var className:String = getQualifiedClassName(instance);
		var xml:XML = TypeCache.getCache(className, TypeCache.DESCRIBE) as XML;
		var needSetCache:Boolean = false;
		if(xml == null) {
			xml = flash.utils.describeType(flash.utils.getDefinitionByName(className));
			TypeCache.setCache(className, TypeCache.DESCRIBE, xml);
			needSetCache = true;
			
			// 后期测试一下，将properties也一并保存后，是否会有较大的性能提升
		}
		
		var listeners:XMLList = xml.factory.metadata.(@name == "Action");
		
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
			
			var extendListeners:XMLList = xml.factory.metadata.(@name == "Action");
			listeners += extendListeners;
		}
		
		for each(var metadata:XML in listeners) {
			if(isRemove) {
				target.removeEventListener(metadata.arg.(@key == "event").@value, instance[metadata.arg.(@key == "callback").@value] as Function);
			}
			if(!isRemove) {
				target.addEventListener(metadata.arg.(@key == "event").@value, instance[metadata.arg.(@key == "callback").@value] as Function);
			}
		}
	}
}