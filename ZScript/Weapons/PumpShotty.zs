
class PumpShotgun : JMWeapon
{
    Default
    {
        Weapon.AmmoGive 6;
        Weapon.AmmoType "MO_ShotShell";
        Weapon.AmmoType2 "PumpShotgunAmmo";
        Inventory.PickupMessage "You got the Pump Action Shotgun! (Slot 3)";
        Obituary "%o was blasted away by %k's Pump Shotgun.";
        Tag "Pump Shotgun";
		Inventory.PickupSound "weapons/pumpshot/pump";
    }
    States
    {
		Inspect:
			TNT1 A 0 JM_SetInspect(true);
			PSGS E 7 JM_WeaponReady();
			PSGM ABCDEF 1 JM_WeaponReady();
			PGR2 A 0 A_StartSound("weapons/pumpshot/pumpBACK", 0);
			PGR2 A 1 JM_WeaponReady();
			PGR2 B 6 JM_WeaponReady();
            PGR2 CCD 1 JM_WeaponReady();
			PGR2 A 0 A_StartSound("weapons/pumpshot/load", 1);
            PGR2 EF 1 JM_WeaponReady();
//			PGR2 A 0 JM_LoadShell("PumpShotgunAmmo","Shell",1);
            PGR2 GHIJKKKKKK 1 JM_WeaponReady();
            PGR2 A 0 A_StartSound("weapons/pumpshot/pumpforward", 0);
            PGR2 KLM 1 JM_WeaponReady();
            PGR2 M 9 JM_WeaponReady();
			PGR2 A 0 A_StartSound("weapons/pumpshot/pumpback", 1);
			PGR2 LKKKKKKK 1 JM_WeaponReady();
			PGR2 L 1 A_StartSound("weapons/pumpshot/pumpforward", 0);
			PGR2 M 6 JM_WeaponReady();
            Goto DoneReload;
        Ready:
		SelectAnimation:
            PSGS A 0 A_StartSound("weapons/pumpshot/draw", CHAN_AUTO);
            PSGS ABCDE 1;
			TNT1 A 0 A_JumpIf(!JM_CheckInspect(), "Inspect");
        ReadyToFire:
            PSGG A 1 JM_WeaponReady(WRF_ALLOWRELOAD);
            Loop;
        Deselect:
			PSGS EDCBA 1;
            SHTG A 0 A_Lower(12);
            WAIT;
        Select:
            TNT1 A 0;
            Goto ClearAudioAndResetOverlays;
		ContinueSelect:
			TNT1 AAAAAAAAAAAAAAAAAA 0 A_Raise();
			Goto Ready;
        Fire:
            PSTG A 0 JM_CheckMag("PumpShotgunAmmo", "Reload");
            PSGF A 1 
            {
                A_FireBullets (random(3, 6), frandom(2,8), 20, 6, "ShotgunShellPuff", FBF_NORANDOM,0,"MO_BulletTracer",0);
                A_StartSound ("weapons/pumpshot/fire", CHAN_WEAPON);
                A_TakeInventory("PumpShotgunAmmo",1);
				A_SpawnItemEx("ShotgunSmoke",15,0,34,2,0,0);
				JM_CheckForQuadDamage();
		    }
            PSGF BC 1 
			{
				if(!GetCvar("mo_nogunrecoil"))
				{
				A_SetPitch(pitch-1.6,SPF_Interpolate);
				A_SetAngle(angle+.13,SPF_INTERPOLATE);
				}
		    }
            PSGF D 1;
            PSGF E 1;
            PSGG A 4
			{
				if(CountInv("MO_PowerSpeed") == 1) {A_SetTics(2);}
			}
            Goto Pump;
        Pump:
            W87A A 0 SetInventory("Levering",1);
 //           W87A A 0 A_JumpIf(CountInv("LeverShottyAmmo") < 1, "TerminatorLever");
            PSGM ABC 1;		
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			PSGM DEFG 1;
            W87A A 0 A_StartSound("weapons/pumpshot/pumpback", 0);
            PSGM H 1
			{
				SetInventory("Levering",0);
				A_SpawnItemEx("ShotgunCasing20ga",30, -11, 18, random(0,4), random(4,6), random(5,9));
			}
			TNT1 A 0 JM_WeaponReady(WRF_NOFIRE); //Quick switch	
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
            PSGM IJKL 1 JM_WeaponReady(WRF_NOFIRE);
			W87A A 0 A_StartSound("weapons/pumpshot/pumpforward", 0);
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			PSGM LKJ 1 JM_WeaponReady(WRF_NOFIRE);
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,3);
            PSGM IHGFEDCBA 1 JM_WeaponReady(WRF_NOFIRE);
            PSGG A 1 A_JumpIf(PressingFire(), "Fire");
            Goto ReadyToFire;
			
		AltFire:
			PSTG A 0 A_JumpIf(CountInv("PumpShotgunAmmo") == 1, "Fire");
			PSTG A 0 JM_CheckMag("PumpShotgunAmmo", "Reload");
			TNT1 A 0 A_StartSound ("weapons/pumpshot/fire", CHAN_WEAPON, CHANF_DEFAULT, 0.85);
			TNT1 A 0 A_StartSound("weapons/pumpshot/altfire",CHAN_7);
			PSGF A 1 
            {
                 A_FireBullets (random(4, 8), frandom(3,12), 40, 6, "ShotgunShellPuff", FBF_NORANDOM,0,"MO_BulletTracer",0);
                A_TakeInventory("PumpShotgunAmmo",2);
				A_SpawnItemEx("ShotgunSmoke",15,0,34,2,0,0);
				JM_CheckForQuadDamage();
		    }
            PSGF B 1 
			{
				if(!GetCvar("mo_nogunrecoil"))
				{
				A_SetPitch(pitch-2.5,SPF_Interpolate);
				A_SetAngle(angle+.13,SPF_INTERPOLATE);
				}
		    }
			PSGF C 1 
			{
				if(!GetCvar("mo_nogunrecoil"))
				{
				A_SetPitch(pitch-1.8,SPF_Interpolate);
				A_SetAngle(angle+.13,SPF_INTERPOLATE);
				}
		    }
			PSGF C 1 
			{
				if(!GetCvar("mo_nogunrecoil"))
				{
				A_SetPitch(pitch-1.8,SPF_Interpolate);
				A_SetAngle(angle+.13,SPF_INTERPOLATE);
				}
		    }
            PSGF D 3;
            PSGF E 4;
            PSGG A 10
			{
				if(CountInv("MO_PowerSpeed") == 1) {A_SetTics(5);}
			}
            Goto AltPump;
		
