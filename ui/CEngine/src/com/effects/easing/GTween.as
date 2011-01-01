package com.effects.easing {

	public class GTween {

		private var _time : int;

		private var _begin : Number;

		private var _end : Number;

		private var _change : Number;

		private var _position : Number;

		private var _duration : int;

		private var _ease : Function;

		public function GTween(duration : int = -1,ease : Function = null) {
			_duration = duration;
			_ease = (ease == null ? Regular.easeIn : ease);
			reset();
		}

		public function reset() : void {
			_change = _end - _begin;
			_position = _begin;
			_time = 0;
		}

		public function init(begin : Number,end : Number) : void {
			_begin = begin;
			_end = end;
			reset();
		}

		public function next() : Number {
			if(_time < _duration) {
				_time++;
				_position = _ease(_time, _begin, _change, _duration);
			} else {
				_position = _end;
			}
			return _position;
		}

		public function get begin() : Number {
			return _begin;
		}

		public function get end() : Number {
			return _end;
		}

		public function get change() : Number {
			return _change;
		}

		public function get position() : Number {
			return _position;
		}
		
		public function set duration(value:int):void{
			_duration=value;
		}

		public function get isEnd() : Boolean {
			return _time >= _duration;
		}
	}
}