package lime.graphics.cairo;

#if (!lime_doc_gen || lime_cairo)
import lime._internal.backend.native.NativeCFFI;
import lime.system.CFFIPointer;

class CairoTextExtents
{
    public var x_bearing:Float;
    public var y_bearing:Float;
    public var width:Float;
    public var height:Float;
    public var x_advance:Float;
    public var y_advance:Float;

	public function new(x_bearing:Float = 0, y_bearing:Float = 0, width:Float = 0, height:Float = 0, x_advance:Float = 0, y_advance:Float = 0)
	{
		this.x_bearing = x_bearing;
		this.y_bearing = y_bearing;
		this.width = width;
		this.height = height;
		this.x_advance = x_advance;
		this.y_advance = y_advance;
	}

	public function toString() {
		return "bearing:"+x_bearing+"/"+y_bearing+" wh:"+width+"/"+height+" advance:"+x_advance+"/"+y_advance;
	}
}
#end
