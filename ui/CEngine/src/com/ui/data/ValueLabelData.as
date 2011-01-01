package com.ui.data {
	import com.ui.core.UIComponentData;

	/**
	 * @author Cafe
	 */
	public class ValueLabelData extends UIComponentData {
		public var nameLableData : LabelData;
		public var valueLableData : LabelData;

		public function ValueLabelData() {
			super();
			nameLableData = new LabelData();
			valueLableData = new LabelData();
		}

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : ValueLabelData = source as ValueLabelData;
			data.nameLableData = nameLableData;
			data.valueLableData = valueLableData;
		}

		override public function clone() : * {
			var data : ValueLabelData = new ValueLabelData();
			parse(data);
			return data;
		}
	}
}
