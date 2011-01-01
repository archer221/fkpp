package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.Align;
	import com.ui.core.ScaleMode;
	import com.ui.manager.UIManager;

	/**
	 * Game Alert Data
	 * 
	 * @author Cafe
	 * @version 20100715
	 */
	public class AlertData extends PanelData {

		public var labelData : LabelData;

		public var textInputData : TextInputData;

		public var buttonData : ButtonData;

		public var flag : uint = 0x4;

		public var okLabel : String = "<b>确定</b>";

		public var cancelLabel : String = "<b>取消</b>";

		public var yesLabel : String = "<b>是</b>";

		public var noLabel : String = "<b>否</b>";

		public var hgap : int = 10;

		public var vgap : int = 10;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : AlertData = source as AlertData;
			if(data == null)return;
			data.labelData = labelData.clone();
			data.textInputData = (textInputData ? textInputData.clone() : null);
			data.buttonData = buttonData.clone();
			data.flag = flag;
			data.okLabel = okLabel;
			data.cancelLabel = cancelLabel;
			data.yesLabel = yesLabel;
			data.noLabel = noLabel;
			data.hgap = hgap;
			data.vgap = vgap;
		}

		public function AlertData() {
			bgAsset = new AssetData("GPanel_backgroundSkin");
			modal = true;
			scaleMode = ScaleMode.AUTO_SIZE;
			align = Align.CENTER;
			padding = 10;
			minWidth = 150;
			minHeight = 60;
			labelData = new LabelData();
			labelData.textFieldFilters = UIManager.getEdgeFilters(0x000000, 0.7);
			buttonData = new ButtonData();
			buttonData.width = 60;
		}

		override public function clone() : * {
			var data : AlertData = new AlertData();
			parse(data);
			return data;
		}
	}
}
