package com.bin
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	public class BINEncoder extends EventDispatcher
	{
		private var _chunks:Array;
		
		public function BINEncoder(){
			this._chunks=new Array();
		}
		
		public function add(chunk:BINChunk):void{
			this._chunks.push(chunk);
		}
		
		public function encode():ByteArray{
			var bin:ByteArray=new ByteArray();
			for each(var chunk:BINChunk in this._chunks){
				bin.writeUnsignedInt(chunk.data.length);
				bin.writeObject({key:chunk.key});
				bin.writeBytes(chunk.data);
			}
			return bin;
		}
	}
}