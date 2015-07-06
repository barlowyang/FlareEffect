package com.gt.effect
{
	import com.bit101.components.NumericStepper;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class Bit101Factor
	{
		
		public static function CreateNumericStepper(parent:DisplayObjectContainer, x:int, y:int, height:int, width:int, step:Number, labelPrecision:int, handle:Function):NumericStepper
		{
			var ns:NumericStepper = new NumericStepper(parent, x, y);
			ns.addEventListener(Event.CHANGE, handle);
			ns.setSize(width, height);
			ns.labelPrecision = labelPrecision;
			ns.step = step;
			return ns;
		}
	}
}