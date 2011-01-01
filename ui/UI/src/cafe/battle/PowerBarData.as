package cafe.battle {
	import cafe.core.Command;
	import com.net.AssetData;
	import com.ui.core.UIComponentData;


	/**
	 * @author cafe
	 */
	public class PowerBarData extends UIComponentData {
		public var trackAsset : AssetData = new AssetData("MenuPercentZero",Command.Skin_FKPP);
		public var barAsset : AssetData = new AssetData("MenuPercentFull", Command.Skin_FKPP);
		public var lastAsset : AssetData = new AssetData("MenuPercentZero", Command.Skin_FKPP);
		public var tipAsset : AssetData = new AssetData("MenuPowerBarTip", Command.Skin_FKPP);

		public function PowerBarData() {
			width = 235;
			height = 45;
		}
	}
}
