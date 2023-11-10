
class MO_HealthBonus : HealthBonus// replaces HealthBonus
{
	Default
	{
	  +COUNTITEM;
	  +INVENTORY.ALWAYSPICKUP;
	  Inventory.Amount 2;
	  Inventory.MaxAmount 300;
	  Inventory.PickupMessage "$GOTHTHBONUS"; // "Picked up a health bonus."
	  Inventory.PickupSound "misc/healthbonus";
	  Health.LowMessage 25, "Picked up a health bonus. It's not much, but hey you needed it.";
	}
	States
	{
	  Spawn:
		B0N1 ABCDCB 6;
		Loop;
	 }
}

class MO_DoubleHealthBonus : MO_HealthBonus
{
	Default
	{
	  Inventory.Amount 4;
	  Inventory.PickupMessage "Picked up a stronger health bonus. (+4 health)"; // "Picked up a health bonus."
	  Inventory.PickupSound "doublehealth";
	  Health.LowMessage 25, "Picked up a stronger health bonus. Not much but you needed it.";
	}
	States
	{
	  Spawn:
		80N1 ABCDCB 6;
		Loop;
	 }
}

class MO_TripleHealthBonus : MO_HealthBonus
{
	Default
	{
	  Inventory.Amount 6;
	  Inventory.PickupMessage "Picked up a greater health bonus. (+6 health)"; // "Picked up a health bonus."
	  Inventory.PickupSound "triplehealth";
	  Health.LowMessage 25, "Picked up a greater health bonus. You needed it, despite it not being enough.";
	}
	States
	{
	  Spawn:
		90N1 ABCDCB 6;
		Loop;
	 }
}

Class MO_Stimpack: Stimpack replaces Stimpack
{
	Default
	{
	  Inventory.Amount 15;
	  Inventory.PickupMessage "$GOTSTIM"; // "Picked up a stimpack."
	  Health.LowMessage 25, "Picked up a stimpack. It's not a medkit, but this will do.";
	  Inventory.PickupSound "misc/stim";
	 }
  States
  {
  Spawn:
    5TIM A -1;
    Stop;
  }
}

Class MO_Medikit : Medikit replaces Medikit
{
	Default
	{
	  Inventory.Amount 30;
	  Inventory.PickupMessage "$GOTMEDIKIT";
	  Health.LowMessage 25, "$GOTMEDINEED";
	  Inventory.PickupSound "misc/medpack";
	}
  States
  {
  Spawn:
    MEDI A -1;
    Stop;
  }
}


Class MO_Berserk : CustomInventory// replaces Berserk
{
	Default
	{
		+COUNTITEM;
		+INVENTORY.ALWAYSPICKUP;
		Inventory.PickupMessage "$GOTBERSERK"; // "Berserk!"
		Inventory.PickupSound "misc/zerkpak";
	}
	States
	{
		Spawn:
		PSTR A -1;
		Stop;
		
		Pickup:	
		TNT1 A 0 A_GiveInventory("PowerStrength");
		TNT1 A 0 HealThing(100, 0);
		Stop;
	}
}
