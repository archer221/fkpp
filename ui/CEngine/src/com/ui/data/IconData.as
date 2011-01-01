package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponentData;
	import flash.display.BitmapData;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class IconData extends UIComponentData {

		public var asset : AssetData;

		public var bitmapData : BitmapData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : IconData = source as IconData;
			if(data == null)return;
			data.asset = asset;
			data.bitmapData = bitmapData;
		}

		public function IconData() {
			scaleMode = ScaleMode.AUTO_SIZE;
		}

		override public function clone() : * {
			var data : IconData = new IconData();
			parse(data);
			return data;
		}
	}
}
