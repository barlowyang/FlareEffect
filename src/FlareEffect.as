package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	import flare.apps.controls.BitmapFont;
	
	[SWF(width="1250", height="800", frameRate="60", backgroundColor="0x333333")]
	public class FlareEffect extends Sprite
	{
		public function FlareEffect()
		{
			var bitFont:BitmapFont = new BitmapFont(new TextFormat("宋体", 16));
			
			bitFont.draw(this.graphics, 100, 100, 100, 100, "杨张永");
			
//			addChild(new Bitmap(bitFont.
		}
	}
}