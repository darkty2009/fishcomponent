package fish.util
{
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	public class KeyCode
	{
		public static const FORESLASH:int = 191;
		public static const ACCENT_GRAVE:int = 192;
		public static const BACKSPACE:int = Keyboard.BACKSPACE;
		public static const SHIFT:int = Keyboard.SHIFT;
		public static const MINUS:int = 189;
		public static const LEFT_BRACKET:int = 219;
		public static const ESCAPE:int = Keyboard.ESCAPE;
		public static const ENTER:int = Keyboard.ENTER;
		public static const INSERT:int = Keyboard.INSERT;
		public static const UNDERSCORE:int = 189;
		public static const END:int = Keyboard.END;
		public static const SEMICOLON:int = 186;
		public static const COMMA:int = 188;
		public static const BACKSLASH:int = 220;
		public static const HOME:int = Keyboard.HOME;
		public static const SPACE:int = Keyboard.SPACE;
		public static const GREATER_THAN:int = 190;
		public static const LESS_THAN:int = 188;
		public static const CONTROL:int = Keyboard.CONTROL;

		public static const SINGLE_QUOTE:int = 222;
		public static const DELETE:int = Keyboard.DELETE;
		public static const PIPE:int = 220;
		
		public static const LEFT_BRACE:int = 219;
		public static const RIGHT_BRACE:int = 221;
		public static const RIGHT_BRACKET:int = 221;
		
		public static const LEFT:int = Keyboard.LEFT;
		public static const RIGHT:int = Keyboard.RIGHT;
		public static const UP:int = Keyboard.UP;
		public static const DOWN:int = Keyboard.DOWN;
		
		public static const PAGE_UP:int = Keyboard.PAGE_UP;
		public static const PAGE_DOWN:int = Keyboard.PAGE_DOWN;
		
		public static const PLUS:int = 187;
		public static const EQUALS:int = 187;
		
		public static const NUM_0:int = 48;
		public static const NUM_1:int = 49;
		public static const NUM_2:int = 50;
		public static const NUM_3:int = 51;
		public static const NUM_4:int = 52;
		public static const NUM_5:int = 53;
		public static const NUM_6:int = 54;
		public static const NUM_7:int = 55;
		public static const NUM_8:int = 56;
		public static const NUM_9:int = 57;
		
		public static const NUMPAD_DECIMAL:int = Keyboard.NUMPAD_DECIMAL;
		public static const NUMPAD_ADD:int = Keyboard.NUMPAD_ADD;
		public static const NUMPAD_MULTIPLY:int = Keyboard.NUMPAD_MULTIPLY;
		public static const NUMPAD_ENTER:int = Keyboard.NUMPAD_ENTER;
		public static const NUMPAD_SUBTRACT:int = Keyboard.NUMPAD_SUBTRACT;
		public static const NUMPAD_DIVIDE:int = Keyboard.NUMPAD_DIVIDE;
		public static const NUMPAD_0:int = Keyboard.NUMPAD_0;
		public static const NUMPAD_1:int = Keyboard.NUMPAD_1;
		public static const NUMPAD_2:int = Keyboard.NUMPAD_2;
		public static const NUMPAD_3:int = Keyboard.NUMPAD_3;
		public static const NUMPAD_4:int = Keyboard.NUMPAD_4;
		public static const NUMPAD_5:int = Keyboard.NUMPAD_5;
		public static const NUMPAD_6:int = Keyboard.NUMPAD_6;
		public static const NUMPAD_7:int = Keyboard.NUMPAD_7;
		public static const NUMPAD_8:int = Keyboard.NUMPAD_8;
		public static const NUMPAD_9:int = Keyboard.NUMPAD_9;
		
		public static const CAPS_LOCK:int = Keyboard.CAPS_LOCK;
		public static const TAB:int = Keyboard.TAB;
		public static const PERIOD:int = 190;
		public static const QUESTION_MARK:int = 191;
		public static const COLON:int = 186;
		public static const TILDE:int = 192;
		
		public static const A:int = 65;
		public static const B:int = 66;
		public static const C:int = 67;
		public static const D:int = 68;
		public static const E:int = 69;
		public static const F:int = 70;
		public static const G:int = 71;
		public static const H:int = 72;
		public static const I:int = 73;
		public static const J:int = 74;
		public static const K:int = 75;
		public static const L:int = 76;
		public static const M:int = 77;
		public static const N:int = 78;
		public static const O:int = 79;
		public static const P:int = 80;
		public static const Q:int = 81;
		public static const R:int = 82;
		public static const S:int = 83;
		public static const T:int = 84;
		public static const U:int = 85;
		public static const V:int = 86;
		public static const W:int = 87;
		public static const X:int = 88;
		public static const Y:int = 89;
		public static const Z:int = 90;
		
		public static const F1:int = Keyboard.F1;
		public static const F2:int = Keyboard.F2;
		public static const F3:int = Keyboard.F3;
		public static const F4:int = Keyboard.F4;
		public static const F5:int = Keyboard.F5;
		public static const F6:int = Keyboard.F6;
		public static const F7:int = Keyboard.F7;
		public static const F8:int = Keyboard.F8;
		public static const F9:int = Keyboard.F9;
		public static const F10:int = Keyboard.F10;
		public static const F11:int = Keyboard.F11;
		public static const F12:int = Keyboard.F12;
		public static const F13:int = Keyboard.F13;
		public static const F14:int = Keyboard.F14;
		public static const F15:int = Keyboard.F15;
		
		private static var instance:KeyCode;
		
		public static function getInstance():KeyCode
		{
			if(instance == null)
				instance = new KeyCode();
			
			return instance;
		}
		
		private var map:Dictionary;
		
		public function KeyCode()
		{
			map = new Dictionary();
			
			this.map[LEFT] = "LEFT";
			this.map[RIGHT] = "RIGHT";
			this.map[SHIFT] = "SHIFT";
			this.map[CONTROL] = "CONTROL";
			this.map[TAB] = "TAB";
			this.map[CAPS_LOCK] = "CAPS_LOCK";
			this.map[ENTER] = "ENTER";
			this.map[ESCAPE] = "ESCAPE";
			this.map[END] = "END";
			this.map[HOME] = "HOME";
			this.map[INSERT] = "INSERT";
			this.map[PAGE_UP] = "PAGE_UP";
			this.map[PAGE_DOWN] = "PAGE_DOWN";
			this.map[DELETE] = "DELETE";
			this.map[BACKSPACE] = "BACKSPACE";
			this.map[SPACE] = "SPACE";
			this.map[F1] = "F1";
			this.map[F2] = "F2";
			this.map[F3] = "F3";
			this.map[F4] = "F4";
			this.map[F5] = "F5";
			this.map[F6] = "F6";
			this.map[F7] = "F7";
			this.map[F8] = "F8";
			this.map[F9] = "F9";
			this.map[F10] = "F10";
			this.map[F11] = "F11";
			this.map[F12] = "F12";
			this.map[F13] = "F13";
			this.map[F14] = "F14";
			this.map[F15] = "F15";
			this.map[NUMPAD_0] = "NUMPAD_0";
			this.map[NUMPAD_1] = "NUMPAD_1";
			this.map[NUMPAD_2] = "NUMPAD_2";
			this.map[NUMPAD_3] = "NUMPAD_3";
			this.map[NUMPAD_4] = "NUMPAD_4";
			this.map[NUMPAD_5] = "NUMPAD_5";
			this.map[NUMPAD_6] = "NUMPAD_6";
			this.map[NUMPAD_7] = "NUMPAD_7";
			this.map[NUMPAD_8] = "NUMPAD_8";
			this.map[NUMPAD_9] = "NUMPAD_9";
			this.map[NUMPAD_MULTIPLY] = "NUMPAD_MULTIPLY";
			this.map[NUMPAD_ADD] = "NUMPAD_ADD";
			this.map[NUMPAD_ENTER] = "NUMPAD_ENTER";
			this.map[NUMPAD_SUBTRACT] = "NUMPAD_SUBTRACT";
			this.map[NUMPAD_DECIMAL] = "NUMPAD_DECIMAL";
			this.map[NUMPAD_DIVIDE] = "NUMPAD_DIVIDE";
			this.map[NUM_0] = "NUM_0";
			this.map[NUM_1] = "NUM_1";
			this.map[NUM_2] = "NUM_2";
			this.map[NUM_3] = "NUM_3";
			this.map[NUM_4] = "NUM_4";
			this.map[NUM_5] = "NUM_5";
			this.map[NUM_6] = "NUM_6";
			this.map[NUM_7] = "NUM_7";
			this.map[NUM_8] = "NUM_8";
			this.map[NUM_9] = "NUM_9";
			this.map[A] = "A";
			this.map[B] = "B";
			this.map[C] = "C";
			this.map[D] = "D";
			this.map[E] = "E";
			this.map[F] = "F";
			this.map[G] = "G";
			this.map[H] = "H";
			this.map[I] = "I";
			this.map[J] = "J";
			this.map[K] = "K";
			this.map[L] = "L";
			this.map[M] = "M";
			this.map[N] = "N";
			this.map[O] = "O";
			this.map[P] = "P";
			this.map[Q] = "Q";
			this.map[R] = "R";
			this.map[S] = "S";
			this.map[T] = "T";
			this.map[U] = "U";
			this.map[V] = "V";
			this.map[W] = "W";
			this.map[X] = "X";
			this.map[Y] = "Y";
			this.map[Z] = "Z";
			this.map[SEMICOLON] = "SEMICOLON";
			this.map[COLON] = "COLON";
			this.map[EQUALS] = "EQUALS";
			this.map[PLUS] = "PLUS";
			this.map[MINUS] = "MINUS";
			this.map[UNDERSCORE] = "UNDERSCORE";
			this.map[FORESLASH] = "FORESLASH";
			this.map[QUESTION_MARK] = "QUESTION_MARK";
			this.map[ACCENT_GRAVE] = "ACCENT_GRAVE";
			this.map[TILDE] = "TILDE";
			this.map[LEFT_BRACKET] = "LEFT_BRACKET";
			this.map[LEFT_BRACE] = "LEFT_BRACE";
			this.map[BACKSLASH] = "BACKSLASH";
			this.map[PIPE] = "PIPE";
			this.map[RIGHT_BRACKET] = "RIGHT_BRACKET";
			this.map[RIGHT_BRACE] = "RIGHT_BRACE";
			this.map[SINGLE_QUOTE] = "SINGLE_QUOTE";
			this.map[COMMA] = "COMMA";
			this.map[LESS_THAN] = "LESS_THAN";
			this.map[PERIOD] = "PERIOD";
			this.map[GREATER_THAN] = "GREATER_THAN";
		}
		
		public static function getCodeChar(target:int):String
		{
			return getInstance().map[target];
		}
	}
}