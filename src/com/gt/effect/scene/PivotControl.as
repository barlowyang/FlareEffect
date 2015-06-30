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

	public class PivotControl
	{
		private static var _stage:Stage;
		private static var _axis_translation:Pivot3D;
		private static var _axis_scale:Pivot3D;
		private static var _axis_rotation:Pivot3D;
		
		public static function setup(axis_tran:Pivot3D, stage:Stage):void
		{
			_stage = stage;
			_axis_translation = axis_tran;
			var x_axis:Pivot3D = _axis_translation.getChildByName("x_axis");
			x_axis.addEventListener(MouseEvent3D.MOUSE_DOWN, onXMove);
			var y_axis:Pivot3D = _axis_translation.getChildByName("y_axis");
			y_axis.addEventListener(MouseEvent3D.MOUSE_DOWN, onYMove);
			var z_axis:Pivot3D = _axis_translation.getChildByName("z_axis");
			z_axis.addEventListener(MouseEvent3D.MOUSE_DOWN, onZMove);
		}
		
		
		private static var _tmpPos:Vector3D;
		private static var _dir:Vector3D = new Vector3D();
		private static var _tmpMousePos:Point = new Point();
		private static function onXMove(evt:MouseEvent3D):void
		{
			_dir.setTo(1, 0, 0);
			_tmpPos = EffectPivotManager.selectObj.getPosition();
			_tmpMousePos.x = _stage.mouseX;
			_tmpMousePos.y = _stage.mouseY;
			_stage.addEventListener(MouseEvent.MOUSE_UP, onEndMove);
			FrameUpdate.addFun(moveObj);
		}
		
		private static function onYMove(evt:MouseEvent3D):void
		{
			_dir.setTo(0, 1, 0);
			_tmpPos = EffectPivotManager.selectObj.getPosition();
			_tmpMousePos.x = _stage.mouseX;
			_tmpMousePos.y = _stage.mouseY;
			_stage.addEventListener(MouseEvent.MOUSE_UP, onEndMove);
			FrameUpdate.addFun(moveObj);
		}
		
		private static function onZMove(evt:MouseEvent3D):void
		{
			_dir.setTo(0, 0, 1);
			_tmpPos = EffectPivotManager.selectObj.getPosition();
			_tmpMousePos.x = _stage.mouseX;
			_tmpMousePos.y = _stage.mouseY;
			_stage.addEventListener(MouseEvent.MOUSE_UP, onEndMove);
			FrameUpdate.addFun(moveObj);
		}
		
		private static function onEndMove(evt:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onEndMove);
			FrameUpdate.removeFun(moveObj);
		}
		
		private static function moveObj():void
		{
			var cur_pos:Point = new Point(_stage.mouseX, _stage.mouseY);
			var tmp_len:Number = cur_pos.length - _tmpMousePos.length;
			var dir_clone:Vector3D = _dir.clone();
			dir_clone.scaleBy(tmp_len / 10);
			dir_clone = _tmpPos.subtract(dir_clone);
			EffectPivotManager.selectObj.setPosition(dir_clone.x, dir_clone.y, dir_clone.z);
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
			FrameUpdate.addFun(moveAxisObj);
		}
		
		private function onEndDragAxis(evt:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onEndDragAxis);
			FrameUpdate.removeFun(moveAxisObj);
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
			
//			var tar_camera_pos:Vector3D = camera.invWorld.transformVector(_tar_pivot.getPosition());
			/*
			var tar_camera_pos:Vector3D = new Vector3D(0, 0, 10);
			var xLen:Number = _stage.mouseX - _oldScreenPos.x;
			var yLen:Number = _stage.mouseY - _oldScreenPos.y;*/
			
			var xLen:Number = vec3.x / 10;
			var yLen:Number = vec3.y / 10;
			_tar_pivot.translateAxis(xLen, rightDir);
			_tar_pivot.translateAxis(yLen, leftDir);
			_oldScreenPos.x = _stage.mouseX;
			_oldScreenPos.y = _stage.mouseY;
		}
		
		private function onChangeMaterial(evt:MouseEvent3D):void
		{
			
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