package com.ui.drag {

	/**
	 * @version 20091201
	 * @author Cafe
	 */
	public interface IDragTarget {
		
		function dragEnter(dragData : DragData) : Boolean;
		
		function canSwap(source:IDragItem,target:IDragItem):Boolean;
	}
}
