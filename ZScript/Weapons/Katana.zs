/////////////////
//   Katana    //
////////////////

class Katana: JMWeapon replaces Fist
{
	  Default 
	  {
	  Obituary "%o was sliced and diced by %k's Katana.";
	  Tag "Katana";
//	  +WEAPON.WIMPY_WEAPON;
	  +WEAPON.NOALERT;
	  Inventory.AltHudIcon "KATAN0";
	  }
	  States
	  {
	  Ready:
	  ReadyToFire:
		KTAG A 1 JM_WeaponReady();
		Loop;
	  Deselect:
		TNT1 A 0 A_STARTSOUND("weapons/katana/sheathe", CHAN_AUTO, CHANF_DEFAULT,0.7);
		DesLoop:
		KTAG A 1 A_Lower;
		Loop;
	  Select:
	  TNT1 A 0;
	  Goto ClearAudioAndResetOverlays;
	  
	  ContinueSelect:
	  TNT1 A 0 A_StartSound("weapons/katana/draw",CHAN_AUTO);
	AnimLoop:
	SelectAnimation:
		KTAG A 1 A_Raise;
		Loop;
	  Fire:
		KTAF ABCD 1;
	  Swing1:
		TNT1 A 0 A_STARTSOUND("weapons/katana/swing", 7,CHANF_DEFAULT, 0.45);
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(1);
			return resolveState(null);
		}
		KTAF EF 1;
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		KTAF G 1;
		KTAF H 1 {
			 JM_CheckForQuadDamage();
			if(CountInv("PowerStrength") == 1)
			{
				A_CustomPunch(120, TRUE, CPF_NOTURN, "KatanaPuff", 96, 0, 0, "none", "weapons/katana/hit");
			}
			else
			{
				A_CustomPunch(36, TRUE, CPF_NOTURN, "KatanaPuff", 96, 0, 0, "none", "weapons/katana/hit");
			}
		}
		KTAF IJ 1;
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		TNT1 AAA 1;
		TNT1 A 0 A_JumpIf(PressingFire(), "Swing2");
		Goto Ready;
	Swing2:
		TNT1 A 0 A_STARTSOUND("weapons/katana/swing", 6);
		KTAF LM 1;
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		KTAF NO 1;
		KTAF Q 1 {
			 JM_CheckForQuadDamage();
			if(CountInv("PowerStrength") == 1)
			{
				if(health <= 30)
				{
				A_CustomPunch(260, TRUE, CPF_NOTURN, "KatanaPuff2", 96, 0, 0, "none", "weapons/katana/hit");
				}
				else
				{A_CustomPunch(130, TRUE, CPF_NOTURN, "KatanaPuff2", 96, 0, 0, null, "weapons/katana/hit");}
			}
			else
			{
				A_CustomPunch(36, TRUE, CPF_NOTURN, "KatanaPuff2", 96, 0, 0, null, "weapons/katana/hit");
			}
		}
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		KTAF R 1;
		KTAF S 1;
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		TNT1 AAA 1;
		TNT1 A 0 A_JumpIf(PressingFire(), "Swing1");
		Goto ReturnToAction;
	AltFire:
		KTAF AB 1;
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		KTAF C 1;
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(1);
			return resolveState(null);
		}
		KTAH ABC 1;
	AltHold:
		KTAH C 1;
		TNT1 A 0 A_JumpIf(PressingAltFire(), "AltHold");
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		KTAH DE 1;
		KTAH F 1 A_STARTSOUND("weapons/katana/swing", 6);
		KTAH G 1;
		KTAF H 1 {
			JM_CheckForQuadDamage();
			if(CountInv("PowerStrength") == 1)
			{
				if(health <= 30)
				{
				A_CustomPunch(280, TRUE, CPF_NOTURN, "KatanaPuff", 96, 0, 0, "none", "weapons/katana/hit");
				}
				else
				{A_CustomPunch(170, TRUE, CPF_NOTURN, "KatanaPuff", 96, 0, 0, "none", "weapons/katana/hit");}
			}
			else
			{
				A_CustomPunch(45, TRUE, CPF_NOTURN, "KatanaPuff", 96, 0, 0, "none", "weapons/katana/hit");
			}
		}
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		KTAF I 1;
		KTAF J 1;
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		TNT1 AAA 1;	
	ReturnToAction:
		KTAK FE 1;
		TNT1 A 0
		{
			if(health <= 30 || CountInv("MO_PowerSpeed") == 1)
			return ResolveState(2);
			return resolveState(null);
		}
		KTAK DCBA 1;
		Goto ReadyToFire;
	 FlashKick:
		KTAK ABCDEF 1;
		KTAK F 4;
		KTAK EEDCBA 1;
		Goto ReadyToFire;
	FlashAirKick:
		KTAK ABCDEF 1;
		KTAK F 6;
		KTAK EEDCBA 1;
		Goto ReadyToFire;
   }
}