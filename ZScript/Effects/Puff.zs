Class UpdatedBulletPuff : BulletPuff //Inherits from base BulletPuff to fix a sound glitch with the Revenant Tracer playing the riochet sound repeatedly
{
	Default
	{
	-ALLOWPARTICLES;
	-DONTSPLASH;
	-EXPLODEONWATER;
	+NOEXTREMEDEATH;
    +FORCEXYBILLBOARD;
	+THRUACTORS;
	+NOCLIP;
	+NOGRAVITY;
	RenderStyle "Add";
	Scale .1;
	Alpha 0.8;
	VSpeed 0;
	Decal "BulletChip";
	Height 1;
	}
	States
	{
		Spawn:
		NULL A 0;
		NULL A 0 A_SpawnItemEX("BulletImpactSmoke");
		TNT1 AAA 0 A_SpawnProjectile("EnhancedHitSpark1", 2, 0, frandom(0,1)*frandom (-180, 180),  flags:CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH, pitch: pitch - frandom(0,1)*frandom (30, 360));
		TNT1 AA 0 A_SpawnProjectile("EnhancedHitSpark2", 2, 0, frandom(0,1)*frandom (-180, 180), flags:CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH, pitch: pitch - frandom(0,1)*frandom (30, 360));
		TNT1 A 0 A_SpawnProjectile("EnhancedHitSpark3", 2, 0, frandom(0,1)*frandom (-180, 180), flags:CMF_AIMDIRECTION|CMF_ABSOLUTEPITCH|CMF_OFFSETPITCH, pitch: pitch - frandom(0,1)*frandom (30, 360));
		TNT1 A 0
		{
			if(CVar.FindCVar("mo_bulletsparksound").GetBool() == False)
			{return resolvestate("NoSound");}
			return resolvestate(null);
		}
		NULL A 0 A_StartSound("ricochet",7);
		NoSound:
		TNT1 A 1 A_SpawnItemEx("BulletRicochet",0,0,0,0,0,0);
		TNT1 A 1 BRIGHT;
		STOP;
	}
}

Class KatanaPuff : UpdatedBulletPuff
{
	Default
	{
		DamageType "Cut"; //For Brutal Doom Monsters only compatiblity
		-ALLOWPARTICLES
		Decal "SwordSlashMark";
		+NOINTERACTION;	
	} 
	
	States
	{
		Spawn:
		Melee:
		TNT1 CD 4;
		Stop;
		
		Crash:
			TNT1 A 0 A_StartSound("Weapons/Katana/Miss", 3);
			TNT1 A 0
			{
				A_SpawnDebris("Sparky");
				//A_SprayDecal("SwordSlashMark");
//				ACS_NamedExecute("SwordDecalSpawner",0,0,0,0);
			}
			BPUF ABCD 1 bright Light("BulletHitLight");
			STOP;
	}
}

class KatanaPuff2 : KatanaPuff // Same as KatanaPuff but it spawns the flipped decal
{Default {Decal "SwordSlashMarkFlipped";}}

class MinigunPuff : UpdatedBulletPuff
{
	Default
	{
		DamageType "Minigun"; //For Brutal Doom Monsters only compatiblity, to shred up the monsters
	} 
}

class ShotgunShellPuff : UpdatedBulletPuff
{
	Default
	{
		DamageType "Shotgun"; //For Brutal Doom Monsters only compatiblity, to shred up the monsters
	} 
}

class SSGPuff : UpdatedBulletPuff
{
	Default
	{
		DamageType "SSG"; //For Brutal Doom Monsters only compatiblity, to shred up the monsters
	} 
}

class KickingPuff : UpdatedBulletPuff
{	
	Default
	{
		DamageType "Kick";
		+NODECAL;
	} 
	States
	{
		Spawn:
		Melee:
		TNT1 CD 4;
		Stop;
		
		Crash:
			TNT1 A 0 A_SpawnItemEx("KickSmoke");
			TNT1 A 1 A_StartSound("playerkick/footwall", 3);
			TNT1 AA 4;
			STOP;
	}
}

Class BerserkKickPuff : KickingPuff
{
	Default
	{
		DamageType "ExtremePunches"; //For Brutal Doom Monsters only compatiblity
		-ALLOWPARTICLES
	} 
}

Class Sparky : Actor
{
  Default
  {
  +Doombounce;
  +NoTeleport;
  +ForceXYBillboard;
  +missile;
  +dontsplash;
  Health 4;
  Radius 3;
  Height 6;
  Speed 0.1;
  RenderStyle "ADD";
  Alpha 0.85;
  Scale 0.04;
  Mass 0;
  }
  States
  {
  Spawn:
    BPUF ABCD 1 bright A_FadeOut(0.05);
    loop;
  }
}

//From Particle Fire Enhancer Mod (v0.8) by Z86
Class MO_BulletTracer : FastProjectile
{
	Default
	{
	RenderStyle "Add";
	Alpha 0.8;
	YScale 0.12;
	XScale 0.3;
	Speed 300;
	radius 10;
	height 8;
	damage 0;
	+PAINLESS;
	SeeSound "Whizby";
	}
	States
	{
	Spawn:
		TRAC A 1 bright;
		loop;
	Death:
		NULL A 0;
		stop;
	}
}

