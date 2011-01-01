package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.UIComponentData;
	import com.ui.skin.SkinStyle;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class RadioButtonData extends UIComponentData {

		public var upAsset : AssetData;

		public var upIcon : AssetData;

		public var selectedUpIcon : AssetData;

		public var labelData : LabelData;

		public var selected : Boolean = false;

		public var padding : int = 2;

		public var hGap : int = 2;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : RadioButtonData = source as RadioButtonData;
			if(data == null)return;
			data.upAsset = upAsset;
			data.upIcon = upIcon;
			data.selectedUpIcon = selectedUpIcon;
			data.labelData = labelData.clone();
			data.selected = selected;
			data.padding = padding;
			data.hGap = hGap;
		}

		public function RadioButtonData() {
			upAsset = new AssetData(SkinStyle.emptySkin, AssetData.AS_LIB);
			upIcon = new AssetData(SkinStyle.radioButton_upIcon);
			selectedUpIcon = new AssetData(SkinStyle.radioButton_selectedUpIcon);
			labelData = new LabelData();
			width = 70;
			height = 18;
		}

		override public function clone() : * {
			var data : RadioButtonData = new RadioButtonData();
			parse(data);
			return data;
		}
	}
}