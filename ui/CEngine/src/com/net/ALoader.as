package com.net {
	import flash.events.EventDispatcher;

	/**
	 * @version 20000719
	 * @author thinkpad
	 */
	public class ALoader extends EventDispatcher {

		protected var _libData : LibData;

		protected var _loadData : LoadData;

		protected var _isLoadding : Boolean = false;

		protected var _isLoaded : Boolean = false;

		public function ALoader(data : LibData) {
			_libData = data;
			_loadData = new LoadData();
		}

		public function get isLoaded() : Boolean {
			return _isLoaded;
		}

		public function get key() : String {
			return _libData.key;
		}

		public function get loadData() : LoadData {
			return _loadData;
		}
		
		public function load():void{
		}
	}
}
