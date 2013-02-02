package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class ConfigureInputEntity extends Entity
	{
		public var inputStrings:Array = new Array();
		public var isSelected:Boolean = false;
		public var selectIndex:int = 0;
		public var endoflist:Boolean = false;
		
		private var keyBindings:Array = new Array();
		
		
		public function ConfigureInputEntity(xPos:Number, yPos:Number) 
		{
			x = xPos;
			y = yPos;
			
			var fontSize:int = 20;
			
			inputStrings.push(new InputTextEntity("A", xPos, yPos, fontSize)); // A button
			inputStrings.push(new InputTextEntity("S", xPos, yPos, fontSize)); // B button
			inputStrings.push(new InputTextEntity("Space", xPos, yPos, fontSize)); // Select Button
			inputStrings.push(new InputTextEntity("Enter", xPos, yPos, fontSize)); // Start Button
			inputStrings.push(new InputTextEntity("Up", xPos, yPos, fontSize)); // Up
			inputStrings.push(new InputTextEntity("Right", xPos, yPos, fontSize)); // Right
			inputStrings.push(new InputTextEntity("Left", xPos, yPos, fontSize)); // Down
			inputStrings.push(new InputTextEntity("Down", xPos, yPos, fontSize)); // Left
			
			
			keyBindings.push(Key.A);
			keyBindings.push(Key.S);
			keyBindings.push(Key.SPACE);
			keyBindings.push(Key.ENTER);
			keyBindings.push(Key.UP);
			keyBindings.push(Key.RIGHT);
			keyBindings.push(Key.DOWN);
			keyBindings.push(Key.LEFT);
			
			// Initialize graphic and size
			graphic = new Image(NESCONTROLLER);
			Image(graphic).scaleX = 1.5;
			Image(graphic).scaleY = 1.5;
			Image(graphic).centerOrigin(); 
			width = (Image(graphic).scaledWidth);
			height = (Image(graphic).scaledHeight);
		}
		
		override public function update():void
		{
			for (var i:int = 0; i < inputStrings.length; i++) {
				inputStrings[i].update();
			}
		}
		
		public function Selected(on:Boolean, index:int) {
			if (on) {
				isSelected = true;
				endoflist = false;
				selectIndex = index;
				inputStrings[selectIndex].isSelected = true;
			} else {
				isSelected = false;
				endoflist = false;
				inputStrings[selectIndex].isSelected = false;
			}
		}
		
		public function ChangeIndex(dir:int):void {
			if (dir == 0) {
				inputStrings[selectIndex].isSelected = false;
				selectIndex--;
				if (selectIndex < 0) {
					endoflist = true;
					selectIndex++;
				} else {
					inputStrings[selectIndex].isSelected = true;
				}
			} else if (dir == 1) {
				inputStrings[selectIndex].isSelected = false;
				selectIndex++;
				if (selectIndex >= inputStrings.length) {
					endoflist = true;
					selectIndex--;
				} else {
					inputStrings[selectIndex].isSelected = true;
				}
			}
		}
		
		override public function render():void
		{
			super.render();
			
			for (var i:int = 0; i < inputStrings.length; i++) {
				inputStrings[i].render();
			}
		}
		
	}

}