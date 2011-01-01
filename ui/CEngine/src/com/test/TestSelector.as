package com.test {
	import com.model.SelectionModel;
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.cell.LabelSource;
	import com.ui.controls.Selector;
	import com.ui.controls.Slider;
	import com.ui.data.SelectorData;
	import com.ui.data.SliderData;
	import flash.events.Event;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x333333,frameRate=30)]

	public class TestSelector extends Game {

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			addSelector();
			addSlider();
		}

		private function addSelector() : void {
			var data : SelectorData = new SelectorData();
			data.x = 10;
			data.y = 10;
			var selector : Selector = new Selector(data);
			selector.model.source = [new LabelSource("10 秒", 10),new LabelSource("15 秒", 15),new LabelSource("20 秒", 20)];
			selector.selectionModel.index = 0;
			addChild(selector);
			selector.selectionModel.addEventListener(Event.CHANGE, selector_changeHandler);
		}

		private function addSlider() : void {
			var data : SliderData = new SliderData();
			data.x = 10;
			data.y = 40;
			data.width = 100;
			data.height =10;
			var slider : Slider = new Slider(data);
			addChild(slider);
		}

		private function selector_changeHandler(event : Event) : void {
			trace(SelectionModel(event.target).index);
		}

		public function TestSelector() {
		}
	}
}
