package com.gt.effect.ui
{
	import com.bit101.components.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import flare.core.Pivot3D;
	
	public class EffectEventPropertyPanel extends EffectSubPropertyPanel
	{
		private var _eventMsgTxt:TextField;
		
		public function EffectEventPropertyPanel(parent:DisplayObjectContainer=null)
		{
			super(parent, 0, 0, "Event", 25);
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			var xPos:int = 0;
			var yPos:int = 0;
			
			//position
			new Label(this, xPos=5, yPos+=5, "Position X:");
			
			_eventMsgTxt = new TextField();
			_eventMsgTxt.x = xPos += 70;
			_eventMsgTxt.y = 5;
			_eventMsgTxt.type = TextFieldType.INPUT;
			_eventMsgTxt.border = true;
			_eventMsgTxt.height = _eventMsgTxt.textHeight + 5;
			this.addChild(_eventMsgTxt);
			
			height = 60;
		}
		
		override public function draw():void
		{
			super.draw();
			
		}
		
		override public function updateInfo():void
		{
			if (_tar_pivot)
			{
				super.updateInfo();
				
				_eventMsgTxt.text = "";
				
				invalidate();
			}
		}
		
		override public function set target(value:Pivot3D):void
		{
			if (_tar_pivot != value)
			{
				super.target = value;
				
				updateInfo();
			}
		}
	}
}