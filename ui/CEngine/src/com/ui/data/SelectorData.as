package com.ui.data {
	import com.net.AssetData;
	import com.ui.controls.Label;
	import com.ui.core.Align;
	import com.ui.core.UIComponent;
	import com.ui.core.UIComponentData;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class SelectorData extends UIComponentData {

		public var prev_buttonData : ButtonData;

		public var next_buttonData : ButtonData;

		public var labelData : LabelData = new LabelData();

		public var content : Class = UIComponent;

		public var componentData : UIComponentData = new UIComponentData();

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : SelectorData = source as SelectorData;
			if(data == null)return;
			data.prev_buttonData = prev_buttonData;
			data.next_buttonData = next_buttonData;
			data.labelData = labelData;
			data.content = content;
			data.componentData = componentData.clone();
		}

		public function SelectorData() {
			prev_buttonData = new ButtonData();
			prev_buttonData.labelData.iconData.asset = new AssetData("GSelector_prevIcon");
			prev_buttonData.width = 19;
			prev_buttonData.height = 19;
			next_buttonData = new ButtonData();
			next_buttonData.labelData.iconData.asset = new AssetData("GSelector_nextIcon");
			next_buttonData.align = new Align(-1, 0, -1, -1, -1, 0);
			next_buttonData.width = 19;
			next_buttonData.height = 19;
			content = Label;
			componentData = new LabelData();
			width = 80;
			height = 20;
		}

		override public function clone() : * {
			var data : SelectorData = new SelectorData();
			parse(data);
			return data;
		}
	}
}
