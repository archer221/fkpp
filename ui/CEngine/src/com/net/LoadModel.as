package com.net {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class LoadModel extends EventDispatcher {

		public static const MAX : int = 5;

		private var _list : Array;

		private var _done : int;

		private var _total : int;

		private var _speed : int;

		private var _progress : int;

		private function changeHandler(event : Event) : void {
			var count : int = 0;
			var speed : int = 0;
			for each(var data:LoadData in _list) {
				count += data.percent;
				speed += data.speed;
			}
			var progress : int = count + _done * 100;
			if(_progress == progress)return;
			_progress = progress;
			_speed = speed / _list.length;
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function LoadModel() {
			_list = new Array();
		}

		public function hasFree() : Boolean {
			return _list.length < MAX;
		}

		public function add(data : LoadData) : void {
			if(_list.length >= MAX)return;
			_list.push(data);
			data.addEventListener(Event.CHANGE, changeHandler);
		}

		public function remove(data : LoadData) : void {
			data.removeEventListener(Event.CHANGE, changeHandler);
			var index : uint = _list.indexOf(data);
			_list.splice(index, 1);
			_done++;
		}

		public function reset(value : int) : void {
			_progress = 0;
			_total = value;
			_done = 0;
			dispatchEvent(new Event(Event.INIT));
		}

		public function end() : void {
			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function get progress() : int {
			return _progress;
		}

		public function get speed() : int {
			return _speed;
		}

		public function get total() : int {
			return _total * 100;
		}
	}
}