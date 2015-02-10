package fish.core
{
	import fish.core.FrameCallLater;
	import fish.metadata.resolveDefaultProperties;
	import fish.metadata.resolveListener;
	import fish.utils.UniqueUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import mx.events.PropertyChangeEvent;
	
	[Listener(event="propertyChange", callback="propertiesChange")]
	[Listener(event="removedFromStage", callback="removeAll")]
	[Listener(event="added", callback="added")]
	[Listener(event="render", callback="validate")]
	
	public class AbstractBitmap extends Bitmap implements IComponent, IDrawable, IMeasurable
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
		
		/**
		 * Bitmap Properties
		 */
		protected var _bitmapData:BitmapData;
		protected var _filters:Array;
		
		public function AbstractBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			
			name = "AbstractBitmap"+fish.utils.UniqueUtil.getUnique();
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
		
		public function resolveProperties():void
		{
			fish.metadata.resolveDefaultProperties(this, propertiesChange);
		}
		
		public function resolveEvent():void
		{
			fish.metadata.resolveListener(this);
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
		
		[Property(value="400", level="basicProperties")]
		[Bindable]
		override public function set width(value:Number):void
		{
			_width = value;
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		[Property(value="300", level="basicProperties")]
		[Bindable]
		override public function set height(value:Number):void
		{
			_height = value;
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
		
		[Property(value="null", callback="propertiesChange")]
		[Bindable]
		public override function set bitmapData(value:BitmapData):void
		{
			_bitmapData = value;
		}
		
		public override function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		
		[Property(value="null", callback="propertiesChange")]
		[Bindable]
		public override function set filters(value:Array):void
		{
			_filters = value;
		}
		
		public override function get filters():Array
		{
			return _filters;
		}
		
		public function measure():void
		{
			
		}
		
		public function validate(event:Event = null):void
		{
			if(level > 0)
				FrameCallLater.call(redraw);
		}
		
		public function redraw():void
		{
			updateBasic();
			
			_level = NESTLEVEL_NONE;
		}
		
		protected function updateBasic():void
		{
			
		}
		
		public function setSize(widthValue:Number, heightValue:Number):void
		{
			_width = widthValue;
			_height = heightValue;
			
			level = NESTLEVEL_ALL;
		}
		
		public function propertiesChange(event:PropertyChangeEvent = null):void
		{
			level = NESTLEVEL_ALL;
		}
		
		public function added(event:Event = null):void
		{	
			if(event != null && event.target !== this)
				return;
			
			this.bitmapData = _bitmapData;
		}
		
		public function removeAll(event:Event = null):void
		{
			fish.metadata.resolveListener(this, true);
		}
	}
}