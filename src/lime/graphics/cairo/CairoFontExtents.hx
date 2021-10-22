package lime.graphics.cairo;

#if (!lime_doc_gen || lime_cairo)
import lime._internal.backend.native.NativeCFFI;
import lime.system.CFFIPointer;

class CairoFontExtents
{
    public var ascent:Float;
    public var descent:Float;
    public var height:Float;
    public var max_x_advance:Float;
    public var max_y_advance:Float;

	public function new(ascent:Float = 0, descent:Float = 0, height:Float = 0, max_x_advance:Float = 0, max_y_advance:Float = 0)
	{
		this.ascent = ascent;
		this.descent = descent;
		this.height = height;
		this.max_x_advance = max_x_advance;
		this.max_y_advance = max_y_advance;
	}

	public function toString() {
		return "asc/desc:"+ascent+"/"+descent+" h:"+height+" advance:"+max_x_advance+"/"+max_y_advance;
	}
}
#end
