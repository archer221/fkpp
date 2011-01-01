package com.ui.manager {
	import com.ui.core.UIComponent;
	import flash.events.MouseEvent;
	import flash.geom.Point;


	/**
	 * Game ToolTip Manager
	 * 
	 * @author Cafe
	 * @version 20100708
	 */
	public class GToolTipManager {

		private static function toolTip_rollOverHandler(event : MouseEvent) : void {
			var target : UIComponent = UIComponent(event.target);
			if(target.toolTip != null && target.toolTip.text.length > 0) {
				var offset : Point = target.localToGlobal(new Point(target.width, target.height));
				if(target.toolTip.data.alginMode == 0) {
					if(offset.x + target.toolTip.width > UIManager.root.stage.width) {
						offset.x -= target.width + target.toolTip.width;
					}
					target.toolTip.moveTo(offset.x, offset.y);
				}else if(target.toolTip.data.alginMode == 1) {
					if(offset.x + target.toolTip.width > UIManager.root.stage.width) {
						offset.x -= target.width + target.toolTip.width;
					}
					offset.y -= target.height + target.toolTip.height;
					target.toolTip.moveTo(offset.x, offset.y);
				}
				UIManager.root.addChild(target.toolTip);
			}
		}

		private static function toolTip_rollOutHandler(event : MouseEvent) : void {
			var target : UIComponent = UIComponent(event.target);
			if(target.toolTip) {
				target.toolTip.hide();	
			}
		}

		public static function registerToolTip(target : UIComponent) : void {
			target.addEventListener(MouseEvent.ROLL_OVER, toolTip_rollOverHandler);
			target.addEventListener(MouseEvent.ROLL_OUT, toolTip_rollOutHandler);
		}
	}
}