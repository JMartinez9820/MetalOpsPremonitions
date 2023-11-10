
Class MO_Soulsphere : CustomInventory replaces SoulSphere
{
	Default
	{
		+COUNTITEM
		+INVENTORY.ALWAYSPICKUP
		+INVENTORY.AUTOACTIVATE
		Inventory.PickupMessage "Soulsphere!";
		Inventory.PickupSound "powerup/soulsphere";
		+floatbob;
		Renderstyle "Translucent";
		Alpha 0.9;
	}
	States
	{
		Spawn:
			SOUL ABCD 6 Bright Light ("SoulsphereLight");
			Loop;
		Pickup:
			TNT1 A 0;
			TNT1 A 1 
			{
				GiveBody(100,200);
				A_SetBlend("Blue",0.8, 20);
			}
			Stop;
	}
}

Class MO_Megasphere : CustomInventory replaces MegaSphere
{
	Default
	{
		+COUNTITEM
		+INVENTORY.ALWAYSPICKUP
		Inventory.PickupMessage "$GOTMSPHERE";
		Inventory.PickupSound "powerup/megasphere";
		+floatbob;
		Renderstyle "Translucent";
		Alpha 0.9;
	}
	States
	{
		Spawn:
			MEGA ABCD 6 Bright Light ("SoulsphereLight");
			Loop;
		Pickup:
			TNT1 A 0;
			TNT1 A 1 
			{
				GiveBody(200,200);
				GiveInventory("MO_HeavyArmor",1);
			}
			Stop;
	}
}

//Portion of code from Realm667, code by scalliano, ZScripted by me (JM2098).	
Class MO_HasteSphere : PowerupGiver
{
	Default
	{
		inventory.pickupmessage "Haste! You move and reload your weapons faster, melee attacks are faster.";
		inventory.maxamount 0;
		+COUNTITEM;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		Inventory.AltHudIcon "HASTA0";
		Inventory.PickupSound "powerup/haste";
		powerup.duration -30;
		powerup.color "000000", 0;
		PowerUp.Type "MO_PowerSpeed";
		Scale 1.1;
		Tag "Haste";
		+floatbob;
	}
	States
	{
	Spawn:
		TNT1 A 0 NoDelay A_StartSound("powerup/hastesphereloop",CHAN_ITEM, CHANF_LOOP, 0.85);
	SpawnLoop:
		HAST ABCD 4 Bright;
		Loop;
	}
}

Class MO_PowerSpeed : PowerSpeed
{
	mixin PowerUpExpiringBase;
	mixin MO_PowerUpWarning;
	//I'll likely redo the expire warning effect later on...
	
	override void DoEffect ()
    {
		if(!owner) return;
        Super.DoEffect();
		
		ExpireSoundTics = playTimer;
		Owner.A_AttachLight("HasteSphereLight", DynamicLight.PointLight,"Yellow", 56, 64);
		Owner.A_StartSound("powerup/hasteloop",41,CHANF_LOOPING|CHANF_OVERLAP);		
		PowerWarning("Haste", "", "powerupwearoff", "FF FF 00", "k");
	}
	
	override void EndEffect()
	{
		Super.EndEffect();
		if(!owner) return;
		Owner.A_StartSound("powerup/hasteover", 41);
		Owner.A_RemoveLight("HasteSphereLight");
		Owner.A_StopSound(40);
	}
		
	Default
	{
		Inventory.AltHudIcon "HASTA0";
		+INVENTORY.NOSCREENBLINK;
		Speed 1.3;
	}
}

Class MO_Invulnerability : PowerUpGiver// replaces InvulnerabilitySphere
{
	Default
	{
	 +COUNTITEM;
	  +INVENTORY.AUTOACTIVATE;
	  +INVENTORY.ALWAYSPICKUP;
	  +INVENTORY.BIGPOWERUP;
	  Inventory.MaxAmount 0;
	  Powerup.Type "MO_PowerInvul";
	  Inventory.PickupMessage "$GOTINVUL";
	  Inventory.PickupSound "powerup/invul";
	  +floatbob;
		Renderstyle "Translucent";
		Alpha 0.9;
	}
	  States
	  {
	  Spawn:
		PINV ABCD 6 Bright;
		Loop;
	  }
}

