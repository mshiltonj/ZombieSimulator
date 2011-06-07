/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 3/15/11
 * Time: 6:57 AM
 * To change this template use File | Settings | File Templates.
 */
package {
//import mx.utils.object_proxy;

import org.flixel.FlxG;
//import org.flixel.FlxGame;
import org.flixel.FlxGroup;
//import org.flixel.FlxObject;
import org.flixel.FlxPoint;
//import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxU;
//import org.flixel.data.FlxAnim;

public class ZombieSeige1 extends FlxState {

    private static var NUM_PEOPLE_START:int = 2500;
    private static var NUM_ZOMBIES_START:int = 1;
    private static var NUM_BUILDINGS:int = 100;
    private static var ZOMBIE_COUNT_LABEL:String = "Zombies:";
    private static var PEOPLE_COUNT_LABEL:String = "People:";
    private static var TIME_COUNT_LABEL:String = "Time: ";

    private var _zombies:FlxGroup;
    private var _people:FlxGroup;
    private var _buildings:FlxGroup;
    private var _packs:Array;

    private var _zombieCount:int = 0;
    private var _peopleCount:int = 0;
    private var _timeCount:Number = 0;

    private var _zombieCountTxt:FlxText;
    private var _peopleCountTxt:FlxText;
    private var _timeCountTxt:FlxText;

    private var _zombieCountHeaderTxt:FlxText;
    private var _peopleCountHeaderTxt:FlxText;
    private var _timeCountHeaderTxt:FlxText;

    override public function create():void {
        init();
    }

    private function init():void {
        initBuildings();
        initPacks();
        initZombies();
        initPeople();
        initLevel();
    }

    /* Add buildings to map.*/
    private function initBuildings():void {
        var idx:int = 0;
        _buildings = new FlxGroup();
        add(_buildings);

        for (idx = 0; idx < NUM_BUILDINGS; idx++) {
            var b:Building = new Building();
            _buildings.add(b);
        }
    }

    /* Add zombie packs to map. Empty to start */
    private function initPacks():void {
        _packs = new Array(); // no packs at start;
    }

    /* Add zombies to map. We start with one */
    private function initZombies():void {
        var idx:int = 0;
        _zombies = new FlxGroup(); // zombies not in a pack;
        add(_zombies);
        var point:FlxPoint;

        for (idx = 0; idx < NUM_ZOMBIES_START; idx++) {
            point = randomPointNotInABuilding();
            var z:Zombie = new Zombie(point.x, point.y);
            z.group = _zombies;
            _zombieCount++;
            _zombies.add(z);
        }
    }

    private function initPeople():void {
        var idx:int = 0;
        _people = new FlxGroup();
        add(_people);
        var point:FlxPoint;
        for (idx = 0; idx < NUM_PEOPLE_START; idx++) {
            point = randomPointNotInABuilding();
            var p:Person = new Person(point.x, point.y);
            _peopleCount++;
            _people.add(p);
        }
    }

    private function initLevel():void {
        bgColor = 0xFF000000;

        _timeCountTxt = new FlxText(60, 10, 60, _timeCount.toFixed(0));
        _zombieCountTxt = new FlxText(60, 25, 50, _zombieCount.toString());
        _peopleCountTxt = new FlxText(60, 40, 60, _peopleCount.toString());


        _timeCountHeaderTxt = new FlxText(10, 10, 50, TIME_COUNT_LABEL);
        _zombieCountHeaderTxt = new FlxText(10, 25, 50, ZOMBIE_COUNT_LABEL);
        _peopleCountHeaderTxt = new FlxText(10, 40, 50, PEOPLE_COUNT_LABEL);


        add(_zombieCountHeaderTxt);
        add(_peopleCountHeaderTxt);
        add(_timeCountHeaderTxt);

        add(_zombieCountTxt);
        add(_peopleCountTxt);
        add(_timeCountTxt);
    }

    private function randomPointNotInABuilding():FlxPoint {
        var point:FlxPoint = new FlxPoint(Math.random() * FlxG.width, Math.random() * FlxG.height);
        while (inABuilding(point)) {
            point.x = Math.random() * FlxG.width;
            point.y = Math.random() * FlxG.height;
        }
        return point;
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


        if (FlxG.keys.R){
           FlxG.state = new ZombieSeige1();
        }
        else if(FlxG.keys.Q){
           FlxG.state = new IntroScreen();
        }


        FlxU.overlap(_zombies, _people, overlapZombiesPeople);
        //   FlxU.overlap(_zombies, _zombies, overlapZombiesZombies);
        FlxU.overlap(_zombies, _buildings, overlapPeopleBuildings);
        FlxU.overlap(_people, _buildings, overlapPeopleBuildings);


        var idx:int = 0;
        var pack:ZombiePack;

        for (idx = 0; idx < _packs.length; idx++) {
            pack = _packs[idx];
            //    FlxU.overlap(pack, _people, overlapZombiesPeople);
        }

        /*
         for (idx = 0; idx < _packs.length; idx++) {
         pack = _packs[idx];
         proximity(20, _zombies, pack, overlapZombiesZombies);
         }*/

        _zombieCountTxt.text = _zombieCount.toString();
        _peopleCountTxt.text = _peopleCount.toString();

        _timeCount += FlxG.elapsed;
        _timeCountTxt.text = _timeCount.toFixed(0);
    }


    // neither of these zombies are in a pack;
    private function overlapZombiesZombies(z1:Zombie, z2:Zombie):void {
        var pack:ZombiePack;
        if (z1.speedBase < 3.0 && z2.speedBase < 3.0) {
            pack = new ZombiePack(z1.x, z1.y);
            pack.add(z1);
            pack.add(z2);

            z1.group.remove(z1);
            z2.group.remove(z2);
            z1.group = pack;
            z2.group = pack;

            _packs.add(pack);
        }
    }


    private function overlapPeopleBuildings(p:Person, b:Building):void {
        p.x = p.oldX;
        p.y = p.oldY;
        p.newDirection();

    }

    private function overlapZombiesPeople(zombie:Zombie, person:Person):void {
        var z:Zombie = new Zombie(person.x, person.y);
        zombie.setStartSpeed(2);
        z.setStartSpeed(2);

//        // once a zombie hits a human, they are free agents again.
//        if (zombie.group != _zombies) {
//            zombie.group.remove(zombie);
//            zombie.group = _zombies;
//            zombie.group.add(zombie)
//
//        }

        person.kill();
        _peopleCount--;
        _zombies.add(z);
        _zombieCount++;
    }
}
}
