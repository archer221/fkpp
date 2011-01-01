package com.test {
	import com.net.AssetData;
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.controls.Alert;
	import com.ui.controls.Label;
	import com.ui.data.AlertData;
	import com.ui.data.LabelData;
	import com.ui.data.TextInputData;
	import com.ui.manager.UIManager;
	import com.utils.BDUtil;
	import flash.events.Event;



	/**
	 * @version 20100115
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x003399,frameRate=30)]

	public class TestAlert extends Game {

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			addLabel();
			addAlert();
		}

		private function addLabel() : void {
			var data : LabelData = new LabelData();
			data.iconData.bitmapData = BDUtil.getBD(new AssetData("light_22"));
			data.text = "你真的要删除[]1个?";
			var label : Label = new Label(data);
			addChild(label);
		}

		private function addAlert() : void {
			var data : AlertData = new AlertData();
			data.parent = UIManager.root;
			data.labelData.iconData.bitmapData = BDUtil.getBD(new AssetData("light_22"));
			data.textInputData = new TextInputData();
			data.textInputData.width = 70;
			data.flag = Alert.YES | Alert.NO;
			var alert : Alert = new Alert(data);
			alert.label = "你真的要删除[]1个?";
			addChild(alert);
			//alert.hide();
		}

		public function TestAlert() {
		}
	}
}
