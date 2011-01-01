package com.test {
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.cell.LabelSource;
	import com.ui.controls.List;
	import com.ui.controls.Spinner;
	import com.ui.core.Align;
	import com.ui.data.ListData;
	import com.ui.data.SpinnerData;
	import flash.events.Event;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x333333,frameRate=30)]

	public class TestSpinner extends Game {

		protected var _spinner : Spinner;

		protected var _list : List;

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			addSpinner();
			addList();
			initView();
		}

		private function addSpinner() : void {
			var data : SpinnerData = new SpinnerData();
			data.x = 10;
			data.y = 10;
			data.parent = this;
			_spinner = new Spinner(data);
			addChild(_spinner);
		}

		private function addList() : void {
			var data : ListData = new ListData();
			data.x = 100;
			data.y = 10;
			data.width = 200;
			data.padding = 3;
			data.cellData.width = 100;
			data.cellData.height = 22;
			data.align = new Align(0, -1, -1, 23, -1, -1);
			data.parent = this;
			_list = new List(data);
			addChild(_list);
		}

		private function initView() : void {
			_spinner.model = _list.model;
			_spinner.selectionModel.index = 0;
			_list.model.source = [new LabelSource("test1"),new LabelSource("test2")];
		}

		public function TestSpinner() {
			super();
		}
	}
}
