
class MO_ArmorBonus : BasicArmorBonus// replaces ArmorBonus
{
	Default
	{
	  Radius 20;
	  Height 16;
	  Inventory.PickupMessage "$GOTARMBONUS";
	  Inventory.Icon "ARM1A0";
	  Armor.SavePercent 33.335;
	  Armor.SaveAmount 2;
	  Armor.MaxSaveAmount 300; // 300 so that it doesn't break item count
	  +COUNTITEM;
	  inventory.pickupsound "misc/armorbonus";
	  +INVENTORY.ALWAYSPICKUP;
	}
	  States
	  {
	  Spawn:
		B0N2 ABCDCB 6;
		Loop;
	  }
}

class MO_GeminusBonus : MO_ArmorBonus
{
	Default
	{
		Inventory.PickupMessage "Picked up a Gemnius Armor Shard.";
		Armor.SaveAmount 4;
		inventory.pickupsound "gemarmorbonus";
	}
	States
	{
		Spawn:
		80N2 ABCDCB 6;
		Loop;
	}
}

class MO_TrebleBonus : MO_ArmorBonus
{
	Default
	{
		Inventory.PickupMessage "Picked up a Treble Armor Shard.";
		Armor.SaveAmount 6;
		inventory.pickupsound "trebarmorbonus";
	}
	States
	{
		Spawn:
		90N2 ABCDCB 6;
		Loop;
	}
}
		

class MO_LightArmor : GreenArmor replaces GreenArmor
{
	Default
	{
	 Radius 20;
	  Height 16;
	  Inventory.PickupMessage "Picked up the light combat armor.";
	  Inventory.Icon "ARM1A0";
	  Armor.SavePercent 33.335;
	  Armor.SaveAmount 100;
	  Inventory.PickupSound "misc/armorup";
	 }
	  States
	  {
	  Spawn:
		ARM1 A -1;
		Stop;
	  }
}

class MO_HeavyArmor : BlueArmor replaces BlueArmor
{
	Default
	{
	 Radius 20;
	  Height 16;
	  Inventory.PickupMessage "Picked up the heavy combat armor.";
	  Inventory.Icon "ARM2A0";
	  Armor.SavePercent 50;
	  Armor.SaveAmount 200;
	  Inventory.PickupSound "misc/armorup";
	}
	  States
	  {
	  Spawn:
		ARM2 A -1;
		Stop;
	  }
}