package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.UIComponentData;

	/**
	 * Game Time Stepper Data
	 * 
	 * @author Cafe
	 * @version 20100608
	 */
	public class TimeStepperData extends UIComponentData {

		public var bdAsset : AssetData;

		public var limit : int;

		public function TimeStepperData() {
			bdAsset = new AssetData("time_number");
			limit = 60;
		}
	}
}
