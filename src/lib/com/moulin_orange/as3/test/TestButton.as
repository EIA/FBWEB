/*****************************************************************************************************
* TestButton
* Author: EIA
*
* date : 2012/05/15 (last update)
* verson : 1.00
* modify:
*       1.2012/05/15 create;
*       2.2012/05/23 update:_btnMsg;
* 
*****************************************************************************************************/

package com.moulin_orange.as3.test {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class TestButton extends Sprite {
		private var _buttonColor:Number;
		private var _buttonAlpha:Number;
		private var _buttonX:Number;
		private var _buttonY:Number;
		private var _buttonWidth:Number;
		private var _buttonHeight:Number;
		//
		private var _btnMsg:String = "";
		private var _msgTxt:TextField;
		//
		public var onClick:Function;
		//
		public function TestButton($x:Number = 300, $y:Number = 300, $buttonColor:uint = 0xff0000, $buttonAlpha:Number = .3,
		 $buttonX:Number = .3, $buttonY:Number = .3, $buttonWidth:Number = 50, $buttonHeight:Number = 20 ):void {
			trace("TestButton");
			//
			x				= $x;
			y				= $y;
			_buttonColor	= $buttonColor;
			_buttonAlpha	= $buttonAlpha;
			_buttonX		= $buttonX;
			_buttonY		= $buttonY;
			_buttonWidth	= $buttonWidth;
			_buttonHeight	= $buttonHeight;
			//
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, _onClick);
			//
			addChild(_msgTxt = new TextField());
			_msgTxt.mouseEnabled = false;
			_msgTxt.multiline = false;
			_msgTxt.height = 20;
			//
			_setBtn();
		}
		private function _onClick(evt:MouseEvent):void {
			if (onClick != null) {
				onClick();
			}else {
				trace("_onClick");
			}
		}
		private function _setBtn():void {
			graphics.beginFill(_buttonColor, _buttonAlpha);
			graphics.drawRect(_buttonX, _buttonY, _buttonWidth, _buttonHeight);
		}
		public function setBtn():void {
			_setBtn();
		}
		public function set msgTxt($msg:String):void {
			_btnMsg = $msg;
			_msgTxt.text = _btnMsg;
		}
		public function get msgTxt():String {
			return _btnMsg;
		}
		
		///////////////////////////////////// Getter /////////////////////////////////////
		public function get buttonColor():Number	{ return _buttonColor;	};
		public function get buttonAlpha():Number	{ return _buttonAlpha;	};
		public function get buttonX():Number		{ return _buttonX; };
		public function get buttonY():Number		{ return _buttonY;	};
		public function get buttonWidth():Number	{ return _buttonWidth;	};
		public function get buttonHeight():Number	{ return _buttonHeight; };
		///////////////////////////////////// Getter /////////////////////////////////////
	}
}