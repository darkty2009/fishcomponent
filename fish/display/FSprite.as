package fish.display
{
	import fish.action.IAction;
	import fish.core.FrameCallLater;
	import fish.core.IActive;
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
	import flash.utils.Dictionary;
	
	import mx.events.PropertyChangeEvent;
	
	[Listener(event="propertyChange", callback="propertiesChange")]
//	[Listener(event="render", callback="validate")]
	
	public class FSprite extends Sprite implements IDrawable, IComponent, IActive
	{
		public function FSprite(value:* = null, isAdd:Boolean = true)
		{
			super();
			
			this.isAdd = isAdd;
			
			if(value && isAdd) {
				if(value is Class) {
					_target = new value();
				}
				else {
					_target = value;
				}
			}
			else if(!isAdd) {
				_target = value;
			}
			
			resolveProperties();
			resolveEvent();
			
			name = "FSprite"+fish.util.UniqueUtil.getUnique();
			
			if(this.isAdd) {
				this.addEventListener(Event.ADDED_TO_STAGE, create);
			}else {
				create();
			}
		}
		
		protected var isAdd:Boolean;
		
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
			this.removeEventListener(Event.RENDER, validate);
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
			
			if(isAdd) {
				super.x = x;
				super.y = y;
				super.width = width;
				super.height = height;
				super.alpha = alpha;
				super.scaleX = super.scaleY = 1;
			}else {
				_target.x = x;
				_target.y = y;
				_target.width = width;
				_target.height = height;
				_target.alpha = alpha;
				_target.scaleX = _target.scaleY = 1;
			}
			
			if(level > ValidateLevel.NESTLEVEL_BASIC && _mask) {
				if(!this.contains(_mask)) {
					this.addChild(_mask);
				}
				_target.mask = _mask;
			}
			
			_level = ValidateLevel.NESTLEVEL_NONE;
		}
		
		public function propertiesChange(event:Event = null):void
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			if(!isAdd) {
				validate();
			}else {
				if(!this.hasEventListener(Event.RENDER)) {
					this.addEventListener(Event.RENDER, validate);
				}
			}
		}
		
		protected var created:Boolean = false;
		protected var destroyed:Boolean = false;
		
		public function destroy(event:Event = null):void
		{
			fish.metadata.resolveListener(this, true);
			
			for(var key:* in actions) {
				(actions[key] as IAction).unregist();
			}
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			destroyed = false;
		}
		
		public function create(event:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, create);
			
			if(_target == null) {
				_target = new FDisplayObject();
				_target.width = this.width;
				_target.height = this.height;
				this.scaleX = this.scaleY = 1;	
			}
			
			if(isAdd) {
				addChild(_target as DisplayObject);
			}else {
				this._x = _target.x;
				this._y = _target.y;
				this._width = _target.width;
				this._height = _target.height;
				this._alpha = _target.alpha;
			}
			if(this._width == 0) {
				this._width = (_target as DisplayObject).width;
			}
			if(this._height == 0) {
				this._height = (_target as DisplayObject).height;
			}
			
			if(_target.hasOwnProperty("mouseEnable"))
				_target.mouseEnable = false;
			
			redraw();
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
			created = true;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			var r:DisplayObject;
			if(isAdd) {
				r = super.addChild(child);
				dispatchResize();
			}else {
				r = target.addChild(child);
			}
			return r;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			var r:DisplayObject;
			if(isAdd) {
				r = super.addChildAt(child, index);
				dispatchResize();
			}else {
				r = target.addChildAt(child, index);
			}
			return r;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			var r:DisplayObject;
			if(isAdd) {
				r = super.removeChild(child);
			}else {
				r = target.removeChild(child);
			}
			dispatchResize();
			return r;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			level = ValidateLevel.NESTLEVEL_BASIC;
			var r:DisplayObject;
			if(isAdd) {
				r = super.removeChildAt(index);
				dispatchResize();
			}else {
				r = target.removeChildAt(index);
			}
			return r;
		}
		
		public function dispatchResize():void
		{
			target && (target.dispatchEvent(new ResizeEvent(ResizeEvent.CHILD_RESIZE)));
		}
		
		/**
		 * New Important Property
		 */
		protected var _target:*;
		
		public function set target(value:*):void
		{
			_target = value;
		}
		
		public function get target():*
		{
			return _target;
		}
		
		protected var _cache:Boolean;
		
		public function set cache(value:Boolean):void
		{
			if(value != _cache) {
				this.cacheAsBitmap = value;
			}
			_cache = value;
		}
		
		public function get cache():Boolean
		{
			return _cache;
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
		
		protected var _mask:DisplayObject;
		
		override public function get mask():DisplayObject
		{
			return _mask;
		}
		[Property(value="null", level="basicProperties")]
		[Bindable]
		override public function set mask(value:DisplayObject):void
		{
			if(_mask != null) {
				this.target.mask = null;
				try {
					this.removeChild(_mask);
				}catch(e:Error) {}
			}
			
			if(value != null)
				level = ValidateLevel.NESTLEVEL_ALL;
			_mask = value;
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
		
		override public function get visible():Boolean
		{
			return super.visible;
		}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = super.mouseEnabled = super.mouseChildren = value;
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
		
		private var _canDrop:Boolean = false;
		
		public function get canDrop():Boolean
		{
			return _canDrop;
		}
		
		public function set canDrop(value:Boolean):void
		{
			_canDrop = value;
		}
		
		public function onDrag():void
		{
			
		}
		
		public function onDrop(source:DragSource):DragSource
		{
			return source;
		}
		
		public function dragOver(success:Boolean, source:DragSource):void
		{
			
		}
		
		/**
		 * IActive
		 */
		protected var _actions:Dictionary = new Dictionary();
		
		public function get actions():Dictionary
		{
			return _actions;
		}
		
		public function registAction(action:Class):void
		{
			if(actions[action] != null) {
				throw new Error("exist action " + action);
			}
			
			actions[action] = new action(this).regist();
		}
	}
}