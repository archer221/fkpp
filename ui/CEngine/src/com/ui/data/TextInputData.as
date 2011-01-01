package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.UIComponentData;
	import com.ui.manager.UIManager;
	import flash.text.TextFormat;


	/**
	 * @version 20100115
	 * @author Cafe
	 */
	public class TextInputData extends UIComponentData {

		public var borderAsset : AssetData = new AssetData("GTextInput_borderSkin");

		public var disabledAsset : AssetData = new AssetData("GTextInput_disabledSkin");

		public var textFormat : TextFormat;

		public var textColor : uint = 0xEFEFEF;

		public var textFieldFilters : Array = UIManager.getEdgeFilters(0x000000, 0.7);

		public var disabledColor : uint = 0x898989;

		public var maxChars : int = 0;

		public var displayAsPassword : Boolean = false;

		public var restrict : String = "";

		public var allowIME : Boolean = true;

		public var text : String = "";

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : TextInputData = source as TextInputData;
			if(data == null)return;
			data.borderAsset = borderAsset;
			data.textFormat = textFormat;
			data.textColor = textColor;
			data.textFieldFilters = textFieldFilters.concat();
			data.maxChars = maxChars;
			data.displayAsPassword = displayAsPassword;
			data.restrict = restrict;
			data.allowIME = allowIME;
			data.text = text;
		}

		public function TextInputData() {
			width = 103;
			height = 22;
			textFormat = new TextFormat();
			textFormat.font = UIManager.defaultFont;
			textFormat.size = 12;
			textFormat.kerning = true;
		}

		override public function clone() : * {
			var data : TextInputData = new TextInputData();
			parse(data);
			return data;
		}
	}
}
