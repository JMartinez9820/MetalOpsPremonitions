//Rawket Lawnchair
class MiniNukeMode :  Inventory {Default{Inventory.MaxAmount 1;}}

class MiniNukeCooldown : Powerup
{
	//Thanks Blue Shadow!
	//From this forum: https://forum.zdoom.org/viewtopic.php?p=1222796#p1222796
	override void DoEffect ()
    {
        Super.DoEffect();

        if (Owner && EffectTics > 0 && EffectTics <= 1)
        {
            Owner.A_StartSound("weapons/rocket/nukemodeact", CHAN_5, CHANF_NOSTOP, 1.0, ATTN_NONE);
			Owner.A_Print("Mini nuke ready!");
        }
    }
	Default{Powerup.Duration 525;}
}

class MiniNukeCoolerGiver : PowerupGiver
{
	Default
	{
		Powerup.Type "MiniNukeCooldown";
		+INVENTORY.AUTOACTIVATE;
	}
}

class MO_RocketLauncher : JMWeapon replaces RocketLauncher
{
    Default
	{
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 5;
		Weapon.AmmoType "MO_RocketAmmo";
		+WEAPON.NOAUTOFIRE
		Inventory.PickupMessage "You got the Rocket Launcher (Slot 5)!";
		Tag "$TAG_ROCKETLAUNCHER";
        Inventory.PickupSound "weapons/rocket/pickup";
	}

