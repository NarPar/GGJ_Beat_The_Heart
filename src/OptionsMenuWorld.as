package  
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class OptionsMenuWorld extends MenuWorld
	{	
		private var title:TextEntity;
		private var backButton:ButtonEntity;
		private var musSlider:SliderEntity;
		private var sfxSlider:SliderEntity;
		private var controllerImage:ControllerImageEntity;
		//inputs
		private var inputs:Array = new Array();
		
		/*private var aInput:InputConfigEntity;
		private var bInput:InputConfigEntity;
		private var selectInput:InputConfigEntity;
		private var startInput:InputConfigEntity;
		private var upInput:InputConfigEntity;
		private var rightInput:InputConfigEntity;
		private var leftInput:InputConfigEntity;
		private var downInput:InputConfigEntity;*/
		
		public function OptionsMenuWorld() 
		{
			title = new TextEntity("Options", Width / 2, Height / 3 - 100, 30);
			
			// Initialize buttons at positions
			musSlider = new SliderEntity("Music", Width / 2, Height / 4);
			sfxSlider = new SliderEntity("SFX", Width / 2, Height / 4 + 75);
			
			controllerImage = new ControllerImageEntity(Width / 2, Height / 4 + 200);
			
			/*inputs.push(new InputConfigEntity(Key.A, "A", configInput.x + configInput.width / 2 - 20, configInput.y, 20));
			inputs.push(new InputConfigEntity(Key.S, "S", configInput.x + configInput.width / 2, configInput.y, 20));
			inputs.push(new InputConfigEntity(Key.SPACE, "SPACE", configInput.x - 20, configInput.y, 20));
			inputs.push(new InputConfigEntity(Key.ENTER, "ENTER", configInput.x + 20, configInput.y, 20));
			inputs.push(new InputConfigEntity(Key.UP, "UP", configInput.x - configInput.width / 2 - 20, configInput.y - 20, 20));
			inputs.push(new InputConfigEntity(Key.RIGHT, "RIGHT", configInput.x + configInput.width / 2 - 40, configInput.y, 20));
			inputs.push(new InputConfigEntity(Key.DOWN, "DOWN", configInput.x + configInput.width / 2 + 20, configInput.y + 20, 20));
			inputs.push(new InputConfigEntity(Key.LEFT, "LEFT", configInput.x + configInput.width / 2, configInput.y, 20));
			*/
			backButton = new ButtonEntity("Back", Width / 2, Height / 4 + 350);
			
			
			musSlider.isSelected = true;
			
			// Add entities
			AddEntity(title);
			AddEntity(musSlider);
			AddEntity(sfxSlider);
			AddEntity(controllerImage);
			AddEntity(backButton);
			for (var i:int = 0; i < inputs.length; i++)
				AddEntity(inputs[i]);
			
			SetTransitionOn();
		}
		
				/* Checks which button is selected, then changes FP.world
		 * to the respective world.
		 */
		override protected function HandleSelect():void
		{
			if (backButton.isSelected){
				SetTransitionOff();
			}
		}

		/* Checks which button is selected, and selects the 
		 * opposite one, since there are only 2 buttons.
		 */
		override protected function HandleNavigation(dir:int):void // 0 = up, 1 = right, 2 = down, 3 = left
		{
			if (musSlider.isSelected) {
				if (dir == 1)
					musSlider.ShiftTab(1);
				if (dir == 3)
					musSlider.ShiftTab(0);
				if (dir == 0) {
					musSlider.isSelected = false;
					backButton.isSelected = true;
				}
				if (dir == 2) {
					musSlider.isSelected = false;
					sfxSlider.isSelected = true;
				}
			} else if(sfxSlider.isSelected) {
				if (dir == 1)
					sfxSlider.ShiftTab(1);
				if (dir == 3)
					sfxSlider.ShiftTab(0);
				if (dir == 0) {
					sfxSlider.isSelected = false;
					musSlider.isSelected = true;
				}
				if (dir == 2) {
					sfxSlider.isSelected = false;
					backButton.isSelected = true;
				}
			} else if (backButton.isSelected) {
				if (dir == 0) {
					backButton.isSelected = false;
					sfxSlider.isSelected = true;//Selected(true, configInput.inputStrings.length - 1);
				}
				if (dir == 2) {
					backButton.isSelected = false;
					musSlider.isSelected = true;
				}
			} /*else if (configInput.isSelected) {
				if (dir == 0) {
					configInput.ChangeIndex(0);
					if (configInput.endoflist){
						configInput.Selected(false,-1);
						sfxSlider.isSelected = true;
					}
				}
				if (dir == 2) {
					configInput.ChangeIndex(1);
					if (configInput.endoflist) {
						configInput.Selected(false, -1);
						backButton.isSelected = true;
					}
				}
				
				backButton.isSelected = true;
			}*/
			
		}
		
		override protected function Transition():void
		{
			if (backButton.isSelected){
				FP.world = new MainMenuWorld();
			}
		}
	}
}