		AltPump:
             W87A A 0 SetInventory("Levering",1);
 //           W87A A 0 A_JumpIf(CountInv("LeverShottyAmmo") < 1, "TerminatorLever");
            PSGM ABC 1;		
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			PSGM DEFG 1;
            W87A A 0 A_StartSound("weapons/pumpshot/pumpback", 0);
            PSGM H 1
			{
				SetInventory("Levering",0);
				A_SpawnItemEx("ShotgunCasing20ga",30, -11, 18, random(0,4), random(4,6), random(5,9));
				A_SpawnItemEx("ShotgunCasing20ga",30, -11, 18, random(0,4), random(4,6), random(5,9));
			}
			TNT1 A 0 JM_WeaponReady(WRF_NOFIRE); //Quick switch	
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
            PSGM IJKL 1 JM_WeaponReady(WRF_NOFIRE);
			W87A A 0 A_StartSound("weapons/pumpshot/pumpforward", 0);
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			PSGM LKJ 1 JM_WeaponReady(WRF_NOFIRE);
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,3);
            PSGM IHGFEDCBA 1 JM_WeaponReady(WRF_NOFIRE);
            PSGG A 1 A_JumpIf(PressingAltFire(), "AltFire");
            Goto ReadyToFire;
			
        Flash:
            TNT1 A 1 Bright A_Light1;
            TNT1 B 1 Bright A_Light2;
            Goto LightDone;
        Reload:
			PSTG A 0 A_JumpIfInventory("PumpShotgunAmmo",6,"ReadyToFire");
			PSTG A 0 A_JumpIfInventory("MO_ShotShell",1,1);
			goto ReadyToFire;
            PSGM ABCDEF 1;// JM_WeaponReady();
            PSGA A 0 A_JumpIf(CountInv("PumpShotgunAmmo") < 1, "ChamberShell");
			PSGR AB 1;// JM_WeaponReady();
			PGR1 I 5;
        ShellLoop:
            PSTG A 0 A_JumpIfInventory("PumpShotgunAmmo",6,"DoneReload");           
			TNT1 A 0 A_JumpIfInventory("MO_ShotShell",1,1);
			Goto DoneReload;
            PGR1 AB 1 JM_WeaponReady(WRF_NOFIRE);
            PGR1 C 1 A_StartSound("weapons/pumpshot/load", 1);
            PISG A 0 JM_LoadShell("PumpShotgunAmmo","MO_ShotShell",1);
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,3);
            PGR1 DEFGHI 1 JM_WeaponReady(WRF_NOFIRE);
            PGR1 I 6 {
				JM_WeaponReady(WRF_NOFIRE);
				if(CountInv("MO_PowerSpeed") == 1) {A_SetTics(2);}
			}
            PISG A 0;
            PISG A 0 A_ReFire();
            Loop;
        DoneReload:
            PSGR BA 1;
            PSGM EDCBA 1;
            Goto ReadyToFire;
        ChamberShell:
            TNT1 A 0 A_StartSound("weapons/pumpshot/pumpback", 0);
            PGR2 A 1;
			PGR2 B 6 {
				if(CountInv("MO_PowerSpeed") == 1) {A_SetTics(3);}
			}
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
            PGR2 CCD 1;
			PGR2 A 0 A_StartSound("weapons/pumpshot/load", 1);
            PGR2 EF 1;
			PGR2 A 0 JM_LoadShell("PumpShotgunAmmo","MO_ShotShell",1);
            PGR2 GHIJ 1;
			PSTF A 0 A_JumpIfInventory("MO_PowerSpeed",1,4);
			PGR2 KKKKKK 1;
            PGR2 A 0 A_StartSound("weapons/pumpshot/pumpforward", 0);
            PGR2 KLM 1;
            PGR2 M 9 
			{
				if(CountInv("MO_PowerSpeed") == 1) {A_SetTics(5);}
			}
			TNT1 A 0 A_ReFire();
            Goto ShellLoop;
		FlashKick:
		PSGM ABCDEF 1;
		PSGM F 4;
		PSGM EEDCBA 1;
		Goto ReadyToFire;
	FlashAirKick:
		PSGM ABCDEF 1;
		PSGM F 6;
		PSGM EEDCBA 1;
		Goto ReadyToFire;
        Spawn:
            PSGC A -1;
            Stop;
    }
	
	//This is so that the shell loading of the inventory give and take is in one function for the Shotgun
	action void JM_LoadShell(name type, name reserve, int c)
	{
		TakeInventory(reserve, c);
		GiveInventory(type, c);
	}
}

class PumpShotgunAmmo : Ammo
{
	Default
	{
		Inventory.Amount 0;
		Inventory.MaxAmount 6;
		Ammo.BackpackAmount 0;
		Ammo.BackpackMaxAmount 6;
		Inventory.Icon "PSGCA0";
	}
}