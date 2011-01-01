package com.test {
	import com.net.AssetData;
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.containers.Panel;
	import com.ui.controls.Alert;
	import com.ui.controls.Button;
	import com.ui.controls.CheckBox;
	import com.ui.controls.RadioButton;
	import com.ui.controls.Tab;
	import com.ui.controls.TextInput;
	import com.ui.controls.ToggleButton;
	import com.ui.data.AlertData;
	import com.ui.data.ButtonData;
	import com.ui.data.CheckBoxData;
	import com.ui.data.PanelData;
	import com.ui.data.RadioButtonData;
	import com.ui.data.TabData;
	import com.ui.data.TextInputData;
	import com.ui.data.ToggleButtonData;
	import com.ui.group.GToggleGroup;
	import com.ui.layout.GLayout;
	import com.ui.manager.UIManager;
	import flash.events.Event;
	import flash.events.MouseEvent;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x333333,frameRate=30)]

	public class TestGroup extends Game {

		private var _alert : Alert;

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			addRadioGroup();
			addCheckBox();
			addTBGroup();
			addButtons();
			addTextInput();
			addTabGroup();
			addAlert();
		}

		private function addAlert() : void {
			var data : AlertData = new AlertData();
			data.labelData.text = "你好啊!";
			data.flag = Alert.OK | Alert.CANCEL;
			data.parent = UIManager.root;
			_alert = new Alert(data);
		}

		private function addTextInput() : void {
			var data : TextInputData = new TextInputData();
			data.x = 180;
			data.y = 30;
			addChild(new TextInput(data));
		}

		private function addCheckBox() : void {
			var data : CheckBoxData = new CheckBoxData();
			data.x = 180;
			data.y = 10;
			data.labelData.text = "检查按钮";
			addChild(new CheckBox(data));
		}

		private function addButtons() : void {
			var data : ButtonData = new ButtonData();
			data.x = 300;
			data.y = 30;
			data.height = 24;
			data.labelData.text = "开始游戏";
			var start_btn : Button = new Button(data);
			start_btn.enabled=false;
			addChild(start_btn);
			start_btn.addEventListener(MouseEvent.CLICK, start_clickHandler);
		}

		private function start_clickHandler(event : MouseEvent) : void {
			_alert.show();
			GLayout.layout(_alert);
		}

		private function addRadioGroup() : void {
			var data : RadioButtonData = new RadioButtonData();
			data.parent = this;
			data.x = 10;
			data.y = 10;
			data.labelData.text = "我是谁?";
			var rb1 : RadioButton = new RadioButton(data);
			data = data.clone();
			data.x = 80;
			data.labelData.text = "他是谁";
			var rb2 : RadioButton = new RadioButton(data);
			addChild(rb1);
			addChild(rb2);
			var group : GToggleGroup = new GToggleGroup();
			group.model.add(rb1);
			group.model.add(rb2);
		}

		private function addTBGroup() : void {
			var data : ToggleButtonData = new ToggleButtonData();
			data.x = 10;
			data.y = 40;
			data.labelData.text = "hello";
			var tb1 : ToggleButton = new ToggleButton(data);
			addChild(tb1);
		}

		private function addTabGroup() : void {
			var panelData : PanelData = new PanelData();
			panelData.bgAsset = new AssetData("GTabPanel_backgroundSkin");
			panelData.x = 10;
			panelData.y = 101;
			panelData.width = 200;
			panelData.height = 120;
			var panel : Panel = new Panel(panelData);
			addChild(panel);
			var data : TabData = new TabData();
			data.x = 10;
			data.y = 80;
			data.width = 55;
			data.labelData.text = "选项1";
			var tab1 : Tab = new Tab(data);
			data.x = 64;
			data = data.clone();
			data.labelData.text = "选项2";
			var tab2 : Tab = new Tab(data);
			data = data.clone();
			data.x = 118;
			data.labelData.text = "选项3";
			var tab3 : Tab = new Tab(data);
			addChild(tab1);
			addChild(tab2);
			addChild(tab3);
			var group : GToggleGroup = new GToggleGroup();
			group.model.add(tab1);
			group.model.add(tab2);
			group.model.add(tab3);
		}

		public function TestGroup() {
			super();
		}
	}
}
