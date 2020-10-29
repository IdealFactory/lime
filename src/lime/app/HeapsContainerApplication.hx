package lime.app;

// import lime.graphics.RenderContext;
// import lime.system.System;
// import lime.ui.Gamepad;
// import lime.ui.GamepadAxis;
// import lime.ui.GamepadButton;
// import lime.ui.Joystick;
// import lime.ui.JoystickHatPosition;
import lime.ui.KeyCode;
import lime.ui.KeyModifier;
import lime.ui.MouseButton;
import lime.ui.MouseWheelMode;
// import lime.ui.Touch;
// import lime.ui.Window;
// import lime.ui.WindowAttributes;
import h3d.Engine;
import hxd.App;
import hxd.System;
import hxd.Window;
import hxd.Event;

enum HeapsResources {
	NONE;
	LOCAL;
	EMBED;
}

class HeapsContainerApplication extends lime.app.Application
{
	var _appClass:Class<Dynamic>;
	var mouseEnabled:Bool;
	var mouseX:Float = 0;
	var mouseY:Float = 0;

	public var appInstance:Dynamic;

	public function new(?appClass:Class<Dynamic>)
	{
		_appClass = appClass;

		super();

		mouseEnabled = !hxd.System.getValue(IsTouch);
	}

	public function initHeapsApp( appClass:Class<Dynamic> ) {
		_appClass = appClass;
		if (_appClass != null && Window.CURRENT != null) {
			appInstance = cast Type.createInstance( _appClass, [] );
		} else {
			trace("Lime Window.CURRENT not set. Heaps App will not be able to render to this Lime backend. Wait for 'onWindowCreate' to complete.");
			trace(haxe.CallStack.callStack());
		}
	}

	override public function update(deltaTime:Int):Void
	{
		#if (!js && !flash)
		trace("STARTING FRAME RENDER #######################################");
		@:privateAccess System.mainLoop();
		trace(" - FRAME RENDERED     #######################################");
		#end
	}

	#if (!js && !flash)
	// override public function onGamepadAxisMove(gamepad:Gamepad, axis:GamepadAxis, value:Float):Void {}
	// override public function onGamepadButtonDown(gamepad:Gamepad, button:GamepadButton):Void {}
	// override public function onGamepadButtonUp(gamepad:Gamepad, button:GamepadButton):Void {}
	// override public function onGamepadConnect(gamepad:Gamepad):Void {}
	// override public function onGamepadDisconnect(gamepad:Gamepad):Void {}
	// override public function onJoystickAxisMove(joystick:Joystick, axis:Int, value:Float):Void {}
	// override public function onJoystickButtonDown(joystick:Joystick, button:Int):Void {}
	// override public function onJoystickButtonUp(joystick:Joystick, button:Int):Void {}
	// override public function onJoystickConnect(joystick:Joystick):Void {}
	// override public function onJoystickDisconnect(joystick:Joystick):Void {}
	// override public function onJoystickHatMove(joystick:Joystick, hat:Int, position:JoystickHatPosition):Void {}
	// override public function onJoystickTrackballMove(joystick:Joystick, trackball:Int, x:Float, y:Float):Void {}
	override public function onKeyDown(keyCode:KeyCode, modifier:KeyModifier):Void {
		var e = new Event(EKeyDown, mouseX, mouseY);
		e.keyCode = keyCode;
		e.charCode = modifier;
		Window.getInstance().event(e);
	}

	override public function onKeyUp(keyCode:KeyCode, modifier:KeyModifier):Void {
		var e = new Event(EKeyUp, mouseX, mouseY);
		e.keyCode = keyCode;
		e.charCode = modifier;
		Window.getInstance().event(e);
	}

	override public function onMouseDown(x:Float, y:Float, button:MouseButton):Void
	{
		if (!mouseEnabled) return;
		var e = new Event(EPush, x, y);
		e.button = button;
		Window.getInstance().event(e);
	}

	override public function onMouseMove(x:Float, y:Float):Void
	{
		if (!mouseEnabled) return;
		mouseX = x;
		mouseY = y;
		Window.getInstance().event(new Event(EMove, x, y));
	}

	override public function onMouseUp(x:Float, y:Float, button:MouseButton):Void
	{
		if (!mouseEnabled) return;
		var e = new Event(ERelease, x, y);
		e.button = button;
		Window.getInstance().event(e);
	}

	override public function onMouseWheel(deltaX:Float, deltaY:Float, deltaMode:MouseWheelMode):Void
	{
		if (!mouseEnabled) return;
		if (deltaY != 0)
		{
			var e = new Event(EWheel, mouseX, mouseY);
			e.wheelDelta = -deltaY;
			Window.getInstance().event(e);
		}
	}

	// override public function onRenderContextLost():Void {}
	// override public function onRenderContextRestored(context:RenderContext):Void {}

	override public function onTextEdit(text:String, start:Int, length:Int):Void {}

	override public function onTextInput(text:String):Void {}

	// override public function onTouchCancel(touch:Touch):Void {}
	// override public function onTouchEnd(touch:Touch):Void {}
	// override public function onTouchMove(touch:Touch):Void {}
	// override public function onTouchStart(touch:Touch):Void {}

	override public function onWindowActivate():Void {}

	override public function onWindowClose():Void {}

	override public function onWindowDeactivate():Void {}

	override public function onWindowDropFile(file:String):Void {}

	override public function onWindowEnter():Void {}

	override public function onWindowExpose():Void {}

	override public function onWindowFocusIn():Void {}

	override public function onWindowFocusOut():Void {}

	override public function onWindowFullscreen():Void {}

	override public function onWindowLeave():Void {}

	override public function onWindowMove(x:Float, y:Float):Void {}

	override public function onWindowMinimize():Void {}

	override public function onWindowResize(width:Int, height:Int):Void
	{
		#if (!js && !flash)
		var window = Window.getInstance();
		@:privateAccess window.windowWidth = width;
		@:privateAccess window.windowHeight = height;

		@:privateAccess Engine.getCurrent().onWindowResize();
		#end

		trace("HeapsContainerAppliation.RESIZE:"+width+"/"+height);
	}

	override public function onWindowRestore():Void {}
	#end

	override public function onWindowCreate():Void
	{
		Window.CURRENT = this;

		if (_appClass != null)
			initHeapsApp( _appClass );
	}
}
