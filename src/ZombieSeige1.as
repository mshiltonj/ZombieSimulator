/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 3/15/11
 * Time: 6:57 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxPoint;
import org.flixel.FlxState;
import org.flixel.FlxU;

public class ZombieSeige1 extends FlxState {

    private static var NUM_PEOPLE:int = 2500;
    private static var NUM_BUILDINGS:int = 100;
    private var _zombies:FlxGroup;
    private var _people:FlxGroup;
    private var _buildings:FlxGroup;
    private var _firstUpdate:Boolean = true;

    public function ZombieSeige1() {
        bgColor = 0xFF000000;
        var idx:int = 0;


        _zombies = new FlxGroup();
        _people = new FlxGroup();
        _buildings = new FlxGroup();

        add(_zombies);
        add(_people);
        add(_buildings);

        for (idx = 0; idx < NUM_BUILDINGS; idx++) {
            var b:Building = new Building();
            _buildings.add(b);
        }


        var pX:int;
        var pY:int;
        for (idx = 0; idx < NUM_PEOPLE; idx++) {
            var point = new FlxPoint(Math.random() * FlxG.width, Math.random() * FlxG.height);

            while (inABuilding(point)) {
                point.x = Math.random() * FlxG.width;
                point.y = Math.random() * FlxG.height;
            }

            var p:Person = new Person(point.x, point.y);
            _people.add(p);
        }


        var zombie:Zombie = new Zombie(Math.random() * FlxG.width, Math.random() * FlxG.height);
        _zombies.add(zombie);


    }

    private function inABuilding(point:FlxPoint):Boolean {


        for (var idx = 0; idx < _buildings.members.length; idx++) {
            var b:Building = _buildings.members[idx];
            if (b.overlapsPoint(point.x, point.y)){
                return true;
            }
        }


        return false;
    }

    override public function update():void {
        FlxU.overlap(_zombies, _people, overlapZombiesPeople);
        FlxU.overlap(_zombies, _buildings, overlapPeopleBuildings);
        FlxU.overlap(_people, _buildings, overlapPeopleBuildings);


        super.update();
    }

//    private function cleanupCreate():void {
//        _firstUpdate = false;
//        FlxU.overlap(_people, _buildings, overlapPersonBuilding);
//        FlxU.overlap(_zombies, _buildings, overlapPersonBuilding);
//    }
//
    private function overlapPeopleBuildings(p:Person, b:Building):void {
        p.velocity.x *= -1;
        p.velocity.y *= -1;
    }

    private function overlapZombiesPeople(zombie:Zombie, person:Person):void {
        var z:Zombie = new Zombie(person.x, person.y);
        person.kill();
        _zombies.add(z);
    }
}
}
