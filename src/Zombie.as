/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 3/15/11
 * Time: 6:55 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxObject;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;

public class Zombie extends Person {
    private static var THINGCOLOR:uint = 0xFFFFFFFF;
    private static var SPEEDBUMP:Number = 10.0;
    private static var SPEEDBASE:Number = 10.0;

    private var _group:FlxGroup; //FlxObject or ZombiePack;

    public function Zombie(x:Number, y:Number):void {
        super(x, y);
        _group = null;
    }

    override public function update():void{
        slowDown();
        super.update();

    }

    override public function setStartSpeed(boost:int = 1):void{
        speedBase = SPEEDBASE;
        speedBump = SPEEDBUMP;
    }

    public function slowDown(otherZombie:Zombie = null):void{
        speedBase *= 0.999;
        speedBump *= 0.999;

        if (speedBase < 0.1){
            speedBase = 0.1;
        }

        if (speedBump < 0.5){
            speedBump = 0.5;
        }
    }

    override protected function getColor():uint {
        return THINGCOLOR;
    }

    public function get group():FlxGroup {
        return _group;
    }

    public function set group(value:FlxGroup):void {
        _group = value;
    }
}
}
