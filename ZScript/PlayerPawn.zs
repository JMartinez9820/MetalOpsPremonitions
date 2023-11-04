//Player class mainly for weapons
class SergeantClassToken : MO_ZSToken{}

class JMPlayerPawn : DoomPlayer
{
	override Void Tick()
	{
		Super.Tick();
		//Destroy the night vision shader if a new level is started or if player dies.
		If(!FindInventory("MO_NightVision"))
		{
			Shader.SetEnabled(Player,"NiteVis",false);
		}
	}

    Default
    {
        Player.StartItem "EnforcerPistol";
		Player.DisplayName "Officer (Pistol Start)";
		Player.CrouchSprite "PLYC";
		Player.WeaponSlot 1, "MO_Flamethrower", "Katana";
		Player.WeaponSlot 2, "EnforcerPistol", "MO_Submachinegun";
		Player.WeaponSlot 3, "LeverShotgun", "PumpShotgun", "JM_SSG";
		Player.WeaponSlot 4, "AssaultRifle", /*"MO_HeavyRifle", */ "MO_MiniGun";
		Player.WeaponSlot 5, "MO_RocketLauncher";
		Player.WeaponSlot 6, "JM_PlasmaRifle";
		Player.WeaponSlot 7, "MO_BFG9000", "MO_Unmaker";
		Player.StartItem "PistolMagAmmo",12;
		Player.StartItem "Gasoline", 200;
		Player.StartItem "LowCalClip",50;
		Player.StartItem "HighCalClip",50;
		Player.StartItem "LeverShottyAmmo",7;
		Player.StartItem "PumpShotgunAmmo", 6;
		Player.StartItem "ARAmmo",30;
		Player.StartItem "SMGAmmo",40;
		Player.StartItem "SSGAmmo",2;
		Player.StartItem "PlasmaAmmo",50;
		Player.StartItem "Katana";
		Player.StartItem "MOLOTOVAMMO",4;
		Player.StartItem "GrenadeAmmo", 4;
		Player.StartItem "FragSelected",1;
    }
}

class JMPlayerDeagleStart : DoomPlayer
{
	override Void Tick()
	{
		Super.Tick();
		//Destroy the night vision shader if a new level is started or if player dies.
		If(!FindInventory("MO_NightVision"))
		{
			Shader.SetEnabled(Player,"NiteVis",false);
		}
	}

	Default
    {
		Player.StartItem "SergeantClassToken";
        Player.StartItem "MO_Deagle";
		Player.DisplayName "Sergeant (Deagle Start)";
		Player.CrouchSprite "PLYC";
		Player.WeaponSlot 1, "MO_Flamethrower", "Katana";
		Player.WeaponSlot 2, "MO_Deagle", "MO_Submachinegun";
		Player.WeaponSlot 3, "LeverShotgun", "PumpShotgun", "JM_SSG";
		Player.WeaponSlot 4, "AssaultRifle", /*"MO_HeavyRifle", */ "MO_MiniGun";
		Player.WeaponSlot 5, "MO_RocketLauncher";
		Player.WeaponSlot 6, "JM_PlasmaRifle";
		Player.WeaponSlot 7, "MO_BFG9000", "MO_Unmaker";
		Player.StartItem "MODeagleAmmo",7;
		Player.StartItem "Gasoline", 200;
		Player.StartItem "LowCalClip",50;
		Player.StartItem "HighCalClip",50;
		Player.StartItem "LeverShottyAmmo",7;
		Player.StartItem "PumpShotgunAmmo", 6;
		Player.StartItem "ARAmmo",30;
		Player.StartItem "SMGAmmo",40;
		Player.StartItem "SSGAmmo",2;
		Player.StartItem "PlasmaAmmo",50;
		Player.StartItem "Katana";
		Player.StartItem "MOLOTOVAMMO",4;
		Player.StartItem "GrenadeAmmo", 4;
		Player.StartItem "FragSelected",1;
    }
}