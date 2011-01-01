package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponentData;
	import com.ui.skin.SkinStyle;

	/**
	 * Game Slider Data
	 * 
	 * @author Cafe
	 * @version 20100712
	 */
	public class SliderData extends UIComponentData {

		public var trackAsset : AssetData;

		public var barAsset : AssetData;

		public var thumbAsset : AssetData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : SliderData = source as SliderData;
			if(data == null)return;
			data.trackAsset = trackAsset;
			data.barAsset = barAsset;
			data.thumbAsset = thumbAsset;
		}

		public function SliderData() {
			trackAsset = new AssetData(SkinStyle.slider_trackSkin);
			barAsset = new AssetData(SkinStyle.slider_barSkin);
			thumbAsset = new AssetData(SkinStyle.slider_thumbSkin);
			width = 100;
			height = 10;
			scaleMode = ScaleMode.SCALE_WIDTH;
		}

		override public function clone() : * {
			var data : SliderData = new SliderData();
			parse(data);
			return data;
		}
	}
}
