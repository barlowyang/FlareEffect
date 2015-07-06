package com.gt.effect.scene
{
	import com.gt.effect.EffectPivotManager;
	import com.gt.effect.FrameUpdate;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import flare.core.Camera3D;
	import flare.core.Pivot3D;
	import flare.events.MouseEvent3D;
	import flare.system.Input3D;
	
	public class PivotControl
	{
		private static var _stage:Stage;
		
		public static function setup(stage:Stage):void
		{
			_stage = stage;
		}
		//--------------------------------------------------------------------------------------------
		
		private var _tar_pivot:Pivot3D;
		
		public function PivotControl(pivot:Pivot3D)
		{
			_tar_pivot = pivot;
			
			_tar_pivot.addEventListener(MouseEvent3D.CLICK, onChangeMaterial);
			_tar_pivot.addEventListener(MouseEvent3D.MOUSE_DOWN, onStartDragAxis);
		}
		
		private function onStartDragAxis(evt:MouseEvent3D):void
		{
			EffectPivotManager.selectObj = _tar_pivot;
			
			_tar_pivot.getScreenCoords(_oldObjPos);
			_oldScreenPos.x = _stage.mouseX;
			_oldScreenPos.y = _stage.mouseY;
			
			_stage.addEventListener(MouseEvent.MOUSE_UP, onEndDragAxis);
			if (Input3D.keyDown(Input3D.Z) || Input3D.keyDown(Input3D.X) || Input3D.keyDown(Input3D.Y))
			{
				FrameUpdate.addFun(moveAxisObj);
			}
			else
			{
				_tar_pivot.startDrag();
			}
		}
		
		private function onEndDragAxis(evt:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onEndDragAxis);
			FrameUpdate.removeFun(moveAxisObj);
			_tar_pivot.stopDrag();
			
			var tmpMousePos:Point = new Point(_stage.mouseX, _stage.mouseY);
			if (Point.distance(tmpMousePos, new Point(_oldScreenPos.x, _oldScreenPos.y)) > 1)
			{
				EffectPivotManager.addFrame(_tar_pivot, FlareEffect.inst.curFrame);
			}
		}
		
		private var _oldObjPos:Vector3D = new Vector3D();
		private var _oldScreenPos:Vector3D = new Vector3D();
		private function moveAxisObj():void
		{
			var camera:Camera3D = EffectPivotManager.scene.camera;
			var rightDir:Vector3D = camera.getRight();
			var leftDir:Vector3D = camera.getDown();
			
			var vec3:Vector3D = new Vector3D();
			vec3.x = (_stage.mouseX - _oldScreenPos.x);
			vec3.y = (_stage.mouseY - _oldScreenPos.y);
			
			var xLen:Number = vec3.x / 10;
			var yLen:Number = vec3.y / 10;
			
			var len:Number = xLen + yLen;
			
			if (Input3D.keyDown(Input3D.Z))
			{
				_tar_pivot.translateZ(len);
			}
			else if (Input3D.keyDown(Input3D.Y))
			{
				_tar_pivot.translateY(len);
			}
			else if (Input3D.keyDown(Input3D.X))
			{
				_tar_pivot.translateX(len);
			}
			/*
			_tar_pivot.translateAxis(xLen, rightDir);
			_tar_pivot.translateAxis(yLen, leftDir);*/
			
			_oldScreenPos.x = _stage.mouseX;
			_oldScreenPos.y = _stage.mouseY;
		}
		
		private function onChangeMaterial(evt:MouseEvent3D):void
		{
			FlareEffect.inst.drawFrameFlag();
			
			//			var tar_pos:Vector3D = EffectPivotManager.selectObj.getPosition();
			
			//			_axis_translation.setPosition(tar_pos.x, tar_pos.y, tar_pos.z);
			//			_axis_translation.parent = EffectPivotManager.selectObj;
			
			/*
			var material:Material3D = _axis.surfaces[0].material;
			material.depthCompare = Context3DCompareMode.ALWAYS;
			*/
		}
	}
}