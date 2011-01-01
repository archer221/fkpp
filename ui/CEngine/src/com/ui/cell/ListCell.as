package com.ui.cell {
	import com.ui.controls.Label;
	import com.ui.layout.GLayout;

	/**
	 * Game List Cell
	 * 
	 * @author Cafe
	 * @version 20100728
	 */
	public class ListCell extends Cell {

		private var _label : Label;

		override protected function create() : void {
			super.create();
			_label = new Label(_data.labelData);
			addChild(_label);
		}

		public function ListCell(data : CellData) {
			super(data);
		}

		override public function set source(value : *) : void {
			var data : LabelSource = value as LabelSource;
			if(data == null) {
				_label.clear();
			} else {
				_label.text = data.text;
				GLayout.layout(_label);
			}
			_source = data;
			enabled = (_source != null);
		}
	}
}
