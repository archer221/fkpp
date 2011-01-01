package com.color {

	/**
	 * @version 20091115
	 * @author Cafe
	 */
	public class ARGB {

		public var alpha : Number;

		public var red : Number;

		public var green : Number;

		public var blue : Number;

		public function ARGB(a : Number = NaN,r : Number = NaN,g : Number = NaN,b : Number = NaN) {
			alpha = a;
			red = r;
			green = g;
			blue = b;
		}

		public static function argbToHex(a : uint,r : uint,g : uint,b : uint) : uint {
			var color : uint = a << 24 | r << 16 | g << 8 | b;
			return color;
		}

		public static function hexToArgb(hex : uint) : ARGB {
			var argb : ARGB = new ARGB();
			argb.alpha = (hex >> 24) & 0xFF;
			argb.red = (hex >> 16) & 0xFF;
			argb.green = (hex >> 8) & 0xFF;
			argb.blue = hex & 0xFF;
			return argb;
		} 

		public static function hexToCSS(rgb : uint) : String {
			return "#" + rgb.toString(16);
		}
	}
}
