package com.test {
	import flash.utils.setTimeout;

	import com.ui.controls.ValueLabel;
	import com.ui.data.ValueLabelData;

	import flash.display.Sprite;

	/**
	 * @author Cafe
	 */
	public class TestValue extends Sprite {
		public function TestValue() {
			var data : ValueLabelData = new ValueLabelData();
			data.valueLableData.text = "value";
			data.nameLableData.text = "name";
			var valueLabel : ValueLabel = new ValueLabel(data);
			addChild(valueLabel);
			setTimeout(function() : void {
				valueLabel.nameText = "myname";
				valueLabel.value = "myvalue";
			}, 3000);
		}
	}
}
