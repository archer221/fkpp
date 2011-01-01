package com.utils {
	import com.bd.BDData;
	import com.bd.BDUnit;
	import com.net.AssetData;
	import com.net.RESManager;
	import com.ui.manager.UIManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Dictionary;


	com.net.AssetData;


	/**
	 * @version 20100325
	 * @author Cafe
	 */
	public class BDUtil {

		private static var _cache : Dictionary = new Dictionary(true);

		private static function toBDS(mc : MovieClip) : BDData {
			if(mc == null)return null;
			var unit : BDUnit;
			var bp : Bitmap;
			var rect : Rectangle;
			var mtx : Matrix;
			mc.gotoAndStop(1);
			var list : Array = new Array();
			for(var i : int = 0;i < mc.totalFrames;i++) {
				unit = new BDUnit();
				bp = mc.getChildAt(0) as Bitmap;
				if(bp == null) {
					rect = mc.getBounds(mc);
					if(rect.width < 1 || rect.height < 1) {
						list.push(null);
						continue;
					} else {
						unit.offset = new Point(rect.x, rect.y);
						unit.bd = new BitmapData(rect.width, rect.height, true, 0);
						mtx = new Matrix();
						mtx.translate(Math.floor(-rect.x), Math.floor(-rect.y));
						unit.bd.draw(mc, mtx, null, null, null, true);
						list.push(unit);
					}
				} else {
					bp.bitmapData.lock();
					unit.offset = new Point(bp.x, bp.y);
					unit.bd = bp.bitmapData;
					list.push(unit);
				}
				mc.nextFrame();
			}
			return new BDData(list);
		}

		private static function toBD(skin : Sprite) : BDUnit {
			if(skin == null || skin.numChildren < 1)return null;
			var bp : Bitmap = skin.getChildAt(0) as Bitmap;
			var unit : BDUnit;
			if(bp != null) {
				bp.bitmapData.lock();
				unit = new BDUnit();
				unit.offset = new Point(bp.x, bp.y);
				unit.bd = bp.bitmapData;
				return unit;
			} 
			var rect : Rectangle = skin.getBounds(skin);
			if(rect.width < 1 || rect.height < 1) {
				return null;
			}
			unit = new BDUnit();
			unit.offset = new Point(rect.x, rect.y);
			unit.bd = new BitmapData(rect.width, rect.height, true, 0);
			var mtx : Matrix = new Matrix();
			mtx.translate(Math.floor(-rect.x), Math.floor(-rect.y));
			unit.bd.draw(skin, mtx, null, null, null, true);
			return unit;
		}

		public static function getResizeBD(source : IBitmapDrawable,w : int,h : int) : BitmapData {
			if(source == null)return null;
			var sw : int = 0;
			var sh : int = 0;
			if(source is DisplayObject) {
				sw = DisplayObject(source).width;
				sh = DisplayObject(source).height;
			}else if(source is BitmapData) {
				sw = BitmapData(source).width;
				sh = BitmapData(source).height;
			} else {
				//Logger.error("unkown type");
				return null;
			}
			var a : Number = w / sw;
			var d : Number = h / sh;
			var mtx : Matrix = new Matrix(a, 0, 0, d, 0, 0);
			var target : BitmapData = new BitmapData(w, h, true, 0);
			target.draw(source, mtx, null, null, null, true);
			return target;
		}

		public static function getThumbBD(bd : BitmapData,w : int,h : int,gap : int) : BitmapData {
			if(bd == null)return null;
			var rect : Rectangle = bd.getColorBoundsRect(0xFF000000, 0x00000000, false);
			var source : BitmapData;
			var mtx : Matrix = new Matrix();
			var sx : Number;
			var sy : Number;
			var s : Number;
			var tx : int;
			var ty : int;
			if(rect.width == 0 || rect.height == 0) {
				source = bd.clone();
				sx = (w - gap * 2) / bd.width;
				sy = (h - gap * 2) / bd.height;
				s = Math.min(Math.min(sx, sy), 1);
				tx = gap;
				ty = gap;
			} else {
				source = new BitmapData(rect.width, rect.height, true, 0);
				source.copyPixels(bd, rect, MathUtil.ORIGIN);
				sx = (w - gap * 2) / rect.width;
				sy = (h - gap * 2) / rect.height;
				s = Math.min(Math.min(sx, sy), 1);
				tx = (w - rect.width * s) * 0.5;
				ty = (h - rect.height * s) * 0.5;
			}
			mtx.scale(s, s);
			mtx.translate(tx, ty);
			var target : BitmapData = new BitmapData(w, h, true, 0);
			target.draw(source, mtx, null, null, null, true);
			source.dispose();
			return target;
		}

		public static function getCutRect(source : BitmapData) : Rectangle {
			return source.getColorBoundsRect(0xFF000000, 0x00000000, false);
		}

		public static function getCutBD(source : BitmapData) : BitmapData {
			var rect : Rectangle = source.getColorBoundsRect(0xFF000000, 0x00000000, false);
			var bd : BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			bd.copyPixels(source, rect, MathUtil.ORIGIN);
			return bd;
		}

		public static function getResizeCutBD(source : BitmapData,scale : Number) : BDUnit {
			var w : int = Math.ceil(source.width * scale);
			var h : int = Math.ceil(source.height * scale);
			if(w < 1 || h < 1)return null;
			var resize : BitmapData = new BitmapData(w, h, true, 0);
			var mtx : Matrix = new Matrix();
			mtx.scale(scale, scale);
			resize.draw(source, mtx, null, null, null, true);
			var rect : Rectangle = resize.getColorBoundsRect(0xFF000000, 0x00000000, false);
			var cut : BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			cut.copyPixels(resize, rect, MathUtil.ORIGIN);
			resize.dispose();
			return new BDUnit(new Point(int(rect.x - w * 0.5), int(rect.y - h)), cut);
		}

		public static function getBD(asset : AssetData,frame : int = 0) : BitmapData {
			var skin : Sprite = UIManager.getUI(asset);
			if(skin is MovieClip) {
				var data : BDData = BDUtil.toBDS(MovieClip(skin));
				if(data == null) {
					//Logger.error(asset.key, "has error!");
					return null;
				}
			} else {
				var bu : BDUnit = BDUtil.toBD(skin);
				if(bu != null) {
					return bu.bd;
				} else {
					//Logger.error(asset.key, "not found!");
					return null;
				}
			}
			return data.getBDUnit(frame).bd;
		}

		public static function getBDData(asset : AssetData) : BDData {
			var key : String = asset.key;
			if(_cache[key] != null) {
				return _cache[key];
			}
			var data : BDData = BDUtil.toBDS(RESManager.getMC(asset));
			if(data == null) {
				//Logger.error(asset.key, "has error!");
				return null;
			}
			_cache[key] = data;
			return data;
		}

		public static function cutBDData(asset : AssetData,width : int,height : int) : BDData {
			var key : String = asset.key + "_cut";
			if(_cache[key] != null)return _cache[key];
			var data : BDData = BDUtil.getBDData(asset);
			var source : BitmapData = data.getBDUnit(0).bd;
			var max : int = Math.floor(source.width / width);
			var rect : Rectangle = new Rectangle(0, 0, width, height);
			var list : Array = new Array();
			for(var i : int = 0;i < max;i++) {
				var unit : BDUnit = new BDUnit();
				unit.offset = new Point(0, 0);
				unit.bd = new BitmapData(width, height, true, 0);
				unit.bd.copyPixels(source, rect, MathUtil.ORIGIN);
				rect.x += width;
				list.push(unit);
			}
			_cache[key] = new BDData(list);
			return _cache[key];
		}

		public static function toGaryBD(source : BitmapData) : BitmapData {
			if(source == null)return null;
			var bd : BitmapData = source.clone();
			bd.applyFilter(bd, bd.rect, bd.rect.topLeft, new ColorMatrixFilter(ColorMatrixUtil.GRAY));
			return bd;
		}

		public static function getCircle(radius : int) : BitmapData {
			var key : String = "circle_" + radius;
			if(_cache[key] != null)return _cache[key];
			var shape : Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 1);
			shape.graphics.drawCircle(radius, radius, radius);
			shape.graphics.endFill();
			var bd : BitmapData = new BitmapData(radius * 2, radius * 2, true, 0);
			bd.draw(shape);
			bd.lock();
			_cache[key] = bd;
			return bd;
		}

		public static function applySharpen(bd : BitmapData) : void {
			var amount : Number = 3;
			var a : Number = amount / -100;
			var b : Number = a * (-8) + 1;
			var mtx : Array = [a,a,a,a,b,a,a,a,a];
			var sharpen : ConvolutionFilter = new ConvolutionFilter(3, 3, mtx);
			bd.applyFilter(bd, bd.rect, bd.rect.topLeft, sharpen);
		}

		public static function getTextSize(tf : TextField) : Rectangle {
			var bd : BitmapData = new BitmapData(tf.textWidth, tf.textHeight, true, 0);
			bd.draw(tf);
			var rect : Rectangle = bd.getColorBoundsRect(0xFF000000, 0x00000000, false);
			bd.dispose();
			return rect;
		}

		public static function createRef(p_source : DisplayObject) : void {
			var bd : BitmapData = new BitmapData(p_source.width, p_source.height, true, 0);
			var mtx : Matrix = new Matrix();
			mtx.d = -1;
			mtx.ty = bd.height;
			bd.draw(p_source, mtx);
			var width : int = bd.width;
			var height : int = bd.height;
			mtx = new Matrix();
			mtx.createGradientBox(width, height, 0.5 * Math.PI);
			var shape : Shape = new Shape();
			shape.graphics.beginGradientFill(GradientType.LINEAR, [0,0], [0.9,0.2], [0,0xFF], mtx);
			shape.graphics.drawRect(0, 0, width, height);
			shape.graphics.endFill();
			var mask_bd : BitmapData = new BitmapData(width, height, true, 0);
			mask_bd.draw(shape);
			bd.copyPixels(bd, bd.rect, MathUtil.ORIGIN, mask_bd, MathUtil.ORIGIN, false);
			var ref : Bitmap = new Bitmap();
			ref.y = p_source.height;
			ref.bitmapData = bd;
			p_source.parent.addChild(ref);
		}
	}
}