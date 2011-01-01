package com.ui.controls {
	import com.model.ListEvent;
	import com.model.ListModel;
	import com.model.ListState;
	import com.model.SelectionModel;
	import com.ui.cell.Cell;
	import com.ui.cell.CellData;
	import com.ui.containers.Panel;
	import com.ui.core.ScaleMode;
	import com.ui.data.ListData;
	import flash.events.Event;


	/**
	 * List
	 * 
	 * @author Cafe
	 * @version 20100802
	 */
	public class List extends Panel {

		protected var _listData : ListData;

		protected var _cell : Class;

		protected var _selectedCells : Array;

		protected var _selectionModel : SelectionModel;

		protected var _model : ListModel;

		protected var _cells : Array;

		protected var _cellWidth : int;

		protected var _cellHeight : int;

		override protected function init() : void {
			_cell = _listData.cell;
			_cells = new Array();
			_selectedCells = new Array();
			super.init();
		}

		override protected function create() : void {
			super.create();
			var templet : Cell = new _cell(_listData.cellData);
			_cellWidth = templet.width;
			_cellHeight = templet.height;
			resetSize(_listData.rows);
			if(_listData.rows > 0) {
				initCells();
			}
		}

		private function resetSize(rows : int) : void {
			if(_base.scaleMode == ScaleMode.AUTO_SIZE) {
				_width = _cellWidth + _listData.padding * 2;
				if(rows > 0) {
					_height = _cellHeight * rows + (rows - 1) * _listData.hGap + _listData.padding * 2;
				} else {
					_height = Math.max(_base.minHeight, _listData.padding * 2);
				}
			}else if(_base.scaleMode == ScaleMode.AUTO_HEIGHT) {
				if(rows > 0) {
					_height = _cellHeight * rows + (rows - 1) * _listData.hGap + _listData.padding * 2;
				} else {
					_height = Math.max(_base.minHeight, _listData.padding * 2);
				}
			}
		}

		override protected function resizeContent() : void {
			for each(var cell:Cell in _cells) {
				cell.width = _viewRect.width;
			}
		}

		protected function removeCells() : void {
			for each(var cell:Cell in _cells) {
				removeCellEvents(cell);
				cell.hide();
			}
			_cells = new Array();
		}

		protected function addCells() : void {
			for(var i : int = 0;i < _model.size;i++) {
				var data : CellData = _listData.cellData.clone();
				data.index = i;
				data.y = i * (_cellHeight + _listData.hGap);
				data.width = _viewRect.width;
				var cell : Cell = new _cell(data);
				_cells.push(cell);
				cell.source = _model.getAt(i);
				add(cell);
				addCellEvents(cell);
			}
		}

		protected function initCells() : void {
			_cells = new Array();
			for(var i : int = 0;i < _listData.rows;i++) {
				var data : CellData = _listData.cellData.clone();
				data.index = i;
				data.y = i * (_cellHeight + _listData.hGap);
				data.enabled = false;
				var cell : Cell = new _cell(data);
				add(cell);
				_cells.push(cell);
				addCellEvents(cell);
			}
		}

		protected function updateCells(start : int = 0) : void {
			var end : int = _model.size;
			var len : int = _cells.length;
			var cell : Cell;
			for(var i : int = start;i < len;i++) {
				cell = _cells[i] as Cell;
				if(i < end) {
					if(cell)cell.source = _model.getAt(i);
				} else {
					if(cell)cell.source = null;
				}
			}
		}

		protected function addCellEvents(cell : Cell) : void {
			if(_listData.cellData.allowDoubleClick) {
				cell.addEventListener(Cell.DOUBLE_CLICK, cell_doubleClickHandler);
			}
			cell.addEventListener(Cell.SINGLE_CLICK, cell_singleClickHandler);
		}

		protected function removeCellEvents(cell : Cell) : void {
			if(_listData.cellData.allowDoubleClick) {
				cell.removeEventListener(Cell.DOUBLE_CLICK, cell_doubleClickHandler);
			}
			cell.removeEventListener(Cell.SINGLE_CLICK, cell_singleClickHandler);
		}

		protected function selection_changeHandler(event : Event) : void {
			var cell : Cell;
			for each(cell in _selectedCells) {
				cell.selected = false;
			}
			_selectedCells.splice(0);
			cell = _cells[_selectionModel.index] as Cell;
			if(cell) {
				cell.selected = true;
				_selectedCells.push(cell);
			}
		}

		protected function cell_doubleClickHandler(event : Event) : void {
			dispatchEvent(event);
		}

		protected function cell_singleClickHandler(event : Event) : void {
			var cell : Cell = Cell(event.target);
			if(cell.data.clickSelect) {
				var index : int = _cells.indexOf(cell);
				if(index != -1) {
					_selectionModel.index = index;
				}
			}
			dispatchEvent(event);
		}

		protected function model_changeHandler(event : ListEvent) : void {
			var cell : Cell;
			var data : CellData;
			var i : int;
			var index : int = event.index;
			var item : Object = event.item;
			switch(event.state) {
				case ListState.RESET:
					if(_cells.length != (_model.max > 0 ? _model.max : _model.size)) {
						removeCells();
						addCells();
						resetSize(_model.size);
						layout();
						_selectionModel.index = -1;
						dispatchEvent(new Event(Event.RESIZE));
					} 
					updateCells();
					if(_selectionModel.index > _model.size) {
						_selectionModel.index = -1;
					}
					break;
				case ListState.ADDED:
					if(_model.max > 0) {
						Cell(_cells[index]).source = item;
						return;
					}
					data = _listData.cellData.clone();
					data.y = event.index * (_cellHeight + _listData.hGap);
					data.width = _viewRect.width;
					data.height = _cellHeight;
					cell = new _cell(data);
					cell.source = item;
					_cells.push(cell);
					_content.addChild(cell);
					addCellEvents(cell);
					if(_data.scaleMode == ScaleMode.AUTO_HEIGHT) {
						height = _cellHeight * _model.size + (_model.size - 1) * _listData.hGap + _listData.padding * 2;
					} else {
						super.reset();
					}
					break;
				case ListState.REMOVED:
					if(_model.max > 0) {
						updateCells(event.index);
						if(event.index < _selectionModel.index) {
							_selectionModel.index -= 1;
						}else if(event.index == _selectionModel.index) {
							_selectionModel.index = -1;
						}
						return;
					}
					cell = _cells[index];
					removeCellEvents(cell);
					cell.hide();
					_cells.splice(index, 1);
					for(i = index;i < _cells.length;i++) {
						Cell(_cells[i]).y -= _cellHeight + _listData.hGap;
					}
					if(index < _selectionModel.index) {
						_selectionModel.index -= 1;
					}else if(index == _selectionModel.index) {
						_selectionModel.index = -1;
					}
					if(_data.scaleMode == ScaleMode.AUTO_HEIGHT) {
						height = _cellHeight * _model.size + (_model.size - 1) * _listData.hGap + _listData.padding * 2;
					} else {
						super.reset();
					}
					break;
				case ListState.UPDATE:
					cell = Cell(_cells[index]);
					cell.source = item;
					if(!item && _selectionModel.index == index)_selectionModel.index = -1;
					break;
				case ListState.INSERT:
					if(_model.max > 0) {
						updateCells(index);
						if(index <= _selectionModel.index)_selectionModel.index += 1;
						return;
					}
					data = _listData.cellData.clone();
					data.y = index * (_cellHeight + _listData.hGap);
					data.width = _viewRect.width;
					data.height = _cellHeight;
					cell = new _cell(data);
					cell.source = item;
					_cells.splice(index, 0, cell);
					_content.addChild(cell);
					addCellEvents(cell);
					for(i = event.index + 1;i < _cells.length;i++) {
						Cell(_cells[i]).y += _cellHeight + _listData.hGap;
					}
					if(event.index <= _selectionModel.index)_selectionModel.index += 1;
					if(_data.scaleMode == ScaleMode.AUTO_HEIGHT) {
						height = _cellHeight * _model.size + (_model.size - 1) * _listData.hGap + _listData.padding * 2;
					} else {
						super.reset();
					}
					break;
			}
		}

		
		protected function addModelEvents() : void {
			_model.addEventListener(ListEvent.CHANGE, model_changeHandler);
			if(_listData.cellData.allowSelect) {
				_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);	
			}
		}

		protected function removeModelEvents() : void {
			_model.removeEventListener(ListEvent.CHANGE, model_changeHandler);
			if(_listData.cellData.allowSelect) {
				_selectionModel.removeEventListener(Event.CHANGE, selection_changeHandler);
			}
		}

		public function List(data : ListData) {
			_listData = data;
			super(data);
			_model = new ListModel(false, _listData.rows);
			_selectionModel = new SelectionModel();
			addModelEvents();
		}

		public function get selectionModel() : SelectionModel {
			return _selectionModel;
		}

		public function set model(value : ListModel) : void {
			if(_model != null) {
				removeModelEvents();
			}
			_model = value;
			if(_model != null) {
				addModelEvents();
				_model.update();
			}
		}

		public function get model() : ListModel {
			return _model;
		}

		public function get selectionCell() : Cell {
			return _cells[_selectionModel.index];
		}

		public function get selection() : Object {
			return _model.getAt(_selectionModel.index);
		}
	}
}