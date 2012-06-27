package com.moulin_orange.as3.FB{
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.moulin_orange.as3.display.GoToMovieClip;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	/**
	 * ...
	 * @author eia
	 */
	[Embed(source='../../shell.swf', symbol='swc_photoObj')]
	public class FbPhotoObj extends GoToMovieClip {
		public static const FBPHOTO_OBJ_SELECT:String   = "fbphoto_obj_select";
		public static const FBPHOTO_OBJ_DESELECT:String = "fbphoto_obj_deselect";
		private var _isChoose:Boolean;
		private var _id:Number;
		private var _fbid:String;
		private var _name:String;
		private var _picURL:String;
		public var name_txt:TextField;
		public var photoContainer:MovieClip;
		private var _picLoader:Loader;
		public function FbPhotoObj():void {
			_isChoose = false;
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, _mch);
			//
			_picLoader = new Loader();
			_picLoader.alpha = 0;
			//
			alpha = 0;
			TweenLite.to(this, 1, { delay:_id * .05, alpha:1, ease:Strong.easeOut } );
		}
		private function _mch(evt:MouseEvent):void {
			_isChoose = !_isChoose;
			_chooseHandler();
		}
		public function setObj($id:Number, $fbid:String, $name:String, $picURL:String):void {
			_id = $id;
			_fbid = $fbid;
			_name = $name;
			name_txt.text = _name;
			_picURL = $picURL;
			TweenLite.to(_picLoader, 1, { delay:.5 + _id * .05, alpha:1, ease:Strong.easeOut , onComplete:_inComplete } );
		}
		private function _inComplete():void {
			var _loaderContext:LoaderContext = new LoaderContext();
			_loaderContext.checkPolicyFile = true;
			_picLoader.load(new URLRequest(_picURL), _loaderContext);
			//
			photoContainer.addChild(_picLoader)
			_picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _lch);
			_picLoader.scaleX = 1.26;
			_picLoader.scaleY = 1.26;
		}
		private function _lch(evt:Event):void {
			var loadedBitmap:Bitmap = _picLoader.content as Bitmap;
			loadedBitmap.smoothing = true;
		}
		private function _chooseHandler():void {
			if (_isChoose == true) {
				dispatchEvent(new Event(FBPHOTO_OBJ_SELECT));
			}else {
				dispatchEvent(new Event(FBPHOTO_OBJ_DESELECT));
			}
			goto(_isChoose? -1:1 );
		}
		public function deselect():void {
			_isChoose = false;
			_chooseHandler();
		}
		// ----------------- Getter Setter -----------------
		public function get isChoose():Boolean { return _isChoose; }
		public function get fbid():String { return _fbid; }
	}
}