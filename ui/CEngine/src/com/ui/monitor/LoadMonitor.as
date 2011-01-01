package com.ui.monitor {
	import com.net.LoadModel;
	import com.ui.containers.Panel;
	import com.ui.controls.Label;
	import com.ui.controls.ProgressBar;
	import com.ui.core.Align;
	import com.ui.data.LabelData;
	import com.ui.data.PanelData;
	import com.ui.data.ProgressBarData;
	import com.ui.layout.GLayout;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	/**
	 * @version 20100115
	 * @author Cafe
	 */
	public class LoadMonitor extends Panel {

		protected var _label : Label;

		protected var _progressBar : ProgressBar;

		protected var _model : LoadModel;

		protected var _timeout : Timer;

		private function initData() : void {
			_data.align = new Align(-1, -1, -1, -1, 0, 0);
			_data.padding = 0;
			_data.width = 400;
			_data.height = 70;
			_data.modal = true;
		}

		override protected function onShow() : void {
			super.onShow();
			GLayout.layout(this);
		}

		private function initView() : void {
			addLabels();
			addProgressBars();
			_timeout = new Timer(500, 1);
			_timeout.addEventListener(TimerEvent.TIMER, timerHandler);
		}

		private function addLabels() : void {
			var data : LabelData = new LabelData();
			data.x = 10;
			data.y = 10;
			data.textColor = 0xFFFF00;
			_label = new Label(data);
			add(_label);
		}

		private function addProgressBars() : void {
			var data : ProgressBarData = new ProgressBarData();
			data.labelData.align = new Align(0, -1, 10, -1, -1, -1);
			data.x = 10;
			data.y = 35;
			data.width = 380;
			data.height = 10;
			_progressBar = new ProgressBar(data);
			add(_progressBar);
		}

		private function timerHandler(event : TimerEvent) : void {
			show();
		}

		private function initHandler(event : Event) : void {
			_progressBar.max = _model.total;
			_timeout.reset();
			_timeout.start();
		}

		private function changeHandler(event : Event) : void {
			_progressBar.value = _model.progress;
			_progressBar.text = "加载速度:" + _model.speed + " KB/S";
		}

		private function completeHandler(event : Event) : void {
			if(_timeout.running)_timeout.stop();
			hide();
		}

		private function addModelEvents() : void {
			_model.addEventListener(Event.INIT, initHandler);
			_model.addEventListener(Event.CHANGE, changeHandler);
			_model.addEventListener(Event.COMPLETE, completeHandler);
		}

		private function removeModelEvents() : void {
			_model.removeEventListener(Event.INIT, initHandler);
			_model.removeEventListener(Event.CHANGE, changeHandler);
			_model.removeEventListener(Event.COMPLETE, completeHandler);
		}

		public function LoadMonitor(parent : Sprite) {
			_data = new PanelData();
			_data.parent = parent;
			initData();
			super(_data);
			initView();
		}

		public function set model(value : LoadModel) : void {
			if(_model)removeModelEvents();
			_model = value;
			if(_model)addModelEvents();
		}

		public function set text(value : String) : void {
			_label.text = value;
		}
	}
}
