package 
{
	import codex.items.Accessory;
	import codex.items.Armor;
	import codex.items.Consumable;
	import codex.items.Inventory;
	import codex.items.Item;
	import codex.items.Weapon;
	import codex.Level;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.fscommand;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Olivier
	 */
	public class Main extends Sprite 
	{
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Global XML Files that store the datas
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static var ItemXMLFile:XML;
		private const ITEM_XML_FILE_PATH:String = "../src/assets/data/XML/Item.xml";
		private var itemFR:FileReference = new FileReference();
		
		public static var LevelsXMLFile:XML;
		private const LEVELS_XML_FILE_PATH:String = "../src/assets/data/XML/Levels.xml"; //Path of the xml file which contains the data of the levels		
		private var levelsFR:FileReference = new FileReference();
		
		public static var ArchetypeXMLFile:XML;
		private const ARCHETYPE_XML_FILE_PATH:String = "../src/assets/data/XML/Archetypes.xml"; //Path of the xml file which contains the data of the archetypes
		private var archetypeFR:FileReference = new FileReference();
		
		public static var SkillXMLFile:XML
		private const SKILLS_XML_FILE_PATH:String = "../src/assets/data/XML/Skills.xml"; //Path to the xml file which contains the data of the skills
		private var skillFR:FileReference = new FileReference();
		
		public static var EnemyXMLFile:XML
		private const ENEMIES_XML_FILE_PATH:String = "../src/assets/data/XML/Enemies.xml"; //Path to the xml file which contains the data of the enemies
		private var enemyFR:FileReference = new FileReference();
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Data Arrays
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var ItemArray:Inventory = new Inventory();
		public var LevelArray:Array = new Array();
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Variables
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _view:MainWindow = new MainWindow();
		private var _mask:Shape;
		
		private var _items_mc:MovieClip = new MovieClip();
		private var _items_displayers:Array = new Array();
		private var _isItemsDisplayed:Boolean = new Boolean();
		
		private var _levels_mc:MovieClip = new MovieClip();
		private var _levels_displayers:Array = new Array();
		private var _isLevelsDisplayed:Boolean = new Boolean();
		
		private var _scrollerStep:Number = 1;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// config stage
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.quality = StageQuality.LOW;
			stage.stageFocusRect = false;
			stage.tabChildren = false;
			
			beginLoad();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Begin Of loading Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function beginLoad():void
		{
			selectItemFile();
		}
		
		
		private function selectItemFile():void
		{
			itemFR = new FileReference();
			itemFR.addEventListener(Event.SELECT, _onItemFileSelected);
			var fileFilter:FileFilter = new FileFilter("XML File: (*.xml)", "Item.xml");
			
			itemFR.browse([fileFilter]);
		}
		
		private function _onItemFileSelected(e:Event):void 
		{
			itemFR.removeEventListener(Event.SELECT, _onItemFileSelected);
			itemFR.addEventListener(Event.COMPLETE, _onItemXMLLoaded);
			itemFR.load();
		}
		
		private function _onItemXMLLoaded(e:Event):void 
		{
			//trace(itemFR.data);
			
			ItemXMLFile = new XML(itemFR.data.readUTFBytes(itemFR.data.length));
			selectLevelFile();
		}
		
		private function selectLevelFile():void
		{
			levelsFR = new FileReference();
			levelsFR.addEventListener(Event.SELECT, _onLevelFileSelected);
			var fileFilter:FileFilter = new FileFilter("XML File: (*.xml)", "Levels.xml");
			levelsFR.browse([fileFilter]);
		}
		
		private function _onLevelFileSelected(e:Event):void 
		{
			levelsFR.removeEventListener(Event.SELECT, _onLevelFileSelected);
			levelsFR.addEventListener(Event.COMPLETE, _onLevelXMLLoaded);
			levelsFR.load();
		}
		
		private function _onLevelXMLLoaded(e:Event):void 
		{
			LevelsXMLFile = new XML(levelsFR.data.readUTFBytes(levelsFR.data.length));
			selectArchFile();
		}
		
		private function selectArchFile():void
		{
			archetypeFR = new FileReference();
			archetypeFR.addEventListener(Event.SELECT, _onArchFileSelected);
			var fileFilter:FileFilter = new FileFilter("XML File: (*.xml)", "Archetypes.xml");
			archetypeFR.browse([fileFilter]);
		}
		
		private function _onArchFileSelected(e:Event):void 
		{
			archetypeFR.removeEventListener(Event.SELECT, _onArchFileSelected);
			archetypeFR.addEventListener(Event.COMPLETE, _onArchXMLLoaded);
			archetypeFR.load();
		}
		
		private function _onArchXMLLoaded(e:Event):void 
		{
			ArchetypeXMLFile = new XML(archetypeFR.data.readUTFBytes(archetypeFR.data.length));
			selectSkillFile();
		}
		
		private function selectSkillFile():void
		{
			skillFR = new FileReference();
			skillFR.addEventListener(Event.SELECT, _onSkillFileSelected);
			var fileFilter:FileFilter = new FileFilter("XML File: (*.xml)", "Skills.xml");
			skillFR.browse([fileFilter]);
		}
		
		private function _onSkillFileSelected(e:Event):void 
		{
			skillFR.removeEventListener(Event.SELECT, _onSkillFileSelected);
			skillFR.addEventListener(Event.COMPLETE, _onSkillXMLLoaded);
			skillFR.load();
		}
		
		private function _onSkillXMLLoaded(e:Event):void 
		{
			SkillXMLFile = new XML(skillFR.data.readUTFBytes(skillFR.data.length));
			//skillFR.save(SkillXMLFile, "Skills-backup.xml");
			selectEnemyFile();
		}
		
		private function selectEnemyFile():void
		{
			enemyFR = new FileReference();
			enemyFR.addEventListener(Event.SELECT, _onEnemyFileSelected);
			var fileFilter:FileFilter = new FileFilter("XML File: (*.xml)", "Enemies.xml");
			enemyFR.browse([fileFilter]);
		}
		
		private function _onEnemyFileSelected(e:Event):void 
		{
			enemyFR.removeEventListener(Event.SELECT, _onEnemyFileSelected);
			enemyFR.addEventListener(Event.COMPLETE, _onEnemyXMLLoaded);
			enemyFR.load();
		}
		
		private function _onEnemyXMLLoaded(e:Event):void 
		{
			EnemyXMLFile = new XML(enemyFR.data.readUTFBytes(enemyFR.data.length));
			//enemyFR.save(EnemyXMLFile, "Enemies-backup.xml");
			onLoadComplete();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				End Of loading Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				On loading Complete Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function onLoadComplete():void
		{
			processItemXML();
			
			_mask = new Shape();
			with (_mask.graphics)
			{
				beginFill(0xFFFFFF, 1);
				drawRect(26,140,698,498);
				endFill();
			}

			addChild(_view);
			_view.addEventListener(MouseEvent.CLICK, _onClicked);
			_view.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
		}
		
		
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Event Handlers
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function _onClicked(e:MouseEvent):void 
		{
			switch(e.target)
			{
				case _view.quit_btn:
					trace("done");
					
					fscommand("quit");
					break;
				case _view.load_btn:
					trace("loaded");
					break;
				case _view.edit_btn:
					trace ("Edit");
					
					ResetItems();
					writeItemXML();
					
					break;
				case _view.items_btn:
					ShowItems();
					break;
					
				
			}
		}
		private function _onMouseDown(e:MouseEvent):void 
		{
			switch(e.target)
			{
				case _view.scroller_sclr.downArrow:
					ScrollerDown();
					break;
				case _view.scroller_sclr.upArrow:
					ScrollerUp();
					break;		
			}
		}
		private function ScrollerUp():void 
		{
			if (_view.scroller_sclr.cursor.y >  15)
			{
				_view.scroller_sclr.cursor.y -= _scrollerStep;
				_items_mc.y += 100;
			}

		}
		
		private function ScrollerDown():void 
		{
			if (_view.scroller_sclr.cursor.y <  _view.scroller_sclr.height - 30 - _view.scroller_sclr.cursor.height)
			{
				_view.scroller_sclr.cursor.y += _scrollerStep;
				_items_mc.y -= 100;
			}
		}
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Display Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function ResetItems():void
		{
			//Call Displayer to Item Here
			var tmpInventory:Inventory = new Inventory();
			for each( var displayer:ItemDisplayerMC in _items_displayers)
			{
				switch(displayer.type_lst.selectedIndex)
				{
					case CONSUMABLE:
						tmpInventory.consumables.push( DisplayerToItem(displayer, Consumable));
						break;
					case WEAPON:
						tmpInventory.weapons.push( DisplayerToItem(displayer, Weapon));
						break;
					case ARMOR:
						tmpInventory.armors.push( DisplayerToItem(displayer, Armor));
						break;
					case ACCESSORY:
						tmpInventory.accesories.push( DisplayerToItem(displayer, Accessory));
						break;
				}
			}
			
			ItemArray = tmpInventory;
			
			while (_items_mc.numChildren) _items_mc.removeChildAt(0);
			_view.scroller_sclr.cursor.y = 15;
			_scrollerStep = 0;
			_view.removeChild(_items_mc);
		}
		
		public function ShowItems():void
		{

			_items_mc.x = 25;
			_items_mc.y = 139;
			
			for each( var c:Consumable in  ItemArray.consumables)
			{
				_items_displayers.push(ItemToDisplayer(c));
			}
			for each( var w:Weapon in  ItemArray.weapons)
			{
				_items_displayers.push(ItemToDisplayer(w));
			}
			for each( var a:Armor in  ItemArray.armors)
			{
				_items_displayers.push(ItemToDisplayer(a));
			}
			for each( var ac:Accessory in  ItemArray.accesories)
			{
				_items_displayers.push(ItemToDisplayer(ac));
			}
			
			for (var i:int = 0; i < _items_displayers.length; i++)
			{
				_items_displayers[i].x = 30;
				_items_displayers[i].y = (100) * i ;
				_items_mc.addChild(_items_displayers[i]);
			}
			
			_items_mc.mask = _mask;
			_view.addChild(_items_mc);
			
			_scrollerStep =  (_view.scroller_sclr.height - 30 - _view.scroller_sclr.cursor.height) / _items_displayers.length;
		}
		
		private function ItemToDisplayer(i:Item):ItemDisplayerMC
		{
			var tmpItemDisplayer:ItemDisplayerMC = new ItemDisplayerMC();
			tmpItemDisplayer.nameField_txt.text = i.name;
			tmpItemDisplayer.idField_txt.text = i.id;
			
			tmpItemDisplayer.life_txt.text  = i.vitalMods[LIFE];
			tmpItemDisplayer.mana_txt.text  = i.vitalMods[MANA];
			
			tmpItemDisplayer.str_txt.text = i.statMods[STRENGTH];
			tmpItemDisplayer.con_txt.text = i.statMods[CONSTITUTION];
			tmpItemDisplayer.wil_txt.text = i.statMods[WILLPOWER];
			tmpItemDisplayer.int_txt.text = i.statMods[INTELLIGENCE];
			tmpItemDisplayer.cha_txt.text = i.statMods[CHARISMA];

			tmpItemDisplayer.className_txt.text = i.viewName;
			
			switch( getDefinitionByName(getQualifiedClassName(i)) as Class )
			{
				case (Consumable):
					tmpItemDisplayer.type_lst.selectedIndex = CONSUMABLE;
					break;
				case ( Weapon):
					tmpItemDisplayer.type_lst.selectedIndex = WEAPON;
					break;
				case ( Armor):
					tmpItemDisplayer.type_lst.selectedIndex = ARMOR;
					break;
				case ( Accessory):
					tmpItemDisplayer.type_lst.selectedIndex = ACCESSORY;
					break;	
			}
			
			return(tmpItemDisplayer);
		}
		
		private function DisplayerToItem(displayer:ItemDisplayerMC , c:Class):Item
		{
			var tmpItem:Item = new c();
			
			tmpItem.id = displayer.idField_txt.text;
			tmpItem.name = displayer.nameField_txt.text;
			
			tmpItem.vitalMods = new Array( int(displayer.life_txt.text), int(displayer.mana_txt.text));
			
			tmpItem.statMods = new Array( int(displayer.str_txt.text), int(displayer.con_txt.text), int(displayer.wil_txt.text), int(displayer.int_txt.text), int(displayer.cha_txt.text) );
			tmpItem.viewName = displayer.className_txt.text;
			
			return  tmpItem;
		}
		
		private function ItemToXML(i:Item):XML
		{
			var tmpXml:XML;
			
			switch( getDefinitionByName(getQualifiedClassName(i)) as Class )
			{
				case (Consumable):
					tmpXml = new XML(<CONSUMABLE> </CONSUMABLE>);
					break;
				case ( Weapon):
					tmpXml = new XML(<WEAPON> </WEAPON>);
					break;
				case ( Armor):
					tmpXml = new XML(<ARMOR> </ARMOR>);
					break;
				case ( Accessory):
					tmpXml = new XML(<ACCESSORY> </ACCESSORY>);
					break;	
			}
			tmpXml.@id = i.id;
			tmpXml.NAME = i.name;
			tmpXml.RESERVED = "ALL";
			tmpXml.LIFE = i.vitalMods[LIFE].toString();
			tmpXml.MANA = i.vitalMods[MANA].toString();
			
			tmpXml.STR = i.statMods[STRENGTH].toString();
			tmpXml.CON = i.statMods[CONSTITUTION].toString();
			tmpXml.WIL = i.statMods[WILLPOWER].toString();
			tmpXml.INT = i.statMods[INTELLIGENCE].toString();
			tmpXml.CHA = i.statMods[CHARISMA].toString();
			
			tmpXml.ICON = i.viewName;

			return tmpXml;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Begin of Writing Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function writeItemXML():void
		{
			var tmpXml:XML = new XML(<data />);
			
			for each (var c:Consumable in ItemArray.consumables)
			{
				var tmpNode:XML = ItemToXML(c as Item);
				tmpXml.appendChild(tmpNode);
			}
			for each (var w:Weapon in ItemArray.weapons)
			{
				var tmpNode:XML = ItemToXML(w as Item);
				tmpXml.appendChild(tmpNode);
			}
			for each (var a:Armor in ItemArray.armors)
			{
				var tmpNode:XML = ItemToXML(a as Item);
				tmpXml.appendChild(tmpNode);
			}
			for each (var ac:Accessory in ItemArray.accesories)
			{
				var tmpNode:XML = ItemToXML(ac as Item);
				tmpXml.appendChild(tmpNode);
			}
			itemFR = new FileReference();
			itemFR.save(tmpXml, "Item-SavedByProject.xml");
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				End of Writing Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Begin of Processing Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function processItemXML():void
		{
			
			for each( var nodec:XML in ItemXMLFile.CONSUMABLE)
			{
				var tmpc:Consumable = new Consumable();
				
				
				tmpc.id = nodec.@ID;
				tmpc.name = nodec.NAME;
				
				switch(nodec.RESERVED)
				{
					case("ALL"):
						tmpc.reserved = Main.ALL;
						break;
					case("GENERAL"):
						tmpc.reserved = Main.GENERAL;
						break;
					case("PRIEST"):
						tmpc.reserved = 2;
						break;
					case("ASSASSIN"):
						tmpc.reserved = 3;
						break;
					case("WIZZARD"):
						tmpc.reserved = 4;
						break;
					case("TROUPS"):
						tmpc.reserved = 5;
						break;
				}

				tmpc.vitalMods[Main.LIFE] = (int)(nodec.LIFE);
				tmpc.vitalMods[Main.MANA] = (int)(nodec.MANA);

				tmpc.statMods[Main.STRENGTH] = (int)(nodec.STR);
				tmpc.statMods[Main.CONSTITUTION] = (int)(nodec.CON);
				tmpc.statMods[Main.INTELLIGENCE] = (int)(nodec.INT);
				tmpc.statMods[Main.WILLPOWER] = (int)(nodec.WIL);
				tmpc.statMods[Main.CHARISMA] = (int)(nodec.CHA);
				tmpc.statMods[Main.AGILITY] = (int)(nodec.AGI);
				
				tmpc.viewName = nodec.ICON;
				ItemArray.consumables.push(tmpc);
				
			}

			for each( var nodew:XML in ItemXMLFile.WEAPON)
			{
				var tmpw:Weapon = new Weapon();
				
				tmpw.name = nodew.NAME;
				tmpw.id = nodew.@ID;
				
				switch(nodew.RESERVED)
				{
					case("ALL"):
						tmpw.reserved = 0;
						break;
					case("GENERAL"):
						tmpw.reserved = 1;
						break;
					case("PRIEST"):
						tmpw.reserved = 2;
						break;
					case("ASSASSIN"):
						tmpw.reserved = 3;
						break;
					case("WIZZARD"):
						tmpw.reserved = 4;
						break;
					case("TROUPS"):
						tmpw.reserved = 5;
						break;
				}

				tmpw.vitalMods[Main.LIFE] = (int)(nodew.LIFE);
				tmpw.vitalMods[Main.MANA] = (int)(nodew.MANA);

				tmpw.statMods[Main.STRENGTH] = (int)(nodew.STR);
				tmpw.statMods[Main.CONSTITUTION] = (int)(nodew.CON);
				tmpw.statMods[Main.INTELLIGENCE] = (int)(nodew.INT);
				tmpw.statMods[Main.WILLPOWER] = (int)(nodew.WIL);
				tmpw.statMods[Main.CHARISMA] = (int)(nodew.CHA);
				tmpw.statMods[Main.AGILITY] = (int)(nodew.AGI);
				
				tmpw.viewName = nodew.ICON;
				ItemArray.weapons.push(tmpw);
				
			}
			
			for each( var nodear:XML in ItemXMLFile.ARMOR)
			{
				var tmpar:Armor = new Armor();
				
				tmpar.name = nodear.NAME;
				tmpar.id = nodear.@ID;
				switch(nodear.RESERVED)
				{
					case("ALL"):
						tmpar.reserved = 0;
						break;
					case("GENERAL"):
						tmpar.reserved = 1;
						break;
					case("PRIEST"):
						tmpar.reserved = 2;
						break;
					case("ASSASSIN"):
						tmpar.reserved = 3;
						break;
					case("WIZZARD"):
						tmpar.reserved = 4;
						break;
					case("TROUPS"):
						tmpar.reserved = 5;
						break;
				}

				tmpar.vitalMods[Main.LIFE] = (int)(nodear.LIFE);
				tmpar.vitalMods[Main.MANA] = (int)(nodear.MANA);

				tmpar.statMods[Main.STRENGTH] = (int)(nodear.STR);
				tmpar.statMods[Main.CONSTITUTION] = (int)(nodear.CON);
				tmpar.statMods[Main.INTELLIGENCE] = (int)(nodear.INT);
				tmpar.statMods[Main.WILLPOWER] = (int)(nodear.WIL);
				tmpar.statMods[Main.CHARISMA] = (int)(nodear.CHA);
				tmpar.statMods[Main.AGILITY] = (int)(nodear.AGI);
				
				tmpar.viewName = nodear.ICON;
				ItemArray.armors.push(tmpar);
				
			}
			
			for each( var nodeac:XML in ItemXMLFile.ACCESSORY)
			{
				var tmpac:Accessory = new Accessory();
				
				tmpac.name = nodeac.NAME;
				tmpac.id = nodeac.@ID;

				switch(nodeac.RESERVED)
				{
					case("ALL"):
						tmpac.reserved = 0;
						break;
					case("GENERAL"):
						tmpac.reserved = 1;
						break;
					case("PRIEST"):
						tmpac.reserved = 2;
						break;
					case("ASSASSIN"):
						tmpac.reserved = 3;
						break;
					case("WIZZARD"):
						tmpac.reserved = 4;
						break;
					case("TROUPS"):
						tmpac.reserved = 5;
						break;
				}

				tmpac.vitalMods[Main.LIFE] = (int)(nodeac.LIFE);
				tmpac.vitalMods[Main.MANA] = (int)(nodeac.MANA);

				tmpac.statMods[Main.STRENGTH] = (int)(nodeac.STR);
				tmpac.statMods[Main.CONSTITUTION] = (int)(nodeac.CON);
				tmpac.statMods[Main.INTELLIGENCE] = (int)(nodeac.INT);
				tmpac.statMods[Main.WILLPOWER] = (int)(nodeac.WIL);
				tmpac.statMods[Main.CHARISMA] = (int)(nodeac.CHA);
				tmpac.statMods[Main.AGILITY] = (int)(nodeac.AGI);
				
				tmpac.viewName = nodeac.ICON;
				ItemArray.accesories.push(tmpac);
				
				
			}
			
		}
		
		private function processLevelXML():void 
		{

			var LevelsXMLFile:XML = Main.LevelsXMLFile;
			
			for each (var levelNode:XML in LevelsXMLFile.TOWN)
			{
				var tmpLevel:Level = new Level();
				tmpLevel.id = levelNode.@ID;
				tmpLevel.name = levelNode.NAME;
				tmpLevel.townIndex = (int)(levelNode.TOWNINDEX);
				tmpLevel.positionOnMapX = (Number)(levelNode.POSITIONONMAPX);
				tmpLevel.positionOnMapY = (Number)(levelNode.POSITIONONMAPY);
				
				
				if (levelNode.ISALLY == "0")
				{
					tmpLevel.isAlly = false;
				}
				else
				{
					tmpLevel.isAlly = true;
				}
				
				tmpLevel.armyGrowth[Main.ARCHER] = (int)(levelNode.ARMYGROWTH.ARCHERS);
				tmpLevel.armyGrowth[Main.LANCER] = (int)(levelNode.ARMYGROWTH.LANCERS);
				tmpLevel.armyGrowth[Main.KNIGHT] = (int)(levelNode.ARMYGROWTH.KNIGHTS);
				
				tmpLevel.propaganda[Main.ARCHER] = (int)(levelNode.PROPAGANDA.ARCHERS);
				tmpLevel.propaganda[Main.LANCER] = (int)(levelNode.PROPAGANDA.LANCERS);
				tmpLevel.propaganda[Main.KNIGHT] = (int)(levelNode.PROPAGANDA.KNIGHTS);

				LevelArray.push(tmpLevel);
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				End of Processing Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Global Constants used as an enum match a name with an int
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//===================================================
		//	Vitals Type
		//===================================================
		public static const LIFE:int = 0;
		public static const MANA:int = 1;
		public static const VITALS_NUMBER:int = 2;
		
		public static const VITALS_NAMES:Array = new Array("Life", "Mana");
		
		//===================================================
		//	Stats Type
		//===================================================
		public static const STRENGTH:int = 0;
		public static const CONSTITUTION:int = 1;
		public static const INTELLIGENCE:int = 2;
		public static const WILLPOWER:int = 3;
		public static const CHARISMA:int = 4;
		public static const AGILITY:int = 5;
		public static const STATS_NUMBER:int = 6;
		
		public static const STATS_NAMES:Array = new Array("Strength", "Constitution", "Intelligence", "Willpower", "Charisma", "Agility");
		
		//===================================================
		//	Character Type and Reserved type of an object
		//===================================================
		
		public static const GENERAL:int = 0;
		public static const PRIEST:int = 1;
		public static const ASSASSIN:int = 2;
		public static const WIZZARD:int = 3;
		public static const TROUPS:int = 4;
		public static const ALL:int = 5; //Everybody except troops
		
		//===================================================
		//	Army Corps
		//===================================================
		public static const LANCER:int = 0;
		public static const ARCHER:int = 1;
		public static const KNIGHT:int = 2;
		
		//===================================================
		//	Item Types
		//===================================================
		public static const CONSUMABLE:int = 0;
		public static const WEAPON:int = 1;
		public static const ARMOR:int = 2;
		public static const ACCESSORY:int = 3;
		
		//===================================================
		//	Animation Types
		//===================================================
		
		public static const IDLE:int = 0;
		public static const ATTACK:int = 1;
		public static const SPELL:int = 2;
		public static const DAMAGED:int = 3;
		public static const DEAD:int = 4;
		public static const VICTORY:int = 5;
		public static const ANIM_NUMBER:int = 6;
		public static const ANIM_NONE:int = 666;
		
		//===================================================
		//	War Skills Types
		//===================================================
		public static const PHYSICAL_ATTACK_WITH_TROOPS:int = 0;
		public static const MAGICAL_ATTACK_WITH_TROOPS:int = 1;
		public static const TALK_TO_TROOPS:int = 2;
		public static const HEAL_TROOPS:int = 3;
		public static const KILL_GENERAL:int = 4;
		public static const SPELL_TROOPS:int = 5;
		
		//===================================================
		//	Duel Skills Types
		//===================================================
		
		public static const PHYSICAL_ATTACK:int = 0;
		public static const MAGICAL_ATTACK:int = 1;
		public static const SPECIAL_TECHNIQUE:int = 2;
		public static const OBJECT_USE:int = 3;
		public static const HEAL:int = 4;
		public static const PROTECT:int = 5;
		public static const CAST_SPELL:int = 6;
		
		
		
	}
	
}