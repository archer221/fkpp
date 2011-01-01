package com.net {
	import com.utils.DictionaryUtil;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;


	com.utils.DictionaryUtil;


	/**
	 * @version 20100115
	 * @author Cafe
	 */
	public class RESManager extends EventDispatcher {

		public static const SWF_TYPE : int = 0;

		public static const XML_TYPE : int = 1;

		private static var _creating : Boolean = false;

		private static var _instance : RESManager;

		private static var _list : Array = new Array;

		private static var _wait : Dictionary = new Dictionary(true);

		private static var _loaded : Dictionary = new Dictionary(true);

		private var _model : LoadModel;

		private function init() : void {
			_model = new LoadModel();
		}

		private function loadNext() : void {
			var loader : ALoader;
			while(_model.hasFree()) {
				if(_list.length == 0)return;
				loader = ALoader(_list.shift());
				_model.add(loader.loadData);
				loader.addEventListener(Event.COMPLETE, completeHandler);
				loader.addEventListener(ErrorEvent.ERROR, errorHandler);
				loader.load();
			}
		}

		private function completeHandler(event : Event) : void {
			var loader : ALoader = ALoader(event.target);
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(ErrorEvent.ERROR, errorHandler);
			_model.remove(loader.loadData);
			delete _wait[loader.key];
			_loaded[loader.key] = loader;
			if(_list.length > 0) {
				loadNext();
			}else if(DictionaryUtil.isEmpty(_wait)) {
				_model.end();
				//Logger.info("RESManager load all done");
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		private function errorHandler(event : ErrorEvent) : void {
			var loader : ALoader = ALoader(event.target);
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(ErrorEvent.ERROR, errorHandler);
			_model.remove(loader.loadData);
			delete _wait[loader.key];
			if(_list.length > 0) {
				loadNext();
			}else if(DictionaryUtil.isEmpty(_wait)) {
				_model.end();
				//Logger.info("RESManager load all done");
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		public function RESManager() {
			if(!_creating) {
			}
			init();
		}

		public static function get instance() : RESManager {
			if(_instance == null) {
				_creating = true;
				_instance = new RESManager();
				_creating = false;
			}
			return _instance;
		}

		public static function getMC(asset : AssetData) : MovieClip {
			var loader : SWFLoader = _loaded[asset.libId] as SWFLoader;
			if(!loader) {
				return null;
			}
			return loader.getMovieClip(asset.className);
		}
		
		public static function getSound(asset:AssetData):Sound{
			var loader : SWFLoader = _loaded[asset.libId] as SWFLoader;
			if(loader==null) {
				return null;
			}
			return loader.getSound(asset.className);
		}

		public static function getXML(key : String) : XML {
			var loader : XMLLoader = _loaded[key] as XMLLoader;
			if(loader == null)return null;
			return loader.getXML();
		}

		public static function getMp3(key : String) : Sound {
			var loader : MP3Loader = _loaded[key] as MP3Loader;
			if(loader == null)return null;
			return loader.getSound();
		}

		public static function getByteArray(key : String) : ByteArray {
			var loader : RESLoader = _loaded[key] as RESLoader;
			if(loader == null)return null;
			return loader.getByteArray();
		}

		public function add(loader : ALoader) : void {
			var key : String = loader.key;
			if(loader.isLoaded) {
				_loaded[key] = loader;
				return;
			}
			if(_loaded[key] != null)return;
			if(_wait[key] != null)return;
			_list.push(loader);
			_wait[key] = loader;
			return;
		}

		public function get model() : LoadModel {
			return _model;
		}

		public function load() : void {
			if(_list.length == 0) {
				_model.end();
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			_model.reset(_list.length);
			loadNext();
		}
	}
}