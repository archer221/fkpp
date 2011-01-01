﻿package com.ui.core {
	import com.effects.GEffect;
	import com.ui.controls.ToolTip;
	import com.ui.manager.GToolTipManager;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;


	/**
	 * @version 20100402
	 * @author Cafe
	 */
	public class UIComponent extends Sprite {

		protected var _base : UIComponentData;

		protected var _width : int;

		protected var _height : int;

		protected var _enabled : Boolean = true;

		protected var _source : *;

		protected var _toolTip : ToolTip;

		private function addToStageHandler(event : Event) : void {
			onShow();
		}

		private function removeFromStageHandler(event : Event) : void {
			onHide();
		}

		protected function init() : void {
			moveTo(_base.x, _base.y);
			_width = _base.width;
			_height = _base.height;
			alpha = _base.alpha;
			visible = _base.visible;
			if(_base.hideEffect) {
				_base.hideEffect.target = this;
			}
			if(_base.toolTipData) {
				_toolTip = new _base.toolTip(_base.toolTipData);
				GToolTipManager.registerToolTip(this);
			}
			create();
			layout();
		}

		protected function create() : void {
		}

		protected function layout() : void {
		}

		protected function swap(source : Sprite,target : Sprite) : Sprite {
			if(source == null || source.parent == null || target == null || source == target) {
				return source;
			}
			var index : int = source.parent.getChildIndex(source);
			var parent : DisplayObjectContainer = source.parent;
			source.parent.removeChild(source);
			parent.addChildAt(target, index);
			return target;
		}

		protected function onShow() : void {
		}

		protected function onHide() : void {
		}

		protected function onEnabled() : void {
		}

		protected function effect_endHandler(event : Event) : void {
			var effect : GEffect = GEffect(event.target);
			effect.removeEventListener(GEffect.END, effect_endHandler);
			parent.removeChild(this);
			alpha = 1;
		}

		public function UIComponent(base : UIComponentData) {
			_base = base;
			init();
			enabled = _base.enabled;
			filters = _base.filters;
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
		}

		public function set align(value : Align) : void {
			_base.align = value;
		}

		public function get align() : Align {
			return _base.align;
		}

		public function moveTo(newX : int,newY : int) : void {
			x = newX;
			y = newY;
		}

		public function set position(value : Point) : void {
			x = value.x;
			y = value.y;
		}

		public function get position() : Point {
			return new Point(x, y);
		}

		public function setSize(w : int,h : int) : void {
			if(_base.scaleMode == ScaleMode.SCALE_NONE)return;
			var newWidth : int = Math.max(_base.minWidth, Math.min(_base.maxWidth, w));
			var newHeight : int = Math.max(_base.minHeight, Math.min(_base.maxHeight, h));
			if(_width == newWidth && _height == newHeight)return;
			switch(_base.scaleMode) {
				case ScaleMode.SCALE_WIDTH:
					_width = newWidth;
					break;
				default:
					_width = newWidth;
					_height = newHeight;
					break;
			}
			layout();
			dispatchEvent(new Event(Event.RESIZE));
		}

		override public function set width(value : Number) : void {
			if(_base.scaleMode == ScaleMode.SCALE_NONE)return;
			var newWidth : int = Math.max(_base.minWidth, Math.min(_base.maxWidth, Math.floor(value)));
			if(_width == newWidth)return;
			_width = newWidth;
			layout();
			dispatchEvent(new Event(Event.RESIZE));
		}

		override public function get width() : Number {
			return _width;
		}

		override public function set height(value : Number) : void {
			if(_base.scaleMode == ScaleMode.SCALE_NONE)return;
			if(_base.scaleMode == ScaleMode.SCALE_WIDTH)return;
			var newHeight : int = Math.max(_base.minHeight, Math.min(_base.maxHeight, Math.floor(value)));
			if(_height == newHeight)return;
			_height = newHeight;
			layout();
			dispatchEvent(new Event(Event.RESIZE));
		}

		override public function get height() : Number {
			return _height;
		}

		public function set enabled(value : Boolean) : void {
			if(_enabled == value)return;
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			onEnabled();
		}

		public function get enabled() : Boolean {
			return _enabled;
		}

		public function show() : void {
			if(_base.parent == null)return;
			if(parent != null) {
				var depth : int = parent.getChildIndex(this);
				var target : int = parent.numChildren - 1;
				if(depth < target) {
					parent.swapChildrenAt(depth, target);
				}
				return;
			}
			_base.parent.addChild(this);
		}

		public function hide() : void {
			if(parent == null)return;
			if(_base.hideEffect) {
				_base.hideEffect.start();
				_base.hideEffect.addEventListener(GEffect.END, effect_endHandler);
			} else {
				if(_base.parent == null) {
					_base.parent = parent;
				}
				parent.removeChild(this);
			}
		}

		public function get toolTip() : ToolTip {
			return _toolTip as ToolTip;
		}

		public function set source(value : *) : void {
			_source = value;
		}

		public function get source() : * {
			return _source;
		}
	}
}
