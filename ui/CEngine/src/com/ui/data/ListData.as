package com.ui.data {
	import com.ui.cell.CellData;
	import com.ui.cell.ListCell;

	/**
	 * Game List Data
	 * 
	 * @author Cafe
	 * @version 20100730
	 */
	public class ListData extends PanelData {

		public var allowDrag : Boolean ;

		public var hGap : int;

		public var rows : int;

		public var cell : Class;

		public var cellData : CellData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : ListData = source as ListData;
			if(data == null)return;
			data.allowDrag = allowDrag;
			data.hGap = hGap;
			data.rows = rows;
			data.cell = cell;
			data.cellData = cellData.clone();
		}

		public function ListData() {
			allowDrag = true;
			padding = 2;
			hGap = 1;
			rows = 5;
			cell = ListCell;
			cellData = new CellData();
		}

		override public function clone() : * {
			var data : ListData = new ListData();
			parse(data);
			return data;
		}
	}
}
