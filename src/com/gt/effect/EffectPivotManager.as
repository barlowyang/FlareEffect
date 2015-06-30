package com.gt.effect
{
	import flare.basic.Scene3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.primitives.DebugWireframe;
	
	public class EffectPivotManager
	{
		public static var scene:Scene3D;
		
		private static var _pivotVec:Vector.<Pivot3D>;
		private static var _selectObj:Pivot3D;
		
		private static var _wire:DebugWireframe;
		
		{
			_pivotVec = new Vector.<Pivot3D>();
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
	}
}