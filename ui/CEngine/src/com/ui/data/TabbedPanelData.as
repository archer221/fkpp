package com.ui.data {
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponentData;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class TabbedPanelData extends UIComponentData {

		public var tabData : TabData;

		public var viewStackData : UIComponentData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : TabbedPanelData = source as TabbedPanelData;
			if(data == null)return;
			data.tabData = (tabData ? tabData.clone() : null);
			data.viewStackData = (viewStackData ? viewStackData.clone() : null);
		}

		public function TabbedPanelData() {
			tabData = new TabData();
			viewStackData = new UIComponentData();
			scaleMode = ScaleMode.AUTO_SIZE;
			width = 200;
			height = 200;
		}

		override public function clone() : * {
			var data : TabbedPanelData = new TabbedPanelData();
			parse(data);
			return data;
		}
	}
}
