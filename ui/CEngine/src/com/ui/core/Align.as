package com.ui.core {
	import com.ui.manager.UIManager;
	import flash.display.DisplayObject;


	/**
	 * @version 20100115
	 * @author Cafe
	 */
	public class Align extends Object {

		public static const CENTER : Align = new Align(-1, -1, -1, -1, 0, 0);

		public static const HCENTER : Align = new Align(-1, -1, -1, -1, 0, -1);

		protected var _left : int = -1;

		protected var _right : int = -1;

		protected var _top : int = -1;

		protected var _bottom : int = -1;

		protected var _horizontalCenter : int = -1;

		protected var _verticalCenter : int = -1;

		public function Align(left : int = -1,right : int = -1,top : int = -1,bottom : int = -1,
			horizontalCenter : int = -1,verticalCenter : int = -1) {
			_left = left;
			_right = right;
			_top = top;
			_bottom = bottom;
			_horizontalCenter = horizontalCenter;
			_verticalCenter = verticalCenter;
		}

		public static function getStageCenter(target : DisplayObject,targetX : int,targetY : int) : Align {
			var centerX : int = UIManager.root.stage.stageWidth * 0.5;
			var centerY : int = UIManager.root.stage.stageHeight * 0.5;
			var offsetX : int = targetX - centerX + target.width * 0.5;
			var offsetY : int = targetY - centerY + target.height * 0.5;
			return new Align(-1, -1, -1, -1, offsetX, offsetY);
		}

		public function set left(value : int) : void {
			_left = Math.max(0, value);
			_horizontalCenter = -1;
		}

		public function get left() : int {
			return _left;
		}

		public function set right(value : int) : void {
			_right = Math.max(0, value);
			_horizontalCenter = -1;
		}

		public function get right() : int {
			return _right;
		}

		public function set top(value : int) : void {
			_top = Math.max(0, value);
			_verticalCenter = -1;
		}

		public function get top() : int {
			return _top;
		}

		public function set bottom(value : int) : void {
			_bottom = Math.max(0, value);
			_verticalCenter = -1;
		}

		public function get bottom() : int {
			return _bottom;
		}

		public function set horizontalCenter(value : int) : void {
			_horizontalCenter = value;
			_left = -1;
			_right = -1;
		}

		public function get horizontalCenter() : int {
			return _horizontalCenter;
		}

		public function set verticalCenter(value : int) : void {
			_verticalCenter = value;
			_top = -1;
			_bottom = -1;
		}

		public function get verticalCenter() : int {
			return _verticalCenter;
		}

		
		public function clone() : Align {
			var align : Align = new Align(_left, _right, _top, _bottom, _horizontalCenter, _verticalCenter);
			return align;
		}

		public function toString() : String {
			return _left + "," + _right + "," + _top + "," + _bottom + "," + _horizontalCenter + "," + _verticalCenter;
		}
	}
}
