class JMWeapon : Weapon
{
	bool isFirstTime;
	property firstTime: isFirstTime;
	
	bool pressedKick;
	property pressedKick: pressedKick;
	
	 //Credits: Matt
    action bool JustPressed(int which) // "which" being any BT_* value, mentioned above or not
    {
        return player.cmd.buttons & which && !(player.oldbuttons & which);
    }
    action bool JustReleased(int which)
    {
        return !(player.cmd.buttons & which) && player.oldbuttons & which;
    }

    //Based on IsPressingInput from Project Brutality
    action bool PressingWhichInput(int which)
    {
        return player.cmd.buttons & which;
    }
	
	action void JM_CheckForQuadDamage()
	{
		If(CheckInventory("MO_PowerQuadDmg",1))
		{
			A_StartSound("powerup/quadfiring",70, CHANF_OVERLAP,3.0,ATTN_NONE);
		}
	}
	
	action bool PressingFire(){return player.cmd.buttons & BT_ATTACK;}
    action bool PressingAltfire(){return player.cmd.buttons & BT_ALTATTACK;}
	
	action state JM_CheckMag(name type, statelabel st = "Reload")
	{
		if(CountInv(type) <= 0)
		{
			return ResolveState(st);
		}
		return ResolveState(Null);
	}
	
	//Based on the Set and Check functions from Project Brutality
	action void JM_SetInspect(bool type)
	{
		invoker.isFirstTime = type;
	}
	
	action bool JM_CheckInspect()
	{
		return invoker.isFirstTime;
	}
	
	action state JM_WeaponReady(int flags = WRF_ALLOWUSER1|WRF_ALLOWUSER3|WRF_ALLOWUSER4)
	{	
		A_WeaponReady(flags);
		if(JustPressed(BT_USER1))
		{
			return ResolveState("TossThrowable");
		}
		
		if(JustPressed(BT_USER3))
		{
			return ResolveState("SwitchThrowables");
		}
		if(JustPressed(BT_USER4))
		{
			State ActionSpecial = invoker.owner.player.ReadyWeapon.FindState("ActionSpecial");
			if(ActionSpecial != NULL)
				return ResolveState('ActionSpecial');
			else
			return null;
		}	
		return null;
	}
	
	action void JM_PressedKick (bool type)
	{
		invoker.pressedKick = type;
	}
	
	action bool JM_CheckIfKicked()
	{
		return invoker.pressedKick;
	}
	
	action bool CheckIfInReady()
	{
		if ( (InStateSequence(invoker.owner.player.GetPSprite(PSP_WEAPON).Curstate,invoker.ResolveState("Ready")) || 
			  InStateSequence(invoker.owner.player.GetPSprite(PSP_WEAPON).Curstate,invoker.ResolveState("ReadyToFire"))||
			  InStateSequence(invoker.owner.player.GetPSprite(PSP_WEAPON).Curstate,invoker.ResolveState("ReadyToFire2"))
			 ) )
		{		
			return true;
		}
		return false;
	}
	
	action void JM_ReloadGun(name magammo, name reserve, int magMax, int reserveTake)
	{
		for(int i = 0; i < magMax; i++)
		{
			if(CountInv(reserve) < 1 || CountInv(magammo) == magMax) 
			return;
			
			A_GiveInventory(magammo, 1);
			A_TakeInventory(reserve, reserveTake, TIF_NOTAKEINFINITE);
		}
	}
	
//Basically A_TakeInventory but with the TIF_NOTAKEINIFNITE Flag built in, for the ammo
	action void JM_UseAmmo(name ammotype, int count)
	{
		A_TakeInventory(ammotype, count, TIF_NOTAKEINFINITE);
	}

	action void JM_GunRecoil(float gunPitch, float gunAngle)
	{
		CVar checkRecoil = CVar.FindCVar("mo_nogunrecoil");
		bool noRecoil = checkRecoil.GetBool();
		if(!noRecoil)
		{
			A_SetPitch(pitch+gunPitch, SPF_INTERPOLATE);
			A_SetAngle(angle+gunAngle, SPF_INTERPOLATE);
		}
	}
	
    Default
    {
        Weapon.BobStyle "InverseSmooth";
        Weapon.BobRangeX 0.3;
		Weapon.BobRangeY 0.6;
		Weapon.BobSpeed 1.5;
        +DONTGIB;
        Inventory.PickupMessage "How did you pick this up? You're not supposed to see or use this.";
    }
	