    States
    {
        Spawn:
            LAUN A -1;
            Stop;
        ContinueSelect:
		MGNG AAAAAAAAAAAAAAAAAA 0 A_Raise();
        Ready:
        SelectAnimation:
            TNT1 A 0 A_StartSound("weapons/rocket/draw", 0);
            RLAS A 1;
			RNAS A 0 A_JumpIfInventory("MiniNukeMode",1,2);
			RLAS A 0;
			"####" BCDEF 1;
        ReadyToFire:
			RNAS A 0 A_JumpIfInventory("MiniNukeMode",1,2);
			RLAS A 0;
            "####" F 1 JM_WeaponReady;
            Loop;
		Select:
			TNT1 A 0;
			Goto ClearAudioAndResetOverlays;
		Deselect:
			RNAS A 0 A_JumpIfInventory("MiniNukeMode",1,2);
			RLAS A 0;
			"####" FEDCB 1;
			RLAS A 1;
			TNT1 A 0 A_lower(12);
			Wait;
        Fire:
			RLAS A 0 A_CheckReload();
			RLAS A 0 A_JumpIfInventory("MiniNukeMode",1,"FireNuke");
            RLAF A 1 BRIGHT
            {
                A_FireProjectile("MO_Rocket",0,true,0,7,0);
                A_StartSound("weapons/rocket/fire", 1);
                A_Overlay(-5, "MuzzleFlash");
//                A_OverlayScale(-5, 0.9, 0.9);
//				A_OverlayPivotAlign(-5, PSPA_CENTER, PSPA_CENTER);
				JM_CheckForQuadDamage();
            }
            RLAF B 1 BRIGHT
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                 A_SetPitch(pitch-3.0,SPF_Interpolate);
			    A_SetAngle(angle+.75,SPF_INTERPOLATE);
				}
		    }
            RLAF C 1
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-3.0,SPF_Interpolate);
			    A_SetAngle(angle+.75,SPF_INTERPOLATE);
				}
		    }
            RLAF D 1
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-3.0,SPF_Interpolate);
			    A_SetAngle(angle+.75,SPF_INTERPOLATE);
				}
            }
			TNT1 A 0 A_JumpIf(CountInv("MO_RocketAmmo") < 1,2);
			RLAF A 0 A_StartSound("weapons/rocket/loading",6);
			TNT1 AAA 0;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
            RLAF E 1;
			RLAF FG 1;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			RLAF H 1 A_WeaponOffset(0,33);
			RLAF H 1 A_WeaponOffset(0,35);
			RLAF H 1 A_WeaponOffset(0,37);
			RLAF H 1 A_WeaponOffset(0,39);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			RLAF H 1 A_WeaponOffset(0,42);
			RLAF H 1 A_WeaponOffset(0,44);
			RLAF H 1 A_WeaponOffset(0,47);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			RLAF H 1 A_WeaponOffset(0,50);
			RLAF H 1 A_WeaponOffset(0,46);
			RLAF H 1 A_WeaponOffset(0,41);
			RLAF I 1 A_WeaponOffset(0,39);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			RLAF IJ 1 A_WeaponOffset(0,36);
			RLAF KL 1 A_WeaponOffset(0,33);
            RLAS F 6 {
			if(CountInv("MO_powerspeed") == 1)
			{A_SetTics(3);}
			}
			TNT1 A 0 A_JumpIf(PressingFire(), "Fire");
            Goto REadyToFire;
		FireNuke:
			TNT1 A 0;
			RLAF A 0 A_JumpIfInventory("MiniNukeCooldown",1, "OnCooldown");
			TNT1 A 0 A_JumpIfInventory("MO_RocketAmmo",30,1);
			Goto ReadyToFire;
            RNAF A 1 BRIGHT
            {
                A_FireProjectile("MO_MiniNukeRocket",0,false,0,7,0);
				A_TakeInventory("MO_RocketAmmo",30);
                A_StartSound("weapons/rocket/fire", 1);
                A_Overlay(-5, "MuzzleFlash");
				JM_CheckForQuadDamage();
            }
            RNAF B 1 BRIGHT
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                 A_SetPitch(pitch-3.0,SPF_Interpolate);
			    A_SetAngle(angle+.75,SPF_INTERPOLATE);
				}
		    }
            RNAF C 1
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-4.0,SPF_Interpolate);
			    A_SetAngle(angle+.75,SPF_INTERPOLATE);
				}
		    }
            RNAF D 1
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-5.0,SPF_Interpolate);
			    A_SetAngle(angle+.75,SPF_INTERPOLATE);
				}
            }
            RLAF EE 1;
			RLAF FFGG 1;
			RLAF H 2 A_WeaponOffset(0,33);
			RLAF H 2 A_WeaponOffset(0,35);
			RLAF H 2 A_WeaponOffset(0,37);
			RLAF H 2 A_WeaponOffset(0,39);
			RLAF H 2 A_WeaponOffset(0,42);
			RLAF H 2 A_WeaponOffset(0,44);
			RNAF A 0 A_StartSound("weapons/rocket/loading",6);
			RLAF H 2 A_WeaponOffset(0,47);
			RLAF A 0 A_GiveInventory("MiniNukeCoolerGiver",1);
			RLAF H 1 A_WeaponOffset(0,50);
			RLAF H 1 A_WeaponOffset(0,46);
			RLAF H 1 A_WeaponOffset(0,41);
			RLAF I 1 A_WeaponOffset(0,39);
			RLAF I 1 A_WeaponOffset(0,36);
			RNAF J 1 A_WeaponOffset(0,36);
			RNAF KL 1 A_WeaponOffset(0,33);
            RNAS F 6;
            Goto REadyToFire;
		OnCooldown:
			TNT1 A 0 A_Print("Mini nuke on cooldown");
			Goto ReadyToFire;
			
        AltFire:
			TNT1 A 0 A_JumpIfInventory("MiniNukeMode",1,"NoAltForNuke");
			TNT1 A 0 A_JumpIf(CountInv("MO_RocketAmmo") < 1,"ReadyToFire");
            RLAF A 1 BRIGHT
            {
                A_FireProjectile("MO_Rocket",0,0,0,7,0);
                A_StartSound("weapons/rocket/altfire", 1);
				A_Overlay(-5, "MuzzleFlashRapid");
				JM_CheckForQuadDamage();
				A_TakeInventory("MO_RocketAmmo",1);
            }
            RLAF B 1 BRIGHT
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-2.0,SPF_Interpolate);
			    A_SetAngle(angle+0.4,SPF_INTERPOLATE);
				}
		    }
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
            RLAF CC 1
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-1.0,SPF_Interpolate);
			    A_SetAngle(angle+0.2,SPF_INTERPOLATE);
				}
		    }
			TNT1 A 0 A_JumpIf(CountInv("MO_RocketAmmo") < 1,"BurstDone");
            RLAF A 1 BRIGHT
            {
                A_FireProjectile("MO_Rocket",0,0,0,7,0);
				A_TakeInventory("MO_RocketAmmo",1);
                A_StartSound("weapons/rocket/altfire", 1);
            }
            RLAF B 1 BRIGHT
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-2.0,SPF_Interpolate);
			    A_SetAngle(angle+0.4,SPF_INTERPOLATE);
				}
		    }
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
            RLAF CC 1
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-1.0,SPF_Interpolate);
			    A_SetAngle(angle+0.2,SPF_INTERPOLATE);
				}
		    }
			TNT1 A 0 A_JumpIf(CountInv("MO_RocketAmmo") < 1,"BurstDone");
            RLAF A 1 BRIGHT
            {
                A_FireProjectile("MO_Rocket",0,0,0,7,0);
				A_TakeInventory("MO_RocketAmmo",1);
                A_StartSound("weapons/rocket/altfire", 1);
            }
            RLAF B 1 BRIGHT
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-2.0,SPF_Interpolate);
			    A_SetAngle(angle+0.4,SPF_INTERPOLATE);
				}
		    }
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
            RLAF CC 1
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-1.0,SPF_Interpolate);
			    A_SetAngle(angle+0.2,SPF_INTERPOLATE);
				}
		    }
		BurstDone:
            RLAF D 1
            {
				if(!GetCvar("mo_nogunrecoil"))
				{
                A_SetPitch(pitch-3.0,SPF_Interpolate);
			    A_SetAngle(angle+.75,SPF_INTERPOLATE);
				}
            }
			TNT1 A 0 A_JumpIf(CountInv("MO_RocketAmmo") < 1,2);
			RLAF A 0 A_StartSound("weapons/rocket/loading",6);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
            RLAF E 1;
			RLAF FG 1;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			RLAF H 1 A_WeaponOffset(0,33);
			RLAF H 1 A_WeaponOffset(0,35);
			RLAF H 1 A_WeaponOffset(0,37);
			RLAF H 1 A_WeaponOffset(0,39);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			RLAF H 1 A_WeaponOffset(0,42);
			RLAF H 1 A_WeaponOffset(0,44);
			RLAF H 1 A_WeaponOffset(0,47);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			RLAF H 1 A_WeaponOffset(0,50);
			RLAF H 1 A_WeaponOffset(0,46);
			RLAF H 1 A_WeaponOffset(0,41);
			RLAF I 1 A_WeaponOffset(0,39);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			RLAF IJ 1 A_WeaponOffset(0,36);
			RLAF KL 1 A_WeaponOffset(0,33);
            RLAS F 6 {
			if(CountInv("MO_powerspeed") == 1)
			{A_SetTics(3);}
			}
			TNT1 A 0 A_JumpIf(PressingAltFire(), "AltFire");
            Goto ReadyToFire;
		NoAltForNuke:
			"####" A 0;// A_Print("You can't do alt fire on nuke mode");
			Goto ReadyTofire;
        MuzzleFlash:
            MUZR ABCD 1 BRIGHT;
            Stop;
		MuzzleFlashRapid:
			MUZR ABC 1 BRIGHT;
			TNT1 A 1;
			MUZR ABC 1 BRIGHT;
			TNT1 A 1;
			MUZR ABCD 1 BRIGHT;
			Stop;
		
		ActionSpecial:
			TNT1 A 0 A_JumpIfInventory("MiniNukeMode",1,"ActionBackToNormal");
			RLAS F 1 A_StartSound("weapons/rocket/special1",0);
			RLAK ABCDEFG 1;
			RLAK G 5;
			RLAS F 0 A_StartSound("weapons/rocket/special2",0);
			RLAK G 1 A_WeaponOffset(-2,34);
			RLAK G 1 A_WeaponOffset(-4,36);
			RLAK G 1 A_WeaponOffset(-2,34);
			RLAK G 18 A_WeaponOffset(1,32);
			RLAS F 0 A_StartSound("weapons/rocket/special3",0);
			RLAK G 1 A_WeaponOffset(-3,36);
			RLAK G 1 A_WeaponOffset(-6,40);
			RLAK G 1 A_WeaponOffset(-9,44);
			RLAK G 1 A_WeaponOffset(-12,48);
			RLAK G 3 A_WeaponOffset(-15,52);
			RLAK G 1 A_WeaponOffset(-12,48);
			RNAK G 1 A_WeaponOffset(-9,44);
			RNAK G 1 A_WeaponOffset(-5,40);
			RNAK G 8 A_WeaponOffset(0,32);
			TNT1 A 0 A_StartSound("weapons/rocket/draw", 0);
			RNAK FEDCBA 1;
			TNT1 A 0
			{
					A_SetInventory("MiniNukeMode",1);
					A_Print("Warning: Mini nuke rockets selected");
					A_StartSound("weapons/rocket/nukemodeact",0);
			}
			Goto ReadyToFire;
			
		ActionBackToNormal:
			RNAS F 1 A_StartSound("weapons/rocket/special1",0);
			RNAK ABCDEFG 1;
			RNAK G 5;
			RNAS F 0 A_StartSound("weapons/rocket/special2",0);
			RNAK G 1 A_WeaponOffset(-2,34);
			RNAK G 1 A_WeaponOffset(-4,36);
			RNAK G 1 A_WeaponOffset(-2,34);
			RNAK G 18 A_WeaponOffset(1,32);
			RNAS F 0 A_StartSound("weapons/rocket/special3",0);
			RNAK G 1 A_WeaponOffset(-3,36);
			RNAK G 1 A_WeaponOffset(-6,40);
			RNAK G 1 A_WeaponOffset(-9,44);
			RNAK G 1 A_WeaponOffset(-12,48);
			RNAK G 3 A_WeaponOffset(-15,52);
			RLAK G 1 A_WeaponOffset(-12,48);
			RLAK G 1 A_WeaponOffset(-9,44);
			RLAK G 1 A_WeaponOffset(-5,40);
			RLAK G 8 A_WeaponOffset(0,32);
			TNT1 A 0 A_StartSound("weapons/rocket/draw", 0);
			RLAK FEDCBA 1;
			TNT1 A 0
			{
					A_SetInventory("MiniNukeMode",0);
					A_Print("Rockets selected");
			}
			Goto ReadyTofire;
		NukeOverlayIdle:
			RNUK A 1;
			Stop;
		FlashKick:
			RNAK A 0 A_JumpIfInventory("MiniNukeMode",1,2);
			RLAK A 0;
			"####" ABCDEFG 1;// JM_WeaponReady();
			"####" GGFFEDCBA 1;// JM_WeaponReady();
			Goto ReadyToFire;
		
		FlashAirKick:
			RNAK A 0 A_JumpIfInventory("MiniNukeMode",1,2);
			RLAK A 0;
			"####" ABCDEFG 1;// JM_WeaponReady();
			"####" G 5;
			"####" GGFEDCBA 1;// JM_WeaponReady();
			Goto ReadyToFire;
    }
}

