package com.gt.effect
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.events.Event;
	
	import flare.core.Pivot3D;
	import flare.primitives.Cube;
	import flare.primitives.Sphere;

	public class EffectMenu
	{
		public static const SPHERE:String = "球";
		public static const CUBE:String = "长方体";
		
		public function EffectMenu(nativeWin:NativeWindow)
		{
			var menu:NativeMenu = new NativeMenu();
			
			var createSubMenu:NativeMenu = new NativeMenu();
			var menuItem:NativeMenuItem = new NativeMenuItem(SPHERE);
			menuItem.addEventListener(Event.SELECT, onCreateMesh);
			createSubMenu.addItem(menuItem);
			menuItem = new NativeMenuItem(CUBE);
			menuItem.addEventListener(Event.SELECT, onCreateMesh);
			createSubMenu.addItem(menuItem);
			
			menu.addSubmenu(createSubMenu, "创建");
			
			nativeWin.menu = menu;
		}
		
		private function onCreateMesh(evt:Event):void
		{
			var menuItem:NativeMenuItem = evt.currentTarget as NativeMenuItem;
			var pivot:Pivot3D;
			switch(menuItem.label)
			{
				case SPHERE:
				{
					pivot = new Sphere();
					break;
				}
					
				case CUBE:
				{
					pivot = new Cube();
					break;
				}
					
			}
			FlareEffect.inst.addPivotToScene(pivot);
		}
	}
}