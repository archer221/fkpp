package com.utils {
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @version 20100401
	 * @author Cafe
	 */
	public class MathUtil {

		public static const ORIGIN : Point = new Point(0, 0);

		private static var _cosLock : Array;

		private static var _sinLock : Array;

		public static function angleToRadian(angle : int) : Number {
			return angle * Math.PI / 180;
		}

		public static function toUAngle(angle : int) : int {
			if(angle > -1 && angle < 360)return angle;
			angle %= 360;
			if(angle < 0)angle += 360;
			return angle;
		}

		public static function cos(angle : int) : Number {
			if(MathUtil._cosLock == null) {
				MathUtil._cosLock = new Array(360);
				for(var i : int = 0;i < 360;i++) {
					MathUtil._cosLock[i] = Math.cos(i * Math.PI / 180);
				}
			}
			return MathUtil._cosLock[MathUtil.toUAngle(angle)];
		}

		public static function sin(angle : int) : Number {
			if(MathUtil._sinLock == null) {
				MathUtil._sinLock = new Array(360);
				for(var i : int = 0;i < 360;i++) {
					MathUtil._sinLock[i] = Math.sin(i * Math.PI / 180);
				}
			}
			return MathUtil._sinLock[MathUtil.toUAngle(angle)];
		}

		public static function toIntRect(rect : Rectangle) : Rectangle {
			rect.x = Math.round(rect.x);
			rect.y = Math.round(rect.y);
			rect.width = Math.round(rect.width);
			rect.height = Math.round(rect.height);
			return rect;
		}

		public static function clamp(n : Number,min : Number,max : Number) : Number {
			if(n < min)return min;
			if(n > max)return max;
			return n;
		}

		public static function getAngle(startX : int,startY : int,endX : int,endY : int) : int {
			var dx : Number = endX - startX;
			var dy : Number = endY - startY;
			return Math.round(Math.atan2(dy, dx) / Math.PI * 180);
		}

		public static function getTwoPointAngle(start : Point,end : Point) : int {
			var dx : Number = end.x - start.x;
			var dy : Number = end.y - start.y;
			return Math.round(Math.atan2(dy, dx) / Math.PI * 180);
		}

		public static function random(min : int,max : int) : int {
			return Math.round(Math.random() * (max - min)) + min;
		}

		public static function randomList(max : int) : Array {
			var s : Array = new Array();
			for(var i : int = 0;i < max;i++) {
				s.push(i);
			}
			var t : Array = new Array();
			while(s.length > 0) {
				t.push(s.splice(random(0, s.length - 1), 1));
			}
			return t;
		}

		public static function randomBoolean() : Boolean {
			var i : int = MathUtil.random(0, 1);
			return i == 0;
		}

		public static function getDistance(startX : Number,startY : Number,endX : Number,endY : Number) : Number {
			var dx : Number = endX - startX;
			var dy : Number = endY - startY;
			return Math.sqrt(dx * dx + dy * dy);
		}

		public static function getTwoPointDistance(start : Point,end : Point) : Number {
			if(start == null || end == null)return 0;
			var dx : Number = end.x - start.x;
			var dy : Number = end.y - start.y;
			return Math.sqrt(dx * dx + dy * dy);
		}

		public static function rotate(x : int,y : int,angle : int,tx : int = 0,ty : int = 0) : Point {
			var xr : int = Math.round(x * MathUtil.cos(angle)) - Math.round(y * MathUtil.sin(angle)) + tx;
			var yr : int = Math.round(x * MathUtil.sin(angle)) + Math.round(y * MathUtil.cos(angle)) + ty;
			return new Point(xr, yr);
		}

		public static function getRotateMatrix(target : DisplayObject,angle : int) : void {
			var matrix : Matrix = new Matrix();
			matrix.rotate(angle * Math.PI / 180);
			var a : Point = matrix.transformPoint(new Point(0, 0));
			var b : Point = matrix.transformPoint(new Point(target.width, 0));
			var c : Point = matrix.transformPoint(new Point(target.width, target.height));
			var d : Point = matrix.transformPoint(new Point(0, target.height));
			var minX : Number = Math.min(a.x, b.x, c.x, d.x);
			var minY : Number = Math.min(a.y, b.y, c.y, d.y);
			matrix.tx += -minX;
			matrix.ty += -minY;
		}

		public static function transformRect(a : Point,b : Point,c : Point,d : Point,tx : int,ty : int) : void {
			a.x += tx;
			a.y += ty;
			b.x += tx;
			b.y += ty;
			c.x += tx;
			c.y += ty;
			d.x += tx,
			d.y += ty;
		}

		public static function cutTwoPoint(source : Point,target : Point,radius : int) : Array {
			var distance : Number = MathUtil.getTwoPointDistance(source, target);
			var diameter : int = radius << 1;
			var cut : Point = new Point();
			if(distance > diameter) {
				var count : int = Math.ceil(distance / diameter);
				var angle : int = MathUtil.getTwoPointAngle(source, target);
				cut.x = Math.round(diameter * MathUtil.cos(angle));
				cut.y = Math.round(diameter * MathUtil.sin(angle));
				var list : Array = new Array();
				var point : Point = source.clone();
				for(var i : int = 0;i < count;i++) {
					list[i] = point;
					point = point.add(cut);
				}
				return list;
			} else {
				return [source];
			}
		}

		public static function getLastInsertPoint(source : Point,target : Point,radius : int) : Point {
			var distance : Number = MathUtil.getTwoPointDistance(source, target);
			var diameter : int = radius * 2;
			var cut : Point = new Point();
			if(distance > diameter) {
				var count : int = Math.ceil(distance / diameter) - 1;
				var angle : int = MathUtil.getTwoPointAngle(source, target);
				cut.x = count * diameter * MathUtil.cos(angle);
				cut.y = count * diameter * MathUtil.sin(angle);
				return source.add(cut);
			} else {
				return source;
			}
		}

		public static function getCrossAngle(source : int,target : int) : int {
			if(source == target)return 0;
			if(source >= 360)source -= 360;
			else if(source < 0)source += 360;
			if(target >= 360)target -= 360;
			else if(target < 0)target += 360;
			var angle : int;
			if(source < target) {
				angle = target - source;
				if(angle > 180) {
					angle = 360 - angle;
					return -angle;
				}
				else return angle;
			} else {
				angle = source - target;
				if(angle > 180) {
					angle = 360 - angle;
					return angle;
				}else return -angle;
			}
		}
	}
}