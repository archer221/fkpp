package com.net {
	import com.utils.GStringUtil;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;


	com.utils.GStringUtil;


	/**
	 * @version 20090712
	 * @author Cafe
	 */
	public class SWFLoader extends RESLoader {

		private var _loader : Loader;

		private var _domain : ApplicationDomain;

		override protected function onComplete() : void {
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.loadBytes(_byteArray);
		}

		private function completeHandler(event : Event) : void {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_domain = LoaderInfo(event.currentTarget).applicationDomain;
			_isLoadding = false;
			_isLoaded = true;
			//Logger.info(this, GStringUtil.format("load {0} complete", _libData.url));
			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function SWFLoader(data : LibData) {
			super(data);
		}

		public function getContent() : DisplayObject {
			return _loader.content;
		}

		public function getClass(className : String) : Class {
			if(!_domain.hasDefinition(className)) {
				//Logger.error(GStringUtil.format("SWFLoader:{0} not find in {1}", className, _libData.url));
				return null;
			}
			var assetClass : Class = _domain.getDefinition(className) as Class;
			return assetClass;
		}

		public function getMovieClip(className : String) : MovieClip {
			var assetClass : Class = getClass(className);
			if(assetClass == null)return null;
			var mc : MovieClip = new assetClass() as MovieClip;
			if(mc == null) {
				//Logger.warn(GStringUtil.format("{0} isn't a MovieClip in {1}", className, _libData.url));
			}
			return mc;
		}

		public function getSound(className : String) : Sound {
			var assetClass : Class = getClass(className);
			if(assetClass == null)return null;
			var sound : Sound = new assetClass() as Sound;
			if(sound == null) {
				//Logger.warn(GStringUtil.format("{0} isn't a Sound in {1}", className, _libData.url));
			}
			return sound;
		}
	}
}