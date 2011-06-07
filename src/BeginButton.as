/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 6/6/11
 * Time: 7:10 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import mx.controls.Text;
import mx.core.EmbeddedFont;
import mx.effects.UnconstrainItemAction;

import org.flixel.FlxButton;
import org.flixel.FlxSprite;

import org.flixel.FlxText;

public class BeginButton extends FlxButton {

    private const DEFAULT_OFF_COLOR = 0xff7f7f7f;
    private const DEFAULT_HOVER_COLOR = 0xffffffff;


    public function BeginButton(x:uint, y:uint, callback:Function, label:FlxText, highlightLabel:FlxText = null, w:uint = null, h:uint = null, offColor:uint = null, hoverColor:uint = null, onColor:uint = null) {
        super(x, y, callback);

        if (w) {
            this.width = w;
        }
        if (h) {
            this.height = h;
        }

        if (! offColor) offColor = DEFAULT_OFF_COLOR;
        if (! hoverColor) hoverColor = DEFAULT_HOVER_COLOR;


        remove(_off);
        remove(_on);

        _off = new FlxSprite().createGraphic(this.width, this.height, offColor);
        _off.solid = false;
        add(_off, true);
        _on = new FlxSprite().createGraphic(this.width, this.height, hoverColor);
        _on.solid = false;
        add(_on, true);

        if (label){
            loadText(label, highlightLabel);
        }

    }
}
}
