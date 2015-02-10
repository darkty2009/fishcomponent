package fish.layout
{
	import fish.core.AbstractComponent;
	import fish.metadata.resolveLayoutProperties;
	import fish.metadata.resolveListener;
	
	import starling.events.EventDispatcher;
	import starling.events.PropertyChangeEvent;
	
	[Listener(event="propertyChange", callback="propertiesChange")]
	
	public class Layout extends EventDispatcher implements ILayout
	{
		private var _target:AbstractComponent;
		
		private var _top:Number = 10;
		private var _bottom:Number = 10;
		private var _left:Number = 10;
		private var _right:Number = 10;
		private var _gap:Number = 10;
		
		protected var _lock:Boolean = false;
		
		public function set target(value:AbstractComponent):void
		{
			_target = value;
		}
		
		public function get target():AbstractComponent
		{
			return _target;
		}
		
		public function Layout(value:AbstractComponent = null)
		{
			target = value;
			
			fish.metadata.resolveListener(this);
		}
		
		public function propertiesChange(event:PropertyChangeEvent):void
		{
			measure();
		}
		
		public function measure():void
		{	
			
		}

		public function get top():Number
		{
			return _top;
		}
		
		[LayoutProperty(name="layout.top", measure="true")]
		public function set top(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "top", _top, value));
			_top = value;
		}

		public function get bottom():Number
		{
			return _bottom;
		}
		
		[LayoutProperty(name="layout.bottom", measure="true")]
		public function set bottom(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bottom", _bottom, value));
			_bottom = value;
		}

		public function get left():Number
		{
			return _left;
		}
		
		[LayoutProperty(name="layout.left", measure="true")]
		public function set left(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "left", _left, value));
			_left = value;
		}

		public function get right():Number
		{
			return _right;
		}
		
		[LayoutProperty(name="layout.right", measure="true")]
		public function set right(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "right", _right, value));
			_right = value;
		}

		public function get gap():Number
		{
			return _gap;
		}
		
		[LayoutProperty(name="layout.gap", measure="true")]
		public function set gap(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gap", _gap, value));
			_gap = value;
		}
	}
}