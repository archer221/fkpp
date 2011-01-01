package com.test {
	import com.project.Game;
	import com.ui.controls.Button;
	import com.ui.controls.ProgressBar;
	import com.ui.controls.ScrollBar;
	import com.ui.controls.ToggleButton;
	import com.ui.data.ButtonData;
	import com.ui.data.ProgressBarData;
	import com.ui.data.ScrollBarData;
	import com.ui.data.ToggleButtonData;
	import com.ui.layout.GLayout;
	import com.ui.monitor.LoadMonitor;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x333333,frameRate=60)]

	public class TestSkin extends Game {

		override protected function initGame() : void {
			addButton();
			addToggleButton();
			addProgressBar();
			addScrollBar();
			addLoadMonitor();
		}

		private function addButton() : void {
			var data : ButtonData = new ButtonData();
			data.x = 10;
			data.y = 10;
			data.width = 60;
			data.labelData.text = "按钮";
			addChild(new Button(data));
			data = data.clone();
			data.x = 100;
			data.enabled = false;
			addChild(new Button(data));
		}

		private function addToggleButton() : void {
			var data : ToggleButtonData = new ToggleButtonData();
			data.x = 10;
			data.y = 40;
			data.labelData.text = "选择按钮";
			data.selected = true;
			addChild(new ToggleButton(data));
			data = data.clone();
			data.x = 100;
			data.enabled = false;
			addChild(new ToggleButton(data));
		}

		private function addProgressBar() : void {
			var data : ProgressBarData = new ProgressBarData();
			data.x = 10;
			data.y = 70;
			data.value = 50;
			data.max = 100;
			addChild(new ProgressBar(data));
			data = data.clone();
			data.mode = ProgressBarData.POLLED;
			data.y = 90;
			addChild(new ProgressBar(data));
		}

		private function addScrollBar() : void {
			var data : ScrollBarData = new ScrollBarData();
			data.x = 200;
			data.y = 10;
			var sb : ScrollBar = new ScrollBar(data);
			sb.resetValue(10, 0, 10, 0);
			addChild(sb);
		}

		private function addLoadMonitor() : void {
			var loadMotion : LoadMonitor = new LoadMonitor(this);
			loadMotion.show();
			GLayout.layout(loadMotion);
		}

		public function TestSkin() {
		}
	}
}
