package com.gt.effect.ui
{
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	import com.bit101.components.VBox;
	import com.bit101.components.VScrollBar;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flare.core.Pivot3D;
	
	public class EffectPropertyPanel extends Panel
	{
		public static const WIDTH:uint = 350;
		
		private var _subPropertys:Vector.<EffectSubPropertyPanel>;
		
		private var FScrollbar:VScrollBar;
		private var FContainer:Panel;
		private var FContent:VBox;
		
		public function EffectPropertyPanel(parent:DisplayObjectContainer)
		{
			super(parent);
			
			width = WIDTH;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			FScrollbar = new VScrollBar(this);
			FScrollbar.addEventListener(Event.CHANGE, DragScroll);
			FScrollbar.lineSize = 50;
			FContainer = new Panel(this);
			
			FContent = new VBox(FContainer.content);
			FContent.spacing = 3;
			FContent.addEventListener(MouseEvent.MOUSE_WHEEL, MouseWheelHandle);
			FContainer.y = 5;
			FScrollbar.y = 5;
			
			_subPropertys = new Vector.<EffectSubPropertyPanel>();
			
			InitPanel(EffectPivotPropertyPanel);
			InitPanel(EffectEventPropertyPanel);
		}
		
		private function InitPanel(panelClass:Class, fold:Boolean = false):*
		{
			var panel:Component = new panelClass(FContent);
			if(fold)
			{
				panel["SwitchFoldState"].apply();
			}
			panel.addEventListener(Event.RESIZE, UpdatePos);
			_subPropertys.push(panel);
			return panel;
		}
		
		private function MouseWheelHandle(e:MouseEvent):void
		{
			FContent.y += e.delta * 10;
			UpdateScroll();
		}
		
		private function UpdateScroll():void
		{
			var maxValue:int = Math.max(FContent.height - FContainer.height, 0)
			var percent:Number =  Math.min(1, FContainer.height/FContent.height);
			
			if(FContent.y > 0)
			{
				FContent.y = 0;
			}
			if(FContent.y < -maxValue)
			{
				FContent.y = -maxValue;
			}
			
			var currValue:int = -FContent.y;
			if(isNaN(percent))
			{
				percent = 0;
			}
			
			FScrollbar.setSliderParams(0, maxValue, currValue);
			FScrollbar.setThumbPercent(percent);
			FScrollbar.pageSize = 225;
		}
		
		private function DragScroll(e:Event):void
		{
			FContent.y = -FScrollbar.value;
		}
		
		private function UpdatePos(e:Event = null):void
		{
			FContent.draw();
			
			UpdateScroll();
			
			invalidate();
		}   
		
		override public function draw():void
		{
			super.draw();
			
			FContainer.height = FScrollbar.height = _height - 10;
			FContainer.width = _width - 10 - FScrollbar.width;
			
			FContainer.x = 5;
			FScrollbar.x = FContainer.width + 5;
			
			var yPos:Number = 0;
			var pw:int = FContainer.width;
			var len:int = _subPropertys.length;
			for(var i:int = 0; i < len; i++)
			{
				_subPropertys[i].width = pw;
			}
			
			UpdateScroll();
		}
		
		public function updateInfo():void
		{
			for each (var pivot:EffectSubPropertyPanel in _subPropertys)
			{
				pivot.updateInfo();
			}
		}
		
		public function set target(val:Pivot3D):void
		{
			for each (var pivot:EffectSubPropertyPanel in _subPropertys)
			{
				pivot.target = val;
			}
		}
	}
}