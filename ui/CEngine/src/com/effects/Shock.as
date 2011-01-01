package com.effects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	public class Shock extends Sprite {

		private var _target : Sprite;

		private var _show : Sprite;

		private var _offsets : Array;

		private var _offsetX : int;

		private var _offsetY : int;

		private var _glow : GlowFilter;

		private var _seed : Number;

		private var _bd : BitmapData;

		private var _show_bd : BitmapData;

		private var _spark_bd : BitmapData;

		private var _timer : Timer;

		private function timerHandler(event : TimerEvent) : void {
			var offset : Point;
			for each (offset in _offsets) {
				offset.x -= -_offsetX;
				offset.y += _offsetY;
			}
			_show_bd.perlinNoise(10, 20, 2, _seed, true, true, 1, true, _offsets);
			var filter : DisplacementMapFilter = new DisplacementMapFilter(_show_bd, new Point(), 1, 1, 16, 16, "color");
			_spark_bd.applyFilter(_bd, _bd.rect, new Point(), _glow);
			_spark_bd.applyFilter(_spark_bd, _bd.rect, new Point(), filter);
		}

		public function Shock() {
			_offsetX = 2;
			_offsetY = 2;
			_glow = new GlowFilter(0x66FFFF, 1, 1, 1, 100, 1, false, true);
			_timer = new Timer(50);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}

		public function set target(value : Sprite) : void {
			_target = value;
		}

		public function start() : void {
			var bounds : Rectangle = _target.getBounds(_target);
			var offsetX : int = 20;
			var offsetY : int = 20;
			var w : int = bounds.width + offsetX;
			var h : int = bounds.height + offsetY;
			bounds.x = bounds.x - offsetX * 0.5;
			bounds.y = bounds.y - offsetY * 0.5;
			_show = new Sprite();
			_show.x = _target.x;
			_show.y = _target.y;
			addChild(_show);
			var holder : Sprite = new Sprite();
			holder.x = bounds.x;
			holder.y = bounds.y;
			_show.addChild(holder);
			_bd = new BitmapData(w, h, true, 0);
			_spark_bd = new BitmapData(w, h, true, 0);
			_bd.draw(_target, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y));
			var spark_bp : Bitmap = new Bitmap();
			spark_bp.bitmapData = _spark_bd;
			holder.addChild(spark_bp);
			_offsets = new Array();
			for(var i : int = 0;i < 4;i++) {
				_offsets.push(new Point());
			}
			_seed = Math.round(Math.random() * 10);
			_show_bd = new BitmapData(w, h);
			var glow2 : GlowFilter = new GlowFilter(0x00FFFF, 0.6, 6, 6, 2, 1, false, false);
			var glow3 : GlowFilter = new GlowFilter(0x6666FF, 0.8, 8, 8, 3, 1, false, false);
			_target.filters = [glow2];
			holder.blendMode = "screen";
			holder.filters = [glow2, glow3];
			_timer.start();
		}

		public function end() : void {
			if(_timer.running)_timer.stop();
		}
	}
}