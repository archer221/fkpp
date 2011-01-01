package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.UIComponentData;
	import com.ui.skin.SkinStyle;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class CheckBoxData extends UIComponentData {

		public var upAsset : AssetData;

		public var upIcon : AssetData;

		public var selectedUpIcon : AssetData;

		public var labelData : LabelData = new LabelData();

		public var selected : Boolean = false;

		public var padding : int = 2;

		public var hGap : int = 3;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : CheckBoxData = source as CheckBoxData;
			if(data == null)return;
			data.upAsset = upAsset;
			data.upIcon = upIcon;
			data.selectedUpIcon = selectedUpIcon;
			data.labelData = labelData.clone();
			data.selected = selected;
			data.hGap = hGap;
			data.padding = padding;
		}

		public function CheckBoxData() {
			upAsset = new AssetData(SkinStyle.emptySkin, AssetData.AS_LIB);
			upIcon = new AssetData(SkinStyle.checkBox_upIcon);
			selectedUpIcon = new AssetData(SkinStyle.checkBox_selectedUpIcon);
			width = 70;
			height = 18;
		}

		override public function clone() : * {
			var data : CheckBoxData = new CheckBoxData();
			parse(data);
			return data;
		}
	}
}
