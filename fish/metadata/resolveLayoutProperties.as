package fish.metadata
{
	import fish.logging.log;
	
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.PropertyChangeEvent;

	public function resolveLayoutProperties(instance:IEventDispatcher, callback:Function):void
	{
		return;
		
		// 没想好要干嘛
		var className:String = getQualifiedClassName(instance);
		var xml:XML = TypeCache.getCache(className, TypeCache.DESCRIBE) as XML;
		var needSetCache:Boolean = false;
		if(xml == null) {
			xml = flash.utils.describeType(flash.utils.getDefinitionByName(className));
			TypeCache.setCache(className, TypeCache.DESCRIBE, xml);
			needSetCache = true;
		}
		
		var properties:XMLList = xml.factory.accessor.*.(@name == "LayoutProperty");
		trace(properties);
	}
}