package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.UIComponentData;
	import com.ui.skin.SkinStyle;

	/**
	 * Game Panel Data
	 * 
	 * @author Cafe
	 * @version 20100801
	 */
	public class PanelData extends UIComponentData {

		public var bgAsset : AssetData;

		public var modal : Boolean = false;

		public var padding : int = 0;

		public var scrollBarData : ScrollBarData = new ScrollBarData();

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : PanelData = source as PanelData;
			if(data == null)return;
			data.bgAsset = bgAsset;
			data.modal = modal;
			data.padding = padding;
			data.scrollBarData = scrollBarData.clone();
		}

		public function PanelData() {
			bgAsset = new AssetData(SkinStyle.panel_backgroundSkin);
			width = 100;
			height = 100;
		}

		override public function clone() : * {
			var data : PanelData = new PanelData();
			parse(data);
			return data;
		}
	}
}
