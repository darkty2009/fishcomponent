package fish.layout
{
	import fish.core.AbstractComponent;
	
	public class VerticalLayout extends HorizonalLayout
	{
		public function VerticalLayout(value:AbstractComponent=null)
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
					
					current.x = current.layout.left;
					var latest:Number = 0;
					if(last != null && last is AbstractComponent) {
						latest = last.y + last.height + last.layout.bottom;
					}
					
					switch(horizonalAlign) {
						case HorizonalAlign.RIGHT:{
							current.x = target.width - current.width - current.layout.right;
						};break;
						case HorizonalAlign.CENTER:{
							current.x = (target.width - current.width) / 2;
						};break;
						case HorizonalAlign.LEFT:break;
					}
					
					current.y = latest + current.layout.top;
					
					last = current;
				}
				
				_lock = false;
			}
		}
	}
}