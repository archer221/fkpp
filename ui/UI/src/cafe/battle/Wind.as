package cafe.battle {
	import cafe.core.Command;
	import com.net.AssetData;
	import com.ui.controls.Icon;
	import com.ui.controls.Label;
	import com.ui.core.UIComponent;
	import com.ui.core.UIComponentData;
	import com.ui.data.IconData;
	import com.ui.data.LabelData;
	import flash.display.Sprite;



	/**
	 * @author Cafe
	 */
	public class Wind extends UIComponent {
		private var _windIcon : Icon;
		private var _wind : Label;

		public function Wind(parent : Sprite) {
			_base = new UIComponentData();
			_base.parent = parent;
			super(_base);
			addIcon();
			addLabel();
		}



		private function addLabel() : void {
			var data : LabelData = new LabelData();
			data.text = "风速";
			data.x = 28;
			data.y = 17;
			_wind = new Label(data);
			addChild(_wind);
		}

		private function addIcon() : void {
			var data : IconData = new IconData();
			data.asset = new AssetData("Wderetion", Command.Skin_FKPP);
			_windIcon = new Icon(data);
			addChild(_windIcon);
		}
	}
}
