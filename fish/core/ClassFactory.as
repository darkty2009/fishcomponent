package fish.core
{
	import fish.skins.button.ButtonDownSkin;
	import fish.skins.button.ButtonNormalSkin;
	import fish.skins.button.ButtonOverSkin;
	import fish.skins.component.ComponentNormalSkin;

	public class ClassFactory
	{
		protected var generator:Class;
		protected var _properties:Object;
		
		public function ClassFactory(clazz:Class = null)
		{
			super();
			
			this.generator = clazz;
		}
		
		public function get properties():Object
		{
			return _properties;
		}

		public function set properties(value:Object):void
		{
			_properties = value;
		}

		public function newInstance():*
		{
			var instance:Object = new generator();
			if(properties != null) {
				for(var property:* in properties) {
					instance[property] = properties[property];
				}
			}
			
			return instance;
		}
		
		private static function includeClasses():void
		{
			fish.skins.component.ComponentNormalSkin;
			fish.skins.button.ButtonNormalSkin;
			fish.skins.button.ButtonOverSkin;
			fish.skins.button.ButtonDownSkin;
		}
	}
}