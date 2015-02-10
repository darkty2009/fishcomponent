package fish.metadata
{
	import fish.core.ClassFactory;
	import fish.skins.ISkin;
	import fish.skins.ISkinable;
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public function resolveStyles(instance:ISkinable):void
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
		
		var styles:XMLList = xml.factory.metadata.(@name == "State");
		
		var extendClass:XMLList = xml..extendsClass;
		for each(var item:XML in extendClass) {
			className = item.@type.toString().replace("::", ".");
			if(className.indexOf("fish.")<0)
				continue;
			
			xml = flash.utils.describeType(flash.utils.getDefinitionByName(className));
			if(xml == null) {
				xml = flash.utils.describeType(flash.utils.getDefinitionByName(className));
				TypeCache.setCache(className, TypeCache.DESCRIBE, xml);
			}
			
			var extendStates:XMLList = xml.factory.metadata.(@name == "State");
			styles += extendStates;
		}
		
		var instanceDict:Dictionary = new Dictionary();
		for each(var metadata:XML in styles) {
			if(instanceDict[String(metadata.arg.(@key == "name").@value)] == null) {
				instanceDict[String(metadata.arg.(@key == "name").@value)] = new ClassFactory(getDefinitionByName(metadata.arg.(@key == "skin").@value + "") as Class).newInstance() as ISkin;
			}
		}
		
		instance.states = instanceDict;
	}
}