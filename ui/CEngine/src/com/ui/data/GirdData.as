package com.ui.data {
	import com.net.AssetData;
	import com.ui.cell.Cell;
	import com.ui.cell.CellData;
	import com.ui.controls.Alert;
	import com.ui.core.ScaleMode;
	import com.ui.manager.UIManager;
	import com.utils.BDUtil;

	/**
	 * @version 20100330
	 * @author Cafe
	 */
	public class GirdData extends PanelData {

		public var allowDrag : Boolean = false;

		public var hgap : int = 2;

		public var vgap : int = 2;

		public var columns : int = 3;

		public var rows : int = 3;

		public var cell : Class = Cell;

		public var cellData : CellData = new CellData();

		public var alertData : AlertData;

		public var hotKeys : Array;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GirdData = source as GirdData;
			if(data == null)return;
			data.allowDrag = allowDrag;
			data.hgap = hgap;
			data.vgap = vgap;
			data.columns = columns;
			data.rows = rows;
			data.cell = cell;
			data.cellData = cellData.clone();
			data.alertData = alertData.clone();
		}

		public function GirdData() {
			alertData = new AlertData();
			alertData.parent = UIManager.root;
			alertData.labelData.iconData.bitmapData = BDUtil.getBD(new AssetData("light_22"));
			alertData.flag = Alert.YES | Alert.NO;
			scaleMode = ScaleMode.AUTO_SIZE;
		}

		override public function clone() : * {
			var data : GirdData = new GirdData();
			parse(data);
			return data;
		}
	}
}
