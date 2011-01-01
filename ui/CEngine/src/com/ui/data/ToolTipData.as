package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponentData;

	/**
	 * Game Tool Tip Data
	 * 
	 * @author Cafe
	 * @version 20100719
	 */
	public class ToolTipData extends UIComponentData {

		public var backgroundAsset : AssetData;

		public var labelData : LabelData = new LabelData();

		public var padding : int;

		public var alginMode : int;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : ToolTipData = source as ToolTipData;
			if(data == null)return;
			data.backgroundAsset = backgroundAsset;
			data.labelData = labelData;
			data.padding = padding;
			data.alginMode = alginMode;
		}

		public function ToolTipData() {
			backgroundAsset = new AssetData("GToolTip_backgroundSkin");
			padding = 5;
			alginMode = 0;
			scaleMode = ScaleMode.AUTO_SIZE;
		}

		override public function clone() : * {
			var data : ToolTipData = new ToolTipData();
			parse(data);
			return data;
		}
	}
}