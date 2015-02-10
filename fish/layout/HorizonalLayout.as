package fish.layout
{
	import fish.container.Container;
	import fish.core.AbstractComponent;
	
	import starling.events.PropertyChangeEvent;
	
	public class HorizonalLayout extends Layout
	{	
		// do the resolve of LayoutProperty
		
		protected var _verticalAlign:String = VerticalAlign.TOP;
		protected var _horizonalAlign:String = HorizonalAlign.LEFT;
		
		[LayoutProperty(name="layout.top", measure="true")]
		public function set verticalAlign(value:String):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "verticalAlign", _verticalAlign, value));
			_verticalAlign = value;
		}
		
		public function get verticalAlign():String
		{
			return _verticalAlign;
		}
		
		[LayoutProperty(name="layout.top", measure="true")]
		public function set horizonalAlign(value:String):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "horizonalAlign", _horizonalAlign, value));
			_horizonalAlign = value;
		}
		
		public function get horizonalAlign():String
		{
			return _horizonalAlign;
		}
		
		public function HorizonalLayout(value:AbstractComponent=null)
		{
			super(value);
		}
		
		override public function measure():void
		{
			if(!_lock) {
				_lock = true;
				
				var length:Number = target.numChildren;
				var last:AbstractComponent = null;
				for(var i:Number = 0;i < length; i++) {
					var current:AbstractComponent = target.getChildAt(i) as AbstractComponent;
					if(current == null)
						continue;
					
					current.y = current.layout.top;
					var latest:Number = 0;
					if(last != null && last is AbstractComponent) {
						latest = last.x + last.width + last.layout.right;
					}
					
					switch(verticalAlign) {
						case VerticalAlign.BOTTOM:{
							current.y = target.height - current.height - current.layout.bottom;
						};break;
						case VerticalAlign.MIDDLE:{
							current.y = (target.height - current.height) / 2;
						};break;
						case VerticalAlign.TOP:break;
					}
					
					current.x = latest + current.layout.left;
					
					last = current;
				}
				
				_lock = false;
			}
		}
	}
}