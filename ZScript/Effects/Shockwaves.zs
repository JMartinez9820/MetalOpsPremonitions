class HeatBlastShockwave : BaseVisualSFX
{
	Default
	{
		 -ALLOWPARTICLES;
		 Mass 1;
		 Radius 1;
		 Height 1;
		 RenderStyle "Add";
		 Alpha 0.8;
		 Speed 20;
		 Scale 0.6;
		 VSpeed 0;
	}
	States
	{
		Spawn:
			SSHK AB 1 BRIGHT;
			SSHK CD 1 BRIGHT;
			SSHK EF 1 BRIGHT;
			SSHK GHIJKL 1 BRIGHT A_FadeOut(0.03);
			Stop;
	}
}

class HeatBlastShockwave2 : HeatBlastShockwave
{
Default
{
	Scale 1.2;
	Speed 40;
}
}

Class HeatBlastShockwaveRed : HeatBlastShockwave
{
	Default
	{Translation "192:247=171:191";}
}

class HeatBlastShockwave2Red : HeatBlastShockwave2
{Default{Translation "192:247=171:191";}}