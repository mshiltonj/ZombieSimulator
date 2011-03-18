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
import org.flixel.FlxText;
import org.flixel.FlxU;

public class ZombieSeige1 extends FlxState {

    private static var NUM_PEOPLE:int = 3500;
    private static var NUM_BUILDINGS:int = 100;
    private var _zombies:FlxGroup;
    private var _people:FlxGroup;
    private var _buildings:FlxGroup;
    private var _firstUpdate:Boolean = true;

    private var _zombieCount:int = 0;
    private var _peopleCount:int = 0;

    private var _zombieCountTxt:FlxText;
    private var _peopleCountTxt:FlxText;

    private var _zombieCountHeaderTxt:FlxText;
    private var _peopleCountHeaderTxt:FlxText;

    public function ZombieSeige1() {
        bgColor = 0xFF000000;
        var idx:int = 0;


        _zombies = new FlxGroup();
        _people = new FlxGroup();
        _buildings = new FlxGroup();

        add(_buildings);
        add(_zombies);
        add(_people);

        for (idx = 0; idx < NUM_BUILDINGS; idx++) {
            var b:Building = new Building();
            _buildings.add(b);
        }


        var pX:int;
        var pY:int;

        var point:FlxPoint;

        for (idx = 0; idx < NUM_PEOPLE; idx++) {
            point = new FlxPoint(Math.random() * FlxG.width, Math.random() * FlxG.height);

            while (inABuilding(point)) {
                point.x = Math.random() * FlxG.width;
                point.y = Math.random() * FlxG.height;
            }

            var p:Person = new Person(point.x, point.y);
            _peopleCount++;
            _people.add(p);
        }


        point = new FlxPoint(Math.random() * FlxG.width, Math.random() * FlxG.height);

        while (inABuilding(point)) {
            point.x = Math.random() * FlxG.width;
            point.y = Math.random() * FlxG.height;
        }

        var zombie:Zombie = new Zombie(point.x, point.y);

        _zombieCount++;
        _zombies.add(zombie);

        _zombieCountTxt = new FlxText(60, 10, 50, _zombieCount.toString());
        _peopleCountTxt = new FlxText(60, 25, 60, _peopleCount.toString());

        _zombieCountHeaderTxt = new FlxText(10, 10, 50, "Zombies:");
        _peopleCountHeaderTxt = new FlxText(10, 25, 50, "People: ");

        add(_zombieCountHeaderTxt);
        add(_peopleCountHeaderTxt);

        add(_zombieCountTxt);
        add(_peopleCountTxt);

    }

    private function inABuilding(point:FlxPoint):Boolean {


        for (var idx:int = 0; idx < _buildings.members.length; idx++) {
            var b:Building = _buildings.members[idx];
            if (b.overlapsPoint(point.x, point.y)) {
                return true;
            }
        }

        return false;
    }

    override public function update():void {
        super.update();
        FlxU.overlap(_zombies, _people, overlapZombiesPeople);
        FlxU.overlap(_zombies, _buildings, overlapPeopleBuildings);
        FlxU.overlap(_people, _buildings, overlapPeopleBuildings);

        _zombieCountTxt.text = _zombieCount.toString();
        _peopleCountTxt.text = _peopleCount.toString();


    }


    private function overlapPeopleBuildings(p:Person, b:Building):void {
        p.x = p.oldX;
        p.y = p.oldY;

        p.newDirection();



    }

    private function overlapZombiesPeople(zombie:Zombie, person:Person):void {
        var z:Zombie = new Zombie(person.x, person.y);
        person.kill();
        _peopleCount--;
        _zombies.add(z);
        _zombieCount++;
    }
}
}
