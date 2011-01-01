package com.ui.cell {
	import com.net.AssetData;
	import com.ui.core.Align;
	import com.ui.core.UIComponentData;
	import com.ui.data.IconData;
	import com.ui.data.LabelData;
	import com.ui.data.ToolTipData;
	import com.utils.BDUtil;

	/**
	 * Game Cell Data
	 * 
	 * @author Cafe
	 * @version 20100730
	 */
	public class CellData extends UIComponentData {

		public var upAsset : AssetData;

		public var overAsset : AssetData;

		public var selected_upAsset : AssetData;

		public var selected_overAsset : AssetData;

		public var disabledAsset : AssetData;

		public var lockIconData : IconData;

		public var labelData : LabelData;

		public var allowSelect : Boolean ;

		public var clickSelect : Boolean;

		public var allowDoubleClick : Boolean;

		public var lock : Boolean;

		public var index : int;

		public var hotKey : String;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : CellData = source as CellData;
			if(data == null)return;
			data.upAsset = upAsset;
			data.overAsset = overAsset;
			data.selected_upAsset = selected_upAsset;
			data.selected_overAsset = selected_overAsset;
			data.disabledAsset = disabledAsset;
			data.lockIconData = lockIconData.clone();
			data.labelData = labelData.clone();
			data.allowSelect = allowSelect;
			data.clickSelect = clickSelect;
			data.allowDoubleClick = allowDoubleClick;
			data.lock = lock;
		}

		public function CellData() {
			upAsset = new AssetData("GCell_upSkin");
			overAsset = new AssetData("GCell_overSkin");
			selected_upAsset = new AssetData("GCell_selected_upSkin");
			selected_overAsset == new AssetData("GCell_selected_overSkin");
			disabledAsset = new AssetData("GCell_disabledSkin");
			lockIconData = new IconData();
			labelData = new LabelData();
			allowSelect = true;
			clickSelect = true;
			allowDoubleClick = false;
			lock = false;
			index = -1;
			width = 100;
			height = 22;
			labelData.align = new Align(8, -1, -1, -1, -1, 0);
			lockIconData.bitmapData = BDUtil.getBD(new AssetData("lock_icon"));
			lockIconData.align = Align.CENTER;
			toolTipData = new ToolTipData();
		}

		override public function clone() : * {
			var data : CellData = new CellData();
			parse(data);
			return data;
		}
	}
}
