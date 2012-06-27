/*＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
|creator : EIA
|date : 2011/10/25 (last update)
|verson : 1.04
|way : inNam: object id,inVal: object value,inWay: object ways
|modify:
|       1.2011/10/25 update: _alreadyGetFriends, invite
|       2.2011/11/01 update: my name
|       3.2012/02/01 update:
|
*/
package com.moulin_orange.as3.FB{
	import adobe.utils.ProductManager;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import com.moulin_orange.as3.FB.FbPermission;
	import com.facebook.graph.Facebook;
	//import com.facebook.graph.FacebookDesktop;
	import com.adobe.serialization.json.*;
	public class FBHandler extends EventDispatcher {
		private const MODE_WEB:String = "mode_web";
		private const MODE_AIR:String = "mode_air";
		public static const LOGIN_STATUS_CHANGE:String = 'login_status_change';
		public static const FB_INIT:String             = 'fb_init';
		public static const FB_GET_FRIENDS:String      = 'fb_get_friends';
		public static const FB_GET_ALBUM:String        = 'fb_get_album';
		public static const FB_CREAT_ALBUM:String      = 'fb_creat_album';
		public static const FB_CREAT_PHOTO:String      = 'fb_creat_photo';
		public static const FB_TAG:String              = 'fb_tag';
		public static const FB_INVITE:String           = 'fb_invite';
		public static const FB_GET_LIKES:String        = 'fb_get_likes';
		public static const FB_LIKE_HANDLER:String     = 'fb_like_handler';
		public static const FB_LOGIN:String            = 'fb_login';
		public static const FB_PUBLISH_SUCCESS:String  = 'fb_publish_success';
		public static const FB_PUBLISH_FAIL:String     = 'fb_publish_fail';
		//
		private var _appID:String = "";
		private var _userName:String = "";
		private var _isLogin:Boolean = false;
		private var _permissionArray:Array;
		private var _friendArray:Array;
		private var _albumArray:Array;
		private var _likesArray:Array;
		private var _uid:String;
		private var _accessToken:String;
		private var _alreadyGetFriends:Boolean = false;
		//
		private var _delayCallTimer:Timer;
		public var photoID:String;
		//
		private static var _instance:FBHandler;
		private var _appMode:String = MODE_WEB; // didn't use yet;
		//
		public var afterLogin:Function;
		//
		//////////////////////////////////////// instance ////////////////////////////////////////
		public function FBHandler($singletonEnforcer:SingletonEnforcer) {
			if ($singletonEnforcer == null) {
				throw new Error("singletonEnforcer");
			}else {
			}
		}
		public static function getInstance():FBHandler{
			if ( !_instance ) {
				trace("[FBHandler builded]");
					_instance = new FBHandler(new SingletonEnforcer());
			}
			return _instance;
		}
		//////////////////////////////////////// instance ////////////////////////////////////////
		//////////////////////////////////////// setFacebook ////////////////////////////////////////
		public function setFacebook():void {
			_appID           = FBConfig.getInstance().API_Key;
			_permissionArray = FBConfig.getInstance().PermissionArray;
			trace("_FBappID: " + _appID + "\n_FBpermission: " + _permissionArray);
			Trace2("FaceBookHandler:\n\t_FBappID: " + _appID + "\n\t_FBpermission: " + _permissionArray + "\n");
			_delayCallTimer = new Timer(100, 1);
			_delayCallTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _dlth);
			_delayCallTimer.start();
		}
		private function _dlth(evt:TimerEvent):void {
			Trace2("_dlth > _appID: " + _appID);
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.init(_appID, _initHandler);
			Facebook.init(_appID, _initHandler);
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		protected function _initHandler(result:Object, fail:Object):void {
			Trace2("initHandler: ");
			if (result){
				Trace2("result.uid = " + result.uid);
				//若曾經登入過，這邊就可以取得session，可以執行自動登入的動作
				Trace2("login");
				Trace2("result: " + result);
				Trace2("login: accessToken " + result.accessToken);
				Trace2("result: " + JSON.encode(result));
				_uid = result.uid;
				_getME();
				_accessToken = result.accessToken;
				_isLogin = true;
				_afterLogin();
			}else {
				Trace2("not login");
				Trace2("fail: " + JSON.encode(fail));
				_isLogin = false;
			}
			dispatchEvent(new Event(FB_INIT));
		}
		//////////////////////////////////////// setFacebook ////////////////////////////////////////
		private function _afterLogin():void {
			//_getFriends();
			//_getLikes();
			/*_getAlbumAPI();*/
			if (afterLogin != null) {
				afterLogin();
			}
		}
		/////////////////////////////////// login logout ///////////////////////////////////
		public function doLogIn():void {
			Trace2("CLICK Login");
			Trace2("_permission: " + _permissionArray);
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.login(_loginHandler, _permissionArray);
			Facebook.login(_loginHandler, { perms:_permissionArray.toString() });
			////////////////////////////////////////////
			////////////////////////////////////////////
			Trace2("login(_loginHandler, { perms: ["+_permissionArray+" ]} ");
		}
		public function doLogOut():void {
			Trace2("CLICK Logout");
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.logout(_logoutHnadlerAIR);
			Facebook.logout(_logoutHnadlerWeb);
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		protected function _loginHandler(result:Object, fail:Object):void {
			Trace2("_loginHandler: ");
			Trace2("result: " + JSON.encode(result));
			Trace2("fail: " + JSON.encode(fail));
			if (result){
				trace("result.uid = " + result.uid);
				//處理登入後的動作
				Trace2("click loggin , uid: " + result.uid);
				Trace2("click loggin: accessToken " + result.accessToken);
				Trace2("result: " + result);
				Trace2("result: " + JSON.encode(result));
				_isLogin = true;
				_uid = result.uid;
				_getME();
				_accessToken = result.accessToken;
				dispatchEvent(new Event(FB_LOGIN));
				_afterLogin();
			}else {
				Trace2("click and not loggin");
				Trace2("fail: " + JSON.encode(fail));
			}
			dispatchEvent(new Event(LOGIN_STATUS_CHANGE));
		}
		
		private function _logoutHnadlerWeb($isLogout:Boolean):void { // for Web
			Trace2("_logoutHnadler: " + $isLogout);
			_isLogin = false;
			_uid = "";
			_accessToken = "";
			dispatchEvent(new Event(LOGIN_STATUS_CHANGE));
		}
		private function _logoutHnadlerAIR(result:Object, fail:Object):void { // for air
			if (result){
				_isLogin = false;
				_uid = "";
				_accessToken = "";
				dispatchEvent(new Event(LOGIN_STATUS_CHANGE));
			}
		}
		/////////////////////////////////// login logout ///////////////////////////////////
		/////////////////////////////////// getME ///////////////////////////////////
		private function _getME():void {
			var _meURLLoader:URLLoader   = new URLLoader();
			var _meURLRequest:URLRequest = new URLRequest("http://graph.facebook.com/"+_uid);
			_meURLLoader.load(_meURLRequest);
			_meURLLoader.addEventListener(Event.COMPLETE, _meHandler);
		}
		private function _meHandler(evt:Event):void {
			Trace2("_meHandler: " + evt.target.data + "\n");
			_userName = JSON.decode(evt.target.data).name;
			//Trace2("_userName: " + _userName + "\n");
		}
		/////////////////////////////////// getME ///////////////////////////////////
		/////////////////////////////////// getFriends ///////////////////////////////////
		public function getFriends($reload:Boolean = false ):void {
			// ------------------------- modify 2011/10/25 -------------------------
			if ($reload == true) {
				_alreadyGetFriends = false; // reload
				_getFriends();
				return;
			}
			///////////////////////////////
			if (_alreadyGetFriends == false ){
				_getFriends();
			}else {
				dispatchEvent(new Event(FB_GET_FRIENDS));
			}
			// ------------------------- modify 2011/10/25 -------------------------
		}
		private function _getFriends():void {
			var callAPI:String = FbCall.ME_FRIENDS;
			//var params:Object = null;
			//var params:Object = {fields:"picture,name"};
			var params:Object = {fields:"picture,name,gender"}; //120626
			//var params:Object = {fields:"picture,name",limit:"23",offset: "0"};
			//var params:Object = {fields:"picture,name",limit:"23",offset: "170"};
			//var params:Object = { fields:"picture,name", limit:"23", offset: String(Math.random() * 170 | 0) };
			Trace2("_getFriends: ");
			Trace2("- Method: " + callAPI);
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.api(callAPI, _callBackHandler, params, "GET");
			Facebook.api(callAPI, _callBackHandler, params, "GET");
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		private function _callBackHandler(response:Object, fail:Object):void {
			_friendArray = new Array();
			Trace2("- CallBackHandler:");
			trace("///////////////////");
			trace("response: "+JSON.encode(response));
			trace("///////////////////");
			if (response) {
				Trace2("- response is Array: " + (response is Array));
				if (response is Array) {
					_friendArray = response as Array;
					var _friendArrayLength:uint = _friendArray.length;
					trace("_friendArrayLength: " + _friendArrayLength);
					for (var i:uint = 0; i < _friendArrayLength;i++ ){
						//Trace2("  response as JSON[" + i + "]: " + JSON.encode(_friendArray[i]) + "\n");
						//Trace2("         _friendArray[i].id = " + _friendArray[i].id+ " response.name: "+response.name+"\n");
						//trace("_friendArray[i].id = " + _friendArray[i].id);
					}
					dispatchEvent(new Event(FB_GET_FRIENDS));
				}else {
					Trace2("  response as JSON: " + JSON.encode(response));
					if(response.name){
						Trace2("  [response me name]: " + response.name);
					}else {
						Trace2("  [response me name]: " + "no name");
					}
				}
			} else {
				Trace2("  CallBackFail: \n");
				Trace2("  response as JSON: " + JSON.encode(fail));
			}
		}
		/////////////////////////////////// getFriends ///////////////////////////////////
		/////////////////////////////////// sendPhoto ///////////////////////////////////
		public function sendPhoto($img:*, $albumID:String = ""):void {
			_sendPhoto($img, $albumID);
		}
		private function _sendPhoto($img:*, $albumID:String = ""):void {
			var values:Object = {
								  message:'Photo From Flash',
								  fileName:'FILE_NAME',
								  image:$img
								};
			Trace2("FBHandler._sendPhoto > $img : " + $img + ", $albumID : " + $albumID);
			if ($albumID != "") {
				////////////////////////////////////////////
				////////////////////////////////////////////
				//FacebookDesktop.api('/'+$albumID + '/photos', _handleUploadComplete, values, 'POST');
				Facebook.api('/'+$albumID + '/photos', _handleUploadComplete, values, 'POST');
				////////////////////////////////////////////
				////////////////////////////////////////////
				Trace2('/' + $albumID + '/photos');
			}else {
				////////////////////////////////////////////
				////////////////////////////////////////////
				//FacebookDesktop.api('/me/photos', _handleUploadComplete, values, 'POST');
				Facebook.api('/me/photos', _handleUploadComplete, values, 'POST');
				////////////////////////////////////////////
				////////////////////////////////////////////
				Trace2('/me/photos');
			}
		}
		private function _handleUploadComplete(response:Object, fail:Object):void {
			if (response) {
				Trace2(" _handleUploadComplete response as JSON: " + JSON.encode(response));
				Trace2(" _handleUploadComplete response.id: " + response.id);
				photoID = response.id;
				dispatchEvent(new Event(FB_CREAT_PHOTO));
			}else {
				Trace2(" _handleUploadComplete fail: " + fail);
			}
		}
		/////////////////////////////////// sendPhoto ///////////////////////////////////
		/////////////////////////////////// tagPhoto ///////////////////////////////////
		public function tagPhoto($tagID:String):void {
			Trace2("FBHandler._tagPhoto > tagPhoto");
			_tagPhoto($tagID);
		}
		private function _tagPhoto($tagID:String = ""):void {
			Trace2("FBHandler._tagPhoto > $tagID : " + $tagID);
			var values:Object = { to:$tagID };
			Facebook.api(photoID + '/tags', _handleTagPhoto, values, 'POST');
			photoID = "";
		}
		private function _handleTagPhoto(response:Object, fail:Object):void {
			if (response) {
				Trace2(" _handleTagPhoto response as JSON: " + JSON.encode(response));
				dispatchEvent(new Event(FB_TAG));
			}else {
				Trace2(" _handleTagPhoto fail as JSON: " + JSON.encode(fail));
			}
		}
		/////////////////////////////////// tagPhoto ///////////////////////////////////
		/////////////////////////////////// getAlbumFQL ///////////////////////////////////
		public function getAlbumFQL():void {
			_getAlbumFQL();
		}
		private function _getAlbumFQL():void {
			Trace2(" _getAlbumHandle:");
			var fql:String = "select name, created from album where owner = me()";
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.fqlQuery(fql, _getAlbumFQLHandle);
			Facebook.fqlQuery(fql, _getAlbumFQLHandle);
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		private function _getAlbumFQLHandle(response:Object, fail:Object):void {
			if (response) {
				Trace2(" _getAlbumHandle response");
				dispatchEvent(new Event(FB_GET_ALBUM));
				if (response is Array) {
					_albumArray = response as Array;
					var _albumArrayLength:uint = _albumArray.length;
					trace("_albumArrayLength: " + _albumArrayLength);
					for (var i:uint = 0; i < _albumArrayLength; i++ ) {
						trace(JSON.encode(_albumArray[i]));
						Trace2(" _getAlbumHandle response as JSON: " + JSON.encode(_albumArray[i]) + "\n");
					}
				}
			}else {
				Trace2(" _getAlbumHandle fail as JSON: " + JSON.encode(fail));
			}
		}
		/////////////////////////////////// getAlbumFQL ///////////////////////////////////
		/////////////////////////////////// getAlbum ///////////////////////////////////
		public function getAlbumAPI():void {
			_getAlbumAPI();
		}
		private function _getAlbumAPI():void {
			var callAPI:String = FbCall.ME_ALBUMS;
			var params:Object = null;
			Trace2("_getAlbumAPI: ");
			Trace2("- Method: " + callAPI);
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.api(callAPI, _getAlbumApiHandle, params, "GET");
			Facebook.api(callAPI, _getAlbumApiHandle, params, "GET");
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		private function _getAlbumApiHandle(response:Object, fail:Object):void {
			if (response) {
				Trace2(" _getAlbumApiHandle response");
				dispatchEvent(new Event(FB_GET_ALBUM));
				if (response is Array) {
					_albumArray = response as Array;
					var _albumArrayLength:uint = _albumArray.length;
					trace("_albumArrayLength: " + _albumArrayLength);
					for (var i:uint = 0; i < _albumArrayLength; i++ ) {
						trace(JSON.encode(_albumArray[i]));
						Trace2(" _getAlbumApiHandle response: ");
						Trace2(JSON.encode(_albumArray[i]));
					}
				}
			}else {
				Trace2(" _getAlbumApiHandle fail as JSON: " + JSON.encode(fail));
			}
		}
		/////////////////////////////////// getAlbum ///////////////////////////////////
		
		
		
		/////////////////////////////////// Likes ///////////////////////////////////
		public function getLikes():void {
			_getLikes();
		}
		private function _getLikes():void {
			var callAPI:String = FbCall.ME_LIKES;
			var params:Object = null;
			Trace2("_getLikes: ");
			Trace2("- Method: " + callAPI);
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.api(callAPI, _getLikesHandle, params, "GET");
			Facebook.api(callAPI, _getLikesHandle, params, "GET");
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		private function _getLikesHandle(response:Object, fail:Object):void {
			if (response) {
				Trace2(" _getLikesHandle response");
				if (response is Array) {
					_likesArray = response as Array;
					var _likesArrayLength:uint = _likesArray.length;
					trace("_likesArrayLength: " + _likesArrayLength);
					for (var i:uint = 0; i < _likesArrayLength; i++ ) {
						trace(JSON.encode(_likesArray[i]));
						//Trace2(" _getLikesHandle response: " + "\n");
						Trace2(JSON.encode(_likesArray[i]));
					}
				}
				dispatchEvent(new Event(FB_GET_LIKES));
			}else {
				Trace2(" _getLikesHandle fail as JSON: " + JSON.encode(fail));
			}
		}
		public function findLike($likeID:String):Boolean {
			return _findLike($likeID);
		}
		private function _findLike($likeID:String):Boolean {
			Trace2("_findLike:");
			var _likesArrayLength:uint = _likesArray.length;
			for (var i:uint = 0; i < _likesArrayLength; i++ ) {
				Trace2("  _likesArray[" + i + "].id" + _likesArray[i].id);
				if (_likesArray[i].id == $likeID) {
					Trace2("_findLike: " + " finded");
					dispatchEvent(new Event(FB_LIKE_HANDLER));
					return true;
				}
			}
			dispatchEvent(new Event(FB_LIKE_HANDLER));
			Trace2("_findLike: "+" didn't found");
			return false;
		}
		public function doLikes($likeID:String):void {
			_doLikes($likeID);
		}
		public function _doLikes($likeID:String):void {
			//var callAPI:String = FbCall.ME_LIKES;
			var params:Object = {
								 id:$likeID
								 //client_id:FBConfig.getInstance().API_Key,
								 //redirectURL:"http://205521576149308.iframehost.com/80394",
								 //redirect_uri:"http://www.facebook.com/annasuinailfansclub",
								 //type : "user_agent",
								 //scope : FBConfig.getInstance().PermissionArray.toString(),
								 //display:"popup"
								};
								
								//"https://graph.facebook.com/oauth/authorize?client_id=
								//_appID&redirect_uri=redirectURL&type=user_agent&scope=appScope&display=popup"
								
								
			Trace2("_doLikes: ");
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.api("/oauth/authorize", _doLikesHandle, params, 'POST');
			//Facebook.api("/oauth/authorize", _doLikesHandle, params, 'POST');
			Facebook.api(FbCall.ME_LIKES, _doLikesHandle, params, 'POST');
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		private function _doLikesHandle(response:Object, fail:Object):void {
			if (response) {
				Trace2(" _doLikesHandle response as JSON: " + JSON.encode(response));
				dispatchEvent(new Event(FB_LIKE_HANDLER));
			}else {
				Trace2(" _doLikesHandle fail as JSON: " + JSON.encode(fail));
			}
		}
		/////////////////////////////////// Likes ///////////////////////////////////
		
		/////////////////////////////////// findAlbum ///////////////////////////////////
		public function findAlbum($albumName:String):String {
			return _findAlbum($albumName);
		}
		private function _findAlbum($albumName:String):String {
			Trace2("  _findAlbum: " + $albumName);
			var _albumArrayLength:uint = _albumArray.length;
			for (var i:uint = 0; i < _albumArrayLength; i++ ) {
				Trace2("  _albumArray[" + i + "].name" + _albumArray[i].name);
				if (_albumArray[i].name == $albumName) {
					return _albumArray[i].id;
				}
			}
			return "";
		}
		/////////////////////////////////// findAlbum ///////////////////////////////////
		/////////////////////////////////// creatAlbum ///////////////////////////////////
		public function creatAlbum($albumName:String):void {
			_creatAlbum($albumName);
		}
		private function _creatAlbum($albumName:String):void {
			//var values:Object = { name:'TEST_0727',message:'photo caption' };
			Trace2("  _creatAlbum: " + $albumName);
			var values:Object = { name:$albumName, message:'photo caption' };
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.api('/me/albums', _creatAlbumHandle, values, 'POST');
			Facebook.api('/me/albums', _creatAlbumHandle, values, 'POST');
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		private function _creatAlbumHandle(response:Object, fail:Object):void {
			if (response) {
				Trace2(" _creatAlbumHandle response as JSON: " + JSON.encode(response));
				dispatchEvent(new Event(FB_CREAT_ALBUM));
				_getAlbumAPI();
			}else {
				Trace2(" _creatAlbumHandle fail as JSON: " + JSON.encode(fail));
			}
		}
		/////////////////////////////////// creatAlbum ///////////////////////////////////
		/////////////////////////////////// invite ///////////////////////////////////
		// -----------------  modify 111025 ----------------- 
		public function invite($uidArray:Array, $msg:String = ""):void {
			_invite($uidArray, $msg);
		}
		private function _invite($uidArray:Array, $msg:String = ""):void {
			Trace2("_invite: " + $uidArray);
			var data:Object = new Object();
			if ($msg == "") {
				data.message = " ";
			}else {
				data.message = $msg;
			}
			//data.title   = "FlashTitle";
			// filtering for non app users only
			//dat.filters = ['app_non_users'];
			//You can use these two options for diasplaying friends invitation window 'iframe' 'popup'
			data.to = $uidArray;
			////////////////////////////////////////////
			////////////////////////////////////////////
			// no FacebookDesktop //
			//Facebook.ui('apprequests', data, _inviteHandler, 'popup');
			//Facebook.ui('apprequests', data, _inviteHandler, 'iframe'); // choose iframe
			Facebook.ui('apprequests', data, _inviteHandler); // choose iframe
			////////////////////////////////////////////
			////////////////////////////////////////////
			/*method: 'apprequests', 
			message: '自訂訊息', 
			data: '自訂資料',
			title: '自訂標題',
			to: uid*/
		}
		private function _inviteHandler(result:Object):void {
			if (result) {
				Trace2(" _inviteHandler response as JSON: " + JSON.encode(result));
				dispatchEvent(new Event(FB_INVITE));
			}else {
				Trace2(" _inviteHandler response : " + "none");
			}
		}
		/////////////////////////////////// invite ///////////////////////////////////
		
		/////////////////////////////////// publish ///////////////////////////////////
		public function publish($publisData:Object):void {
			_publish($publisData);
		}
		private function _publish($publisData:Object):void {
			var values:Object = $publisData;
			////////////////////////////////////////////
			////////////////////////////////////////////
			//FacebookDesktop.api(FbCall.ME_FEED, _feedHandle, values, 'POST');
			Facebook.api(FbCall.ME_FEED, _feedHandle, values, 'POST');
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		private function _feedHandle(response:Object, fail:Object):void {
			if (response) {
				Trace2(" _feedHandle response as JSON: " + JSON.encode(response));
			}else {
				Trace2(" _feedHandle fail as JSON: " + JSON.encode(fail));
			}
		}
		/////////////////////////////////// publish ///////////////////////////////////
		
		
		/////////////////////////////////// publish_ui ///////////////////////////////////
		public function publishUI($publisData:Object):void {
			_publishUI($publisData);
		}
		private function _publishUI($publisData:Object):void {
			var values:Object = $publisData;
			////////////////////////////////////////////
			////////////////////////////////////////////
			//Facebook.ui('apprequests', $publisData, _publishUIHandle, 'popup');
			Facebook.ui('feed', $publisData, _publishUIHandle, 'popup');
			//Facebook.ui('feed', $publisData, _publishUIHandle, 'iframe');
			////////////////////////////////////////////
			////////////////////////////////////////////
		}
		private function _publishUIHandle(response:Object):void {
			Trace2(" _publishUIHandle response as JSON: " + JSON.encode(response));
			if (response) {
				dispatchEvent(new Event(FB_PUBLISH_SUCCESS));
			}else {
				dispatchEvent(new Event(FB_PUBLISH_FAIL));
			}
		}
		/////////////////////////////////// publish_ui ///////////////////////////////////
		public function get uid():String{return _uid};
		public function get userName():String{return _userName};
		public function get accessToken():String { return _accessToken };
		public function get friendArray():Array { return _friendArray };
		public function get albumArray():Array { return _albumArray };
		public function get isLogin():Boolean { return _isLogin; };
		public function get alreadyGetFriends():Boolean { return _alreadyGetFriends; }
	}
}
class SingletonEnforcer {}