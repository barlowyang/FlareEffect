package
{
	import com.gt.effect.EffectPivotManager;
	import com.gt.effect.EffectScene;
	import com.gt.effect.scene.PivotControl;
	import com.gt.effect.ui.EffectPropertyPanel;
	import com.gt.effect.ui.EffectTimeAxisPanel;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DCompareMode;
	import flash.events.Event;
	
	import flare.basic.Scene3D;
	import flare.core.Lines3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.materials.Material3D;
	import flare.primitives.Cube;
	import flare.primitives.Sphere;
	
	[SWF(width="1250", height="800", frameRate="60", backgroundColor="0x333333")]
	public class FlareEffect extends Sprite
	{
		[Embed(source = "../embed/axis.f3d", mimeType = "application/octet-stream")]
		private var AXIS:Class;
		private static var _inst:FlareEffect;
		public static function get inst():FlareEffect
		{
			return _inst;
		}
		
		private var _viewer:Scene3D;
		
		private var _property_panel:EffectPropertyPanel;
		private var _timeAxis_panel:EffectTimeAxisPanel;
		
		public function FlareEffect()
		{
			_inst = this;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
//			_viewer = new Viewer3D(this);
			_viewer = new EffectScene(this);
//			_viewer.autoResize = true;
			_viewer.antialias = 2;
			_viewer.camera.setPosition( 0, 10, 30 );
			_viewer.camera.lookAt( 0, 0, 0 );
			
			EffectPivotManager.scene = _viewer;
			
			var axis_translate:Pivot3D = _viewer.addChildFromFile(new AXIS());
			axis_translate = axis_translate.getChildByName("axis") as Pivot3D;
			axis_translate.setScale(0.5, 0.5, 0.5);
			axis_translate.parent = null;
			axis_translate.forEach(function (mesh:Mesh3D):void
			{
				var material:Material3D = mesh.surfaces[0].material;
				material.depthCompare = Context3DCompareMode.ALWAYS;
			}, Mesh3D);
			
			PivotControl.setup(axis_translate, stage);
			
			drawWires();
			
			var circle:Sphere = new Sphere("sphere");
			_viewer.addChild(circle);
			new PivotControl(circle);
			
			var cube:Cube = new Cube("cube");
			cube.x = 10;
			_viewer.addChild(cube);
			new PivotControl(cube);
			
			
			_property_panel = new EffectPropertyPanel(this);
			_timeAxis_panel = new EffectTimeAxisPanel(this);
			
			onResizeScene(null);
			stage.addEventListener(Event.RESIZE, onResizeScene);
		}
		
		private function onResizeScene(evt:Event):void
		{
			var sw:uint = stage.stageWidth - EffectPropertyPanel.WIDTH;
			var sh:uint = stage.stageHeight - EffectTimeAxisPanel.HEIGHT;
			_property_panel.x = sw;
			_property_panel.height = stage.stageHeight;
			_timeAxis_panel.y = sh;
			_timeAxis_panel.width = sw;
			
			_viewer.setViewport(0, 0, sw, sh, 2);
		}
		
		public function updateObj(obj:Pivot3D):void
		{
			_property_panel.target = obj;
		}
		
		private function drawWires():void
		{
			var line:Lines3D = new Lines3D("wires");
			
			var w_t:uint = 30;
			var h_t:uint = 30;
			for (var i:int = -w_t; i < w_t; i++)
			{
				if (i == 0)
				{
					line.lineStyle(1, 0x0, 0.5);
				}
				else
				{
					line.lineStyle(1, 0x333333, 0.5);
				}
				
				line.moveTo(-w_t, 0, i);
				line.lineTo(w_t, 0, i);
			}
			for (var j:int = -h_t; j < h_t; j++)
			{
				if (j == 0)
				{
					line.lineStyle(1, 0x0, 0.5);
				}
				else
				{
					line.lineStyle(1, 0x333333, 0.5);
				}
				
				line.moveTo(j, 0, -h_t);
				line.lineTo(j, 0, h_t);
			}
			_viewer.addChild(line);
		}
	}
}