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
    private static var THINGCOLOR:uint = 0xFFFFFFFF;
    private static var SPEEDBUMP:Number = 10.0;
    private static var SPEEDBASE:Number = 10.0;

    private var localPack:Array;
    private static var MAX_PACK_SIZE=6;

    public function Zombie(x:Number, y:Number):void {
        super(x, y);
        localPack = new Array();
    }

    override public function setStartSpeed(boost:int = 1):void{
        speedBase = SPEEDBASE;
        speedBump = SPEEDBUMP;
    }

    public function inLocalPack(otherZombie:Zombie){
        localPack.indexOf(otherZombie);
    }

    public function slowDown(otherZombie:Zombie):void{
        speedBase *= 0.97;
        speedBump *= 0.97;

        if (speedBase < 0.1){
            speedBase = 0.1;
        }

        if (speedBump < 0.5){
            speedBump = 0.5;
        }

 //       localPack.push(otherZombie);
 //       if (localPack.size > MAX_PACK_SIZE){
  //          localPack.shift();
 //       }
    }

    override protected function getColor():uint {
        return THINGCOLOR;
    }
}
}
