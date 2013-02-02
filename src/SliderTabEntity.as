package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class SliderTabEntity extends Entity
	{
		[Embed(source = '../assets/button.png')] private const BUTTON:Class;
		
		public var isSelected:Boolean = false;
		
		public function SliderTabEntity(xPos:Number, yPos:Number) 
		{
			x = xPos;
			y = yPos;
			
			// Initialize graphic and size
			graphic = new Image(BUTTON);
			Image(graphic).scaleX = .1;
			Image(graphic).scaleY = 1;
			Image(graphic).centerOrigin(); 
			width = (Image(graphic).scaledWidth);
			height = (Image(graphic).scaledHeight);
		}	
		
		
	}
}