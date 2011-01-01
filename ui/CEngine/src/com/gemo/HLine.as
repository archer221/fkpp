package com.gemo {
	import com.utils.MathUtil;
	import flash.geom.Point;


	/**
	 * HLine
	 * 
	 * @author Cafe
	 * @version 20100608
	 */
	public class HLine {

		private var _x : int;

		private var _y : int;

		private var _width : int;

		public function HLine(x : int,y : int,width : int) {
			_x = x;
			_y = y;
			_width = width;
		}

		public function get x() : int {
			return _x;
		}

		public function get y() : int {
			return _y;
		}

		public function get width() : int {
			return _width;
		}

		public function getRandomPoint() : Point {
			var x : int = _x + MathUtil.random(0, _width);
			return new Point(x, _y);
		}

		public function toString() : String {
			return "x=" + _x + ",y=" + _y + ",width=" + _width;
		}
	}
}