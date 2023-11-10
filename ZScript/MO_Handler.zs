class MOps_KeysHandler : EventHandler
{
    override void WorldTick()
    {
        PlayerInfo plyr = players[consoleplayer];
    }
    override void NetworkProcess(ConsoleEvent e)
    {
        let pl = players[e.Player].mo;
        if(!pl)
         return;

        if (e.Name == "PrevThrowable")
        {
            let moweap = JMWeapon(pl.player.readyweapon);

            int throwType = pl.CountInv("ThrowableType");

            switch(throwType)
            {
                case 1:
                    pl.SetInventory("ThrowableType", 0);
                    pl.A_Print("Frag Grenades Selected");
					pl.S_StartSound("MOLPKUP",3);
                    break;
                default:
                    pl.GiveInventory("ThrowableType", 1);
                    pl.A_Print("Molotov Cocktails Selected");
					pl.S_StartSound("MOLPKUP",3);
                    break;
            }
        }
		
		/*
		if (e.Name == "NextThrowable")
        {
            let moweap = JMWeapon(pl.player.readyweapon);

            State SwitchThrowables = moweap.FindState("SwitchThrowables");

            int throwType = pl.CountInv("ThrowableType");

            switch(throwType)
            {
                case 2:
                    pl.SetInventory("ThrowableType", 0);
                    break;
                default:
                    pl.GiveInventory("ThrowableType", 1);
                    break;
            }
			if ((players[e.Player].weaponstate & WF_WEAPONREADY) || (moweap && moweap.CheckIfInReady() ))
			{
				if(SwitchThrowables != NULL)
				{
					pl.player.SetPSprite(PSP_WEAPON, moweap.FindState("SwitchThrowables"));
				}
			}
        }*/
    }
}