package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.Align;
	import com.ui.core.UIComponentData;

	/**
	 * @author Cafe
	 */
	public class TitleBarData extends UIComponentData {

		public var backgroundAsset : AssetData = new AssetData("GTitleBar_backgroundSkin");

		public var labelData : LabelData;

		public function TitleBarData() {
			width = 100;
			height = 30;
			labelData=new LabelData();
			labelData.align=new Align(10,-1,-1,-1,-1,0);
		}
	}
}
