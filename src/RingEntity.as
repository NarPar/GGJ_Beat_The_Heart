package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class RingEntity extends Entity
	{
		[Embed(source = '../assets/ring.png')] private const RING:Class;

		public var difficulty:Number = 3.0; // the range of seconds for each round
		public var lightCounter:int;
		public var previousTime:Number = 0;
		public var currentTime:Number = 0;
		
		private var lights:Array = new Array();
		private var progressX:Number;
		private var timer:Number;
		private var timeincrement:Number;
		private var currentColor:uint = Color.White;
		
		
		
		private var isShrinking:Boolean = false;
		private var minShrink:Number = 0;
		
		public function RingEntity(posX:Number, posY:Number, sc:Number, d:Number) 
		{
			x = posX;
			y = posY;
			graphic = new Image(RING);
			difficulty = d;
			
			Image(graphic).centerOrigin();
			for (var i:int = 300; i < 660; i+=10) {
				lights.push(new LightEntity(x + Image(graphic).scaledWidth / 2, y, x, y, i, Color.RoyalBlue));
			}
			
			Image(graphic).scale = sc;
		}
		
		override public function update():void 
		{
			if (timer > 0) {
				timer -= FP.elapsed;
			} else if (lightCounter > -1) {
				lights[lightCounter].Activate(currentColor);
				lightCounter--;
				timer = timeincrement;
			} else
				lightCounter = -2;
			
			
			/*for (var i:int = 0; i < lights.length; i++) {
				lights[i].update();
			}*/
			super.update();
		}
		
		public function SetTimer():void
		{
			for (var i:int = 0; i < lights.length; i++) {
				lights[i].isActive = false;
			}
			
			timer = FP.random * difficulty;
			previousTime = currentTime;
			currentTime = timer;
			
			if(timer < .25)
				currentColor = Color.Red;
			else if (timer >= .25 && timer < .5)
				currentColor = Color.Orange;
			else if (timer >= .5 && timer < .75)
				currentColor = Color.Yellow;
			else if ( timer >= .75 && timer < 1.0)
				currentColor = Color.GreenYellow;
			else if ( timer >= 1.0 && timer < 1.25)
				currentColor = Color.LimeGreen;
			else if ( timer >= 1.25 && timer < 1.5)
				currentColor = Color.Green;
			else if ( timer >= 1.5 && timer < 1.75)
				currentColor = Color.Teal;
			else if (timer >= 1.75 && timer < 2.0)
				currentColor = Color.RoyalBlue;
			else if (timer >= 2.0)
				currentColor = Color.Cobalt;
				
			timeincrement = timer / lights.length;
			timer = timeincrement;
			lightCounter = lights.length - 1;
		}
		
		public function LevelUp():void 
		{
			if(difficulty > .5)
				difficulty -= .5;
		}
		
		public function IsOnBeat():Boolean 
		{
			if (lightCounter == -1){
				return true;
			} else {
				return false;
			}
		}
		
		public function TurnOffLights():void
		{
			for (var i:int = 0; i < lights.length; i++) {
				lights[i].isActive = false;
			}
		}
		
		// Will return true when shrunk as small as possible
		public function Shrink(stop:Boolean, speed:Number ):Boolean 
		{
			if(!stop){
				Image(graphic).scale -= speed;
				if (Image(graphic).scale <= minShrink)
					return true;
				else
					return false;
			} else {
				Image(graphic).scale = 1;
				return false;
			}
		}
		
		override public function render():void 
		{
			super.render();
			for (var i:int = 0; i < lights.length; i++) {
				if(lights[i].isActive)
					lights[i].render();
			}
		}
		
		/*private function returnY(x:Number):Number {
			return Math.sqrt(radius * radius - (x - originX) * (x - originX)) + originY;
		}*/
		
	}

}