package fish.display
{
	import fish.core.FrameCallLater;
	import fish.core.IComponent;
	import fish.core.IDrawable;
	import fish.core.ValidateLevel;
	import fish.events.DataChangeEvent;
	import fish.events.ResizeEvent;
	import fish.manager.DragSource;
	import fish.metadata.*;
	import fish.util.UniqueUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mx.events.PropertyChangeEvent;
	
	[Listener(event="propertyChange", callback="propertiesChange")]
//	[Listener(event="render", callback="validate")]
	
	public class FDisplayObject extends Sprite implements IComponent, IDrawable
	{
		public function FDisplayObject()
		{
			super();
			
			resolveProperties();
			resolveEvent();
			
			this.addEventListener(Event.ADDED_TO_STAGE, create);
			
			name = "FDisplayObject"+fish.util.UniqueUtil.getUnique();
		}
		
		public function resolveProperties():void
		{
			fish.metadata.resolveDefaultProperties(this);
		}
		
		public function resolveEvent():void
		{
			fish.metadata.resolveListener(this);	
		}
		
		public function validate(event:Event=null):void
		{
			if(level > ValidateLevel.NESTLEVEL_NONE) {
				FrameCallLater.call(name, redraw);
			}
		}
		
		public function redraw():void
		{
			if(super.width != width || super.height != height) {
				if(this.parent) {
					var e:ResizeEvent = new ResizeEvent(ResizeEvent.CHILD_RESIZE);
					e.oldValue = new Rectangle(0, 0, super.width, super.height);
					e.newValue = new Rectangle(0, 0, width, height);
					e.child = this;
					this.parent.dispatchEvent(e);
				}
			}
			
			super.x = x;
			super.y = y;
			super.width = width;
			super.height = height;
			super.alpha = alpha;
			super.scaleX = super.scaleY = 1;
			
			_level = ValidateLevel.NESTLEVEL_NONE;
			this.removeEventListener(Event.RENDER, validate);
		}
		
		public function propertiesChange(event:Event):void
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			if(!this.hasEventListener(Event.RENDER)) {
				this.addEventListener(Event.RENDER, validate);
			}
		}
		
		protected var created:Boolean = false;
		protected var destroyed:Boolean = false;
		
		public function destroy(event:Event = null):void
		{
			fish.metadata.resolveListener(this, true);
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			while(this.numChildren>0) {
				this.removeChildAt(0);
			}
			
			destroyed = true;
		}
		
		public function create(event:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, create);
			
			redraw();
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			created = true;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			var r:DisplayObject = super.addChild(child);
			dispatchResize();
			return r;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			var r:DisplayObject = super.addChildAt(child, index);
			dispatchResize();
			return r;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			var r:DisplayObject = super.removeChild(child);
			dispatchResize();
			return r;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			var r:DisplayObject = super.removeChildAt(index);
			dispatchResize();
			return r;
		}
		
		public function dispatchResize():void
		{
			this.dispatchEvent(new ResizeEvent(ResizeEvent.CHILD_RESIZE));
		}
		
		/**
		 * Basic Property
		 */
		protected var _x:Number;
		
		override public function get x():Number
		{
			return _x;
		}
		
		[Property(value="0", level="basicProperties")]
		[Bindable]
		override public function set x(value:Number):void
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			_x = value;
		}
		
		protected var _y:Number;
		
		override public function get y():Number
		{
			return _y;
		}
		[Property(value="0", level="basicProperties")]
		[Bindable]
		override public function set y(value:Number):void
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			_y = value;
		}
		
		protected var _width:Number;
		
		override public function get width():Number
		{
			return _width;
		}
		[Property(value="0", level="basicProperties")]
		[Bindable]
		override public function set width(value:Number):void
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			_width = value;
		}
		
		protected var _height:Number;
		
		override public function get height():Number
		{
			return _height;
		}
		[Property(value="0", level="basicProperties")]
		[Bindable]
		override public function set height(value:Number):void
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			_height = value;
		}
		
		protected var _alpha:Number;
		
		override public function get alpha():Number
		{
			return _alpha;
		}
		[Property(value="1", level="basicProperties")]
		[Bindable]
		override public function set alpha(value:Number):void
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			_alpha = value;
		}
		
		/**
		 * Redraw Property
		 */
		protected var _name:String;
		
		override public function get name():String
		{
			return _name;
		}
		override public function set name(value:String):void
		{
			_name = value;
		}
		
		protected var _level:uint;
		
		public function get level():uint
		{
			return _level;
		}
		public function set level(value:uint):void
		{
			if(value > level) {
				_level = value;
			}
		}
		
		protected var _enable:Boolean = true;
		
		public function get enable():Boolean
		{
			return _enable;
		}
		
		public function set enable(value:Boolean):void
		{
			dispatchEvent(new DataChangeEvent("enableChange", _enable, value));
			_enable = value;
		}
		
		private var _canDrag:Boolean = false;

		public function get canDrag():Boolean
		{
			return _canDrag;
		}

		public function set canDrag(value:Boolean):void
		{
			_canDrag = value;
		}

		public function onDrag():void
		{
			
		}
		
		public function dragOver(success:Boolean, source:DragSource):void
		{
			
		}
	}
}