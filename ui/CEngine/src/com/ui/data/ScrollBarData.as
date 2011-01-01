package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.UIComponentData;
	import com.ui.skin.SkinStyle;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class ScrollBarData extends UIComponentData {

		public static const VERTICAL : int = 0;

		public static const HORIZONTAL : int = 1;

		public var trackAsset : AssetData = new AssetData(SkinStyle.scrollBar_trackSkin);

		public var thumbButtonData : ButtonData;

		public var direction : int = VERTICAL;

		public var wheelSpeed : int = 2;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : ScrollBarData = source as ScrollBarData;
			if(data == null)return;
			data.trackAsset = trackAsset;
			data.thumbButtonData = (thumbButtonData ? thumbButtonData.clone() : null);
			data.direction = direction;
			data.wheelSpeed = wheelSpeed;
		}

		public function ScrollBarData() {
			thumbButtonData = new ButtonData();
			thumbButtonData.upAsset = new AssetData(SkinStyle.scrollBar_thumbUpSkin);
			thumbButtonData.overAsset = new AssetData(SkinStyle.scrollBar_thumbOverSkin);
			thumbButtonData.downAsset = new AssetData(SkinStyle.scrollBar_thumbDownSkin);
			thumbButtonData.disabledAsset = null;
			width = 14;
			height = 100;
		}

		override public function clone() : * {
			var data : ScrollBarData = new ScrollBarData();
			parse(data);
			return data;
		}
	}
}
