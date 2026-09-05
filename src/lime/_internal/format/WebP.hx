package lime._internal.format;

import haxe.io.Bytes;
import lime._internal.graphics.ImageCanvasUtil;
import lime.graphics.Image;
#if (js && html5)
import js.Browser;
#end

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(lime.graphics.ImageBuffer)
class WebP
{
	/**
		Encodes lossy WebP through the browser's canvas encoder. Returns null
		where no encoder exists (native targets, or a browser that answers the
		request with PNG), so callers can fall back to another format.
	**/
	public static function encode(image:Image, quality:Int):Bytes
	{
		#if (js && html5)
		if (image.premultiplied || image.format != RGBA32)
		{
			image = image.clone();
			image.premultiplied = false;
			image.format = RGBA32;
		}

		ImageCanvasUtil.convertToCanvas(image, false);

		if (image.buffer.__srcCanvas != null)
		{
			var data = image.buffer.__srcCanvas.toDataURL("image/webp", quality / 100);

			if (!StringTools.startsWith(data, "data:image/webp"))
			{
				return null;
			}

			var buffer = Browser.window.atob(data.split(";base64,")[1]);
			var bytes = Bytes.alloc(buffer.length);

			for (i in 0...buffer.length)
			{
				bytes.set(i, buffer.charCodeAt(i));
			}

			return bytes;
		}
		#end

		return null;
	}
}
