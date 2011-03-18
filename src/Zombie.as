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

    private var _speedBase:int = 6;
    private var _speedBump:int = 6;

    public function Zombie(x:Number, y:Number):void {
        super(x, y);

    }

    override protected function getColor():uint {
        return thingColor;
    }

    override public function get speedBase():int {
        return _speedBase;
    }

    override public function set speedBase(value:int):void {
        _speedBase = value;
    }

    override public function get speedBump():int {
        return _speedBump;
    }

    override public function set speedBump(value:int):void {
        _speedBump = value;
    }
}
}
