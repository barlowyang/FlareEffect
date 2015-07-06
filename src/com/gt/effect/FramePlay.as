package com.gt.effect
{
	import flare.ide.controls.Rule;

	public class FramePlay
	{
		private var _rule:Rule;
		public function FramePlay(rule:Rule)
		{
			_rule = rule;
		}
		
		private var _startFrame:uint;
		private var _min:int;
		private var _max:int;
		public function play(min:int, max:int):void
		{
			_min = min;
			_max = max;
			_startFrame = _rule.currentFrame;
			
			FrameUpdate.addFun(onFrame);
		}
		
		private function onFrame():void
		{
			if (_rule.currentFrame > _max)
			{
				_rule.currentFrame = _min;
			}
			else
			{
				_rule.currentFrame ++;
			}
			_rule.position = _rule.currentFrame - 10;
			FlareEffect.inst.updateFrame();
		}
		
		public function stop():void
		{
			FrameUpdate.removeFun(onFrame);
		}
	}
}