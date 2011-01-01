package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.UIComponentData;
	import com.ui.manager.UIManager;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;


	/**
	 * @version 20100325
	 * @author Cafe
	 */
	public class TextAreaData extends UIComponentData {

		public var backgroundAsset : AssetData = new AssetData("GTextArea_backgroundSkin");

		public var textFormat : TextFormat;

		public var styleSheet : StyleSheet;

		public var textColor : uint = 0xFFFFFF;

		public var textFieldFilters : Array = UIManager.getEdgeFilters(0x000000, 0.7);

		public var padding : int = 2;

		public var editable : Boolean = true;

		public var selectable : Boolean = true;

		public var maxLines : int = 0;

		public var edlim : String;

		public var maxChars : int = 0;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : TextAreaData = source as TextAreaData;
			if(data == null)return;
			data.backgroundAsset = backgroundAsset;
			data.textFormat = textFormat;
			data.styleSheet = styleSheet;
			data.textColor = textColor;
			data.textFieldFilters = textFieldFilters.concat();
			data.padding = padding;
			data.editable = editable;
			data.selectable = selectable;
			data.maxLines = maxLines;
			data.edlim = edlim;
		}

		public function TextAreaData() {
			textFormat = new TextFormat();
			textFormat.font = UIManager.defaultFont;
			textFormat.size = 12;
			textFormat.leading = 2;
			textFormat.kerning = true;
			styleSheet = UIManager.defaultCSS;
			width = 104;
			height = 104;
		}

		override public function clone() : * {
			var data : TextAreaData = new TextAreaData();
			parse(data);
			return data;
		}
	}
}
