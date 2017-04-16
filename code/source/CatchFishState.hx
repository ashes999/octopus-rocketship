package;

import flixel.FlxG;
import flixel.math.FlxRandom;

import turbo.Config;
import turbo.ecs.TurboState;
import turbo.ecs.Entity;
import turbo.ecs.components.ColourComponent;
import turbo.ecs.components.PositionComponent;

class CatchFishState extends TurboState
{
	private static inline var NUM_FISH:Int = 5;

	private var random = new FlxRandom();
	private var width = Std.int(FlxG.stage.stageWidth);
	private var height = Std.int(FlxG.stage.stageHeight);
	private var allFish = new Array<Entity>();

	override public function create():Void
	{
		super.create();

		var octopus = new Entity().colour(255, 0, 0).size(64, 64).moveWithKeyboard(250);
		octopus.onEveryFrame(function()
		{
			var pos = octopus.get(PositionComponent);					
			var target = this.getClosestFishTo(pos);
			if (cast(target.getData("distance"), Float) < cast(Config.get("tentacleDistance"), Float))
			{
				// temporarily "kill" it
				if (target.get(ColourComponent).sprite.alpha > 0)
				{
					trace('Latch target d=${target.getData("distance")}');									
					// instagib
					var targetPos = target.get(PositionComponent);
					var length = Std.int(Math.sqrt(Math.pow(targetPos.x - pos.x, 2) + Math.pow(targetPos.y - pos.y, 2)));
					
					/*
					var tentacle = new Entity().colour(255, 0, 0).size(length, 4).move(pos.x + 32, pos.y + 32);
					// sine law: sin(90) / diagonal = sin(angle) / height
					// height/diagonal = sin(angle)
					// sin-1(height / diagonal)
					// angle in radians
					var angle = Math.asin((targetPos.y - pos.y) / length);
					var degrees = angle * 180 / Math.PI;
					tentacle.get(ColourComponent).sprite.angle = degrees;
					*/

					target.get(ColourComponent).sprite.alpha = 0; // "die"
				}
			}
		});

		this.entities.push(octopus);

		for (i in 0...NUM_FISH)
		{
			var fish = new Entity().colour(255, 128, 255).size(70, 32);
			var x = random.int(0, this.width);
			var y = random.int(0, this.height);

			fish.move(x, y);

			var vx = random.int(65, 125) * (x >= width/2 ? -1 : 1);
			var vy = random.int(50, 100) * (y >= height/2 ? -1 : 1);
			fish.velocity(vx, vy);

			this.entities.push(fish);
			this.allFish.push(fish);
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	private function getClosestFishTo(point:PositionComponent):Entity
	{
		var distance:Float = -1;
		var target:Entity = this.allFish[0];

		for (fish in this.allFish)
		{
			var p = fish.get(PositionComponent);
			var d = Math.pow(point.x - p.x, 2) + Math.pow(point.y - p.y, 2);
			if (distance == -1 || d < distance)
			{
				distance = d;
				target = fish;
				fish.setData("distance", distance);
			}
		}

		return target;
	}
}
