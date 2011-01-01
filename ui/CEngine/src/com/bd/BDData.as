package com.bd {
	import com.core.IDispose;

	/**
	 * @author Cafe
	 * @version 20100325
	 */
	public class BDData implements IDispose {

		private var _list : Array;

		private var _total : int;

		public function BDData(value : Array) {
			_list = value;
			_total = _list.length;
		}

		public function getBDUnit(frame : int) : BDUnit {
			if(frame < 0 || frame >= _list.length)return null;
			return _list[frame];
		}

		public function get total() : int {
			return _total;
		}

		public function dispose() : void {
			if(_list == null)return;
			for each(var bd:BDUnit in _list) {
				bd.dispose();
			}
			_list.splice(0);
		}
	}
}