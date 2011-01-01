package com.ui.containers {
	import com.ui.core.UIComponent;
	import com.ui.data.TitleWindowData;
	import com.ui.manager.UIManager;
	import com.ui.skin.ASSkin;
	import com.utils.MathUtil;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class TitleWindow extends UIComponent {

		protected var _data : TitleWindowData;

		protected var _titleBar : TitleBar;

		protected var _contentPanel : Panel;

		protected var _modalSkin : Sprite;

		protected var _regX : int;

		protected var _regY : int;

		override protected function create() : void {
			_titleBar = new TitleBar(_data.titleBarData);
			_contentPanel = new Panel(_data.panelData);
			_contentPanel.y = _titleBar.height - 1;
			addChild(_titleBar);
			addChild(_contentPanel);
			if(_data.modal) {
				_modalSkin = ASSkin.modalSkin;
			}
		}

		override protected function layout() : void {
			_titleBar.width = _width;
			_contentPanel.setSize(_width, _height - _titleBar.height - 1);
		}

		override protected function onShow() : void {
			if(_data.modal) {
				var topLeft : Point = parent.localToGlobal(MathUtil.ORIGIN);
				_modalSkin.x = -topLeft.x;
				_modalSkin.y = -topLeft.y;
				_modalSkin.width = UIManager.root.stage.stageWidth;
				_modalSkin.height = UIManager.root.stage.stageHeight;
				parent.addChildAt(_modalSkin, parent.numChildren - 1);
				parent.swapChildrenAt(parent.getChildIndex(this), parent.numChildren - 1);
			}
			if(_data.allowDrag) {
				_titleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBar_mouseDownHandler);
			}
		}

		override protected function onHide() : void {
			if(_data.modal) {
				_modalSkin.parent.removeChild(_modalSkin);
			}
			if(_data.allowDrag) {
				_titleBar.removeEventListener(MouseEvent.MOUSE_DOWN, titleBar_mouseDownHandler);
				if(stage.hasEventListener(MouseEvent.MOUSE_MOVE)) {
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
				}
				if(stage.hasEventListener(MouseEvent.MOUSE_UP)) {
					stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				}
			}
		}

		private function titleBar_mouseDownHandler(event : MouseEvent) : void {
			startDragging(event);
		}

		private function startDragging(event : MouseEvent) : void {
			_regX = event.stageX - x;
			_regY = event.stageY - y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		private function stage_mouseMoveHandler(event : MouseEvent) : void {
			if(isNaN(_regX) || isNaN(_regY))return;
			var newX : int = Math.min(stage.stageWidth - _width, event.stageX - _regX);
			var newY : int = Math.min(stage.stageHeight - _height, event.stageY - _regY);
			moveTo(newX, newY);
		}

		private function stage_mouseUpHandler(event : MouseEvent) : void {
			if(!isNaN(_regX))stopDragging();
		}

		private function stopDragging() : void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			_regX = NaN;
			_regY = NaN;
		}

		public function TitleWindow(data : TitleWindowData) {
			_data = data;
			super(data);
		}

		public function get contentPanel() : Panel {
			return _contentPanel;
		}

		public function get modal() : Boolean {
			return _data.modal;
		}

		public function resizeModal() : void {
			if(_modalSkin == null)return;
			_modalSkin.width = UIManager.root.stage.stageWidth;
			_modalSkin.height = UIManager.root.stage.stageHeight;
		}
	}
}