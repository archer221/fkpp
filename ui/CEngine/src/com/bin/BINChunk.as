package com.bin
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	public class BINChunk extends EventDispatcher
	{
		public var key:String;
		
		public var length:uint;
		
		public var data:ByteArray;
				
		public function BINChunk(){
			this.data=new ByteArray();
		}
	}
}