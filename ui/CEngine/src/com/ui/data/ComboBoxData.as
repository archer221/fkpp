package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.Align;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponentData;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class ComboBoxData extends UIComponentData {

		public var buttonData : ButtonData;

		public var textInputData : TextInputData;

		public var arrow : ButtonData;

		public var listData : ListData;

		public var editable : Boolean = false;

		public function ComboBoxData() {
			buttonData = new ButtonData();
			buttonData.upAsset = new AssetData("GComboBox_upSkin");
			buttonData.overAsset = new AssetData("GComboBox_overSkin");
			buttonData.downAsset = new AssetData("GComboBox_downSkin");
			buttonData.disabledAsset = new AssetData("GComboBox_disabledSkin");
			buttonData.labelData.align = new Align(5, -1, -1, -1, -1, 0);
			textInputData = new TextInputData();
			arrow = new ButtonData();
			arrow.upAsset = new AssetData("GComboBox_arrowUpSkin");
			arrow.overAsset = new AssetData("GComboBox_arrowOverSkin");
			arrow.downAsset = new AssetData("GComboBox_arrowDownSkin");
			arrow.disabledAsset = new AssetData("GComboBox_arrowDisabledSkin");
			arrow.width = 18;
			arrow.height = 22;
			listData = new ListData();
			listData.scaleMode = ScaleMode.AUTO_HEIGHT;
			width = 100;
			height = 22;
		}
	}
}
