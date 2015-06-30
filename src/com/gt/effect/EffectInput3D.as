package com.gt.effect
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class EffectInput3D extends Object
   {
      
      private static var _ups:Array;
      
      private static var _downs:Array;
      
      private static var _hits:Array;
      
      private static var _keyCode:int = 0;
      
      private static var _delta:int = 0;
      
      private static var _deltaMove:int = 0;
      
      private static var _mouseUp:int = 0;
      
      private static var _mouseHit:int = 0;
      
      private static var _mouseDown:int;
      
      private static var _rightMouseUp:int = 0;
      
      private static var _rightMouseHit:int = 0;
      
      private static var _rightMouseDown:int;
      
      private static var _middleMouseUp:int = 0;
      
      private static var _middleMouseHit:int = 0;
      
      private static var _middleMouseDown:int;
      
      private static var _mouseDoubleClick:int = 0;
      
      private static var _mouseX:Number = 0;
      
      private static var _mouseY:Number = 0;
      
      private static var _mouseXSpeed:Number = 0;
      
      private static var _mouseYSpeed:Number = 0;
      
      private static var _movementX:Number = 0;
      
      private static var _movementY:Number = 0;
      
      private static var _mouseUpdated:int = 1;
      
      private static var _stage:Stage;
      
      private static var _doubleClickEnabled:Boolean;
      
      private static var _rightClickEnabled:Boolean;
      
      private static var _stageX:Number = 0;
      
      private static var _stageY:Number = 0;
      
      public static var eventPhase:uint;
      
      public static var enableEventPhase:Boolean = true;
      
      private static var _currFrame:int;
      
      public static const A:uint = 65;
      
      public static const B:uint = 66;
      
      public static const C:uint = 67;
      
      public static const D:uint = 68;
      
      public static const E:uint = 69;
      
      public static const F:uint = 70;
      
      public static const G:uint = 71;
      
      public static const H:uint = 72;
      
      public static const I:uint = 73;
      
      public static const J:uint = 74;
      
      public static const K:uint = 75;
      
      public static const L:uint = 76;
      
      public static const M:uint = 77;
      
      public static const N:uint = 78;
      
      public static const O:uint = 79;
      
      public static const P:uint = 80;
      
      public static const Q:uint = 81;
      
      public static const R:uint = 82;
      
      public static const S:uint = 83;
      
      public static const T:uint = 84;
      
      public static const U:uint = 85;
      
      public static const V:uint = 86;
      
      public static const W:uint = 87;
      
      public static const X:uint = 88;
      
      public static const Y:uint = 89;
      
      public static const Z:uint = 90;
      
      public static const ALTERNATE:uint = 18;
      
      public static const BACKQUOTE:uint = 192;
      
      public static const BACKSLASH:uint = 220;
      
      public static const BACKSPACE:uint = 8;
      
      public static const CAPS_LOCK:uint = 20;
      
      public static const COMMA:uint = 188;
      
      public static const COMMAND:uint = 19;
      
      public static const CONTROL:uint = 17;
      
      public static const DELETE:uint = 46;
      
      public static const DOWN:uint = 40;
      
      public static const END:uint = 35;
      
      public static const ENTER:uint = 13;
      
      public static const EQUAL:uint = 187;
      
      public static const ESCAPE:uint = 27;
      
      public static const F1:uint = 112;
      
      public static const F10:uint = 121;
      
      public static const F11:uint = 122;
      
      public static const F12:uint = 123;
      
      public static const F13:uint = 124;
      
      public static const F14:uint = 125;
      
      public static const F15:uint = 126;
      
      public static const F2:uint = 113;
      
      public static const F3:uint = 114;
      
      public static const F4:uint = 115;
      
      public static const F5:uint = 116;
      
      public static const F6:uint = 117;
      
      public static const F7:uint = 118;
      
      public static const F8:uint = 119;
      
      public static const F9:uint = 120;
      
      public static const HOME:uint = 36;
      
      public static const INSERT:uint = 45;
      
      public static const LEFT:uint = 37;
      
      public static const LEFTBRACKET:uint = 219;
      
      public static const MINUS:uint = 189;
      
      public static const NUMBER_0:uint = 48;
      
      public static const NUMBER_1:uint = 49;
      
      public static const NUMBER_2:uint = 50;
      
      public static const NUMBER_3:uint = 51;
      
      public static const NUMBER_4:uint = 52;
      
      public static const NUMBER_5:uint = 53;
      
      public static const NUMBER_6:uint = 54;
      
      public static const NUMBER_7:uint = 55;
      
      public static const NUMBER_8:uint = 56;
      
      public static const NUMBER_9:uint = 57;
      
      public static const NUMPAD:uint = 21;
      
      public static const NUMPAD_0:uint = 96;
      
      public static const NUMPAD_1:uint = 97;
      
      public static const NUMPAD_2:uint = 98;
      
      public static const NUMPAD_3:uint = 99;
      
      public static const NUMPAD_4:uint = 100;
      
      public static const NUMPAD_5:uint = 101;
      
      public static const NUMPAD_6:uint = 102;
      
      public static const NUMPAD_7:uint = 103;
      
      public static const NUMPAD_8:uint = 104;
      
      public static const NUMPAD_9:uint = 105;
      
      public static const NUMPAD_ADD:uint = 107;
      
      public static const NUMPAD_DECIMAL:uint = 110;
      
      public static const NUMPAD_DIVIDE:uint = 111;
      
      public static const NUMPAD_ENTER:uint = 108;
      
      public static const NUMPAD_MULTIPLY:uint = 106;
      
      public static const NUMPAD_SUBTRACT:uint = 109;
      
      public static const PAGE_DOWN:uint = 34;
      
      public static const PAGE_UP:uint = 33;
      
      public static const PERIOD:uint = 190;
      
      public static const QUOTE:uint = 222;
      
      public static const RIGHT:uint = 39;
      
      public static const RIGHTBRACKET:uint = 221;
      
      public static const SEMICOLON:uint = 186;
      
      public static const SHIFT:uint = 16;
      
      public static const SLASH:uint = 191;
      
      public static const SPACE:uint = 32;
      
      public static const TAB:uint = 9;
      
      public static const UP:uint = 38;
      
      {
         _keyCode = 0;
         _delta = 0;
         _deltaMove = 0;
         _mouseUp = 0;
         _mouseHit = 0;
         _rightMouseUp = 0;
         _rightMouseHit = 0;
         _middleMouseUp = 0;
         _middleMouseHit = 0;
         _mouseDoubleClick = 0;
         _mouseX = 0;
         _mouseY = 0;
         _mouseXSpeed = 0;
         _mouseYSpeed = 0;
         _movementX = 0;
         _movementY = 0;
         _mouseUpdated = 1;
         _stageX = 0;
         _stageY = 0;
         enableEventPhase = true;
      }
      
      public function EffectInput3D()
      {
         super();
      }
      
      public static function initialize(stage:Stage) : void
      {
         if(stage == null)
         {
            throw "The \'stage\' parameter is null";
         }
         else
         {
            _stage = stage;
            _downs = _downs || new Array();
            _hits = _hits || new Array();
            _ups = _ups || new Array();
            _mouseX = _stage.mouseX;
            _mouseY = _stage.mouseY;
            _stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownEvent);
            _stage.addEventListener(KeyboardEvent.KEY_UP,keyUpEvent);
            _stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseUpdate);
            _stage.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelEvent);
            _stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownEvent);
            _stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpEvent);
            _stage.addEventListener("middleMouseDown",middleMouseDownEvent);
            _stage.addEventListener("middleMouseUp",middleMouseUpEvent);
            _stage.addEventListener(Event.DEACTIVATE,deactivateEvent);
            doubleClickEnabled = _doubleClickEnabled;
            rightClickEnabled = _rightClickEnabled;
            return;
         }
      }
      
      public static function deactivate() : void
      {
         if(!_stage)
         {
            return;
         }
         _stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownEvent);
         _stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpEvent);
         _stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseUpdate);
         _stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownEvent);
         _stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpEvent);
         _stage.removeEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelEvent);
         _stage.removeEventListener(MouseEvent.DOUBLE_CLICK,mouseDoubleClickEvent);
         _stage.removeEventListener(Event.DEACTIVATE,deactivateEvent);
      }
      
      private static function deactivateEvent(e:Event) : void
      {
         reset();
      }
      
      public static function dispose() : void
      {
         deactivate();
         _downs = null;
         _hits = null;
         _ups = null;
         _stage = null;
      }
      
      private static function mouseUpdate(e:MouseEvent) : void
      {
         if(_stage.mouseLock)
         {
            _mouseUpdated = 2;
            _movementX = _movementX + e.movementX;
            _movementY = _movementY + e.movementY;
         }
         else
         {
            _mouseUpdated = 1;
         }
         _stageX = e.stageX;
         _stageY = e.stageY;
      }
      
      public static function update() : void
      {
         _currFrame++;
         if(_mouseUpdated == 1)
         {
            _mouseXSpeed = _stageX - _mouseX;
            _mouseYSpeed = _stageY - _mouseY;
            _mouseUpdated = 0;
         }
         else if(_mouseUpdated == 2)
         {
            _mouseUpdated = 0;
            _mouseXSpeed = _movementX;
            _mouseYSpeed = _movementY;
            _movementX = 0;
            _movementY = 0;
         }
         else
         {
            _mouseXSpeed = 0;
            _mouseYSpeed = 0;
         }
         
         _mouseX = _stageX;
         _mouseY = _stageY;
      }
      
      public static function reset() : void
      {
         for(var i:int = 0; i < 255; i++)
         {
            _downs[i] = 0;
            _hits[i] = 0;
            _ups[i] = 0;
         }
         _mouseXSpeed = 0;
         _mouseYSpeed = 0;
         _movementX = 0;
         _movementY = 0;
         _mouseUp = 0;
         _mouseDown = 0;
         _mouseHit = 0;
         _rightMouseUp = 0;
         _rightMouseDown = 0;
         _rightMouseHit = 0;
         _middleMouseUp = 0;
         _middleMouseDown = 0;
         _middleMouseHit = 0;
         _mouseDoubleClick = 0;
      }
      
      private static function keyDownEvent(e:KeyboardEvent) : void
      {
         if(!_downs[e.keyCode])
         {
            _hits[e.keyCode] = _currFrame + 1;
         }
         _downs[e.keyCode] = 1;
         _keyCode = e.keyCode;
      }
      
      private static function keyUpEvent(e:KeyboardEvent) : void
      {
         if(!_stage)
         {
            return;
         }
         _downs[e.keyCode] = 0;
         _hits[e.keyCode] = 0;
         _ups[e.keyCode] = _currFrame + 1;
         _keyCode = 0;
      }
      
      private static function mouseDownEvent(e:MouseEvent) : void
      {
         if(enableEventPhase)
         {
            eventPhase = e.eventPhase;
         }
         else
         {
            eventPhase = 0;
         }
         _mouseDown = 1;
         _mouseUp = 0;
         _mouseHit = _currFrame + 1;
         _mouseX = _stageX;
         _mouseY = _stageY;
      }
      
      private static function mouseWheelEvent(e:MouseEvent) : void
      {
         if(enableEventPhase)
         {
            eventPhase = e.eventPhase;
         }
         else
         {
            eventPhase = 0;
         }
         _delta = e.delta;
         _deltaMove = _currFrame + 1;
      }
      
      private static function mouseUpEvent(e:MouseEvent) : void
      {
         if(enableEventPhase)
         {
            eventPhase = e.eventPhase;
         }
         else
         {
            eventPhase = 0;
         }
         _mouseDown = 0;
         _mouseUp = _currFrame + 1;
         _mouseHit = 0;
      }
      
      private static function rightMouseDownEvent(e:Event) : void
      {
         _rightMouseDown = 1;
         _rightMouseUp = 0;
         _rightMouseHit = _currFrame + 1;
      }
      
      private static function rightMouseUpEvent(e:Event) : void
      {
         _rightMouseDown = 0;
         _rightMouseUp = _currFrame + 1;
         _rightMouseHit = 0;
      }
      
      private static function middleMouseDownEvent(e:Event) : void
      {
         _middleMouseDown = 1;
         _middleMouseUp = 0;
         _middleMouseHit = _currFrame + 1;
      }
      
      private static function middleMouseUpEvent(e:Event) : void
      {
         _middleMouseDown = 0;
         _middleMouseUp = _currFrame + 1;
         _middleMouseHit = 0;
      }
      
      private static function mouseDoubleClickEvent(e:MouseEvent) : void
      {
         _mouseDoubleClick = _currFrame + 1;
      }
      
      public static function get keyCode() : int
      {
         return _keyCode;
      }
      
      public static function keyDown(keyCode:int) : Boolean
      {
         return _downs[keyCode];
      }
      
      public static function keyHit(keyCode:int) : Boolean
      {
         return _hits[keyCode] == _currFrame?true:false;
      }
      
      public static function keyUp(keyCode:int) : Boolean
      {
         return _ups[keyCode] == _currFrame?true:false;
      }
      
      public static function get mouseDoubleClick() : int
      {
         return _mouseDoubleClick == _currFrame?1:0;
      }
      
      public static function get delta() : int
      {
         return _deltaMove == _currFrame?_delta:0;
      }
      
      public static function set delta(value:int) : void
      {
         _delta = value;
      }
      
      public static function get mouseYSpeed() : Number
      {
         return _mouseYSpeed;
      }
      
      public static function get mouseHit() : int
      {
         return _mouseHit == _currFrame?1:0;
      }
      
      public static function get mouseUp() : int
      {
         return _mouseUp == _currFrame?1:0;
      }
      
      public static function get mouseDown() : int
      {
         return _mouseDown;
      }
      
      public static function get rightMouseHit() : int
      {
         return _rightMouseHit == _currFrame ? 1 : 0;
      }
      
      public static function get rightMouseUp() : int
      {
         return _rightMouseUp == _currFrame?1:0;
      }
      
      public static function get rightMouseDown() : int
      {
         return _rightMouseDown;
      }
      
      public static function get middleMouseHit() : int
      {
         return _middleMouseHit == _currFrame?1:0;
      }
      
      public static function get middleMouseUp() : int
      {
         return _middleMouseUp == _currFrame?1:0;
      }
      
      public static function get middleMouseDown() : int
      {
         return _middleMouseDown;
      }
      
      public static function get mouseXSpeed() : Number
      {
         return _mouseXSpeed;
      }
      
      public static function get mouseY() : Number
      {
         return _mouseY;
      }
      
      public static function set mouseY(value:Number) : void
      {
         _mouseY = value;
      }
      
      public static function get mouseX() : Number
      {
         return _mouseX;
      }
      
      public static function set mouseX(value:Number) : void
      {
         _mouseX = value;
      }
      
      public static function get mouseMoved() : Number
      {
         return Math.abs(_mouseXSpeed) + Math.abs(_mouseYSpeed);
      }
      
      public static function get doubleClickEnabled() : Boolean
      {
         return _doubleClickEnabled;
      }
      
      public static function set doubleClickEnabled(value:Boolean) : void
      {
         _doubleClickEnabled = value;
         _stage.doubleClickEnabled = value;
         if(value)
         {
            _stage.addEventListener(MouseEvent.DOUBLE_CLICK,mouseDoubleClickEvent);
         }
         else
         {
            _stage.removeEventListener(MouseEvent.DOUBLE_CLICK,mouseDoubleClickEvent);
         }
      }
      
      public static function get rightClickEnabled() : Boolean
      {
         return _rightClickEnabled;
      }
      
      public static function set rightClickEnabled(value:Boolean) : void
      {
         _rightClickEnabled = value;
         if(value)
         {
            _stage.addEventListener("rightMouseDown",rightMouseDownEvent);
            _stage.addEventListener("rightMouseUp",rightMouseUpEvent);
         }
         else
         {
            _stage.removeEventListener("rightMouseDown",rightMouseDownEvent);
            _stage.removeEventListener("rightMouseUp",rightMouseUpEvent);
         }
      }
      
      public static function get downs() : Array
      {
         return _downs;
      }
      
      public static function get hits() : Array
      {
         return _hits;
      }
      
      public static function get stage() : Stage
      {
         return _stage;
      }
   }
}
