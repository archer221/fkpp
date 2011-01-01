package com.ui.controls {
	import com.model.ListModel;
	import com.model.SelectionModel;
	import com.ui.cell.Cell;
	import com.ui.core.UIComponent;
	import com.ui.data.ComboBoxData;
	import com.ui.manager.UIManager;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;


	/**
	 * @version 20100325
	 * @author Cafe
	 */
	public class ComboBox extends UIComponent {

		protected var _data : ComboBoxData;

		protected var _button : Button;

		protected var _textInput : TextInput;

		protected var _arrow : Button;

		protected var _list : List;

		protected var _editable : Boolean;

		override protected function create() : void {
			_button = new Button(_data.buttonData);
			_textInput = new TextInput(_data.textInputData);
			_arrow = new Button(_data.arrow);
			_list = new List(_data.listData);
			_editable = _data.editable;
			if(_editable) {
				addChild(_textInput);
				addChild(_arrow);
			} else {
				addChild(_button);
			}
		}

		override protected function layout() : void {
			_button.setSize(_width, _height);
			_textInput.width = _width - _arrow.width;
			_arrow.x = _width - _arrow.width;
		}

		protected function clickHandler(event : MouseEvent) : void {
			if(_list.parent) {
				_list.parent.removeChild(_list);
			} else {
				var global : Point = localToGlobal(new Point(0, _height));
				_list.moveTo(global.x, global.y);
				UIManager.root.addChild(_list);
			}
		}

		protected function list_singleClickHandler(event : Event) : void {
			if(_list.selectionModel.isSelected) {
				var value : Object = _list.selection;
				if(value) {
					if(_editable) {
						_textInput.text = value.toString();
					} else {
						_button.text = value.toString();
					}
				}
			}
			_list.hide();
		}

		override protected function onShow() : void {
			_button.addEventListener(MouseEvent.CLICK, clickHandler);
			_arrow.addEventListener(MouseEvent.CLICK, clickHandler);
			_list.addEventListener(Cell.SINGLE_CLICK, list_singleClickHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);
		}

		override protected function onHide() : void {
			_button.removeEventListener(MouseEvent.CLICK, clickHandler);
			_arrow.removeEventListener(MouseEvent.CLICK, clickHandler);
			_list.removeEventListener(Cell.SINGLE_CLICK, list_singleClickHandler);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);
		}

		private function stage_mouseDownHandler(event : MouseEvent) : void {
			var target : DisplayObject = event.target as DisplayObject;
			if(UIManager.atParent(target, _list))return;
			if(UIManager.atParent(target, this))return;
			_list.hide();
		}

		private function selectHandler(event : Event) : void {
			if(_list.selectionModel.isSelected) {
				var value : Object = _list.selection;
				if(value) {
					if(_editable) {
						_textInput.text = value.toString();
					} else {
						_button.text = value.toString();
					}
				}
			}
			_list.hide();
		}

		public function ComboBox(data : ComboBoxData) {
			_data = data;
			super(_data);
			_list.selectionModel.addEventListener(Event.CHANGE, selectHandler);
		}

		public function get model() : ListModel {
			return _list.model;
		}

		public function get selectionModel() : SelectionModel {
			return _list.selectionModel;
		}

		public function set listWidth(value : int) : void {
			_list.width = value;
		}
		
		public function get list():List{
			return _list;
		}
	}
}
