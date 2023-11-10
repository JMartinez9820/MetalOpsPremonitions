//////////////////////////////////////
//      THE FLAMETHROWER      //
//   Sprites by VriskaSerket  	//
///////////////////////////////////

class IceMode :  Inventory {Default{Inventory.MaxAmount 1;}}

class MO_Flamethrower : JMWeapon// replaces Chainsaw
{
    Default
    {
        Weapon.AmmoUse1 0;
        Weapon.AmmoGive 75;
        Weapon.AmmoType1 "Gasoline";
        Inventory.PickupSound "weapons/flamer/pickup";
        Inventory.PickupMessage "You got the Flamethrower! (Slot 1)";
		Tag "Flamethrower";
        +FLOORCLIP;
		Scale 0.42;
		Obituary "%o was burnt to a crisp by %k's Flamethrower.";
    }
    States
    {
    Ready:
	SelectAnimation:
        TNT1 A 0 {
			if(CountInv("IceMode") == 1)
			{A_StartSound("Weapons/flamer/icedraw",1);}
			else{	A_StartSound("weapons/flamer/draw", 1);}
		}
        FLMS ABCD 1;
    ReadyToFire:
        FLMG A 1 JM_WeaponReady();
        Loop;
    Deselect:
        FLMS DCBA 1;
		TNT1 A 0 A_Lower(12);
        Wait;
    Select:
        TNT1 A 0;
        Goto ClearAudioAndResetOverlays;
    ContinueSelect:
		TNT1 AAAAAAAAAAAAAAAAAA 0 A_Raise();
		Goto Ready;
    Fire:
		FLMG A 0 A_CheckReload();
        FLMG A 1 A_WeaponOffset(0,34);
        FLMG A 1 A_WeaponOffset(0,38);
		FLMG A 0 A_JumpIf(WaterLevel > 1, "DontFire");
		FLMG A 0 A_JumpIf(CountInv("Gasoline") < 4, "DontFire");
		FLMG A 0 A_JumpIfInventory("IceMode",1, "FireIcethrower");
        TNT1 A 0 A_StartSound("Weapons/flamer/startfire", 2);
        FLMG A 1 {
            A_WeaponOffset(0,42);
            A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
        FLMG A 1 {
            A_WeaponOffset(0,46);
           A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
		FLMG A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
        FLMG A 1 
        {
            A_WeaponOffset(0,41);
             for(int i = 2; i > 0; i--)
            {
                A_SpawnItemEx("GunSmoke", 33, 0, 33, 3, 0, 0);
            }
        }
        FLMG A 1 {
            A_WeaponOffset(0,38);
			A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
		TNT1 A 0 A_StartSound("weapons/flamer/flameon",7, CHANF_DEFAULT, 0.6);
        TNT1 A 0 A_StartSound("weapons/flamer/fireloop", 1, CHANF_LOOPING);
		FLMG A 0 JM_CheckForQuadDamage();
	HoldingFire:
		FLMG A 0 A_JumpIf(CountInv("Gasoline") < 4, "StopFire");
        FTF1 ABCD 1 {
            A_WeaponOffset(random(-3,3), random(32, 36));
            A_FireProjectile("FlamethrowerAttack",0,0,0,4);
			if(!GetCvar("mo_nogunrecoil"))
			{
				A_SetPitch(pitch-.4,SPF_Interpolate);
				A_SetAngle(angle-0,SPF_INTERPOLATE);
			}
			if(CountInv("Gasoline") < 4) {return ResolveState("StopFire");}
			return ResolveState(null);
			}
		TNT1 A 0 A_TakeInventory("Gasoline", 4);
        SAWG B 0 A_JumpIf(PressingFire(), "HoldingFire");
	StopFire:
		SAWG A 0 A_StopSound(1);
		SAWG A 0 A_StopSound(7);
		SAWG A 0 A_StartSound("weapons/flamer/end",1);
	StopAnimation:
		FLMG A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
        FLMG A 1 {
            A_WeaponOffset(0,42);
        }
        FLMG A 1 {
            A_WeaponOffset(0,46);
        }
        FLMG A 1 
        {
            A_WeaponOffset(0,41);
        }
        FLMG A 1 {
            A_WeaponOffset(0,38);
             for(int i = 2; i > 0; i--)
            {
                A_SpawnItemEx("GunSmoke", 33, 0, 33, 3, 0, 0);
            }
        }
        FLMG A 1 {
            A_WeaponOffset(0,34);
            A_SpawnItemEx("GunSmoke", 33, 0, 33, 3, 0, 0);
        }
        Goto ReadyToFire;
	DontFire:
		 TNT1 A 0 A_StartSound("Weapons/flamer/inwater", 2);
		  FLMG A 1 {
            A_WeaponOffset(0,42);
            A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
        FLMG A 1 {
            A_WeaponOffset(0,46);
           A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
        FLMG A 1 
        {
            A_WeaponOffset(0,41);
             for(int i = 2; i > 0; i--)
            {
                A_SpawnItemEx("GunSmoke", 33, 0, 33, 3, 0, 0);
            }
        }
        FLMG A 1 {
            A_WeaponOffset(0,38);
			A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
		Goto StopAnimation;
	
	FireIcethrower:
        TNT1 A 0 A_StartSound("Weapons/flamer/startice", 2);
        FLMG A 1 {
            A_WeaponOffset(0,42);
            A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
        FLMG A 1 {
            A_WeaponOffset(0,46);
           A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
		FLMG A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
        FLMG A 1 
        {
            A_WeaponOffset(0,41);
             for(int i = 2; i > 0; i--)
            {
                A_SpawnItemEx("GunSmoke", 33, 0, 33, 3, 0, 0);
            }
        }
        FLMG A 1 {
            A_WeaponOffset(0,38);
			A_SpawnItemEx("GunSmoke", 33, 0, 36, 3, 0, 0);
        }
		TNT1 A 0 A_StartSound("Weapons/flamer/fireicebegin", 7);
        TNT1 A 0 A_StartSound("weapons/flamer/iceloop", 1, CHANF_LOOPING);
		TNT1 A 0 A_StartSound("weapons/flamer/icelooplayer", 6, CHANF_LOOPING,0.2);
		FLMG A 0 JM_CheckForQuadDamage();
	HoldingFireIce:
		FLMG A 0 A_JumpIf(CountInv("Gasoline") < 4, "StopFireIce");
        FTF2 ABCD 1 {
            A_WeaponOffset(random(-3,3), random(32, 36));
            A_FireProjectile("IcethrowerAttack",0,0,0,4);
			if(!GetCvar("mo_nogunrecoil"))
			{
				A_SetPitch(pitch-.4,SPF_Interpolate);
				A_SetAngle(angle-0,SPF_INTERPOLATE);
			}
			if(CountInv("Gasoline") < 4) {return ResolveState("StopFireIce");}
			return ResolveState(null);
			}
		TNT1 A 0 A_TakeInventory("Gasoline", 4);
        SAWG B 0 A_JumpIf(PressingFire(), "HoldingFireIce");
	StopFireIce:
		SAWG A 0 A_StopSound(1);
		SAWG A 0 A_StopSound(6);
		SAWG A 0 A_StartSound("weapons/flamer/end",1,chanf_default, 0.7);
		SAWG A 0 A_StartSound("weapons/flamer/iceend",3);
		Goto StopAnimation;
		
	ActionSpecial:
		FLMG A 0 A_StartSound("weapons/flamer/special1",CHAN_AUTO);
		FLMK ABCD 1;
		FLMG A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
		FLMK EF 1;
		FLMG A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
		FLMK F 1 A_WeaponOffset(-2, 34);
		FLMK F 1 A_WeaponOffset(-5, 37);
		FLMK F 25 {
			A_WeaponOffset(-8, 40);
			IF(CountInv("MO_PowerSpeed") == 1) {A_SetTics(12);}
		}
		FLMK F 1 A_WeaponOffset(-11, 43);
		FLMG A 0 A_StartSound("weapons/flamer/special2",CHAN_AUTO);
		FLMK F 1 A_WeaponOffset(-15, 47);
		FLMK F 1 A_WeaponOffset(-18, 50);
		FLMG A 0 
		{
			if(CountInv("IceMode") < 1)
			{
				A_StartSound("weapons/flamer/icemodeactive",CHAN_AUTO);
				A_SetInventory("IceMode",1);
				A_Print("Cryo mode activated");
			}
			else
			{
				A_StartSound("weapons/flamer/firemodeactive",CHAN_AUTO);
				A_SetInventory("IceMode",0);
				A_Print("Flame mode activated");
			}
		}
		FLMK F 1 A_WeaponOffset(-22, 54);
		FLMK F 1 A_WeaponOffset(-25, 57);
		FLMK F 1 A_WeaponOffset(-22, 54);
		FLMK F 8 	
		{
			A_WeaponOffset(-8, 40);
			IF(CountInv("MO_PowerSpeed") == 1) {A_SetTics(4);}
		}
		FLMK F 1 A_WeaponOffset(-15, 45);
		FLMG A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
		FLMK E 1 A_WeaponOffset(-7, 40);
		FLMK D 1 A_WeaponOffset(-4, 36);
		FLMG A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
		FLMK CBA 1 A_WeaponOffset(0,32);
		Goto ReadyToFire;
		
    Spawn:
        F1MC A -1;
        Stop;
	FlashKick:
		"####" A 0 A_JumpIfInventory("MO_PowerSpeed",1,"FlashKickFast");
		FLMK ABCDEFFFFFEDCBA 1;
		Goto ReadyToFire;
	FlashKickFast:
		FLMK ABCDEFFFEDCBA 1;
		Goto ReadyToFire;
	FlashAirKick:
		"####" A 0 A_JumpIfInventory("MO_PowerSpeed",1,"FlashAirKickFast");
		FLMK ABCDEFFFFFFFEDCBA 1;
		Goto ReadyToFire;
	FlashAirKickFast:
		FLMK ABCDEFFFFFFEDCBA 1;
		Goto ReadyToFire;
    } 
}
		 
//Based on PB's Flamethrower missile
Class FlamethrowerAttack : Actor
{
    default {
		Radius 12;
		Height 8;
		Speed 12;
		DamageFunction (random(24, 28));
		+NOBLOCKMAP;
		+NOTELEPORT;
		+DONTSPLASH;
		+MISSILE;
		+FORCEXYBILLBOARD;
		+Randomize;
		-RIPPER;
		+NOBLOOD;
		+NOBLOODDECALS;
		+BLOODLESSIMPACT;
		-BLOODSPLATTER;
//		+HitMaster;
		RenderStyle "Add";
		DamageType "Fire";
		Scale 0.1;
		Gravity 0;
	}
	States {
		Spawn:
			TNT1 A 0;
			DB55 ABCDE 1 BRIGHT A_SetScale(frandom(0.02, 0.08),frandom(0.02, 0.08));
			DB55 FGH 1 BRIGHT A_SetScale(Scale.X+0.1, Scale.Y+0.1);
			DB55 IJKLMNOPQRSTUVWXYZ 1 BRIGHT {
				A_SetScale(Scale.X+0.04, Scale.Y+0.04);
				A_Explode(1, 85, 0);
			}
			TNT1 A 0 A_SpawnItemEx("FlamerAttackExplosion",0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
			Stop;
		Death:
			TNT1 A 0 A_Explode(8, 150, 0);
			TNT1 A 0 A_CheckFloor(1);
			TNT1 A 0 A_SpawnItemEx("GroundFlameSpawner",random (-25, 25), random (-15, 15),0,5);
			TNT1 A 0 A_SpawnItemEx("FlamerAttackExplosion",0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
			Stop;
    }
}

Class IceThrowerAttack : Actor
{
	Default
	{
		Radius 12;
		Height 8;
		Speed 12;
		DamageFunction (random(16, 22));
		+NOBLOCKMAP;
		+NOTELEPORT;
		+DONTSPLASH;
		+MISSILE;
		+FORCEXYBILLBOARD;
		+Randomize;
		-RIPPER;
		+NOBLOOD;
		+NOBLOODDECALS;
		+BLOODLESSIMPACT;
		-BLOODSPLATTER;
		DamageType "Ice";
		Translation "CryoBlue"; //New Translation to fix an issue with Legion of Bones' custom PLAYPAL palette, see TRNSLATE
		Decal "FreezeScorch";
		RenderStyle "Add";
		Alpha 0.8;
		Scale 0.1;
		Gravity 0;
	}
	States
	{
		Spawn:
			TNT1 A 0;
			DB55 ABCDE 1 BRIGHT A_SetScale(frandom(0.02, 0.08),frandom(0.02, 0.08));
			DB55 FG 1 BRIGHT 
			{
				A_SetScale(Scale.X+0.1, Scale.Y+0.1);
				A_SpawnProjectile ("IceThrowerSnowFlakes", 1, 0, random (0, 360), CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH|CMF_BADPITCH|CMF_SAVEPITCH, random (0, 360));
	//			A_SpawnProjectile ("CryoSmoke", 0, 0, random (0, 360), CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH|CMF_BADPITCH|CMF_SAVEPITCH, random (40, 160));
			}
			DB55 HIJKLMN 1  BRIGHT {
				A_SetScale(Scale.X+0.04, Scale.Y+0.04);
				A_Explode(1, 85, 0);
			}
			DB55 OPQ 1 BRIGHT {
				A_SetScale(Scale.X+0.04, Scale.Y+0.04);
				A_Explode(1, 85, 0);
				A_SpawnProjectile ("IceThrowerSnowFlakes", 1, 0, random (0, 360), CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH|CMF_BADPITCH|CMF_SAVEPITCH, random (0, 360));
			}
//			TNT1 A 0 A_SpawnProjectile ("CryoSmoke", 0, 0, random (0, 360), CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH|CMF_BADPITCH|CMF_SAVEPITCH, random (40, 160));
			DB55 STUVWXYZ 1 BRIGHT {
				A_SetScale(Scale.X+0.04, Scale.Y+0.04);
				A_Explode(1, 85, 0);
			}
			TNT1 A 0 A_SpawnItemEx("IcethrowerAttackExplosion",0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);

		Death:
			TNT1 A 0 A_Explode(8, 150, 0);
			TNT1 A 0 A_SpawnItemEx("IcicleSpawner",0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
			TNT1 A 1 A_SpawnItemEx("IcethrowerAttackExplosion",0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
			Stop;
	}
}