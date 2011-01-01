package com.test {
	import com.net.AssetData;
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.containers.Panel;
	import com.ui.containers.TabbedPanel;
	import com.ui.controls.Button;
	import com.ui.data.ButtonData;
	import com.ui.data.PanelData;
	import com.ui.data.TabbedPanelData;
	import flash.events.Event;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x003399,frameRate=30)]

	public class TestPanel extends Game {

		private var _panel : Panel;

		private var _panel2 : Panel;

		private var _tabbedPanel : TabbedPanel;

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			addPanel();
			addTabbedPanel();
		}

		private function addPanel() : void {
			var data : PanelData = new PanelData();
			data.bgAsset = new AssetData("GTabbedPanel_backgroundSkin");
			data.width = 149;
			data.height = 150 + 13;
			data.padding = 0;
			_panel = new Panel(data);
			data = data.clone();
			_panel2 = new Panel(data);
			var buttonData : ButtonData = new ButtonData();
			buttonData.x = 10;
			buttonData.y = 10;
			buttonData.labelData.text = "测试1";
			_panel.add(new Button(buttonData));
			buttonData = buttonData.clone();
			buttonData.y = 50;
			buttonData.labelData.text = "测试2";
			_panel2.add(new Button(buttonData));
		}

		private function addTabbedPanel() : void {
			var data : TabbedPanelData = new TabbedPanelData();
			data.x = 10;
			data.y = 10;
			_tabbedPanel = new TabbedPanel(data);
			_tabbedPanel.addTab("合成", _panel);
			_tabbedPanel.addTab("转移", _panel2);
			_tabbedPanel.addTab("帽子", _panel);
			addChild(_tabbedPanel);
		}

		public function TestPanel() {
			super();
		}
	}
}
