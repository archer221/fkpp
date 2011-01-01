package com.bd {
	import com.core.IDispose;
	import flash.display.BitmapData;
	import flash.geom.Point;


	/**
	 * @author Cafe
	 * @version 20100323
	 */
	public class BDUnit implements IDispose {

		public var offset : Point;

		public var bd : BitmapData;

		public function BDUnit(o : Point = null,b : BitmapData = null) {
			offset = o;
			bd = b;
		}

		public function dispose() : void {
			if(bd != null)bd.dispose();
		}
	}
}