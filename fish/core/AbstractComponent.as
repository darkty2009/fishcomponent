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
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.events.PropertyChangeEvent;
	
	[Listener(event="propertyChange", callback="propertiesChange")]
	[Listener(event="removedFromStage", callback="removeAll")]
	[Listener(event="added", callback="added")]
	[Listener(event="render", callback="validate")]
	
	[State(name="normal", skin="fish.skins.component.ComponentNormalSkin")]
	
	public class AbstractComponent extends Sprite implements IDrawable, ISkinable, IMeasurable, IComponent
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
		
		protected var _background:Sprite;
		protected var _foreground:Sprite;
		protected var _mouseground:Sprite;
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
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			level = AbstractComponent.NESTLEVEL_ALL;
			var re:DisplayObject = super.addChild(child);
			measure();
			return re;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			level = AbstractComponent.NESTLEVEL_ALL;
			var re:DisplayObject = super.removeChild(child);
			measure();
			return re;
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
		[Bindable]
		override public function set x(value:Number):void
		{
			_x = value;
		}
		
		override public function get x():Number
		{
			return _x;
		}
		
		[Property(value="0", level="basicProperties")]
		[Bindable]
		override public function set y(value:Number):void
		{
			_y = value;
		}
		
		override public function get y():Number
		{
			return _y;
		}
		
		[Property(value="400", level="advancedProperties")]
		[Bindable]
		override public function set width(value:Number):void
		{
			_width = value;
			measure();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		[Property(value="300", level="advancedProperties")]
		[Bindable]
		override public function set height(value:Number):void
		{
			_height = value;
			measure();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		[Property(value="80", level="basicProperties")]
		[Bindable]
		public function set minWidth(value:Number):void
		{
			_minWidth = value;
		}
		
		public function get minWidth():Number
		{
			return _minWidth;
		}
		
		[Property(value="2880", level="basicProperties")]
		[Bindable]
		public function set maxWidth(value:Number):void
		{
			_maxWidth = value;
		}
		
		public function get maxWidth():Number
		{
			return _maxWidth;
		}
		
		[Property(value="60", level="basicProperties")]
		[Bindable]
		public function set minHeight(value:Number):void
		{
			_minHeight = value;
		}
		
		public function get minHeight():Number
		{
			return _minHeight;
		}
		
		[Property(value="2880", level="basicProperties")]
		[Bindable]
		public function set maxHeight(value:Number):void
		{
			_maxHeight = value;
		}
		
		public function get maxHeight():Number
		{
			return _maxHeight;
		}
		
		[Property(value="0", level="advancedProperties")]
		[Bindable]
		public function set percentWidth(value:Number):void
		{
			_percentWidth = value;
			measure();
		}
		
		public function get percentWidth():Number
		{
			return _percentWidth;
		}
		
		[Property(value="0", level="advancedProperties")]
		[Bindable]
		public function set percentHeight(value:Number):void
		{
			_percentHeight = value;
			measure();
		}
		
		public function get percentHeight():Number
		{
			return _percentHeight;
		}
		
		[Property(value="1", level="basicProperties")]
		[Bindable]
		public override function set alpha(value:Number):void
		{
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
			if(event != null && event.target !== this)
				return;
			
			_currentState = getStateStyle("normal") as ISkin;
			
			super.addChild(_background);
			super.addChild(_foreground);
			super.addChild(_mouseground);
			
			_background.addChild(_currentState.update(_width, _height) as DisplayObject);
		}
		
		public function removeAll(event:Event = null):void
		{
			fish.metadata.resolveListener(this, true);
		}
	}
}