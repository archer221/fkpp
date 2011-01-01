package com.test {
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.controls.Button;
	import com.ui.controls.CheckBox;
	import com.ui.controls.RadioButton;
	import com.ui.controls.ToggleButton;
	import com.ui.data.ButtonData;
	import com.ui.data.CheckBoxData;
	import com.ui.data.RadioButtonData;
	import com.ui.data.ToggleButtonData;
	import flash.events.Event;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x003399,frameRate=30)]

	public class TestButton extends Game {

		private var _btn1 : Button;

		private var _btn2 : Button;

		private var _tb : ToggleButton;

		private var _cb : CheckBox;

		private var _rb1 : RadioButton;

		private var _rb2 : RadioButton;

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			testButtons();
			testToggleButtons();
			testCheckBoxs();
			testRadioButtons();
		}

		private function testButtons() : void {
			var data : ButtonData = new ButtonData();
			data.x = 10;
			data.y = 10;
			data.width = 70;
			data.height = 24;
			data.labelData.text = "背包";
			_btn1 = new Button(data);
			addChild(_btn1);
			data.x = 100;
			data = data.clone();
			_btn2 = new Button(data);
			addChild(_btn2);
		}

		private function testToggleButtons() : void {
			var data : ToggleButtonData = new ToggleButtonData();
			data.x = 200;
			data.y = 10;
			data.labelData.text = "选择按钮";
			_tb = new ToggleButton(data);
			addChild(_tb);
		}

		private function testCheckBoxs() : void {
			var data : CheckBoxData = new CheckBoxData();
			data.x = 10;
			data.y = 50;
			data.enabled = false;
			data.selected = true;
			data.labelData.text = "检查按钮";
			_cb = new CheckBox(data);
			addChild(_cb);
		}

		private function testRadioButtons() : void {
			var data : RadioButtonData = new RadioButtonData();
			data.x = 100;
			data.y = 50;
			data.labelData.text = "选择1";
			_rb1 = new RadioButton(data);
			data = data.clone();
			data.x = 160;
			data.labelData.text = "选择2";
			_rb2 = new RadioButton(data);
			addChild(_rb1);
			addChild(_rb2);
		}

		public function TestButton() {
			super();
		}
	}
}
