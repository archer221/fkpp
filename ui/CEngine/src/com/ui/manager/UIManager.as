package com.ui.manager {
	import com.net.AssetData;
	import com.net.RESManager;
	import com.ui.containers.Panel;
	import com.ui.containers.TitleWindow;
	import com.ui.core.UIComponent;
	import com.ui.layout.GLayout;
	import com.ui.skin.ASSkin;
	import com.utils.GStringUtil;
	import com.utils.MathUtil;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;


	com.net.AssetData;


	/**
	 * UI Manager
	 * 
	 * @author Cafe
	 * @version 20100724
	 */
	public class UIManager {

		public static const SHADOW : DropShadowFilter = new DropShadowFilter(1, 45, 0, 0.5, 1, 1);

		private static var _defaultFont : String;

		private static var _defaultCSS : StyleSheet;

		private static var _root : Sprite;

		private static var _url : String = "unkown";

		private static var _swfName : String = "unkown.swf";

		private static var _dragModal : Sprite = ASSkin.emptySkin;

		private static function stageResizeHandler(event : Event) : void {
			if(UIManager._root == null)return;
			for(var i : int = 0;i < UIManager._root.numChildren;i++) {
				var child : DisplayObject = UIManager._root.getChildAt(i);
				var component : UIComponent = child as UIComponent;
				if(component == null)continue;
				if(component.align == null)continue;
				if(component is Panel) {
					var panel : Panel = component as Panel;
					if(panel.modal)panel.resizeModal();
				}else if(component is TitleWindow) {
					var titleWindow : TitleWindow = component as TitleWindow;
					if(titleWindow.modal)titleWindow.resizeModal();
				}
				GLayout.layout(component);
			}
			if(_dragModal.parent) {
				_dragModal.width = _root.stage.stageWidth;
				_dragModal.height = _root.stage.stageHeight;
			}
		}

		public static function setRoot(value : Sprite) : void {
			_root = value;
			_url = UIManager._root.loaderInfo.url;
			_swfName = UIManager._url.split("/").pop();
			_root.stage.addEventListener(Event.RESIZE, UIManager.stageResizeHandler);
		}

		public static function get root() : Sprite {
			return UIManager._root;
		}

		public static function get url() : String {
			return UIManager._url;
		}

		public static function get swfName() : String {
			return UIManager._swfName;
		}

		public static function get defaultFont() : String {
			if(_defaultFont == null) {
				_defaultFont = "宋体";
				var os : String = Capabilities.os;
				if (os.indexOf("Mac") != -1) {
					_defaultFont = "华文黑体";
				}else if(os.indexOf("Linux") != -1) {
					_defaultFont = "AR PL UMing CN";
				}
			}
			return _defaultFont;
		}

		public static function get defaultCSS() : StyleSheet {
			if(_defaultCSS == null) {
				_defaultCSS = new StyleSheet();
				_defaultCSS.setStyle(".font", {fontFamily:defaultCSS});
			}
			return _defaultCSS;
		}

		public static function getEdgeFilters(edgeColor : uint,edgeAlpha : Number = 1) : Array {
			return [new GlowFilter(edgeColor, edgeAlpha, 2, 2, 17, 1, false, false)];
		}

		public static function getOffset(value : DisplayObject) : Point {
			var rect : Rectangle = MathUtil.toIntRect(value.getBounds(value));
			return rect.topLeft;
		}

		public static function getUI(asset : AssetData) : Sprite {
			if(asset == null) {
				return null;
			}
			var skin : Sprite;
			if(asset.libId == AssetData.AS_LIB) {
				skin = ASSkin.getBy(asset);
			} else {
				skin = RESManager.getMC(asset);
				if(!skin)skin = ASSkin.getBy(asset);
				else skin.mouseEnabled = skin.mouseChildren = false;
			}
			if(skin.name == "errorSkin") {
				trace(GStringUtil.format("UIManager:{0} not found!", asset.key));
			}
			return skin;
		}

		public static function createRect(color : uint,alpha : Number = 1) : Sprite {
			var skin : Sprite = new Sprite();
			skin.mouseEnabled = skin.mouseChildren = false;
			var g : Graphics = skin.graphics;
			g.beginFill(0, 1);
			g.drawRect(0, 0, 20, 20);
			g.endFill();
			g.beginFill(color, alpha);
			g.drawRect(1, 1, 18, 18);
			g.endFill();
			skin.scale9Grid = new Rectangle(1, 1, 18, 18);
			return skin;
		}

		public static function createBorder(color : uint = 0x000000) : Sprite {
			var skin : Sprite = new Sprite();
			skin.mouseEnabled = skin.mouseChildren = false;
			var g : Graphics = skin.graphics;
			g.beginFill(0, 0.2);
			g.drawRect(1, 1, 18, 18);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(0, 0, 20, 1);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(0, 1, 1, 18);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(19, 1, 1, 18);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(0, 19, 20, 1);
			g.endFill();
			skin.scale9Grid = new Rectangle(1, 1, 18, 18);
			return skin;
		}

		public static function createBar(color : uint = 0xFFFF00) : Sprite {
			var skin : Sprite = new Sprite();
			skin.mouseEnabled = skin.mouseChildren = false;
			var g : Graphics = skin.graphics;
			g.beginFill(0x000000, 1);
			g.drawRect(0, 0, 20, 20);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(1, 1, 18, 18);
			g.endFill();
			g.beginFill(0xFFFFFF, 0.2);
			g.drawRect(1, 1, 18, 1);
			g.endFill();
			g.beginFill(0xFFFFFF, 0.2);
			g.drawRect(1, 1, 1, 18);
			g.endFill();
			g.beginFill(0xFFFFFF, 0.2);
			g.drawRect(18, 1, 1, 18);
			g.endFill();
			g.beginFill(0x000000, 0.2);
			g.drawRect(1, 18, 18, 1);
			g.endFill();
			skin.scale9Grid = new Rectangle(2, 2, 16, 16);
			return skin;
		}

		public static function getMask() : Sprite {
			var mask : Sprite = new Sprite();
			mask.mouseEnabled = false;
			var g : Graphics = mask.graphics;
			g.beginFill(0x0000FF, 1);
			g.drawRect(0, 0, 10, 10);
			g.endFill();
			return mask;
		}

		public static function getTextFormat() : TextFormat {
			var textFormat : TextFormat = new TextFormat();
			textFormat.font = UIManager.defaultFont;
			textFormat.size = 12;
			return textFormat;
		}

		public static function getTextField() : TextField {
			var textField : TextField = new TextField();
			textField.width = 0;
			textField.text = "?";
			textField.height = textField.textHeight + 4;
			textField.text = "";
			return textField;
		}

		public static function getInputTextField() : TextField {
			var textField : TextField = new TextField();
			textField.defaultTextFormat = UIManager.getTextFormat();
			textField.text = "?";
			textField.height = textField.textHeight + 4;
			textField.text = "";
			textField.tabEnabled = true;
			textField.type = TextFieldType.INPUT;
			return textField;
		}

		public static function atParent(source : DisplayObject,target : DisplayObject) : Boolean {
			if(source == null || target == null)return false;
			if(source == target)return true;
			var parent : DisplayObjectContainer = source.parent;
			while(parent != null) {
				if(parent == target) {
					return true;
				}
				parent = parent.parent;
			}
			return false;
		}

		public static function hitTest(x : int,y : int) : DisplayObject {
			if(!_root)return null;
			var result : Array = _root.getObjectsUnderPoint(new Point(x, y));
			if(!result)return null;
			var index : int = result.indexOf(_dragModal);
			if(index != -1)result.splice(index, 1);
			return result.pop();
		}

		public static function set dragModal(value : Boolean) : void {
			if(value) {
				if(!_dragModal.parent) {
					_dragModal.width = _root.stage.stageWidth;
					_dragModal.height = _root.stage.stageHeight;
					_dragModal.mouseEnabled = _dragModal.mouseChildren = true;
					_root.addChild(_dragModal);
				}
			} else {
				if(_dragModal.parent) {
					_dragModal.parent.removeChild(_dragModal);
				}
			}
		}
	}
}