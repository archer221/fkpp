package com.bin {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;

	flash.display.Loader;


	public class SWFChunk extends EventDispatcher {
		public var key : String;

		private var _data : ByteArray;

		private var _loader : Loader;

		private var _domain : ApplicationDomain;

		private function completeHandler(event : Event) : void {
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.completeHandler);
			this._domain = LoaderInfo(event.currentTarget).applicationDomain;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		public function SWFChunk(key : String,data : ByteArray) {
			this.key = key;
			this._data = data;
		}

		public function load() : void {
			this._loader = new Loader();
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.completeHandler);
			this._loader.loadBytes(this._data);
		}

		public function getClass(className : String) : Class {
			if(!this._domain.hasDefinition(className)) {
				//Logger.error(className + " definition not find in " + this.key);
				return null;
			}
			var assetClass : Class = _domain.getDefinition(className) as Class;
			return assetClass;
		}

		public function getMovieClip(className : String) : MovieClip {
			var assetClass : Class = getClass(className);
			if(!assetClass)return null;
			var mc : MovieClip = new assetClass() as MovieClip;
			if(!mc)//Logger.error(className + " isn't a MovieClip in " + key);
			return mc;
		}
	}
}