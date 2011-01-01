package com.ui.controls {
	import com.bd.BDData;
	import com.bd.BDUnit;
	import com.core.IDispose;
	import com.ui.core.UIComponent;
	import com.ui.core.UIComponentData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	/**
	 * BD Player
	 * 
	 * @author Cafe
	 * @version 20100726
	 */
	public class BDPlayer extends UIComponent implements IDispose {

		private var _bitmap : Bitmap;

		private var _data : BDData;

		private var _timer : Timer;

		private var _frame : int;

		private var _frames : Array;

		private var _index : int;

		private var _count : int;

		private var _loop : int;

		override protected function create() : void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}

		override protected function onHide() : void {
			super.onHide();
			stop();
		}

		private function timerHandler(event : TimerEvent) : void {
			if(_index == _frames.length) {
				_index = 0;
				if(_loop > 0) {
					_count++;
					if(_count == _loop) {
						_timer.stop();
						_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
						dispatchEvent(new Event(Event.COMPLETE));
						return;
					}
				}
			}
			goto(_frames[_index]);
			_index++;
		}

		private function goto(frame : int) : void {
			if(frame < 0 || frame >= _data.total) {
				_frame = -1;
				_bitmap.bitmapData = null;
				return;
			}
			if(_frame == frame)return;
			_frame = frame;
			var unit : BDUnit = _data.getBDUnit(_frame);
			_bitmap.x = unit.offset.x;
			_bitmap.y = unit.offset.y;
			_bitmap.bitmapData = unit.bd;
			_bitmap.smoothing = true;
		}

		public function BDPlayer(base : UIComponentData) {
			super(base);
			_timer = new Timer(80);
			_frame = -1;
		}

		public function dispose() : void {
			stop();
			if(_data != null) {
				_data.dispose();
			}
		}

		public function setBDData(data : BDData) : void {
			_data = data;
			_frame = -1;
			_bitmap.bitmapData = null;
		}

		/**
		 * play bd
		 * 
		 * @delay int default=80(0.08s)
		 * @frames Array
		 * @loop int 0 n
		 */
		public function play(delay : int = 80,frames : Array = null,loop : int = 1) : void {
			if(_data == null) {
				return;
			}
			stop();
			_frames = frames;
			if(_frames == null) {
				_frames = new Array();
				for(var i : int = 0;i < _data.total;i++) {
					_frames.push(i);
				}
			}
			if(_frames.length < 2) {
				frame = _frames[0];
			} else {
				_index = 0;
				_count = 0;
				_loop = loop;
				_timer.delay = delay;
				goto(_frames[_index++]);
				_timer.addEventListener(TimerEvent.TIMER, timerHandler);
				_timer.reset();
				_timer.start();
			}
		}

		public function stop() : void {
			if(_timer.running) {
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			}
		}

		public function set frame(frame : int) : void {
			if(_data == null)return;
			stop();
			goto(frame);
		}

		public function get frame() : int {
			return _frame;
		}

		public function get total() : int {
			return _data.total;
		}

		public function set flipH(value : Boolean) : void {
			scaleX = (value ? -1 : 1);
		}

		public function get hasNext() : Boolean {
			if(!_data)return false;
			return (_frame < _data.total - 1);
		}

		public function next() : void {
			frame = _frame + 1;
		}

		public function clone() : BDPlayer {
			var data : UIComponentData = _base.clone();
			var bd : BDPlayer = new BDPlayer(data);
			bd.moveTo(x, y);
			bd.scaleX = scaleX;
			bd.rotation = rotation;
			bd.setBDData(_data);
			bd.frame = 0;
			return bd;
		}
	}
}