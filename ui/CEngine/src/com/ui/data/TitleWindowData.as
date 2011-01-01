package com.ui.data {

	import com.ui.core.UIComponentData;
	/**
	 * @author thinkpad
	 */
	public class TitleWindowData extends UIComponentData{

		public var titleBarData:TitleBarData=new TitleBarData();
		
		public var modal:Boolean=false;
		
		public var allowDrag:Boolean=false;
		
		public var allowScale:Boolean=false;
		
		public var panelData:PanelData=new PanelData();
		
		public function TitleWindowData():void{
			width=100;
			height=100;
		}
	}
}
