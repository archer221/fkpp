package com.ui.controls {
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponent;
	import com.ui.data.IconData;
	import com.utils.BDUtil;
	import com.utils.ColorMatrixUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;

	/**
	 * @version 20100402
	 * @author Cafe
	 */
	public class Icon extends UIComponent {
		protected var _data : IconData;
		protected var _bitmap : Bitmap;
		protected var _bd : BitmapData;
		protected var _flipH : Boolean = false;
		protected var _offset : Point = new Point(0, 0);

		override protected function create() : void {
			_bitmap = new Bitmap();
			if (_data.asset) {
				_bd = BDUtil.getBD(_data.asset);
			} else {
				_bd = _data.bitmapData;
			}
			addChild(_bitmap);
			bitmapData = _bd;
		}

		public function Icon(data : IconData) {
			_data = data;
			super(data);
		}

		public function set bitmapData(value : BitmapData) : void {
			_bd = value;
			if (_bd != null) {
				_bitmap.bitmapData = _bd;
				_bitmap.smoothing = true;
				if (_data.scaleMode == ScaleMode.AUTO_SIZE) {
					_width = _bd.width - 1;
					_height = _bd.height - 1;
				} else {
					_bitmap.width = _width;
					_bitmap.height = _height;
				}
			} else {
				_bitmap.bitmapData = null;
			}
			var scaleX : Number = (_bitmap.scaleX > 0 ? _bitmap.scaleX : -_bitmap.scaleX);
			if (_flipH) {
				_bitmap.scaleX = -scaleX;
				_bitmap.x = _offset.x + _bitmap.width;
			} else {
				_bitmap.scaleX = scaleX;
				_bitmap.x = _offset.x;
			}
		}

		public function set gray(value : Boolean) : void {
			filters = (value ? [new ColorMatrixFilter(ColorMatrixUtil.GRAY)] : null);
		}

		public function set offset(offset : Point) : void {
			_offset = offset.clone();
			_bitmap.x = (_flipH ? _offset.x + _bitmap.width : _offset.x);
			_bitmap.y = _offset.y;
		}

		public function setFlipH(value : Boolean) : void {
			_flipH = value;
		}

		public function clone() : Icon {
			var data : IconData = _data.clone();
			data.bitmapData = _bd;
			var icon : Icon = new Icon(data);
			return icon;
		}
	}
}