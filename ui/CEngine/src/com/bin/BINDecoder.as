package com.bin {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;


	public class BINDecoder extends EventDispatcher {

		private static var _chunks : Dictionary = new Dictionary(true);

		private var _bin : ByteArray;

		private var _list : Array;

		private function readChunks() : void {
			_bin.position = 0;
			_list = new Array();
			while(_bin.position < _bin.length) {
				var chunk : BINChunk = new BINChunk();
				chunk.length = _bin.readUnsignedInt();
				chunk.key = _bin.readObject()["key"];
				_bin.readBytes(chunk.data, 0, chunk.length);
				var type : String = chunk.key.split(".").pop();
				if(type == "swf") {
					_list.push(new SWFChunk(chunk.key, chunk.data));
				}else BINDecoder._chunks[chunk.key] = chunk;
				loadNext();
			}
		}

		private function loadNext() : void {
			if(_list.length == 0) {
				dispatchEvent(new Event(Event.COMPLETE));
			} else {
				var swfChunk : SWFChunk = _list.shift();
				swfChunk.addEventListener(Event.COMPLETE, onSWFChunkComplete);
				swfChunk.load();
			}
		}

		private function onSWFChunkComplete(event : Event) : void {
			var swfChunk : SWFChunk = SWFChunk(event.currentTarget);
			swfChunk.removeEventListener(Event.COMPLETE, onSWFChunkComplete);
			BINDecoder._chunks[swfChunk.key] = swfChunk;
			loadNext();
		}

		public function BINDecoder(bin : ByteArray) {
			_bin = bin;
			readChunks();
		}

		public static function getChunk(key : String) : BINChunk {
			var binChunk : BINChunk = BINDecoder._chunks[key];
			return binChunk;
		}

		public static function getSWFChunk(key : String) : SWFChunk {
			var swfChunk : SWFChunk = BINDecoder._chunks[key] as SWFChunk;
			return swfChunk;
		}
	}
}