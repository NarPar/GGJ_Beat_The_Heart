package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class ControllerImageEntity extends Entity
	{
		[Embed(source = '../assets/nes-joystick.png')] private const NESCONTROLLER:Class;
		
		public function ControllerImageEntity(xPos:Number, yPos:Number) 
		{
			x = xPos;
			y = yPos;
			
			// Initialize graphic and size
			graphic = new Image(NESCONTROLLER);
			Image(graphic).scaleX = 1.5;
			Image(graphic).scaleY = 1.5;
			Image(graphic).centerOrigin(); 
			width = (Image(graphic).scaledWidth);
			height = (Image(graphic).scaledHeight);
		}
		
	}

}