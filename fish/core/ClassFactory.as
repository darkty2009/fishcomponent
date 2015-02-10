package fish.core
{
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
	}
}