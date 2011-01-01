package com.key {

	/**
	 * @author Cafe
	 * @version 20100329
	 */
	public interface IKeyFliter {

		function convertKeyCode(keyCode : uint) : uint;

		function keyDownFliter(keyCode : uint) : Boolean;
	}
}