Class MO_Rocket : Rocket// replaces rocket
{
    Default
    {
        Speed 40;
        SeeSound "NULLSND";
	    DeathSound "rocket/explosion";
		Scale 0.5;
		DamageFunction (random(50, 70));
		DamageType "Explosive";
		Decal "Scorch";
    }
	States
	{
		Spawn:
			MI5L A 1;
			MI5L A 1 BRIGHT A_StartSound("rocket/flyloop", CHAN_7, CHANF_LOOPING);
		FlyLoop:
			MI5L ABCD 1 BRIGHT
			{
				if(waterlevel < 1) {
					A_SpawnItemEx("MO_RocketSmokeTrail",-3,0,0,-1,0,0);
				}
			}
            Loop;
		Death:
            TNT1 A 0 A_StopSound(CHAN_7);
			TNT1 A 0 A_StartSound("rocket/explosion");
			TNT1 A 1 A_SpawnItemEx("RocketExplosionFX",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
			TNT1 A 0 A_Explode(200, 180);
			Stop;
    }
}

Class MO_WeakRocket : MO_Rocket
{
	Default
	{
		Damage 16;
	}
}

Class MO_MiniNukeRocket : MO_Rocket
{
	Default
	{
		Speed 25;
		Scale 1.1;
		DamageFunction(3000);
		Obituary "%o was nuked by %k's mini-nuke.";
		DeathSound "NULLSND";
	}
	States
	{
		Spawn:
			NMIS A 1;
			NMIS A 1 BRIGHT A_StartSound("rocket/flyloop", CHAN_7, CHANF_LOOPING);
		FlyLoop:
			NMIS ABCD 1 BRIGHT
			{
				if(waterlevel < 1) {
					A_SpawnItemEx("MO_NukeRocketSmokeTrail",-3,0,0,-1,0,0);
				}
			}
            Loop;
		Death:
            TNT1 A 0 A_StopSound(CHAN_7);
			TNT1 A 1;
			TNT1 A 0 A_StartSound("rocket/nukeexplosion",CHAN_5, CHANF_DEFAULT,2, ATTN_NORM );
			TNT1 A 0 A_StartSound("rocket/nukeexplosionfar",CHAN_6, CHANF_DEFAULT,1, ATTN_NONE);
			TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("MO_MiniNukeFlamesImpact", 5, 0, random (0, 360), CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH|CMF_BADPITCH|CMF_SAVEPITCH, random (0, 10));
			TNT1 A 0 A_SpawnProjectile ("MO_SpawnedExplosionNuke2", 30, 0, random (0, 360), CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH|CMF_BADPITCH|CMF_SAVEPITCH, random(80, 90));
			//TNT1 AAA 0 A_CustomMissile ("lONGExplosionSpawner", 30, 0, random (0, 360), 2, 90)
			TNT1 AA 0  A_SpawnItemEx("MO_SpawnedExplosionNuke", random (-600, 600), random (-600, 600), random (0, 100));
			TNT1 AAAAAAAAAAAAAA 0  A_SpawnItemEx("MO_SpawnedExplosionNuke", random (-500, 500), random (-600, 600), random (0, 50));
			EXPL A 0 Radius_Quake (9, 100, 0, 150, 0);
			TNT1 AAA 0 A_SpawnItemEx("MO_MiniNukeFlare", random (-500, 500), random (-600, 600), random (0, 100));
			TNT1 AAA 1 A_SpawnItemEx("MO_MiniNukeFlare", random (-500, 500), random (-600, 600), random (0, 100));
			TNT1 A 0 A_Explode(200, 1300, 1, 1, 4000);
//			TNT1 A 0 A_PlaySound("NUKEEXP", 1);
			TNT1 A 0 A_Explode(750,250, 1, 1, 1);
			TNT1 A 0 A_SpawnItemEx("NukeCloud",0,0,0,0,0,0,SXF_NOCHECKPOSITION);
			TNT1 A 0 A_SpawnItemEx("NukeExplosionFX",0,0,200,0,0,3,SXF_NOCHECKPOSITION);
			TNT1 A 2 A_SpawnItemEx("MO_MiniNukeFlare", 0, 0, 300);
			TNT1 A 2 A_SpawnItemEx("MO_MiniNukeFlare", 0, 0, 400);
			TNT1 A 2 A_SpawnItemEx("MO_MiniNukeFlare", 0, 0, 450);
			TNT1 A 2 A_SpawnItemEx("MO_MiniNukeFlare", 0, 0, 500);
			TNT1 AAAAA 2 A_SpawnItemEx("MO_MiniNukeFlare", 0, 0, 500);
			EXPL A 0 Radius_Quake (6, 100, 0, 150, 0);
			TNT1 A 45;
			TNT1 A 1000;
			Stop;
    }
}

Class NukeCloud : Actor
{
	States
	{
	Spawn:
		TNT1 A 1 {
				A_SpawnItemEx("MO_NukeSmoke",-40,-100,20);
				A_SpawnItemEx("MO_NukeSmoke",-30,-70,20);
				A_SpawnItemEx("MO_NukeSmoke",-20,-40,20);
				A_SpawnItemEx("MO_NukeSmoke",-10,-10,20);
				A_SpawnItemEx("MO_NukeSmoke",0,20,20);
				A_SpawnItemEx("MO_NukeSmoke",10,50,20);
				A_SpawnItemEx("MO_NukeSmoke",20,80,20);
				A_SpawnItemEx("MO_NukeSmoke",30,110,20);
				A_SpawnItemEx("MO_NukeSmoke",40,140,20);
				A_SpawnItemEx("MO_NukeSmoke",50,170,20);
				}
			TNT1 AAAAAAAAAAAAAA 0  A_SpawnProjectile ("MO_NukeSmoke", random (50, 400), 0, random (0, 360), CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH|CMF_BADPITCH|CMF_SAVEPITCH, random(80, 90));
//			TNT1 AAA 0  A_SpawnProjectile ("MO_NukeSmokeBig", 1400, 0, random (0, 360), CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH|CMF_BADPITCH|CMF_SAVEPITCH, random(80, 90));
			TNT1 A 0 A_SpawnItemEx("MO_NukeSmokeBig",10,-8,600);
			TNT1 A 0 A_SpawnItemEx("MO_NukeSmokeBig",8,-16,625);
			TNT1 A 0 A_SpawnItemEx("MO_NukeSmokeBig",6,0,670);
			TNT1 A 0 A_SpawnItemEx("MO_NukeSmokeBig",-2,8,700);
			TNT1 A 0 A_SpawnItemEx("MO_NukeSmokeBig",-4,-16,725);
			Stop;
	}
}
	

Class RocketExplosionFX : Actor
{
	Default
	{
		Radius 0;
		Height 0;
		RenderStyle 'Add';
		Alpha 1;
		Scale 1.35;
	  +NOGRAVITY;
	  +NOINTERACTION;
	  +NOBLOCKMAP;
	  +NOTELEPORT;
	  +ForceXYBillboard;
	  +CLIENTSIDEONLY;
	}
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 1 A_Jump(256, "Effect1", "Effect2", "Effect3", "Effect4", "Effect5");
		Effect1:
			X203 ABCDE 1 bright;
			X203 FGHIJKLMNOPQ 1 bright;
			Stop;
		Effect2:
			X204 ABCDE 1 bright;
			X204 FGHIJKLMNOPQ 1 bright;
			Stop;
		Effect3:
			X005 ABCDE 1 bright;
			X005 FGHIJKLMNOPQ 1 bright;
			Stop;
		Effect4:
			X006 ABCDE 1 bright;
			X006 FGHIJKLMNOPQ 1 bright;
			Stop;
		Effect5:
			X007 A 0 A_SetScale (.70);
			X007 ABCDE 1 bright;
			X007 FGHIJJKKLMNO 1 bright;
			Stop;
    }
}

Class NukeExplosionFX : Actor
{
	Default
	{
		Radius 0;
		Height 0;
		RenderStyle 'Add';
		Alpha 1;
		Scale 2.5;
		Speed 3;
	  +NOGRAVITY;
	  +NOINTERACTION;
	  +NOBLOCKMAP;
	  +NOTELEPORT;
	  +ForceXYBillboard;
	  +CLIENTSIDEONLY;
	}
	States
	{
		Spawn:
		NKE1 ABCDE 10;
		NKE1 FGHIJKL 7;
		NKE1 MNOPQRST 7;
		Stop;
	}
}
		