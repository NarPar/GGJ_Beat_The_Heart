package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class ScoreBoardPopupEntity extends Entity
	{
		[Embed(source = '../assets/transition_block.png')] private const SCOREBACK:Class;
		
		private var successText:TextEntity;
		private var scoreText:TextEntity;
		
		public function ScoreBoardPopupEntity(beathighscore:Boolean, posX:Number, posY:Number, s:Number) 
		{
			x = posX;
			y = posY;
			// Initialize graphic and size
			graphic = new Image(SCOREBACK);
			Image(graphic).centerOrigin();
			Image(graphic).scale = 500;
			//Image(graphic).alpha = .5;
			width = (Image(graphic).scaledWidth);
			height = (Image(graphic).scaledHeight);
			
			var st:String = "";
			if (beathighscore)
				st = "You beat the highscore!";
			else
				st = "Better luck next time!";
			successText = new TextEntity(st, x, y - width / 3 + 15, 22);
			scoreText = new TextEntity("Score: " + s, x, y, 22);
		}
		
		override public function render():void 
		{

			super.render();
			successText.render();
			scoreText.render();
		}
		
	}

}