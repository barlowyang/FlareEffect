package com.gt.effect.ui
{
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	
	import flare.apps.events.ControlEvent;
	import flare.ide.controls.Rule;
	
	public class EffectTimeAxisPanel extends Panel
	{
		public static const HEIGHT:uint = 25;
		
		private var _rule:Rule;
		
		public function EffectTimeAxisPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			height = HEIGHT;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			var xPos:int = 0;
			var yPos:int = 0;
			
			_rule = new Rule();
			_rule.x = 100;
			_rule.height = 25;
			addChild(_rule.view);
			_rule.addEventListener(ControlEvent.CHANGE, onRuleChange);
		}
		
		private function onRuleChange(evt:ControlEvent):void
		{
			
		}
		
		override public function set width(w:Number):void
		{
			super.width = w;
			
			_rule.width = w - _rule.x;
			_rule.position = 0;
		}
	}
}