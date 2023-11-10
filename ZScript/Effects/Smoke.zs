Class GunSmoke : BaseVisualSFX
{
  Default
  {
	  Radius 0;
	  Height 0;
	  Scale 0.25;
	  Speed 1;
	  Renderstyle "Add";
	  Alpha 0.25;
  }
  States
  {
  Spawn:
    SM0K ABCDEFGHIJKLMNOPQ 1 A_FadeOut(0.01);
    stop;
  }
}

//Thanks sTULKER aka dimonass!
Class SparkSpray : Actor
{
	Default
	{
    +NOGRAVITY
    +NOBLOCKMAP
    -ALLOWPARTICLES
    +RANDOMIZE
    +NOEXTREMEDEATH
	+ROLLSPRITE
    Mass 0;
    Alpha 1.0;
    Speed 0;
    Scale 0.4;
	}
    States
    {
    Spawn:
       S9RK A 0 NoDelay A_SetRoll(random(-45, 45));
       S9RK A 1 bright;
       S9RK B 2 bright;
       S9RK C 1 bright;
	   Stop;
    }
}


class GunsmokeSpray : Actor
{
	Default
	{
    +NOGRAVITY;
    +NOBLOCKMAP;
    -ALLOWPARTICLES;
    +RANDOMIZE;
    +NOEXTREMEDEATH;
    +ROLLSPRITE;
    Mass 0;
    Speed 0;
	Scale 0.75;
    RenderStyle 'translucent';
    Alpha 0.8;
	}
    States
    {
    Spawn:
       GNSK A 0 NoDelay A_SetRoll(random(0, 359));
       GNSK A 1;
       GNSK A 2;
       GNSK BCDE 2 A_FadeOut(0.2);
	   Stop;
    }
}

class LittleGunsmokeSpray : GunsmokeSpray
{Default{Scale 0.45;}}

Class LittleGunSmoke : GunSmoke
{
  Default
  {
	  Radius 0;
	  Height 0;
	  Scale 0.15;
	  Speed 1;
  }
}

Class BigGunSmoke : GunSmoke
{
  Default
  {
	  Radius 0;
	  Height 0;
	  Scale 0.4;
	  Speed 1;
  }
}

Class ShotgunSmoke : GunSmoke
{
	Default
  {
	  Radius 0;
	  Height 0;
	  Scale 0.25;
	  Speed 1;
	  Renderstyle "Add";
	  Alpha 0.25;
  }
  States
  {
  Spawn:
    SMKA ABCDEFGHIJKLMNOPQ 1 A_FadeOut(0.01);
    stop;
  }
}

class KickSmoke : ShotgunSmoke
{
	Default
	{
		Scale .2;
		Alpha 0.4;
	}
}

class PlasmaCoolSmoke1 : ShotgunSmoke
{
	Default
	{
		Scale .17;
		Alpha 0.5;
	}
}

class PlasmaCoolSmoke2 : PlasmaCoolSmoke1
{
	Default
	{
		Alpha 0.3;
	}
}

class PlasmaCoolSmoke3 : PlasmaCoolSmoke1
{
	Default
	{
		Scale .12;
		Alpha 0.2;
	}
}
Class BulletImpactSmoke : GunSmoke
{
		Default{Scale 0.17;}
}

Class BulletSmoke : GunSmoke
{
  Default
  {
	  Scale 0.10;
	  Renderstyle "Add";
	  Alpha 0.5;
  }
}

Class EmptyCellSmoke : GunSmoke
{
	Default
	{
		Scale 0.5;
		Alpha 0.4;
	}
}
	
Class RestingBulletSmoke : BulletSmoke
{
	States
	{
		Spawn:
		TNT1 "###########################################" 2 A_SpawnItemEx("BulletSmoke",frandom(0.3,0.2),random(0,-1.0),0,0,0,frandom(1.2,0.5),0,SXF_CLIENTSIDE,0);
		Stop;
	}
}

Class RestingCellSmoke : RestingBulletSmoke
{
	Default
	{
		Scale 0.5;
		Alpha 0.4;
	}
	States
	{
		Spawn:
		TNT1 "###########################################" 2 A_SpawnItemEx("EmptyCellSmoke",frandom(0.3,0.2),random(0,-1.0),0,0,0,frandom(1.2,0.5),0,SXF_CLIENTSIDE,0);
		Stop;
	}
}

