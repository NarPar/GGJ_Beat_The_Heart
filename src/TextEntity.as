package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class TextEntity extends Entity
	{
		public var offsetX:Number;
		public var offsetY:Number;
		public function TextEntity(text:String, xPos:Number, yPos:Number, fontSize:Number) 
		{
			x = xPos;
			y = yPos;
			graphic = new Text(text);
			Text(graphic).size = fontSize;
			offsetX = Text(graphic).width / 2;
			offsetY = Text(graphic).height / 2;
			x -= offsetX;
			y -= offsetY;
		}		
			
		public function ChangeText(s:String):void 
		{
			Text(graphic).text = s;
		}
	}
}