package com.gt.effect.ui
{
	import com.bit101.components.NumericStepper;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.gt.effect.Bit101Factor;
	import com.gt.effect.EffectPivotManager;
	import com.gt.effect.FramePlay;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.Dictionary;
	
	import flare.apps.events.ControlEvent;
	import flare.core.Frame3D;
	import flare.ide.controls.Rule;
	import flare.ide.controls.infos.RuleFrameInfo;
	
	public class EffectTimeAxisPanel extends Panel
	{
		public static const HEIGHT:uint = 25;
		
		private var _rule:Rule;
		
		public function EffectTimeAxisPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			height = HEIGHT;
		}
		
		
		private var _frame_num:NumericStepper;
		private var _play_con:Sprite;
		private var _min_frame:TextField;
		private var _max_frame:TextField;
		private var _play_btn:PushButton;
		
		private var _framePlay:FramePlay;
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			var xPos:int = 0;
			var yPos:int = 0;
			
			_frame_num = Bit101Factor.CreateNumericStepper(this, xPos = 5, yPos + 5, 20, 70, 1, 0, onUpdateFrame);
			
			_play_con = new Sprite();
			_min_frame = new TextField();
			_min_frame.border = true;
			_min_frame.text = "0";
			_min_frame.type = TextFieldType.INPUT;
			_min_frame.width = 30;
			_play_con.addChild(_min_frame);
			_play_btn = new PushButton(_play_con, 30, 0, "播放", function (evt:Event):void
			{
				playOrStop();
			});
			_play_btn.width = 40;
			_max_frame =  new TextField();
			_max_frame.border = true;
			_max_frame.x = 70;
			_max_frame.text = "100";
			_max_frame.type = TextFieldType.INPUT;
			_max_frame.width = 30;
			_play_con.addChild(_max_frame);
			_play_con.y = 5;
			addChild(_play_con);
			
			_rule = new Rule();
			_rule.x = 80;
			_rule.height = 25;
			_rule.position = 0;
			addChild(_rule.view);
			_rule.addEventListener(ControlEvent.CHANGE, onRuleChange);
			_rule.view.addEventListener(MouseEvent.CLICK, function (evt:MouseEvent):void
			{
				_framePlay.stop();
				_play_btn.label = "播放";
			});
			
//			_rule.addEventListener(ControlEvent.DRAW_EXIT, onDrawFlag);
			
			_framePlay = new FramePlay(_rule);
		}
		
		public static const FRAME_FLAG_COLOR:uint = 0x0;
		
		public function drawFrameFlag():void
		{
			_rule.drawFlag(frameInfos);
		}
		
		private function get frameInfos():Array
		{
			var res_arr:Array = new Array();
			var frameObj:Dictionary = EffectPivotManager.pivotFrameDict;
			var objFrame:Vector.<Frame3D> = frameObj[EffectPivotManager.selectObj];
			for each (var frame3D:Frame3D in objFrame)
			{
				res_arr.push(new RuleFrameInfo(frame3D.type, 1, 0xff0000));
			}
			return res_arr;
		}
		
		private function playOrStop():void
		{
			if (_play_btn.label == "播放")
			{
				_framePlay.play(int(_min_frame.text), int(_max_frame.text));
				_play_btn.label = "停止";
			}
			else
			{
				_framePlay.stop();
				_play_btn.label = "播放";
			}
		}
		
		private function onUpdateFrame(evt:Event):void
		{
			_rule.position = _frame_num.value;
			_rule.currentFrame = _frame_num.value;
		}
		
		private function onRuleChange(evt:Event):void
		{
			dispatchEvent(evt.clone());
		}
		
		override public function set width(w:Number):void
		{
			super.width = w;
			
			_rule.width = w - _rule.x - 100;
			_rule.draw();
//			_rule.position = 0;
			
			_play_con.x = _rule.x + _rule.width;
		}
		
		public function get curFrame():int
		{
			return _rule.currentFrame;
		}
	}
}