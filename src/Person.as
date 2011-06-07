/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 3/15/11
 * Time: 6:55 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import org.flixel.FlxSprite;
import org.flixel.FlxPoint;
import org.flixel.FlxG;

public class Person extends FlxSprite {
    private static var THINGCOLOR:uint = 0xFF3399FF;
    //private static var THINGCOLOR:uint = 0xFF00FF00;

    private static var SPEEDBASE:Number = 30.0;
    private static var SPEEDBUMP:Number = 25.0;
    private static var SPEEDMAX:Number = 20.0;

    private var _directionDuration:Number;

    protected var _speedBase:Number;
    protected var _speedBump:Number;


    public var oldX:Number;
    public var oldY:Number;


    public function Person(x:Number, y:Number):void {
        super(x, y);
        createGraphic(1, 1, getColor());
        setStartSpeed();
        var p:FlxPoint = getRandomVelocity();
        velocity.x = p.x;
        velocity.y = p.y;
        _directionDuration = getRandomDuration();
    }

    public function setStartSpeed(boost:int = 1):void{
        speedBase = SPEEDBASE * boost;
        speedBump = SPEEDBUMP * boost;
    }

    protected function getColor():uint {
        return THINGCOLOR;
    }

    public function relocate():void {
        x = Math.random() * FlxG.width;
        y = Math.random() * FlxG.height;
    }

    override public function update():void {

        oldX = x;
        oldY = y;

        super.update();

        if (x < 0) {
            x = 0;
            bounce();
        }
        else if (x > FlxG.width - width) {
            x = FlxG.width - width;
            bounce();
        }

        if (y < 0) {
            y = 0;
            bounce();
        }
        else if (y > FlxG.height - height) {
            y = FlxG.height - height;
            bounce();
        }

        _directionDuration -= FlxG.elapsed;
        //trace(_directionDuration.toString());
        if (_directionDuration < 0) {
            newDirection();

        }

    }

    public function newDirection():void {
        _directionDuration = getRandomDuration();
        var p:FlxPoint = getRandomVelocity();
        velocity.x = p.x;
        velocity.y = p.y;
    }

    public function bounce():void {
        velocity.x *= -1;
        velocity.y *= -1;
    }

    private function getRandomDuration():Number {
        var v:Number = (Math.random() * 500 + 0250) / 1000.0;
        return v;
    }

    private function getRandomVelocity():FlxPoint {
        var p:FlxPoint = new FlxPoint();

        var speed:Number = 2 * (this.speedBase + Math.random() * this.speedBump) ;

        var split:Number = Math.random() * speed;

        p.x = speed - split;
        p.y = speed - p.x;

        if (p.x > this.speedMax) p.x = this.speedMax;
        if (p.y > this.speedMax) p.y = this.speedMax;

        if (Math.random() < 0.5) {
            p.x *= -1;
        }
 
        if (Math.random() < 0.5) {
            p.y *= -1;
        }
        trace("X: " + p.x + "  Y: " + p.y);
        return p;
    }

    public function get directionDuration():Number {
        return _directionDuration;
    }

    public function set directionDuration(value:Number):void {
        _directionDuration = value;
    }

    public function get speedBase():Number {
        return _speedBase;
    }

    public function get speedMax():Number{
        return SPEEDMAX;
    }

    public function set speedBase(value:Number):void {
        _speedBase = value;
    }

    public function get speedBump():Number {
        return _speedBump;
    }

    public function set speedBump(value:Number):void {
        _speedBump = value;
    }
}
}
