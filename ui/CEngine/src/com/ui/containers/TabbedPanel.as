package com.ui.containers {
	import com.ui.controls.Tab;
	import com.ui.core.UIComponent;
	import com.ui.data.TabbedPanelData;
	import com.ui.group.GToggleGroup;
	import flash.events.Event;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class TabbedPanel extends UIComponent {

		protected var _data : TabbedPanelData;

		protected var _group : GToggleGroup;

		protected var _viewStack : ViewStack;

		override protected function create() : void {
			_group = new GToggleGroup();
			_viewStack = new ViewStack(_data.viewStackData);
			addChild(_viewStack);
		}

		override protected function layout() : void {
			_viewStack.x = 0;
			_viewStack.y = _data.tabData.height - 1;
		}

		private function initEvents() : void {
			_group.selectionModel.addEventListener(Event.CHANGE, group_changeHandler);
		}

		private function group_changeHandler(event : Event) : void {
			_viewStack.selectionModel.index = _group.selectionModel.index;
			_width = _viewStack.width;
			_height = _data.tabData.height + _viewStack.height - 1;
		}

		public function TabbedPanel(data : TabbedPanelData) {
			_data = data;
			super(_data);
			initEvents();
		}

		public function get selection() : UIComponent {
			return _viewStack.selection;
		}

		public function get group() : GToggleGroup {
			return _group;
		}

		public function addTab(title : String,component : UIComponent) : void {
			var tab : Tab = new Tab(_data.tabData);
			tab.text = title;
			var lastTab : Tab = _group.model.getLast() as Tab;
			if(lastTab) {
				tab.x = lastTab.x + lastTab.width - 1;
				tab.y = 0;
			}
			addChild(tab);
			_group.model.add(tab);
			_viewStack.add(component);
		}
	}
}
