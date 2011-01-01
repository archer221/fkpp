package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.Align;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponentData;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class TabData extends UIComponentData {

		public var upAsset : AssetData = new AssetData("GTab_upSkin");

		public var overAsset : AssetData = new AssetData("GTab_overSkin");

		public var disabledAsset : AssetData = new AssetData("GTab_disabledSkin");

		public var selectedUpAsset : AssetData = new AssetData("GTab_selectedUpSkin");

		public var selectedDisabledAsset : AssetData = new AssetData("GTab_selectedDisabledSkin");

		public var labelData : LabelData;

		public var textRollOverColor : uint = 0xFFFFFF;

		public var textSelectedColor : uint = 0xEFEFEF;

		public var selected : Boolean = false;

		public var padding : int = 7;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : TabData = source as TabData;
			if(data == null)return;
			data.upAsset = upAsset;
			data.overAsset = overAsset;
			data.disabledAsset = disabledAsset;
			data.selectedUpAsset = selectedUpAsset;
			data.selectedDisabledAsset = selectedDisabledAsset;
			data.labelData = (labelData ? labelData.clone() : null);
			data.textRollOverColor = textRollOverColor;
			data.textSelectedColor = textSelectedColor;
			data.selected = selected;
			data.padding = padding;
		}

		public function TabData() {
			scaleMode = ScaleMode.AUTO_WIDTH;
			width = 60;
			height = 22;
			labelData = new LabelData();
			labelData.textColor = 0xBEBEBE;
			labelData.align = new Align(-1, -1, -1, -1, 0, 0);
		}

		override public function clone() : * {
			var data : TabData = new TabData();
			parse(data);
			return data;
		}
	}
}
