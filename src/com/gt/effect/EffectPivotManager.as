package com.gt.effect
{
	import flash.geom.Matrix3D;
	import flash.utils.Dictionary;
	
	import flare.basic.Scene3D;
	import flare.core.Frame3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.primitives.DebugWireframe;
	import flare.utils.Matrix3DUtils;
	
	public class EffectPivotManager
	{
		public static var scene:Scene3D;
		
		private static var _pivotVec:Vector.<Pivot3D>;
		private static var _pivotFrameDict:Dictionary;
		
		private static var _selectObj:Pivot3D;
		
		private static var _wire:DebugWireframe;
		
		{
			_pivotVec = new Vector.<Pivot3D>();
			_pivotFrameDict = new Dictionary();//Vector.<Vector.<Frame3D>>();
		}
		
		public static function addObj(obj:Pivot3D):void
		{
			if (_pivotVec.indexOf(obj) == -1)
			{
				_pivotVec.push(obj);
				
				addFrame(obj, 0);
			}
		}
		
		public static function removeObj(obj:Pivot3D):void
		{
			var idx:int = _pivotVec.indexOf(obj);
			if (idx != -1)
			{
				_pivotVec.splice(idx, 1);
			}
		}
		
		public static function updateFrame(frame_num:int):void
		{
			var matrix3d:Matrix3D;
			for each (var tmp_obj:Pivot3D in _pivotVec)
			{
				matrix3d = getFrame3D(tmp_obj, 	frame_num);
				tmp_obj.transform.copyFrom(matrix3d);
				tmp_obj.updateTransforms(true);
			}
			
			FlareEffect.inst.updateProperty();
		}
		
		public static function addFrame(obj:Pivot3D, frame_num:uint):void
		{
			var frameVec:Vector.<Frame3D> = _pivotFrameDict[obj] || new Vector.<Frame3D>;
			_pivotFrameDict[obj] = frameVec;
			
			for each (var frame:Frame3D in frameVec)
			{
				if (frame.type == frame_num)
				{
					frame.copyFrom(obj.transform);
					return;
				}
			}
			frameVec.push(new Frame3D(obj.transform.rawData, frame_num));
			
			FlareEffect.inst.drawFrameFlag();
		}
		
		public static function removeFrame(obj:Pivot3D, frame_num:uint):void
		{
			var frameVec:Vector.<Frame3D> = _pivotFrameDict[obj];
			if (frameVec)
			{
				var frame:Frame3D;
				for (var i:int = 0; i < frameVec.length; i++)
				{
					frame = frameVec[i];
					if (frame.type == frame_num)
					{
						frameVec.splice(i, 1);
					}
				}
				FlareEffect.inst.drawFrameFlag();
			}
		}
		
		public static function isFrame(obj:Pivot3D, frame_num:uint):Boolean
		{
			var frameVec:Vector.<Frame3D> = _pivotFrameDict[obj];
			if (frameVec.length == 1)
			{
				return false;
			}
			if (frameVec)
			{
				var frame:Frame3D;
				for (var i:int = 0; i < frameVec.length; i++)
				{
					frame = frameVec[i];
					if (frame.type == frame_num)
					{
						return true;
					}
				}
			}
			return false;
		}
		
		public static function getFrame3D(obj:Pivot3D, frame_num:Number):Matrix3D
		{
			var frameVec:Vector.<Frame3D> = _pivotFrameDict[obj];
			if (frameVec)
			{
				var frame:Frame3D;
				var leftFrame:Frame3D;
				var leftVal:int = int.MAX_VALUE;
				var rightFrame:Frame3D;
				var rightVal:int = int.MAX_VALUE;
				for (var i:int = 0; i < frameVec.length; i++)
				{
					frame = frameVec[i];
					if (frame.type == frame_num)
					{
						return frame;
					}
					else if (frame.type > frame_num)
					{
						if (rightVal > frame.type - frame_num)
						{
							rightVal = frame.type - frame_num;
							rightFrame = frame;
						}
					}
					else if (frame.type < frame_num)
					{
						if (leftVal > frame_num - frame.type)
						{
							leftVal = frame_num - frame.type;
							leftFrame = frame;
						}
					}
				}
				if ((leftFrame && rightFrame == null) || (leftFrame == null && rightFrame))
				{
					return leftFrame || rightFrame;
				}
				var tmp_mat:Matrix3D = leftFrame.clone();
				Matrix3DUtils.interpolateTo(tmp_mat, rightFrame, (frame_num - leftFrame.type) / (rightFrame.type - leftFrame.type));
				return tmp_mat;
			}
			return frame;
		}
		
		public static function get selectObj():Pivot3D
		{
			return _selectObj;
		}
		
		public static function set selectObj(value:Pivot3D):void
		{
			if (_selectObj != value)
			{
				if (_wire)
				{
					_wire.dispose();
				}
				_selectObj = value;
				
				if (_selectObj is Mesh3D)
				{
					_wire = new DebugWireframe(_selectObj as Mesh3D);
					_selectObj.addChild(_wire);
				}
				
				FlareEffect.inst.updateObj(_selectObj);
			}
		}

		public static function get pivotFrameDict():Dictionary
		{
			return _pivotFrameDict;
		}

	}
}