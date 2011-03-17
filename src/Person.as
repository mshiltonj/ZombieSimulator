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

    private static var thingColor:uint = 0xFF3333FF;
    private var _directionDuration:Number;


    public function Person(x:Number, y:Number):void {
        super(x, y);
        createGraphic(1, 1, getColor());
        var p:FlxPoint = getRandomVelocity();
        velocity.x = p.x;
        velocity.y = p.y;
        _directionDuration = getRandomDuration();
    }

    protected function getColor():uint {
        return thingColor;
    }

    public function relocate():void {
        x = Math.random() * FlxG.width;
        y = Math.random() * FlxG.height;
    }

    override public function update():void {

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
            _directionDuration = getRandomDuration();
            var p:FlxPoint = getRandomVelocity();
            velocity.x = p.x;
            velocity.y = p.y;
        }

        super.update();
    }

    private function bounce():void {
        velocity.x *= -1;
        velocity.y *= -1;
    }

    private function getRandomDuration():Number {
        var v:Number = (Math.random() * 500 + 0250) / 1000.0;
        return v;
    }

    private function getRandomVelocity():FlxPoint {
        var p:FlxPoint = new FlxPoint();
        p.x = Math.random() * 15 + 10;
        if (Math.random() < 0.5) {
            p.x *= -1;
        }

        p.y = Math.random() * 15 + 10;;
        if (Math.random() < 0.5) {
            p.y *= -1;
        }
        return p;
    }
}
}
