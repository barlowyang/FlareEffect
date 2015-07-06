package com.gt.effect.ui
{
	import com.bit101.components.TFoldPanelBase;
	
	import flash.display.DisplayObjectContainer;
	
	import flare.core.Pivot3D;
	
	public class EffectSubPropertyPanel extends TFoldPanelBase
	{
		protected var _tar_pivot:Pivot3D;
		
		public function EffectSubPropertyPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, title:String="Window", titleHeight:int=30, content:DisplayObjectContainer=null)
		{
			super(parent, xpos, ypos, title, titleHeight, content);
			
			this.mouseChildren = this.mouseEnabled = false;
			this.alpha = 0.5;
		}
		
		public function set target(val:Pivot3D):void
		{
			_tar_pivot = val;
			
			if (_tar_pivot)
			{
				this.mouseChildren = this.mouseEnabled = true;
				this.alpha = 1;
			}
			else
			{
				this.mouseChildren = this.mouseEnabled = false;
				this.alpha = 0.5;
			}
		}
		
		public function updateInfo():void
		{
			
		}
	}
}