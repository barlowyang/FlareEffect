package com.gt.effect
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	import flare.basic.Scene3D;
	import flare.core.Camera3D;
	import flare.core.Pivot3D;
	import flare.system.Input3D;
	import flare.utils.Vector3DUtils;
	
	public class EffectScene extends Scene3D
	{
		private var _out:Vector3D;
		
		private var _spinX:Number = 0;
		
		private var _spinY:Number = 0;
		
		private var _spinZ:Number = 0;
		
		public var smooth:Number;
		
		public var speedFactor:Number;
		
		private var _stage:Stage;
		
		public function EffectScene(container:DisplayObjectContainer, file:String = "", smooth:Number = 1, speedFactor:Number = 0.5)
		{
			this._out = new Vector3D();
			super(container,file);
			if(smooth > 1)
			{
				throw new Error("Smooth value should be between 0 and 1.");
			}
			else
			{
				this.smooth = smooth;
				this.speedFactor = speedFactor;
			}
			_stage = container.stage;
			_stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onStartDrag);
			
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, onCheckWheel);
			
			FrameUpdate.addFun(onUpdate);
		}
		
		private function onUpdate():void
		{
			camera.translateZ(this._spinZ);
			this._spinZ = this._spinZ * (1 - this.smooth);
			
			if (Input3D.keyHit(Input3D.Z) && EffectPivotManager.selectObj)
			{
				var tar_obj:Pivot3D = EffectPivotManager.selectObj;
				camera.y = tar_obj.y + 10;
				camera.z = tar_obj.z - 20;
				camera.lookAt(tar_obj.x, tar_obj.y, tar_obj.z);
			}
		}
		
		private function onCheckWheel(evt:MouseEvent):void
		{
//			if(viewPort.contains(Input3D.mouseX,Input3D.mouseY))
			{
				this._spinZ = (camera.getPosition(false,this._out).length + 0.1) * this.speedFactor * evt.delta / 20;
			}
		}
		
		private function onStartDrag(evt:MouseEvent):void
		{
			addEventListener(Scene3D.UPDATE_EVENT, this.updateEvent, false, 0, true);
			_stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onEndDrag);
		}
		
		private function onEndDrag(evt:MouseEvent):void
		{
			removeEventListener(Scene3D.UPDATE_EVENT, this.updateEvent);
			_stage.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, onEndDrag);
		}
		
		private function updateEvent(e:Event) : void
		{
//			if(this._drag)
			{
				if(Input3D.keyDown(Input3D.SPACE))
				{
					camera.translateX(-Input3D.mouseXSpeed * camera.getPosition().length / 300);
					camera.translateY(Input3D.mouseYSpeed * camera.getPosition().length / 300);
				}
				else
				{
					this._spinX = this._spinX + Input3D.mouseXSpeed * this.smooth * this.speedFactor;
					this._spinY = this._spinY + Input3D.mouseYSpeed * this.smooth * this.speedFactor;
				}
			}
			camera.rotateY(this._spinX, false, Vector3DUtils.ZERO);
			camera.rotateX(this._spinY, true, Vector3DUtils.ZERO);
			this._spinX = this._spinX * (1 - this.smooth);
			this._spinY = this._spinY * (1 - this.smooth);
		}
	}
}