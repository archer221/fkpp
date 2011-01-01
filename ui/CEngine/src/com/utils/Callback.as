package com.utils {
 class Callback {

		private var _method : Function;

		private var _args : Array;

		public function Callback(method : Function,...args : Array) {
			_method = method;
			_args = args;
		}

		public function get method() : Function {
			return _method;
		}

		public function execute(...args : Array) : void {
			try {
				var new_args : Array = _args.concat();
				for each(var item:* in args) {
					new_args.push(item);
				}
				_method.apply(null, new_args);
			}catch(error : Error) {
				//Logger.error(this, error.message);
			}
		}

		public function equal(value : Callback) : Boolean {
			return _method == value.method;
		}
	}
}