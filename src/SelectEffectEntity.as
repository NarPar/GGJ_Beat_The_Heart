package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class SelectEffectEntity extends Entity
	{
		[Embed(source = '../assets/button.png')] private const SELECT:Class;
		
		// Variables for pulsation effect
		private var alpha = .5;
		private var pulseFactor = .02;
		
		public function SelectEffectEntity(xPos:Number, yPos:Number, effectScale:Number) 
		{
			graphic = new Image(SELECT);
			Image(graphic).scale = effectScale;
			Image(graphic).centerOrigin(); 
			Image(graphic).alpha = alpha;
			x = xPos;
			y = yPos;
		}
		
		override public function update():void
		{
			// Oscillate the alpha factor to make pulsating effect
			alpha += pulseFactor;
			if (alpha > .8)
				pulseFactor *= -1;
			
			if (alpha < .2)
				pulseFactor *= -1;
				
			Image(graphic).alpha = alpha;
		}
		
	}

}