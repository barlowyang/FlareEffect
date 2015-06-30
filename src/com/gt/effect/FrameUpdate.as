package com.gt.effect
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class FrameUpdate
	{
		private static var _obj:DisplayObject;
		
		{
			_obj = new Sprite();
			_obj.addEventListener(Event.ENTER_FRAME, onFrame);
			
			_dict = new Vector.<Function>();
		}
		private static var _dict:Vector.<Function>;
		
		
		public static function addFun(func:Function):void
		{
			_dict.push(func);
		}
		
		public static function removeFun(func:Function):void
		{
			var idx:int = _dict.indexOf(func);
			if (idx != -1)
			{
				_dict.splice(idx, 1);
			}
		}
		
		private static function onFrame(evt:Event):void
		{
			for each (var func:Function in _dict)
			{
				func.apply();
			}
		}
	}
}