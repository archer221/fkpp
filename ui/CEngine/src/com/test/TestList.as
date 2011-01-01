package com.test {
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.cell.Cell;
	import com.ui.cell.LabelSource;
	import com.ui.controls.Button;
	import com.ui.controls.ComboBox;
	import com.ui.controls.List;
	import com.ui.core.Align;
	import com.ui.core.ScaleMode;
	import com.ui.data.ButtonData;
	import com.ui.data.ComboBoxData;
	import com.ui.data.IconData;
	import com.ui.data.ListData;
	import com.ui.manager.UIManager;
	import flash.events.Event;
	import flash.events.MouseEvent;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x333333,frameRate=30)]

	public class TestList extends Game {

		private var _list : List;

		private var _add_btn : Button;

		private var _remove_btn : Button;

		private var _test_btn : Button;

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			addList();
			addButtons();
			addComboBox();
			initEvents();
		}

		private function addList() : void {
			var data : ListData = new ListData();
			data.x = 10;
			data.y = 10;
			data.padding = 3;
			data.scaleMode = ScaleMode.AUTO_SIZE;
			data.cellData.width = 100;
			data.cellData.height = 22;
			data.cellData.labelData.textFieldFilters = UIManager.getEdgeFilters(0x000000, 0.8);
			data.align = new Align(0, -1, -1, 23, -1, -1);
			data.parent = this;
			_list = new List(data);
			addChild(_list);
			var test : Array = [new LabelSource("abc"),new LabelSource("cde")];
			_list.model.source = test;
			test.shift();
			_list.model.update();
		}

		private function addButtons() : void {
			var data : ButtonData = new ButtonData();
			data.x = 10;
			data.y = 120;
			data.width = 45;
			data.height = 24;
			data.labelData.text = "增加";
			_add_btn = new Button(data);
			data = data.clone();
			data.x = 60;
			data.labelData.text = "删除";
			var iconData : IconData = new IconData();
			data.labelData.iconData = iconData;
			_remove_btn = new Button(data);
			data = data.clone();
			data.x = 110;
			data.labelData.text = "测试";
			_test_btn = new Button(data);
			addChild(_add_btn);
			addChild(_remove_btn);
			addChild(_test_btn);
		}

		private function addComboBox() : void {
			var data : ComboBoxData = new ComboBoxData();
			//data.editable = true;
			var comboBox : ComboBox = new ComboBox(data);
			comboBox.moveTo(10, 80);
			comboBox.width = 70;
			comboBox.listWidth = 60;
			comboBox.model.source = [new LabelSource("战队"),new LabelSource("房间")];
			addChild(comboBox);
		}

		private function initEvents() : void {
			_add_btn.addEventListener(MouseEvent.CLICK, add_clickHandler);
			_remove_btn.addEventListener(MouseEvent.CLICK, remove_clickHandler);
			_test_btn.addEventListener(MouseEvent.CLICK, testClickHandler);
			_list.addEventListener(Cell.SINGLE_CLICK, SINGLE_CLICK);
			_list.selectionModel.addEventListener(Event.CHANGE, selectHandler);
		}

		private function selectHandler() : void {
			trace("CHANGE");
		}

		private function SINGLE_CLICK(event : Event) : void {
			trace(_list.selectionModel);
		}

		
		private function add_clickHandler(event : MouseEvent) : void {
			_list.model.add(new LabelSource("added_0", 0));
		}

		private function remove_clickHandler(event : MouseEvent) : void {
			//_list.model.setAt(1,null);
			_list.model.removeAt(0);
			//_list.model.insert(1,new LabelSource("insert_0", 0));
			//_list.model.swapAt(0,2);
			//_list.model.source=[new LabelSource("aaa",0)];
		}

		private function testClickHandler(event : MouseEvent) : void {
			trace(_list.selectionModel.index);
		}

		public function TestList() {
			super();
		}
	}
}