Class MO_PlasmaSmoke : GunSmoke
{
  Default {
  Scale 0.7;
  RenderStyle 'Add';
  Alpha 0.4;
  }
  States
  {
  Spawn:
    1SMK ABCDEFGHIJKLMNOPQ 1 A_FadeOut(0.01);
    stop;
  }
}

Class MO_RocketSmokeTrail: RocketSmokeTrail
{
	Default
	{
	Renderstyle 'Translucent';
	Alpha 0.8;
	Speed 1;
	+CLIENTSIDEONLY;
	+RollSprite;
	Scale 0.25;
	}
	States
    {
		Spawn:  
			TNT1 A 0;
			TNT1 A 1 A_SetScale(0.08, 0.05);
			TNT1 A 1 A_SetRoll(random(0,360));
			SMK3 ABCDEFGHI 1 A_SetScale(Scale.X+0.03, Scale.Y+0.03);
			SMK3 JJKKLLMM 1;
			Stop;
	}
}

Class MO_GrenadeSmokeTrail : MO_RocketSmokeTrail
{
	Default{Scale 0.08;}
	States
	{
		Spawn:  
			TNT1 A 0;
			TNT1 A 1 A_SetScale(0.08, 0.05);
			TNT1 A 1 A_SetRoll(random(0,360));
			SMK3 ABCDEFGHI 1 A_SetScale(Scale.X+0.01, Scale.Y+0.01);
			SMK3 JJKKLLMM 1;
			Stop;
	}
}

Class MO_NukeRocketSmokeTrail: MO_RocketSmokeTrail
{
	States
    {
		Spawn:  
			TNT1 A 0;
			TNT1 A 1 A_SetScale(0.63, 0.60);
			TNT1 A 1 A_SetRoll(random(0,360));
			SMK3 ABCDEFGHI 1 A_SetScale(Scale.X+0.03, Scale.Y+0.03);
			SMK3 JJKKLLMM 1;
			Stop;
	}
}

Class BlackSmokeFromFire : Actor
{
	Default
	{
    +NOBLOCKMAP
    +NOTELEPORT
    +DONTSPLASH
	+FORCEXYBILLBOARD
    +CLIENTSIDEONLY
    +NOINTERACTION
	+NOGRAVITY
	+DOOMBOUNCE
	+THRUACTORS
	Health 99999;
	BounceFactor 0.5;
	Radius 1;
	Height 1;
	Alpha 1.0;
	RenderStyle "Translucent";
	Scale 0.13;
	Speed 2;
  }
    States
    {
    Spawn:
	TNT1 A 0;
	TNT1 A 0 A_FadeOut(0.9);
	SMK1 KKKKKKKK 2 A_FadeIn(0.02);
	TNT1 A 0 A_JumpIf(waterlevel > 1, "Stap");
	SMK1 K 25;
	TNT1 A 0 A_JumpIf(waterlevel > 1, "Stap");
	SMK1 KKKKKKKKKKKKKKKKKKKKKKKKKKKK 2 A_FadeOut(0.01);
	Goto Death;
	Death:
	    TNT1 A 1;
    Stop;
	Stap:		
	TNT1 A 1;
	Stop;
    }
}

Class MO_NukeSmoke: Actor
{
	Default
	{
	Scale 2.5;
	Speed 0;
	Alpha 0.1;
	+SKYEXPLODE;
	+FORCEXYBILLBOARD;
	PROJECTILE;
	+CLIENTSIDEONLY;
	+MISSILE;
	+THRUACTORS;
	+DOOMBOUNCE;
	Radius 1;
	Height 1;
	Renderstyle "Translucent";
	}
States
    {
    Spawn:  
	    SMk2 AAAAAAAAAAAA 2 A_FadeIn(0.05);
		SMk2 A 600;
	Death:	
		SMk2 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 10 A_FadeOut(0.02);
		Stop;		
}
}

Class MO_NukeSmokeBig : Mo_NukeSmoke
{
	Default
	{
		XScale 8.0;
		YScale 6.0;
	}
}
