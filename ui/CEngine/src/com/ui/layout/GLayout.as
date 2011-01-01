package com.ui.layout {
	import com.ui.containers.Panel;
	import com.ui.core.Align;
	import com.ui.core.UIComponent;
	import com.ui.manager.UIManager;
	import flash.display.DisplayObject;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class GLayout {

		public function GLayout() {
		}

		public static function update(parent : DisplayObject,target : UIComponent) : void {
			if(!target)return;
			var a : Align = target.align;
			if(!a)return;
			var w : int;
			var h : int;
			if(parent == UIManager.root) {
				w = parent.stage.stageWidth;
				h = parent.stage.stageHeight;
			} else if(parent is Panel) {
				w = parent.width - Panel(parent).padding * 2;
				h = parent.height - Panel(parent).padding * 2;
			} else {
				w = parent.width;
				h = parent.height;
			}
			var l : int = a.left;
			var r : int = a.right;
			var t : int = a.top;
			var b : int = a.bottom;
			var hc : int = a.horizontalCenter;
			var vc : int = a.verticalCenter;
			if(l != -1) {
				target.x = l;
				if(r != -1)target.width = w - l - r;        
			}else if(r != -1) {
				target.x = w - target.width - r;
			}else if(hc != -1) {
				target.x = int((w - target.width) * 0.5) + hc;
			}
			if(t != -1) {
				target.y = t;
				if(b != -1)target.height = h - t - b;
			}else if(b != -1) {
				target.y = h - target.height - b;
			}else if(vc != -1) {
				target.y = int((h - target.height) * 0.5) + vc;
			}
		}

		public static function layout(target : DisplayObject,align : Align = null) : void {
			if(!target || !target.parent)return;
			var a : Align;
			if(align) {
				a = align;
			}else if(target is UIComponent) {
				a = UIComponent(target).align;
			}
			if(!a)return;
			var w : int;
			var h : int;
			if(target.parent == UIManager.root) {
				w = target.stage.stageWidth;
				h = target.stage.stageHeight;
			} else if(target.parent.name == "content") {
				var panel : Panel = Panel(target.parent.parent);
				w = panel.width - panel.padding * 2;
				h = panel.height - panel.padding * 2;
			} else {
				w = target.parent.width;
				h = target.parent.height;
			}
			var l : int = a.left;
			var r : int = a.right;
			var t : int = a.top;
			var b : int = a.bottom;
			var hc : int = a.horizontalCenter;
			var vc : int = a.verticalCenter;
			if(l != -1) {
				target.x = l;
				if(r != -1)target.width = w - l - r;		
			}else if(r != -1) {
				target.x = w - target.width - r;
			}else if(hc != -1) {
				target.x = int((w - target.width) * 0.5) + hc;
			}
			if(t != -1) {
				target.y = t;
				if(b != -1)target.height = h - t - b;
			}else if(b != -1) {
				target.y = h - target.height - b;
			}else if(vc != -1) {
				target.y = int((h - target.height) * 0.5) + vc;
			}
		}
	}
}
