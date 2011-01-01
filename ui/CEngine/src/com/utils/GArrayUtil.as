package com.utils {

	/**
	 * Game Array Util
	 * 
	 * @author Cafe
	 * @version 20100608
	 */
	public class GArrayUtil {

		public static function shuffle(value : Array) : void {
			var source : Array = value.concat();
			var index : int;
			value.splice(0);
			while(source.length > 0) {
				index = MathUtil.random(0, source.length - 1);
				value.push(source[index]);
				source.splice(index, 1);
			}
		}

		public static function trim(value : Array) : Array {
			var list : Array = new Array();
			for each(var item:Object in value) {
				if(item != null)list.push(item);
			}
			return list;
		}
	}
}
