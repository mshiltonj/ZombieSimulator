/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 3/15/11
 * Time: 6:55 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

public class Zombie extends Person {
    private var thingColor:uint = 0xFFFFFFFF;
    private var _directionDuration:Number;

    public function Zombie(x:Number, y:Number):void {
        super(x, y);

    }

    override protected function getColor():uint {
        return thingColor;
    }
}
}
