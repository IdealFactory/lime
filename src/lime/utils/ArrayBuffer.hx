package lime.utils;

#if (js && !doc_gen)
typedef ArrayBuffer = #if haxe4 js.lib.ArrayBuffer #else js.html.ArrayBuffer #end;
#else
import haxe.io.Bytes;

@:forward
@:transitive
abstract ArrayBuffer(Bytes) from Bytes to Bytes
#if doc_gen from Dynamic to Dynamic
#end
{
	public inline function new(byteLength:Int)
	{
		this = Bytes.alloc(byteLength);
	}
}
#end // !js
