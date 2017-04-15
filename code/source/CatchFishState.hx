package;

import flixel.FlxG;
import turbo.ecs.TurboState;
import turbo.ecs.Entity;

class CatchFishState extends TurboState
{
	override public function create():Void
	{
		super.create();

		var octopus = new Entity().colour(255, 0, 0).size(64, 64).moveWithKeyboard(250);
		this.entities.push(octopus);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
