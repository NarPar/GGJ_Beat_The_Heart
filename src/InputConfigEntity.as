package  
{
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class InputConfigEntity extends MenuEntity
	{
		public var keyBinding:Key;
		
		public var offsetX:Number;
		public var offsetY:Number;
		
		
		private var selectEffect:SelectEffectEntity;
		
		
		public function InputConfigEntity(inputkey:Key, text:String, xPos:Number, yPos:Number, fontSize:Number) 
		{
			// initialize text graphic
			graphic = new Text(text);
			Text(graphic).size = fontSize;
			offsetX = Text(graphic).width / 2;
			offsetY = Text(graphic).height / 2;
			x -= offsetX;
			y -= offsetY;
			
			//
			keyBinding = inputkey;
			selectEffect = new SelectEffectEntity(xPos, yPos, .5);
		}
		
		override public function update():void
		{
			if(isSelected)
				selectEffect.update();
			
			selectEffect.x = x;
			selectEffect.y = y;
		}
		
		override public function HandleInput():void
		{
			if (isSelected) {
				var k:Key = Input.lastKey;
				//if(k != nu
			}
		}
		
		override public function render():void
		{
			if (isSelected)
				selectEffect.render();
			
			super.render();
		}
		
	}

}