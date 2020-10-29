package lime.app;

import lime.graphics.RenderContext;

import h3d.Engine;
import hxd.App;
import hxd.System;
import hxd.Window;

class HeapsApp {

	public var instance:Dynamic;

	var _appClass:Class<Dynamic>;

	public function new( appClass:Class<Dynamic> ) {

		_appClass = appClass;

		#if flash
		onLimeWindowReady(null);
		#else
		Application.current.onCreateWindow.add(onLimeWindowReady);
		#end
	}

	private function onLimeWindowReady(window:lime.ui.Window) {

		Window.CURRENT = Application.current;

		#if (!js && !flash)
		Application.current.window.onRender.add(render);
		Application.current.window.onResize.add(onWindowResize);
		#end

		var main = Reflect.field( _appClass, "main" );
		Reflect.callMethod( _appClass, main, [] );

		// --------------------------------------------------------

		// Alternative to create instane of <appClass> but requires no static main() method
		// specifically, no call to Res.initEmbed() as this causes macro def conflicts

		// Init resources
		// hxd.Res.initEmbed();

		// // Create the instance of the Heaps app
		// instance = cast Type.createInstance( _appClass, [] );

	}

	public function render (context:RenderContext):Void {
		#if (!js && !flash)
		@:privateAccess System.mainLoop();
		#end
	}

	public function onWindowResize(width:Int, height:Int):Void {
		#if (!flash)
		var window = Window.getInstance();
		@:privateAccess window.windowWidth = width;
		@:privateAccess window.windowHeight = height;

		@:privateAccess Engine.getCurrent().onWindowResize();
		#end
	}

}