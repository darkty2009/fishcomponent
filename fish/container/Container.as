package fish.container
{
	import fish.core.AbstractComponent;
	import fish.layout.ILayout;
	import fish.layout.Layout;
	import starling.events.PropertyChangeEvent;
	
	public class Container extends AbstractComponent
	{
		protected var _backgroundColor:Number;
		protected var _backgroundAlpha:Number;
		
		public function Container()
		{
			super();
		}
		
		override public function measure():void
		{
			_layout.measure();
		}

		public function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}

		[Property(value="1", level="basicProperties")]
		public function set backgroundAlpha(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backgroundAlpha", _backgroundAlpha, value));
			_backgroundAlpha = value;
			
			super._background.alpha = backgroundAlpha;
		}

	}
}