package com.gt.effect.ui
{
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import com.gt.effect.EffectPivotManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import flare.core.Pivot3D;
	
	public class EffectPivotPropertyPanel extends EffectSubPropertyPanel
	{
		private var FPosXNum:NumericStepper;
		private var FPosYNum:NumericStepper;
		private var FPosZNum:NumericStepper;
		
		private var FRotXNum:NumericStepper;
		private var FRotYNum:NumericStepper;
		private var FRotZNum:NumericStepper;
		
		private var FScaleXNum:NumericStepper;
		private var FScaleYNum:NumericStepper;
		private var FScaleZNum:NumericStepper;
		
		private var _remove_frame_btn:PushButton;
		
		public function EffectPivotPropertyPanel(parent:DisplayObjectContainer=null)
		{
			super(parent, 0, 0, "Transform", 25);
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			var xPos:int = 0;
			var yPos:int = 0;
			
			const Num_Step:Number = 1;
			//position
			new Label(this, xPos=5, yPos+=5, "Position X:");
			FPosXNum = CreateNumericStepper(xPos += 70, yPos, 20, 70, Num_Step, 2, UpdateProperty);
			new Label(this, xPos+75, yPos, "Y:");
			FPosYNum = CreateNumericStepper(xPos += 90, yPos, 20, 70, Num_Step, 2, UpdateProperty);
			new Label(this, xPos+75, yPos, "Z:");
			FPosZNum = CreateNumericStepper(xPos += 90, yPos, 20, 70, Num_Step, 2, UpdateProperty);
			
			new Label(this, xPos=5, yPos+=25, "Rotation X:");
			FRotXNum = CreateNumericStepper(xPos += 70, yPos, 20, 70, Num_Step, 0, UpdateProperty);
			new Label(this, xPos+75, yPos, "Y:");
			FRotYNum = CreateNumericStepper(xPos += 90, yPos, 20, 70, Num_Step, 0, UpdateProperty);
			new Label(this, xPos+75, yPos, "Z:");
			FRotZNum = CreateNumericStepper(xPos += 90, yPos, 20, 70, Num_Step, 0, UpdateProperty);
			
			new Label(this, xPos=5, yPos+=25, "Scale X:");
			FScaleXNum = CreateNumericStepper(xPos += 70, yPos, 20, 70, Num_Step, 2, UpdateProperty);
			new Label(this, xPos+75, yPos, "Y:");
			FScaleYNum = CreateNumericStepper(xPos += 90, yPos, 20, 70, Num_Step, 0, UpdateProperty);
			new Label(this, xPos+75, yPos, "Z:");
			FScaleZNum = CreateNumericStepper(xPos += 90, yPos, 20, 70, Num_Step, 0, UpdateProperty);
			
			_remove_frame_btn = new PushButton(this, xPos = 5, xPos += 75, "删除关键帧", onRemoveFrame);
			
			height = 130;
		}
		
		private function onRemoveFrame(evt:Event):void
		{
			var curFrame:int = FlareEffect.inst.curFrame;
			EffectPivotManager.removeFrame(_tar_pivot, curFrame);
			
			FlareEffect.inst.updateFrame();
			
			_remove_frame_btn.enabled = EffectPivotManager.isFrame(_tar_pivot, curFrame);
		}
		
		override public function draw():void
		{
			super.draw();
			
			if (_tar_pivot)
			{
				var posVec:Vector3D = _tar_pivot.getPosition(false);
				FPosXNum.value = posVec.x;
				FPosYNum.value = posVec.y;
				FPosZNum.value = posVec.z;
				
				var rotVec:Vector3D = _tar_pivot.getRotation();
				FRotXNum.value = rotVec.x;
				FRotYNum.value = rotVec.y;
				FRotZNum.value = rotVec.z;
				
				//				var scaleVec:Vector3D = _tar_pivot.getScale(false);
				FScaleXNum.value = _tar_pivot.scaleX;
				FScaleYNum.value = _tar_pivot.scaleY;
				FScaleZNum.value = _tar_pivot.scaleZ;
				
				var curFrame:int = FlareEffect.inst.curFrame;
				
				_remove_frame_btn.enabled = EffectPivotManager.isFrame(_tar_pivot, curFrame);
			}
			else
			{
				_remove_frame_btn.enabled = false;
			}
		}
		
		private function UpdateProperty(e:Event):void
		{
			if (_tar_pivot)
			{
				var RotVec:Vector3D;
				var Numeric:NumericStepper = e.currentTarget as NumericStepper;
				switch(Numeric)
				{
					case FPosXNum:
					{
						_tar_pivot.x = Numeric.value;
						break;
					}
					case FPosYNum:
					{
						_tar_pivot.y = Numeric.value;
						break;
					}
					case FPosZNum:
					{
						_tar_pivot.z = Numeric.value;
						break;
					}
						
					case FRotXNum:
					{
						RotVec = _tar_pivot.getRotation();
						_tar_pivot.setRotation(Numeric.value, RotVec.y, RotVec.z);
						break;
					}
					case FRotYNum:
					{
						RotVec = _tar_pivot.getRotation();
						_tar_pivot.setRotation(RotVec.x, Numeric.value, RotVec.z);
						break;
					}
					case FRotZNum:
					{
						RotVec = _tar_pivot.getRotation();
						_tar_pivot.setRotation(RotVec.x, RotVec.y, Numeric.value);
						break;
					}
						
					case FScaleXNum:
					{
						_tar_pivot.scaleX = Numeric.value;
						break;
					}
					case FScaleYNum:
					{
						_tar_pivot.scaleY = Numeric.value;
						break;
					}
					case FScaleZNum:
					{
						_tar_pivot.scaleZ = Numeric.value;
						break;
					}
				}
				
				EffectPivotManager.addFrame(_tar_pivot, FlareEffect.inst.curFrame);
			}
		}
		
		private function CreateNumericStepper(x:int, y:int, height:int, width:int, step:Number, labelPrecision:int, handle:Function):NumericStepper
		{
			var ns:NumericStepper = new NumericStepper(this, x, y);
			ns.addEventListener(Event.CHANGE, handle);
			ns.setSize(width, height);
			ns.labelPrecision = labelPrecision;
			ns.step = step;
			return ns;
		}
		
		private function onUpdateInfo(evt:Event):void
		{
			updateInfo();
		}
		
		override public function updateInfo():void
		{
			if (_tar_pivot)
			{
				super.updateInfo();
				
				invalidate();
			}
		}
		
		override public function set target(value:Pivot3D):void
		{
			super.target = value;
			
			onUpdateInfo(null);
			_tar_pivot.addEventListener(Pivot3D.UPDATE_TRANSFORM_EVENT, onUpdateInfo);
		}
	}
}