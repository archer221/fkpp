package com.lib
{
	import flash.utils.ByteArray;
	
	public class LIBEncoder
	{
		private var _chunks:Array;
		
		public function LIBEncoder(){
			this._chunks=new Array();
		}
		
		public function add(chunk:LIBChunk):void{
			this._chunks.push(chunk);
		}
		
		public function removeAll():void{
			this._chunks=new Array();
		}
		
		public function encode():ByteArray{
			var lib:ByteArray=new ByteArray();
			for each(var chunk:LIBChunk in this._chunks){
				lib.writeUTF(chunk.key);
				lib.writeUTF(chunk.type);
				lib.writeUnsignedInt(chunk.data.length);
				lib.writeBytes(chunk.data);
			}
			return lib;
		}
	}
}