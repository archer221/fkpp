package com.ui.controls {
	import com.model.RangeModel;
	import com.ui.core.UIComponent;
	import com.ui.data.StepperData;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;



	/**
	 * Game Stepper
	 * 
	 * @author Cafe
	 * @version 20100708
	 */
	public class Stepper extends UIComponent {

		protected var _data : StepperData;

		protected var _upArrow : Button;

		protected var _downArrow : Button;

		protected var _textInput : TextInput;

		protected var _model : RangeModel;

		override protected function create() : void {
			_upArrow = new Button(_data.upArrowData);
			_downArrow = new Button(_data.downArrowData);
			_downArrow.y = _upArrow.height;
			_textInput = new TextInput(_data.textInputData);
			addChild(_upArrow);
			addChild(_downArrow);
			addChild(_textInput);
		}

		override protected function layout() : void {
			_upArrow.x = _width - _upArrow.width;
			_downArrow.x = _width - _downArrow.width;
			_textInput.width = _width - _upArrow.width;
		}

		protected function addModelEvents() : void {
			_model.addEventListener(Event.CHANGE, model_changeHandler);
		}

		protected function removeModelEvents() : void {
			_model.removeEventListener(Event.CHANGE, model_changeHandler);
		}

		protected function model_changeHandler(event : Event) : void {
			_textInput.text = String(_model.value);
		}

		protected function initEvents() : void {
			_textInput.addEventListener(TextInput.ENTER, enterHandler);
			_textInput.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			_upArrow.addEventListener(MouseEvent.CLICK, up_clickHandler);
			_downArrow.addEventListener(MouseEvent.CLICK, down_clickHandler);
			addModelEvents();
		}

		protected function enterHandler(event : Event) : void {
			var value : Number = Number(_textInput.text);
			if(isNaN(Number(value))) {
				_textInput.text = String(_model.value);
			} else {
				_model.value = value;
			}
		}

		protected function focusOutHandler(event : Event) : void {
			var value : Number = Number(_textInput.text);
			if(isNaN(Number(value))) {
				_textInput.text = String(_model.value);
			} else {
				_model.value = value;
			}
		}

		protected function up_clickHandler(event : MouseEvent) : void {
			if(_model.value < _model.max) {
				_model.value++;
			}
		}

		protected function down_clickHandler(event : MouseEvent) : void {
			if(_model.value > _model.min) {
				_model.value--;
			}
		}

		public function Stepper(data : StepperData) {
			_data = data;
			super(_data);
			_model = new RangeModel();
			_textInput.text = String(_model.value);
			initEvents();
		}

		public function get model() : RangeModel {
			return _model;
		}

		public function set model(value : RangeModel) : void {
			if(_model === value)return;
			if(_model != null) {
				removeModelEvents();
			}
			_model = value;
			_textInput.text = String(_model.value);
			addModelEvents();
		}
	}
}
