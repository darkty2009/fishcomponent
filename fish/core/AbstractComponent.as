package fish.core
{
	import fish.layout.ILayout;
	import fish.layout.Layout;
	import fish.logging.log;
	import fish.metadata.resolveDefaultProperties;
	import fish.metadata.resolveListener;
	import fish.metadata.resolveStyles;
	import fish.skins.ISkin;
	import fish.skins.ISkinable;
	import fish.utils.UniqueUtil;
	
	import flash.utils.Dictionary;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.PropertyChangeEvent;
	
	[Listener(event="propertyChange", callback="propertiesChange")]
	[Listener(event="removedFromStage", callback="removeAll")]
	[Listener(event="added", callback="added")]
	[Listener(event="enterFrame", callback="validate")]
	
	[State(name="normal", skin="fish.skins.component.ComponentNormalSkin")]
	
	public class AbstractComponent extends DisplayObjectContainer implements IDrawable, ISkinable, IMeasurable, IComponent
	{
		public static const NESTLEVEL_NONE:uint = 0;
		public static const NESTLEVEL_BASIC:uint = 1;
		public static const NESTLEVEL_ALL:uint = 2;
		
		/**
		 * Basic Properties
		 */
		protected var _x:Number;
		protected var _y:Number;
		protected var _width:Number;
		protected var _height:Number;
		protected var _minWidth:Number;
		protected var _minHeight:Number;
		protected var _maxWidth:Number;
		protected var _maxHeight:Number;
		protected var _percentWidth:Number;
		protected var _percentHeight:Number;
		protected var _alpha:Number;
		
		/**
		 * Redraw Properties
		 */
		protected var _name:String;
		protected var _level:uint;
		protected var _layout:Object;
		
		/**
		 * Skin Properties
		 */
		protected var _skinName:String;
		protected var _currentState:ISkin;
		
		/**
		 * Component Properties
		 */
		protected var _states:Dictionary;
		
		protected var _background:DisplayObjectContainer;
		protected var _foreground:DisplayObjectContainer;
		protected var _mouseground:DisplayObjectContainer;
		protected var _enable:Boolean = true;
		
		public function AbstractComponent()
		{
			super();
			
			name = "AbstractComponent"+fish.utils.UniqueUtil.getUnique();
			
			_layout = new Layout(this);
			_background = new Sprite;
			_foreground = new Sprite;
			_mouseground = new Sprite;
			
			resolveStyles();
			resolveProperties();
			resolveEvent();
		}
		
		override public function get name():String
		{
			return _name;
		}
		
		override public function set name(value:String):void
		{
			_name = value;
		}
		
		public function set level(value:uint):void
		{
			if(value > _level) {
				_level = value;
			}
		}
		
		public function get level():uint
		{
			return _level;
		}
		
		public function redraw():void
		{
			if(level>=NESTLEVEL_ALL) {
				updateAdvanced();
			}
			if(level>=NESTLEVEL_BASIC) {
				updateBasic();
			}
			
			_level = NESTLEVEL_NONE;
		}
		
		protected function updateBasic():void
		{
			super.width = width;
			super.height = height;
			super.x = x;
			super.y = y;
			super.alpha = alpha;
		}
		
		protected function updateAdvanced():void
		{
			_currentState.update(width, height);
		}
		
		public function set skinName(value:String):void
		{
			_skinName = value;
		}
		
		public function get skinName():String
		{
			return _skinName;
		}
		
		public function set states(value:*):void
		{
			_states = value;
		}
		
		public function get states():Dictionary
		{
			return _states;
		}
		
		public function setStateStyle(key:*, value:ISkin):void
		{
			_states[key] = value;
		}
		
		public function getStateStyle(value:*):ISkin
		{
			return _states[value] as ISkin;
		}
		
		public function resolveProperties():void
		{
			fish.metadata.resolveDefaultProperties(this, propertiesChange);
		}
		
		public function resolveStyles():void
		{
			fish.metadata.resolveStyles(this);
		}
		
		public function resolveEvent():void
		{
			fish.metadata.resolveListener(this);
		}
		
		override public function addChild(child:DisplayObject):void
		{
			level = AbstractComponent.NESTLEVEL_ALL;
			super.addChild(child);
			measure();
		}
		
		override public function removeChild(child:DisplayObject, dispose:Boolean=false):void
		{
			level = AbstractComponent.NESTLEVEL_ALL;
			super.removeChild(child, dispose);
			measure();
		}
		
		public function set currentState(value:ISkin):void
		{
			if(_currentState != null && _background.contains(_currentState as DisplayObject)) {
				_background.removeChild(_currentState as DisplayObject);
			}
			_currentState = value;
			
			_background.addChild(_currentState.update(_width, _height) as DisplayObject);
		}
		
		public function get currentState():ISkin
		{
			return _currentState;
		}
		
		[Property(value="0", level="basicProperties")]
		override public function set x(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "x", _x, value));
			_x = value;
		}
		
		override public function get x():Number
		{
			return _x;
		}
		
		[Property(value="0", level="basicProperties")]
		override public function set y(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "y", _y, value));
			_y = value;
		}
		
		override public function get y():Number
		{
			return _y;
		}
		
		[Property(value="400", level="advancedProperties")]
		override public function set width(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "width", _width, value));
			_width = value;
			measure();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		[Property(value="300", level="advancedProperties")]
		override public function set height(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "height", _height, value));
			_height = value;
			measure();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		[Property(value="80", level="basicProperties")]
		public function set minWidth(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minWidth", _minWidth, value));
			_minWidth = value;
		}
		
		public function get minWidth():Number
		{
			return _minWidth;
		}
		
		[Property(value="2880", level="basicProperties")]
		public function set maxWidth(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxWidth", _maxWidth, value));
			_maxWidth = value;
		}
		
		public function get maxWidth():Number
		{
			return _maxWidth;
		}
		
		[Property(value="60", level="basicProperties")]
		public function set minHeight(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minHeight", _minHeight, value));
			_minHeight = value;
		}
		
		public function get minHeight():Number
		{
			return _minHeight;
		}
		
		[Property(value="2880", level="basicProperties")]
		public function set maxHeight(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxHeight", _maxHeight, value));
			_maxHeight = value;
		}
		
		public function get maxHeight():Number
		{
			return _maxHeight;
		}
		
		[Property(value="0", level="advancedProperties")]
		public function set percentWidth(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percentWidth", _percentWidth, value));
			_percentWidth = value;
			measure();
		}
		
		public function get percentWidth():Number
		{
			return _percentWidth;
		}
		
		[Property(value="0", level="advancedProperties")]
		public function set percentHeight(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percentHeight", _percentHeight, value));
			_percentHeight = value;
			measure();
		}
		
		public function get percentHeight():Number
		{
			return _percentHeight;
		}
		
		[Property(value="1", level="basicProperties")]
		public override function set alpha(value:Number):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alpha", _alpha, value));
			_alpha = value;
		}
		
		public override function get alpha():Number
		{
			return _alpha;
		}
		
		public function set layout(value:Object):void
		{
			_layout = value;
			measure();
		}
		
		public function get layout():Object
		{
			return _layout;
		}
		
		public function measure():void
		{
			// 终于想到这方法是拿 来干嘛的了
			for(var i:Number = 0; i<this._background.numChildren;i++) {
				try {
					var child:AbstractComponent = this._background.getChildAt(0) as AbstractComponent;
					if(child == null || !child.hasOwnProperty("width") || !child.hasOwnProperty("height"))
						continue;
						
					if(child.width > this.width) {
						child.x -= child.width - width;
						child.width = width;
					}
					
					if(child.height > this.height) {
						child.y -= child.height - height;
						child.height = height;
					}
				}catch(e:Error) {
					fish.logging.log(1, this.name + " must be a non-null Object", this._background.name);
				}
			}
			
			for(var i:Number = 0; i<this._foreground.numChildren;i++) {
				try {
					var child:AbstractComponent = this._foreground.getChildAt(0) as AbstractComponent;
					if(child == null || !child.hasOwnProperty("width") || !child.hasOwnProperty("height"))
						continue;
					
					if(child.width > this.width) {
						child.x -= child.width - width;
						child.width = width;
					}
					
					if(child.height > this.height) {
						child.y -= child.height - height;
						child.height = height;
					}
				}catch(e:Error) {
					fish.logging.log(1, this.name + " must be a non-null Object", this._foreground.name);
				}
			}
		}
		
		public function validate(event:Event = null):void
		{
			if(level > 0)
				FrameCallLater.call(redraw);
		}
		
		public function setSize(widthValue:Number, heightValue:Number):void
		{
			width = widthValue;
			height = heightValue;
		}
		
		public function propertiesChange(event:PropertyChangeEvent = null):void
		{
			level = NESTLEVEL_BASIC;
		}
		
		public function added(event:Event = null):void
		{	
			if(checkEventTarget(event)) {
				addLayers();
			}
		}
		
		protected function checkEventTarget(event:Event):Boolean
		{
			if(event != null && event.target !== this)
				return false;
			
			return true;
		}
		
		private function addLayers():void
		{
			_currentState = getStateStyle("normal") as ISkin;
			
			super.addChild(_background);
			super.addChild(_foreground);
			super.addChild(_mouseground);
			
			_background.addChild(_currentState.update(_width, _height) as DisplayObject);
		}
		
		public function removeAll(event:* = null):void
		{
			fish.metadata.resolveListener(this, true);
		}
		
		public function toString():String
		{
			return name;
		}
	}
}