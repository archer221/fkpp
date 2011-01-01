package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.Align;
	import com.ui.core.UIComponentData;
	import com.ui.skin.SkinStyle;

	/**
	 * Game Button Data
	 * 
	 * @author Cafe
	 * @version 20100727
	 */
	public class ButtonData extends UIComponentData {

		public var upAsset : AssetData;

		public var overAsset : AssetData;

		public var downAsset : AssetData;

		public var disabledAsset : AssetData;

		public var labelData : LabelData;

		public var disabledColor : uint = 0x898989;

		public var rollOverColor : uint = 0xFFFFFF;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : ButtonData = source as ButtonData;
			if(data == null)return;
			data.upAsset = upAsset;
			data.overAsset = overAsset;
			data.downAsset = downAsset;
			data.disabledAsset = disabledAsset;
			data.labelData = (labelData ? labelData.clone() : null);
			data.disabledColor = disabledColor;
			data.rollOverColor = rollOverColor;
		}

		public function ButtonData() {
			upAsset = new AssetData(SkinStyle.button_upSkin);
			overAsset = new AssetData(SkinStyle.button_overSkin);
			downAsset = new AssetData(SkinStyle.button_downSkin);
			disabledAsset = new AssetData(SkinStyle.button_disabledSkin);
			width = 70;
			height = 24;
			labelData = new LabelData();
			labelData.align = new Align(-1, -1, -1, -1, 0, 0);
		}

		override public function clone() : * {
			var data : ButtonData = new ButtonData();
			parse(data);
			return data;
		}
	}
}
