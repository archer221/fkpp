package com.effects {
	import com.utils.MathUtil;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;


	/**
	 * @author Cafe
	 * @version 20100402
	 */
	public class GRefEffect extends GEffect {

		private var _ref_bp : Bitmap;

		override protected function onChangeTarget() : void {
			if(_ref_bp == null) {
				_ref_bp = new Bitmap();
				_target.parent.addChild(_ref_bp);
			}
			_ref_bp.x = _target.x;
			_ref_bp.y = _target.y + _target.height - 5;
		}

		override protected function timerHandler(event : TimerEvent) : void {
			var bd : BitmapData = new BitmapData(_target.width, _target.height, true, 0);
			var mtx : Matrix = new Matrix();
			mtx.d = -1;
			mtx.ty = bd.height;
			bd.draw(_target, mtx);
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
			if(_ref_bp.bitmapData != null) {
				_ref_bp.bitmapData.dispose();
			}
			_ref_bp.bitmapData = bd;
		}

		public function GRefEffect() {
		}

		override public function dispose() : void {
		}
	}
}
