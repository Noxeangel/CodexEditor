package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import fl.controls.UIScrollBar;
	
	public class MainWindow extends MovieClip {
		
		public var inputField_txt:TextField;
		
		public var load_btn:LoadBTN;
		public var edit_btn:EditButtonBTN;
		public var quit_btn:QuitBTN
		
		public var levels_btn:LevelBTN;
		public var archetypes_btn:ArchetypeBTN;
		public var items_btn:ItemBTN
		public var skills_btn:SkillBTN;
		public var enemies_btn:EnemyBTN;
		
		public var scroller_sclr:CustomScrollerMC;
		
		public function MainWindow() {
			// constructor code
		}
	}
	
}