	States
	{
		
		Select:
			TNT1 A 1 A_RAISE();
			wait;
		ClearAudioAndResetOverlays:
			TNT1 A 0;
			TNT1 A 1 {
				A_StopSound(CHAN_5);
				A_StopSound(CHAN_WEAPON);
				A_StopSound(CHAN_6);
				A_STOPSOUND(CHAN_7);
				SetPlayerProperty(0,0,0);
				A_Overlay(-99, "KickHandler");
				A_ClearOverlays(-8,8);
				JM_PressedKick(false);
				}
			TNT1 A 0 A_Jump(255, "ContinueSelect");
			Loop;
		Deselect:
			TNT1 A 1 A_Lower();
			Loop;
		
		KickHandler:
			TNT1 A 1
			{
				if(JustPressed(BT_USER2) && !JM_CheckIfKicked() && health >= 1)
				{
					JM_PressedKick(true);
					A_OverlayOffset(-999,0,32);
					A_Overlay(-999, "Kick");
				}
			}
			Loop;
			
		Ready:
		FIRE:
		ReallyReady:
			"####" A 0;
			"####" A 0;
			"####" AAAA 1 A_Jump(256, "readytofire");
			Loop;
		BackToWeapon:
			TNT1 A 1 A_Jump(256, "SelectAnimation");
			Loop;
			
		Kick:
			"####" A 0 A_ZoomFactor(1.0);
			"####" A 0 A_StopSound(CHAN_VOICE);
			"####" A 0 A_JumpIf (vel.Z != 0, "AirKick");
			"####" A 0
			{	
				if(CheckIfInReady())
				{
					A_Overlay(PSP_WEAPON, "FlashKick");
					A_OverlayOffset(PSP_WEAPON, 0, 32);
				}
			}
			"####" A 0;// A_OverlayFlags(PSP_WEAPON,PSPF_PLAYERTRANSLATED,TRUE);
			"####" A 0 SetPlayerProperty(0,1,0);
			"####" A 0 A_JumpIfInventory("MO_PowerSpeed",1,"KickFaster");
			KCK1 ABC 1;
			"####" A 0 A_StartSound("playerkick",0);
			KCK1 DEF 1;
			KCK1 G 1
			{
				if(CountInv("PowerStrength") == 1)
				{
					if(health < 25)
					{A_CustomPunch(65 * 3, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");}
					else
					{A_CustomPunch(65, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");}
				}
				else
				{
					A_CustomPunch(30, TRUE, CPF_NOTURN, "KickingPuff", 80, 0, 0, "none", "playerkick/hit");
				}
			}
			KCK1 GHG 1;
			KCK1 FEDCBA 1;
			TNT1 A 0 JM_PressedKick(false);// A_OverlayFlags(PSP_WEAPON,PSPF_PLAYERTRANSLATED,FALSE);
			TNT1 A 0 SetPlayerProperty(0,0,0);
			Stop;
		
		KickFaster:
			KCK1 ABC 1;
			"####" A 0 A_StartSound("playerkick",0);
			KCK1 DF 1;
			KCK1 G 1
			{
				if(CountInv("PowerStrength") == 1)
				{
					if(health < 25)
					{A_CustomPunch(65 * 3, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");}
					else
					{A_CustomPunch(65, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");}
				}
				else
				{
					A_CustomPunch(30, TRUE, CPF_NOTURN, "KickingPuff", 80, 0, 0, "none", "playerkick/hit");
				}
			}
			KCK1 HG 1;
			KCK1 FEDCA 1;
			TNT1 A 0 JM_PressedKick(false);// A_OverlayFlags(PSP_WEAPON,PSPF_PLAYERTRANSLATED,FALSE);
			TNT1 A 0 SetPlayerProperty(0,0,0);
			Stop;
		AirKick:
			"####" A 0 ThrustThing(angle * 256 / 360, 3, 0, 0);
			"####" A 0
			{	
				if(CheckIfInReady())
				{
					A_Overlay(PSP_WEAPON, "FlashAirKick");
					A_OverlayOffset(PSP_WEAPON, 0, 32);
				}
			}
			"####" A 0 A_JumpIfInventory("MO_PowerSpeed",1,"AirKickFaster");
			KCK2 AABC 1;
			"####" A 0 A_StartSound("playerkick",0);
			KCK2 DEE 1;
			KCK2 F 1 
			{
				if(CountInv("PowerStrength") == 1)
				{
					if(health < 25)
					{A_CustomPunch(65 * 3, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");}
					else
					{A_CustomPunch(65, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");}
				}
				else
				{
					A_CustomPunch(30, TRUE, CPF_NOTURN, "KickingPuff", 80, 0, 0, "none", "playerkick/hit");
				}
			}
			KCK2 GGHHI 1;
			KCK2 JKLMN 1;
			TNT1 A 0 JM_PressedKick(false);
			Stop;
		
		AirKickFaster:
			KCK2 ABC 1;
			"####" A 0 A_StartSound("playerkick",0);
			KCK2 DE 1;
			KCK2 F 1 
			{
				if(CountInv("PowerStrength") == 1)
				{
					if(health < 25)
					{A_CustomPunch(65 * 3, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");}
					else
					{A_CustomPunch(65, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");}
				}
				else
				{
					A_CustomPunch(30, TRUE, CPF_NOTURN, "KickingPuff", 80, 0, 0, "none", "playerkick/hit");
				}
			}
			KCK2 GGHI 1;
			KCK2 JKLN 1;
			TNT1 A 0 JM_PressedKick(false);
			Stop;
			
/*		KickNoFlash:
			"####" A 0
			{	
				A_OverlayOffset(PSP_WEAPON,0,32);
				A_OverlayOffset(-999, 0, 32);
			}
			"####" A 0 A_ZoomFactor(1.0);
			"####" A 0 A_StopSound(6);
			"####" A 0 A_StopSound(CHAN_VOICE);
			"####" A 0 A_JumpIf (vel.Z != 0, "AirKickNoFlash");
			TNT1 A 0;// A_OverlayFlags(PSP_WEAPON,PSPF_PLAYERTRANSLATED,TRUE);
			TNT1 A 0 SetPlayerProperty(0,1,0);
			KCK1 ABC 1;
			"####" A 0 A_StartSound("playerkick",0);
			KCK1 DEF 1;
			KCK1 G 1
			{
				if(CountInv("PowerStrength") == 1)
				{
					A_CustomPunch(random(35,40) * 2, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");
				}
				else
				{
					A_CustomPunch(random(25,30), TRUE, CPF_NOTURN, "KickingPuff", 80, 0, 0, "none", "playerkick/hit");
				}
			}
			KCK1 GHG 1;
			KCK1 FEDCBA 1;
			TNT1 A 0;// A_OverlayFlags(PSP_WEAPON,PSPF_PLAYERTRANSLATED,FALSE);
			TNT1 A 0 SetPlayerProperty(0,0,0);
			Goto Ready;
		
		AirKickNoFlash:
			TNT1 A 0 ThrustThing(angle * 256 / 360, 6, 0, 0);
			KCK2 AABC 1;
			"####" A 0 A_StartSound("playerkick",0);
			KCK2 DEE 1;
			KCK2 F 1 
			{
				if(CountInv("PowerStrength") == 1)
				{
					A_CustomPunch(random(35,40) * 2, TRUE, CPF_NOTURN, "BerserkKickPuff", 80, 0, 0, "none", "playerkick/hit");
				}
				else
				{
					A_CustomPunch(random(25,30), TRUE, CPF_NOTURN, "KickingPuff", 80, 0, 0, "none", "playerkick/hit");
				}
			}
			KCK2 GGHI 1;
			KCK2 JKLMN 1;
			Goto ReallyReady;*/
		
		SwitchThrowables:
			"####" "#" 1 {
				if(CountInv("FragSelected") == 1)
				{
					A_SetInventory("FragSelected",0);
					A_SetInventory("MolotovSelected",1);
					A_Print("Molotov Cocktails Selected");
					A_StartSound("MOLPKUP",3);
				}
				else
				{
					A_SetInventory("FragSelected",1);
					A_SetInventory("MolotovSelected",0);
					A_Print("Frag Grenades Selected");
					A_StartSound("FragGrenade/Pickup",3);
				}
			}
			Goto ReallyReady;
		//From the PB Add-on	
		TossThrowable:
			"####" "#" 0;
			"####" "#" 0 {
				if(CountInv("FragSelected") == 1)
				{return ResolveState("ThrowGrenade");}
				else if(CountInv("MolotovSelected") == 1)
				{return ResolveState("ThrowMolotov");}
				return resolvestate(null);
			}
			Goto Ready;
			
		ThrowMolotov:
		"####" "#" 0 A_ZoomFactor(1.0);
			"####" "#" 0 A_StopSound(6);
			"####" "#" 0 A_StopSound(CHAN_VOICE);
			"####" "#" 1 A_JumpIfInventory("MolotovAmmo", 1, 2);
			"####" "#" 0 A_Print("No Molotov Cocktails left");
			Goto ReallyReady;
			MTOV AB 1;
			TNT1 A 0 A_StartSound("Molotov/Open",0);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			MTOV CDE 1;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			MTOV FG 1;
			MTOV H 2 {
				A_StartSound("Molotov/Lit",1);
				if(CountInv("MO_PowerSpeed") == 1) {A_SetTics(1);}
			}
			MTOV I 1 A_StartSound("Molotov/Flame",0,CHANF_DEFAULT,2.0);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			MTOV JKK 1;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			MTOV LLM 1;
//			MOLO FG 2 A_SpawnItemEx ("FlameTrails",cos(pitch)*1,0,0-(sin(pitch))*-10,cos(pitch)*20,0,-sin(pitch)*20,0,SXF_NOCHECKPOSITION);
			MOLO A 0 A_StartSound("Molotov/Close", 5);
//			MOLO H 2 A_SpawnItemEx ("FlameTrails",cos(pitch)*1,0,0-(sin(pitch))*-10,cos(pitch)*20,0,-sin(pitch)*20,0,SXF_NOCHECKPOSITION);
			MTOV N 1;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			MTOV OP 1;
			TNT1 A 0;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,3);
			TNT1 AAAA 1;
			//HND1 I 2
			TNT1 A 0 A_StartSound("MOLTHRW",0,CHANF_DEFAULT,2.0);
			MTOV QRS 1;
			MTOV A 0 
			{
				A_FireProjectile("MolotovThrown",0,0,0,0,FPF_NOAUTOAIM,0);
				A_TakeInventory("MolotovAmmo", 1, TIF_NOTAKEINFINITE);
			}
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			MTOV TUVW 1;
			TNT1 A 5
			{
//				A_StartSound("Molotov/Lit",1);
				if(CountInv("MO_PowerSpeed") == 1) {A_SetTics(2);}
			}
			TNT1 A 0 A_JumpIf(PressingWhichInput(BT_USER1), "ThrowMolotov");
			Goto BackToWeapon;
		
		CookingGrenade:
			TNT1 A 0;
			TNT1 A 0 ACS_Execute(2098,0,0,0,0);
		CookingGrenadeHold:
			TNT1 A 1 A_GiveInventory("GrenadeCookTimer", 1);			
			TNT1 A 0 A_JumpIf(CountInv("GrenadeCookTimer") == 105, "ExplodeOnYerFace");
			TNT1 A 0 A_JumpIf(PressingWhichInput(BT_USER1), "CookingGrenadeHold");
			Goto TossTheGrenade;
		
		ExplodeOnYerFace:
			TNT1 A 1
			{
					ACS_Terminate(2098,0);
					A_Explode(125, 220,XF_HURTSOURCE);
					A_AlertMonsters(200);
					A_StartSound("rocket/explosion", 6);
					A_SpawnItemEx("RocketExplosionFX",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
					A_SetInventory("GrenadeCookTimer",0);
			}
			TNT1 AAA 1;
			Goto BackToWeapon;
			
		ThrowGrenade:
			"####" "#" 0 A_ZoomFactor(1.0);
			"####" "#" 0 A_StopSound(6);
			"####" "#" 0 A_StopSound(CHAN_VOICE);
			"####" "#" 1 A_JumpIfInventory("GrenadeAmmo", 1, 2);
			"####" "#" 0 A_Print("No Frag Grenades left");
			Goto ReallyReady;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			GREP AABCD 1;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,2);
			GREP EFGII 1;
			TNT1 A 0 A_StartSound("FragGrenade/Pin",0);
			GREP K 1;
			TNT1 A 0 A_TakeInventory("GrenadeAmmo", 1, TIF_NOTAKEINFINITE);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,3);
			GREP LMNOPQ 1;
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,3);
			TNT1 A 0 A_JumpIf(PressingWhichInput(BT_USER1), "CookingGrenade");
//			MOLO FG 2 A_SpawnItemEx ("FlameTrails",cos(pitch)*1,0,0-(sin(pitch))*-10,cos(pitch)*20,0,-sin(pitch)*20,0,SXF_NOCHECKPOSITION);
			TNT1 AAAAA 1;
			//HND1 I 2
		TossTheGrenade:
			TNT1 A 0 ACS_Terminate(2098,0);
			GRE1 AB 1;
			TNT1 A 0 A_SetInventory("GrenadeThrownTimer", CountInv("GrenadeCookTimer"));
			TNT1 A 0 A_SetInventory("GrenadeCookTimer",0);
			TNT1 A 0 A_StartSound("FragGrenade/Throw",0,CHANF_DEFAULT,2.0);
			GRE1 C 1;
			MTOV A 0 A_FireProjectile("GrenadeThrown",0,0,0,8,FPF_NOAUTOAIM,0);
			TNT1 A 0 A_JumpIfInventory("MO_PowerSpeed",1,1);
			GRE1 DEFG 1;
			TNT1 A 4
			{
				A_StartSound("Molotov/Lit",1);
				if(CountInv("MO_PowerSpeed") == 1) {A_SetTics(2);}
			}
			TNT1 A 0 A_JumpIf(PressingWhichInput(BT_USER1), "ThrowGrenade");
			Goto BackToWeapon;
		
		//Failsafe just in case there are no flash kick states
		FlashKick:
		FlashAirKick:
		FlashSlideKick:
			"####" "#" 16;
			Goto ReallyReady;
		}
}