package com.ui.group {
	import com.model.ListEvent;
	import com.model.ListModel;
	import com.model.ListState;
	import com.model.SingleSelectionModel;
	import com.ui.controls.ToggleBase;
	import flash.events.Event;


	/**
	 * @author Cafe
	 * @version 20100430
	 */
	public class GToggleGroup {

		protected var _selectionModel : SingleSelectionModel;

		protected var _model : ListModel;

		protected var _selection : ToggleBase;

		protected var _enabled : Boolean = true;

		protected function addModelEvents() : void {
			_model.addEventListener(ListEvent.CHANGE, model_changeHandler);
		}

		protected function removeModelEvents() : void {
			_model.removeEventListener(ListEvent.CHANGE, model_changeHandler);
		}

		protected function model_changeHandler(event : ListEvent) : void {
			var tb : ToggleBase;
			switch(event.state) {
				case ListState.RESET:
					update();
					if(_selectionModel.index >= _model.size)_selectionModel.index = -1;
					break;
				case ListState.ADDED:
					tb = event.item as ToggleBase;
					if(tb) {
						tb.selected = false;
						tb.group = this;
					}
					break;
				case ListState.REMOVED:
					tb = event.item as ToggleBase;
					if(tb)tb.group = null;
					if(event.index < _selectionModel.index) {
						_selectionModel.index -= 1;
					}else if(event.index == _selectionModel.index) {
						_selectionModel.index = -1;
					}
					break;
				case ListState.UPDATE:
					break;
				case ListState.INSERT:
					tb = event.item as ToggleBase;
					if(tb) {
						tb.selected = false;
						tb.group = this;
					}
					if(event.index <= _selectionModel.index)_selectionModel.index += 1;
					break;
			}
		}

		protected function update() : void {
			var olds : Array = _model.oldSource;
			var tb : ToggleBase;
			for each(tb in olds) {
				tb.group = null;
			}
			for(var i : int = 0;i < _model.size;i++) {
				tb = _model.getAt(i) as ToggleBase;
				if(tb) {
					tb.group = this;
					tb.selected = false;
				}
			}
			tb = _model.getAt(_selectionModel.index) as ToggleBase;
			if(tb)tb.selected = true;
			_selection = tb;
		}

		protected function toggleButton_selectHandler(event : Event) : void {
			var index : int = _model.indexOf(event.currentTarget);		
			_selectionModel.index = index;
		}

		protected function selection_changeHandler(event : Event) : void {
			if(_selection)_selection.selected = false;
			var tb : ToggleBase = _model.getAt(_selectionModel.index) as ToggleBase;
			if(tb)tb.selected = true;
			_selection = tb;
		}

		public function GToggleGroup() {
			_selectionModel = new SingleSelectionModel();
			_model = new ListModel();
			addModelEvents();
			_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
		}

		public function get selectionModel() : SingleSelectionModel {
			return _selectionModel;
		}

		public function get model() : ListModel {
			return _model;
		}

		public function set enabled(value : Boolean) : void {
			if(_enabled == value)return;
			_enabled = value;
			for(var i : int = 0;i < _model.size;i++) {
				var tb : ToggleBase = _model.getAt(i) as ToggleBase;
				tb.enabled = _enabled;
			}
		}

		public function get enabled() : Boolean {
			return _enabled;
		}

		public function isSelected(tb : ToggleBase) : void {
			_selectionModel.index = _model.indexOf(tb);
		}

		public function get selection() : ToggleBase {
			return _selection;
		}

		public function show() : void {
			for(var i : int = 0;i < _model.size;i++) {
				var tb : ToggleBase = _model.getAt(i) as ToggleBase;
				tb.show();
			}
		}

		public function hide() : void {
			for(var i : int = 0;i < _model.size;i++) {
				var tb : ToggleBase = _model.getAt(i) as ToggleBase;
				tb.hide();
			}
		}
	}
}