Class MO_PowerInvul : PowerInvulnerable
{
	mixin PowerUpExpiringBase;
	mixin MO_PowerUpWarning;
	//I'll likely redo the expire warning effect later on...
	
	override void DoEffect ()
    {
		if(!owner) return;
        Super.DoEffect();
		
		ExpireSoundTics = playTimer;
		Owner.A_AttachLight("lnvulLight", DynamicLight.PointLight,"Green", 56, 64);
		Owner.A_StartSound("powerup/invul_loop",50,CHANF_LOOPING|CHANF_OVERLAP);
		Owner.A_StartSound("powerup/invul_looplayer",51,CHANF_LOOPING|CHANF_OVERLAP, 0.28);		
		PowerWarning("Invulnerability", "", "powerupwearoff", "Green", "d");
	}
	
	override void EndEffect()
	{
		Super.EndEffect();
		if(!owner) return;
		Owner.A_RemoveLight("lnvulLight");
		Owner.A_StopSound(50);
		Owner.A_StopSound(51);
		Owner.A_StartSound("powerup/invul_end",50, CHANF_DEFAULT, 0.8);
	}
		
	Default
	{
		Inventory.AltHudIcon "PINVA0";
		+INVENTORY.NOSCREENBLINK;
	}
}

Class MO_BlurSphere: BlurSphere replaces BlurSphere
{
	Default
	{
		Inventory.PickupSound "powerup/invis";
		+FLOATBOB;
		Powerup.Type "MO_PowerInvis";
	}
}

Class MO_PowerInvis : PowerInvisibility
{
	mixin PowerUpExpiringBase;
	mixin MO_PowerUpWarning;
	//I'll likely redo the expire warning effect later on...
	
	override void DoEffect ()
    {
		if(!owner) return;
        Super.DoEffect();
		
		ExpireSoundTics = playTimer;
		PowerWarning("Partial Invisibility", "", "powerup/inviswear", "Blue", "h");
	}
	
	override void EndEffect()
	{
		Super.EndEffect();
		if(!owner) return;
//		Owner.A_StartSound("powerup/hasteover", 41);
		Owner.A_StopSound(40);
	}
		
	Default
	{
		Inventory.AltHudIcon "PINSA0";
		+INVENTORY.NOSCREENBLINK;
		-VISIBILITYPULSE;
	}
}

Class MO_QuadDMGSphere : PowerupGiver
{
	Default
	{
		+COUNTITEM;
		+INVENTORY.AUTOACTIVATE;
		+INVENTORY.ALWAYSPICKUP;
		  Inventory.MaxAmount 0;
		  Powerup.Type "MO_PowerQuadDMG";
		  Inventory.PickupMessage "Quad Damage!";
		  Inventory.PickupSound "powerup/quadpick";
		 +floatbob;
		  Renderstyle "Translucent";
		  Alpha 0.9;
		  Powerup.Duration -30;
	}
	States
	{
	  Spawn:
		TNT1 A 0 NoDelay A_StartSound("powerup/quadidle",CHAN_ITEM, CHANF_LOOP, 0.65);
	  SpawnLoop:
		QDAM ABCDEF 4 Bright;
		Loop;
	}
}

Class MO_PowerQuadDMG : PowerDamage
{
	mixin PowerUpExpiringBase;
	mixin MO_PowerUpWarning;
	//I'll likely redo the expire warning effect later on...
	
	override void DoEffect ()
    {
		if(!owner) return;
        Super.DoEffect();
		
		ExpireSoundTics = playTimer;
		Owner.A_AttachLight("QuadDmgLight", DynamicLight.PointLight,"80 00 FF", 56, 64);
		Owner.A_StartSound("powerup/quadloop",50,CHANF_LOOPING|CHANF_OVERLAP, 0.5);
		
		PowerWarning("Quad Damage", "", "powerup/quadexpire", "80 00 FF", "t");
	}
	
	override void EndEffect()
	{
		Super.EndEffect();
		if(!owner) return;
		Owner.A_StopSound(50);
		Owner.A_StartSound("powerup/quadend", 50);
		Owner.A_RemoveLight("QuadDmgLight");
		Owner.A_StopSound(40);
	}
	
	Default
	{
		Inventory.AltHudIcon "QDAMZ0";
		+INVENTORY.NOSCREENBLINK;
		Speed 1.3;
		DamageFactor "normal",4;
	}
}

//Class MO_BloodrushSphere : CustomInventory
