package com.test {
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.cell.LabelSource;
	import com.ui.cell.ListCell;
	import com.ui.controls.Button;
	import com.ui.controls.Gird;
	import com.ui.controls.PageControl;
	import com.ui.core.Align;
	import com.ui.core.ScaleMode;
	import com.ui.data.ButtonData;
	import com.ui.data.GirdData;
	import com.ui.data.PageControlData;
	import com.ui.manager.UIManager;
	import flash.events.Event;
	import flash.events.MouseEvent;


	/**
	 * @version 20091201
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x333333,frameRate=30)]

	public class TestGird extends Game {

		private var _gird : Gird;

		private var _pc : PageControl;

		private var _test_btn : Button;

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			addGird();
			addPC();
			addButtons();
			initEvents();
		}

		private function addGird() : void {
			var data : GirdData = new GirdData();
			data.x = 10;
			data.y = 10;
			data.width = 200;
			data.padding = 3;
			data.scaleMode = ScaleMode.AUTO_SIZE;
			data.cell = ListCell;
			data.cellData.width = 60;
			data.cellData.height = 22;
			data.cellData.labelData.textFieldFilters = UIManager.getEdgeFilters(0x000000, 0.8);
			data.align = new Align(0, -1, -1, 23, -1, -1);
			data.parent = this;
			data.columns = 2;
			data.rows = 2;
			_gird = new Gird(data);
			addChild(_gird);
		}

		private function addPC() : void {
			var data : PageControlData = new PageControlData();
			data.x = 10;
			data.y = 90;
			_pc = new PageControl(data);
			addChild(_pc);
		}

		private function addButtons() : void {
			var data : ButtonData = new ButtonData();
			data.x = 110;
			data.y = 120;
			data.labelData.text = "测试";
			_test_btn = new Button(data);
			addChild(_test_btn);
		}

		private function initEvents() : void {
			_gird.model.source = [new LabelSource("a"),new LabelSource("b")];
			_pc.model = _gird.pageModel;
			_test_btn.addEventListener(MouseEvent.CLICK, testClickHandler);
		}

		private function testClickHandler(event : MouseEvent) : void {
			//_gird.model.add(new LabelSource("new_" + getTimer()));
		}

		public function TestGird() {
			super();
		}
	}
}
