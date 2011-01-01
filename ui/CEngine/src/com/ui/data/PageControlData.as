package com.ui.data {
	import com.ui.core.Align;
	import com.ui.core.UIComponentData;

	public class PageControlData extends UIComponentData {

		public var prev_buttonData : ButtonData;

		public var next_buttonData : ButtonData;

		public var labelData : LabelData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : PageControlData = source as PageControlData;
			if(data == null)return;
			data.prev_buttonData = (prev_buttonData == null ? null : prev_buttonData.clone());
			data.next_buttonData = (next_buttonData == null ? null : next_buttonData.clone());
			data.labelData = (labelData == null ? null : labelData.clone());
		}

		public function PageControlData() {
			width = 150;
			height = 24;
			prev_buttonData = new ButtonData();
			prev_buttonData.width = 50;
			prev_buttonData.align = new Align(0, -1, -1, -1, -1, 0);
			prev_buttonData.labelData.text = "上一页";
			next_buttonData = new ButtonData();
			next_buttonData.width = 50;
			next_buttonData.align = new Align(-1, 0, -1, -1, -1, 0);
			next_buttonData.labelData.text = "下一页";
			labelData = new LabelData();
			labelData.align = new Align(-1, -1, -1, -1, 0, 0);
			labelData.text = "1/1";
		}

		override public function clone() : * {
			var data : PageControlData = new PageControlData();
			parse(data);
			return data;
		}
	}
}