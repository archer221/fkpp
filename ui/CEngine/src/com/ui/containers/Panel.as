package com.ui.containers {
	import com.ui.controls.ScrollBar;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponent;
	import com.ui.data.PanelData;
	import com.ui.data.ScrollBarData;
	import com.ui.events.GScrollBarEvent;
	import com.ui.layout.GLayout;
	import com.ui.manager.UIManager;
	import com.ui.skin.ASSkin;
	import com.utils.MathUtil;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;


	/**
	 * Game Panel
	 * 
	 * @author Cafe
	 * @version 20100801
	 */
	public class Panel extends UIComponent {

		protected var _data : PanelData;

		protected var _bgSkin : Sprite;

		protected var _content : Sprite;

		protected var _modalSkin : Sprite;

		protected var _viewW : int;

		protected var _viewH : int;

		protected var _viewRect : Rectangle = new Rectangle();

		protected var _bounds : Rectangle = new Rectangle();

		protected var _v_sb : ScrollBar;

		protected var _h_sb : ScrollBar;

		protected var _menuTrigger : DisplayObject;

		override protected function create() : void {
			_bgSkin = UIManager.getUI(_data.bgAsset);
			_content = new Sprite();
			_content.name = "content";
			_content.x = this._content.y = _data.padding;
			var data : ScrollBarData = _data.scrollBarData.clone();
			data.visible = false;
			data.direction = ScrollBarData.VERTICAL;
			_v_sb = new ScrollBar(data);
			data = _data.scrollBarData.clone();
			data.direction = ScrollBarData.HORIZONTAL;
			data.visible = false;
			_h_sb = new ScrollBar(data);
			addChild(_bgSkin);
			addChild(_content);
			addChild(_v_sb);
			addChild(_h_sb);
			if(_data.modal)_modalSkin = ASSkin.modalSkin;
			switch(_data.scaleMode) {
				case ScaleMode.SCALE_WIDTH:
					_height = _bgSkin.height;
					break;
				case ScaleMode.SCALE_NONE:
					var offset : Point = UIManager.getOffset(_bgSkin);
					_width = _bgSkin.width + offset.x;
					_height = _bgSkin.height + offset.y;
					break;
			}
		}

		override protected function layout() : void {
			_bgSkin.width = _width;
			_bgSkin.height = _height;
			_viewW = Math.max(_base.minWidth, _width - _data.padding * 2);
			_viewH = Math.max(_base.minHeight, _height - _data.padding * 2);
			_viewRect.width = _viewW;
			_viewRect.height = _viewW;
			_content.scrollRect = _viewRect;
			_v_sb.x = _width - _data.padding - _v_sb.width;
			_v_sb.y = _data.padding;
			_h_sb.x = _data.padding;
			_h_sb.y = _height - _data.padding - _h_sb.height;
			reset();
		}

		protected function reset() : void {
			resetBounds();
			var needV : Boolean = _bounds.height > _viewH;
			var needH : Boolean = _bounds.width > _viewW;
			if(needV && !needH) {
				needH = _bounds.width > _viewW - _v_sb.width;
			}
			if(needH && !needV) {
				needV = _bounds.height > _viewH - _h_sb.height;
			}
			var newW : int = _viewW - (needV ? _v_sb.width : 0);
			var newH : int = _viewH - (needH ? _h_sb.height : 0);
			if(_viewRect.width != newW || _viewRect.height != newH) {
				_viewRect.width = newW;
				_viewRect.height = newH;
				resizeContent();
				reset();
				return;
			}
			if(needV) {
				if(!_v_sb.visible) {
					_v_sb.visible = true;
					_v_sb.addEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				}
				_v_sb.height = newH;
				_v_sb.resetValue(newH, 0, _bounds.height - newH, (_content.scrollRect ? _content.scrollRect.y : 0));
			}else if(_v_sb.visible) {
				_v_sb.removeEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				_v_sb.visible = false;
				_viewRect.y = 0;
			}
			if(needH) {
				if(!_h_sb.visible) {
					_h_sb.visible = true;
					_h_sb.addEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				}
				_h_sb.width = newW;
				_h_sb.resetValue(newW, 0, _bounds.width - newW, (_content.scrollRect ? +_content.scrollRect.x : 0));
			}else if(_h_sb.visible) {
				_h_sb.removeEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				_h_sb.visible = false;
				_viewRect.x = 0;
			}
			_content.scrollRect = _viewRect;
		}

		protected function resizeContent() : void {
		}

		protected function resetBounds() : void {
			var total : int = _content.numChildren;
			var x : Number = 0;
			var y : Number = 0;
			var w : Number = _base.minWidth;
			var h : Number = _base.minHeight;
			for(var i : int = 0;i < total;i++) {
				var child : DisplayObject = _content.getChildAt(i);
				x = Math.min(x, child.x);
				y = Math.min(y, child.y);
				w = Math.max(w, child.x + child.width);
				h = Math.max(h, child.y + child.height);
			}
			_bounds = new Rectangle(x, y, w, h);
		}

		protected function scrollHandler(event : GScrollBarEvent) : void {
			if(event.direction == ScrollBarData.VERTICAL) {
				_viewRect.y = event.position;
			} else {
				_viewRect.x = event.position;
			}
			_content.scrollRect = _viewRect;
		}

		override protected  function onShow() : void {
			if(_data.modal) {
				UIManager.root.stage.focus = null;
				var topLeft : Point = parent.localToGlobal(MathUtil.ORIGIN);
				_modalSkin.x = -topLeft.x;
				_modalSkin.y = -topLeft.y;
				_modalSkin.width = UIManager.root.stage.stageWidth;
				_modalSkin.height = UIManager.root.stage.stageHeight;
				parent.addChildAt(_modalSkin, parent.numChildren - 1);
				parent.swapChildrenAt(parent.getChildIndex(this), parent.numChildren - 1);
			}
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			if(_menuTrigger != null) {
				stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			}
		}

		override protected function onHide() : void {
			if(_data.modal) {
				_modalSkin.parent.removeChild(_modalSkin);
			}
			removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			if(_menuTrigger != null) {
				stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			}
		}

		protected function mouseWheelHandler(event : MouseEvent) : void {
			if(_v_sb && _v_sb.visible) {
				event.stopPropagation();
				_v_sb.scroll(event.delta);
			}
		}

		protected function stage_mouseUpHandler(event : MouseEvent) : void {
			var hitTarget : DisplayObject = UIManager.hitTest(stage.mouseX, stage.mouseY);
			if(!UIManager.atParent(hitTarget, this)) {
				var outside : Boolean = true;
				if(UIManager.atParent(hitTarget, _menuTrigger)) {
					outside = false;
				}
				if(outside) {
					hide();
				}
			}
		}

		public function Panel(data : PanelData) {
			_data = data;
			super(data);
		}

		public function add(value : DisplayObject) : void {
			if(!value)return;
			_content.addChild(value);
			if(value is UIComponent)GLayout.update(this, UIComponent(value));
			reset();
		}

		public function get modal() : Boolean {
			return _data.modal;
		}

		public function resizeModal() : void {
			if(_modalSkin == null)return;
			_modalSkin.width = UIManager.root.stage.stageWidth;
			_modalSkin.height = UIManager.root.stage.stageHeight;
		}

		public function get padding() : int {
			return _data.padding;
		}

		public function set menuTrigger(value : DisplayObject) : void {
			_menuTrigger = value;
		}
	}
}
