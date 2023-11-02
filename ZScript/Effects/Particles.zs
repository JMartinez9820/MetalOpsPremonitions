Class MO_ExplosionParticle : Actor
{
	Default
	{
	  Height 1;
	  Radius 1;
	  Mass 0;
	  +Missile;
	  +NoBlockMap;
	  +DontSplash;
	  +FORCEXYBILLBOARD;
	  +CLIENTSIDEONLY;
	  +THRUACTORS;
	  +GHOST;
	  -NOGRAVITY;
	  +THRUGHOST;
	  +NOTELEPORT;
	  RenderStyle 'Add';
	  Scale 0.8;
	  Gravity 0;
	}
	  States
	  {
	  Spawn:
		SPKO B 1 Bright A_FadeOut(0.02);
		Loop;
	  }
}

Class MO_HeavyExplosionParticle: MO_ExplosionParticle
{
	Default
	{
	  speed 5;
	  Gravity 0.5;
	  Scale 0.2;
	  BounceFactor 0.01;
	}
    States
    {
     Spawn:
       SPRK SSSSS 1 BRIGHT;
	   SPRK SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS 1 Bright A_FadeOut(0.02);
        stop;
     Death:
		 SPRK SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS 1 Bright A_FadeOut(0.02);
       Stop;
    }
}

Class BulletRicochet : Actor
{
	Default
	{
		+NOGRAVITY;
		-DONTSPLASH;
		-EXPLODEONWATER;
		+NOEXTREMEDEATH;
		+FORCEXYBILLBOARD;
		+THRUACTORS;
		+NOCLIP;
		RenderStyle "Add";
		Scale .1;
		Alpha 0.8;
		VSpeed 0;
		Height 1;
	}
	States
	{
		Spawn:
		BPUF ABCD 1 bright Light("BulletHitLight");
		 BPUF ABCD 1 bright A_FadeOut(0.05);
		Stop;
	}
}
//From Hellrider by Endie (aka Moa Dixon), Insanity's Requiem by TiberiumSoul, and Enhanced Bullet Puffs by Cacodemon345
Class EnhancedHitSpark1 : Actor
{
	Default
	{
		speed 10;
		Scale 0.05;
		Gravity 0.7;
		RADIUS 1;
		HEIGHT 1;
		BOUNCEFACTOR 0.5;
	  RenderStyle "Add";
	   +MISSILE;
	   +CLIENTSIDEONLY;
	   +NOTELEPORT;
	   +NOBLOCKMAP;
	   +BLOODLESSIMPACT ;
	   +FORCEXYBILLBOARD;
	  +FORCEXYBILLBOARD;
		+DONTSPLASH;
		 +THRUACTORS;
	  +THRUGHOST;
	   +GHOST;
	   -NOCLIP;
		BounceType "Doom";
	   Damage 0;
	  Mass 0;
	}
    States
    {
    Spawn:
		TNT1 A 1;
	   SPKO S 20 BRIGHT;
       SPKO SSSSSSSSSS 1 Bright A_FadeOut(0.1);
       stop;
    Death:
       TNT1 A 1;
       Stop;
    }
}

Class EnhancedHitSpark2: EnhancedHitSpark1
{
	Default
	{
	 speed 8;
	  Gravity 0.9;
	  Scale 0.04;
	  Bouncefactor 0.01;
	}
  States
    {
     Spawn:
		TNT1 A 1;
	   SPKO S 30 BRIGHT;
       SPKO SSSSSSSSSS 1 Bright A_FadeOut(0.1);
        stop;
	}
}

Class EnhancedHitSpark3: EnhancedHitSpark1
{
	Default
	{
	 speed 8;
	 Scale 0.06;
	 Gravity 1.0;
	BounceType "None";
	}
  States
    {
     Spawn:
		TNT1 A 1;
	   SPKO S 40 BRIGHT;
       SPKO SSSSSSSSSS 1 Bright A_FadeOut(0.1);
        stop;
	}
}

Class EnhancedPlasmaSpark1 : EnhancedHitSpark1
{
	Default{Translation "PlasmaBlue";}
}

Class EnhancedPlasmaSpark2 : EnhancedHitSpark2
{
	Default{Translation "PlasmaBlue";}
}

Class EnhancedPlasmaSpark3 : EnhancedHitSpark3
{
	Default{Translation "PlasmaBlue";}
}

//Heated Plasma
Class EnhancedHPlasmaSpark1 : EnhancedHitSpark1
{
	Default{Translation "HeatedPlasma";}
}

Class EnhancedHPlasmaSpark2 : EnhancedHitSpark2
{
	Default{Translation "HeatedPlasma";}
}

Class EnhancedHPlasmaSpark3 : EnhancedHitSpark3
{
	Default{Translation "HeatedPlasma";}
}