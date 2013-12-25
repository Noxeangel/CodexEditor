package codex.items 
{
	/**
	 * ...
	 * @author Olivier
	 */
	public class Inventory 
	{
		public var consumables:Array = new Array();
		public var weapons:Array = new Array();
		public var armors:Array = new Array();
		public var accesories:Array = new Array();
		
		public function Inventory() 
		{
			
		}
		
		public function AddItem(item:Item):void
		{
			switch (item)
			{
				case typeof(Consumable):
					consumables.push(item);
					break;
				case typeof(Weapon):
					weapons.push(item);
					break;
				case typeof(Armor):
					armors.push(item);
					break;
				case typeof(Accessory):
					accesories.push(item);
					break;
			}
		}
		
		public function AddInventory(inv:Inventory):void
		{
			for each (var consum:Consumable in inv.consumables)
			{
				consumables.push(consum);
			}
			for each (var weap:Weapon in inv.weapons)
			{
				weapons.push(weap);
			}
			for each (var arm:Armor in inv.armors)
			{
				armors.push(arm);
			}
			for each (var acc:Accessory in inv.accesories)
			{
				accesories.push(acc);
			}
			/*
			consumables.concat( inventory.consumables);
			weapons.concat( inventory.weapons);
			armors.concat( inventory.armors);
			accesories.concat( inventory.accesories);
			*/
		}
		
		public function ReturnItemArray():Array
		{
			var arr:Array = new Array();
			
			for each (var c:Consumable in consumables)
			{
				arr.push(c as Item);
			}
			for each (var w:Weapon in weapons)
			{
				arr.push(w as Item);
			}
			for each (var ar:Armor in armors)
			{
				arr.push(ar as Item);
			}
			for each (var ac:Accessory in accesories)
			{
				arr.push(ac as Item);
			}
			
			return arr;
		}
		
	}

}