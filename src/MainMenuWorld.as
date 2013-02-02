package  
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class MainMenuWorld extends MenuWorld
	{	
		// Keep track of entities so we can move them in transitions
		// and handle button selection
		private var title:TextEntity;
		private var playButton:ButtonEntity;
		private var optionsButton:ButtonEntity;
		
		private var transitionBlock:TransitionBlock;
		
		public function MainMenuWorld()
		{
			// Initialize title
			title = new TextEntity("The Limit of Arrhythmia", Width / 2, Height / 3 - 100, 30);
			
			// Initialize buttons at positions
			playButton = new ButtonEntity("Play", Width / 2, Height / 2);
			optionsButton = new ButtonEntity("Options", Width / 2, Height / 2 + 100);
			transitionBlock = new TransitionBlock(0, 0, Width, 3);
			
			playButton.isSelected = true; // start with playButton selected
			
			// Add entities
			AddEntity(title);
			AddEntity(playButton);
			//AddEntity(optionsButton);
			add(transitionBlock);
			
			SetTransitionOn();
		}	
		override public function update():void 
		{
			transitionBlock.update();
			super.update();
			if (transitionState == 3 && transitionBlock.state == 2)
				Transition();
		}
		/* Checks which button is selected, then changes FP.world
		 * to the respective world.
		 */
		override protected function HandleSelect():void
		{
			if (playButton.isSelected) {
				transitionBlock.SetState(0);
				transitionState = 3;
			} else if (optionsButton.isSelected) {
				SetTransitionOff();
			}
	
		}
		/* Checks which button is selected, and selects the 
		 * opposite one, since there are only 2 buttons.
		 */
		override protected function HandleNavigation(dir:int):void
		{
			/*if (playButton.isSelected){
				optionsButton.isSelected = true;
				playButton.isSelected = false;
			} else {
				playButton.isSelected = true;
				optionsButton.isSelected = false;
			}*/
		}
		override protected function Transition():void
		{
			if (playButton.isSelected) {
				trace("transitioned to game!");
				FP.world = new GameWorld();
			} else {
				FP.world = new OptionsMenuWorld();
			}
		}
	}
}