class ShotgunSpawner : RandomSpawner replaces Shotgun
{
	Default
    {
		DropItem "LeverShotgun", 255, 4;
		DropItem "PumpShotgun", 255, 2;
		DropItem "SSGRandomizer", 255,1;
	}
}

//This is not a spawner! This is a randomizer actor for the SSG spawn option.
//If the ssg random spawn on shotgun is off, it would spawn either the 
//lever action or pump shotgun. -JM
class SSGRandomizer : actor
{
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 1
			{
				if(CVar.FindCVar("mo_ssgrandomizer").GetBool() == True)
				{return resolvestate("SpawnSSG");}
				return A_Jump(256, "SpawnPump", "SpawnLever");
			}
		SpawnSSG:
			TNT1 A 0;
			TNT1 A 1 A_Jump(96, "SpawnPump", "SpawnLever");
			TNT1 A 0 A_SpawnItemEx("JM_SSG");
			Stop;
		SpawnPump:
			TNT1 A 0 A_SpawnItemEx("PumpShotgun");
			Stop;
		SpawnLever:
			TNT1 A 0 A_SpawnItemEx("LeverShotgun");
			Stop;
	}
}

class FlakShellRandomizer : actor
{
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 1
			{
				if(CVar.FindCVar("mo_ssgrandomizer").GetBool() == False)
				{return resolvestate("12GShells");}
				return A_Jump(256, "FlakShells");
			}
		FlakShells:
			TNT1 A 0;
			TNT1 A 1 A_Jump(96, "12GShells");
			TNT1 A 0 A_SpawnItemEx("MO_FlakShell");
			Stop;
		12GShells:
			TNT1 A 0 A_SpawnItemEx("MO_ShotShell");
			Stop;
	}
}

class FlakBoxRandomizer : FlakShellRandomizer
{
	States
	{
		FlakShells:
			TNT1 A 0;
			TNT1 A 1 A_Jump(96, "12GShells");
			TNT1 A 0 A_SpawnItemEx("MO_FlakShellBox");
			Stop;
		12GShells:
			TNT1 A 0 A_SpawnItemEx("MO_ShellBox");
			Stop;
	}
}

class ChaingunSpawner : RandomSpawner replaces Chaingun
{
	Default
    {
		DropItem "MO_MiniGun", 255, 3;
		DropItem "AssaultRifle", 255, 2;
		DropItem "MO_SubMachinegun",255, 2;
	}
}

class ClipSpawner : RandomSpawner replaces Clip
{
	Default
	{
		DropItem "HighCalClip";
		DropItem "LowCalClip";
	}
}

class ClipboxSpawner : RandomSpawner replaces Clipbox
{
	Default
	{
		DropItem "HighCalBox", 255;
		DropItem "LowCalBox", 255;
	}
}

class ShellSpawner : RandomSpawner replaces Shell
{
	Default
	{
		DropItem "MO_ShotShell";
		DropItem "FlakShellRandomizer";
	}
}

class ShellboxSpawner : RandomSpawner replaces ShellBox
{
	Default
	{
		DropItem "MO_ShellBox";
		DropItem "FlakBoxRandomizer";
	}
}

class BFGSpawner : RandomSpawner replaces BFG9000
{
	Default
	{
		DropItem "MO_BFG9000", 255, 3;
		DropItem "MO_Unmaker", 255, 1;
	}
}

class FlamethrowerSpawner : CustomInventory replaces Chainsaw
{
	Default
	{
//		+COUNTITEM;
		+FLOORCLIP;
		+DONTGIB;
		Scale 0.42;
		Inventory.PickupSound "weapons/flamer/pickup";
        Inventory.PickupMessage "";
	}
	States
	{
		Spawn:
			TNT1 A 0;
			F1MC A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_JumpIfInventory("MO_Flamethrower",1,"PickupGas");
			TNT1 A 1
			{
				A_GiveInventory("MO_Flamethrower",1);
				A_GiveInventory("Gasoline",75);
				A_Log("You got the Flamethrower! (Slot 1)");
			}
			Stop;
		PickupGas:
			TNT1 A 1
			{
				A_GiveInventory("Gasoline",90);
				A_Log("You got the gasoline from the Flamethrower! +90 Gas");
			}
			Stop;
	}
}

//Items and Powerups
Class BerserkPackSpawner: RandomSpawner replaces Berserk
{
	Default
	{
		DropItem "MO_Berserk",255,3;
		DropItem "MO_HasteSphere",255,2;
	}
}

Class InvulSphereSpawner : RandomSpawner replaces InvulnerabilitySphere
{
	Default
	{
		DropItem "MO_Invulnerability",255,3;
		DropItem "MO_QuadDMGSphere",255,1;
	}
}

Class ArmorBonusSpawner : RandomSpawner replaces ArmorBonus
{
	Default
	{
		DropItem "MO_ArmorBonus",255,3;
		DropItem "MO_GeminusBonus",255, 1;
		DropItem "MO_TrebleBonus",255,1;
	}
}


Class HealthBonusSpawner : RandomSpawner replaces HealthBonus
{
	Default
	{
		DropItem "MO_HealthBonus",255,3;
		DropItem "MO_DoubleHealthBonus",255, 1;
		DropItem "MO_TripleHealthBonus",255,1;
	}
}