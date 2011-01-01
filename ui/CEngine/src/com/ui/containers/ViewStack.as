package com.ui.containers {
	import com.model.ListEvent;
	import com.model.ListModel;
	import com.model.ListState;
	import com.model.SingleSelectionModel;
	import com.ui.core.UIComponent;
	import com.ui.core.UIComponentData;
	import flash.events.Event;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class ViewStack extends UIComponent {

		protected var _selection : UIComponent;

		protected var _selectionModel : SingleSelectionModel;

		protected var _model : ListModel;

		protected function addModelEvents() : void {
			_model.addEventListener(ListEvent.CHANGE, model_changeHandler);
		}

		protected function removeModelEvents() : void {
			_model.removeEventListener(ListEvent.CHANGE, model_changeHandler);
		}

		protected function model_changeHandler(event : ListEvent) : void {
			switch(event.state) {
				case ListState.RESET:
					if(_selectionModel.index >= _model.size)_selectionModel.index = 0;
					updateContent();
					break;
				case ListState.ADDED:
					break;
				case ListState.REMOVED:
					if(event.index < _selectionModel.index) {
						_selectionModel.index -= 1;
					}else if(event.index == _selectionModel.index) {
						_selectionModel.index = -1;
					}
					if(_selectionModel.index == -1)_selectionModel.index = 0;
					updateContent();
					break;
				case ListState.UPDATE:
					break;
				case ListState.INSERT:
					if(event.index <= _selectionModel.index)_selectionModel.index += 1;
					if(_selectionModel.index == -1)_selectionModel.index = 0;
					updateContent();
					break;
			}
		}

		private function selection_changeHandler(event : Event) : void {
			updateContent();
		}

		protected function updateContent() : void {
			if(_selection)_selection.parent.removeChild(_selection);
			var component : UIComponent = _model.getAt(_selectionModel.index) as UIComponent;
			if(component) {
				addChild(component);
				_width = component.width;
				_height = component.height;
			}
			_selection = component;
		}

		public function ViewStack(base : UIComponentData) {
			super(base);
			_selectionModel = new SingleSelectionModel();
			_model = new ListModel();
			addModelEvents();
			_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
		}

		public function get selectionModel() : SingleSelectionModel {
			return _selectionModel;
		}

		public function get selection() : UIComponent {
			return _model.getAt(_selectionModel.index) as UIComponent;
		}

		public function add(component : UIComponent) : void {
			_model.add(component);
		}
	}
}