package fish.display
{
	import fish.core.FrameCallLater;
	import fish.core.IComponent;
	import fish.core.IDrawable;
	import fish.core.ValidateLevel;
	import fish.events.ResizeEvent;
	import fish.manager.DragSource;
	import fish.metadata.*;
	import fish.util.TextFormatFactory;
	import fish.util.UniqueUtil;
	
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[Listener(event="propertyChange", callback="propertiesChange")]
	
	public class FTextField extends TextField implements IComponent, IDrawable
	{
		public function FTextField(value:String = null, useShadow:Boolean = false)
		{
			super();
			
			resolveProperties();
			resolveEvent();
			
			this.text = value || "";
			this.useShadow = useShadow;
			this.gridFitType = flash.text.GridFitType.PIXEL;
			this.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			this.mouseEnabled = this.mouseWheelEnabled = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE, create);
			
			name = "FTextField"+fish.util.UniqueUtil.getUnique();
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
			
			if(_format) {
				super.setTextFormat(_format);
			}
			
			if(useShadow) {
				this.filters = [new GlowFilter(0, 1, 4, 4)];
			}
			
			_level = ValidateLevel.NESTLEVEL_NONE;
			this.removeEventListener(Event.RENDER, validate);
		}
		
		public function propertiesChange(event:Event = null):void
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
			
			destroyed = true;
		}
		
		public function create(event:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, create);
			
			redraw();
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			created = true;
		}
		
		/**
		 * TextField Property
		 */
		override public function get text():String
		{
			return super.text;
		}
		
		override public function set text(value:String):void
		{
			super.text = value;
			if(format != null) {
				super.setTextFormat(format);
			}
		}
		
		protected var _format:TextFormat;
		
		public function get format():TextFormat
		{
			return _format;
		}
		
		public function set format(value:TextFormat):void
		{
			_format = value;
			propertiesChange();
		}
		
		override public function get htmlText():String
		{
			return super.htmlText;
		}
		
		override public function set htmlText(value:String):void
		{
			super.htmlText = value;
		}
		
		/**
		 * New Important Property
		 */
		protected var _target:*;
		
		public function set target(value:*):void
		{
			_target = value;
		}
		
		protected var _useShadow:Boolean;
		
		public function get useShadow():Boolean
		{
			return _useShadow;
		}
		
		[Property(value="0", level="basicProperties")]
		public function set useShadow(value:Boolean):void
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			_useShadow = value;
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
			_enable = value;
		}
		
		override public function get visible():Boolean
		{
			return super.visible;
		}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = super.mouseEnabled = value;
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