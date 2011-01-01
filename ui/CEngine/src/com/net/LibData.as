package com.net {

	/**
	 * @version 20090712
	 * @author Cafe
	 */
	public class LibData {

		protected var _url : String;

		protected var _key : String;

		protected var _version : String;

		public function LibData(url : String,key : String = null,version : String = null) {
			_url = url;
			if(key == null) {
				var separator : String = (url.indexOf("/") > -1) ? "/" : "\\";
				_key = _url.split(separator).pop().split(".").shift();
			}
			else _key = key;
			_version = (version == null ? String(Math.random()) : version);
		}

		public function get url() : String {
			return _url;
		}

		public function get key() : String {
			return _key;
		}

		public function get version() : String {
			return _version;
		}
	}
}
