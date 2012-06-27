package com.moulin_orange.as3.test {
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author eia
	 * @version 2011/09/07
	 */
	public class EiaDebug extends Sprite {
		//
		public static const HIGHLIGHTMODE_YELLOW_BOLD:String = "highlightmode_yellow_bold";
		//
		private static var _instance:EiaDebug;
		private var _debugTxt:TextField;
		private var _dTextFormat:TextFormat;
		private var _yellowBoldFormat:TextFormat;
		private var _bdSprite:Sprite;
		private var _tSpeed:Number = .5;
		private var _sSpeed:Number = .9;
		public function EiaDebug($singletonEnforcer:SingletonEnforcer) {
			if ($singletonEnforcer == null) {
				throw new Error("singletonEnforcer");
			}else {
				_EiaDebugInit();
			}
		}
		public static function getInstance():EiaDebug{
			if ( !_instance ) {
				trace("[EiaDebugPanel builded]");
					_instance = new EiaDebug(new SingletonEnforcer());
			}
			return _instance;
		}
		private function _EiaDebugInit():void {
			_bdSprite = new Sprite();
			addChild(_bdSprite);
			///////////////////////// debug ///////////////////
			_debugTxt = new TextField();
			_debugTxt.width = 600;
			_debugTxt.wordWrap = false; //0802
			_debugTxt.multiline = true;
			_debugTxt.autoSize = TextFieldAutoSize.LEFT;
			addChild(_debugTxt);
			//
			_dTextFormat = new TextFormat();
			_dTextFormat.color = 0xffffff;
			_dTextFormat.font = "Arial";
			_dTextFormat.bold = false;
			_debugTxt.text = "";
			_debugTxt.type = TextFieldType.INPUT;
			_debugTxt.addEventListener(Event.CHANGE, _dbch);
			//
			_yellowBoldFormat = new TextFormat();
			_yellowBoldFormat.bold = true;
			_yellowBoldFormat.color = 0xffff00;
			_yellowBoldFormat.font = "Arial";
			///////////////////////// debug ///////////////////
			x = 0;
			y = 0;
			//visible = Config.getInstance().showLog;
			//visible = false;
			//
			_debugTxt.setTextFormat(_dTextFormat);
			_bdSprite.graphics.beginFill(0x000000, .5);
			_bdSprite.graphics.drawRect(0, 0, 100, 10);
			//
			addEventListener(Event.ADDED_TO_STAGE, _adh);
			//
			_setDebugMsg("press [ESC] to disable/enable DebugPanel" +"\n", HIGHLIGHTMODE_YELLOW_BOLD);
		}
		private function _adh(evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, _adh);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _kbh);
		}
		private function _kbh(evt:KeyboardEvent):void {
			trace("KeyboardEvent: " + evt.charCode);
			if (evt.charCode == 27) { //key "esc"
				visible = !visible;
			}
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function setDebugMsg($debugMsg:String, $highlightmode:String = ""):void {
			_setDebugMsg($debugMsg, $highlightmode);
		}
		private function _setDebugMsg($debugMsg:String, $highlightmode:String = ""):void {
			//var tl:uint;
			var tl:uint = _debugTxt.length;
			if (_debugTxt.text == "") {
				//tl = 0;
				_debugTxt.text = $debugMsg;
			}else {
				//tl = _debugTxt.length;
				_debugTxt.appendText( $debugMsg);
			}
			var al:uint = $debugMsg.length;
			trace("tl:" + tl + " al: " + al);
			switch ($highlightmode){
				case HIGHLIGHTMODE_YELLOW_BOLD:
					_debugTxt.setTextFormat(_yellowBoldFormat, tl, tl + al);
					break;
				default:
					_debugTxt.setTextFormat(_dTextFormat, tl, tl + al);
			}
			/*_bdSprite.graphics.clear();
			_bdSprite.graphics.beginFill(0x000000, .5);
			_bdSprite.graphics.drawRect(0, 0, _debugTxt.textWidth+10, _debugTxt.textHeight+10);
			_bdSprite.graphics.endFill();*/
			//TweenMax.to(_bdSprite, _tSpeed, { width:_debugTxt.textWidth+10,height:_debugTxt.textHeight+10,ease:Strong.easeOut} );
			TweenMax.to(_bdSprite, _tSpeed, { width:_debugTxt.width+10,height:_debugTxt.height+10,ease:Strong.easeOut} );
		}
		public function clearDebugMsg():void {
			_debugTxt.text = "";
		}
		private function _dbch(evt:Event):void {
			TweenMax.to(_bdSprite, _tSpeed, { width:_debugTxt.width+10,height:_debugTxt.height+10,ease:Strong.easeOut} );
		}
		public function focusThis():void {
			TweenMax.to(this, _sSpeed, { x: 0, blurFilter: { blurX:0, blurY:0 }, alpha: 1, ease:Strong.easeOut } );
		}
		public function killFocus():void {
			TweenMax.to(this, _sSpeed, { x:10, blurFilter: { blurX:2, blurY:2 }, alpha:.7, ease:Strong.easeOut } );
		}
	}
}
class SingletonEnforcer {}