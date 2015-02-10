package fish.container
{
	import fish.core.ValidateLevel;
	import fish.display.FDisplayObject;
	import fish.display.FSprite;
	import fish.events.ResizeEvent;
	import fish.layout.Layout;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FContainer extends FSprite
	{
		public function FContainer(value:*=null, isAdd:Boolean = true)
		{
			super(value, isAdd);
		}
		
		public var background:*;
		
		public var layout:Layout;
		
		override public function create(event:Event=null):void
		{	
			if(background) {
				this.addChild(background);
			}
			
			if(layout == null) {
				layout = new Layout(_target);
			}
			
			var flag:Boolean = (target == null);
			
			super.create(event);
			
			if(flag) {
				layout.target = this.target;
				layout.execute(null, null, null);
			}
		}
	}
}