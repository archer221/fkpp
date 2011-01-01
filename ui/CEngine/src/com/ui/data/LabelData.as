package com.ui.data {
	import com.ui.core.UIComponentData;
	import com.ui.manager.UIManager;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;


	/**
	 * Game Label Data
	 * 
	 * @author Cafe
	 * @version 20100719
	 */
	public class LabelData extends UIComponentData {

		public var iconData : IconData = new IconData();

		public var iconY : int = 0;

		public var textColor : uint;

		public var textFieldFilters : Array;

		public var textFieldAlpha : Number;

		public var textFormat : TextFormat;

		public var styleSheet : StyleSheet;

		public var hGap : int;

		public var text : String;

		public var maxLength : int;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : LabelData = source as LabelData;
			if(data == null)return;
			data.iconData = iconData.clone();
			data.iconY = iconY;
			data.textColor = textColor;
			data.textFieldFilters = (textFieldFilters ? textFieldFilters.concat() : null);
			data.textFormat = textFormat;
			data.styleSheet = styleSheet;
			data.hGap = hGap;
			data.text = text;
		}

		public function LabelData() {
			textColor = 0xEFEFEF;
			textFieldFilters = UIManager.getEdgeFilters(0x000000, 0.7);
			textFieldAlpha = 1;
			textFormat = new TextFormat();
			textFormat.font = UIManager.defaultFont;
			textFormat.size = 12;
			textFormat.leading = 3;
			textFormat.kerning = true;
			styleSheet = UIManager.defaultCSS;
			hGap = 1;
			text = "";
			maxLength = 0;
		}

		override public function clone() : * {
			var data : LabelData = new LabelData();
			parse(data);
			return data;
		}
	}
}
