include( "groupchange/config.lua" )

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

---------------------------------------------- FUNÇÕES MOTORAS -----------------------------------------

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
local function GSC.ArraySum(a1,a2)
	for _,v in ipairs(a2) do 

  	  table.insert(a1, v)

	end
end

local function GSC.superadminSearch(id)
	for i, v in ipairs(GSC.superadminList) do
      if id == v then
      	return true
      end
    end
    return false
end

local function GSC.adminSearch(id)
	for i, v in ipairs(GSC.adminList) do
      if id == v then
      	return true
      end
    end
    return false
end

local function GSC.moderatorSearch(id)
	for i, v in ipairs(GSC.moderatorList) do
      if id == v then
      	return true
      end
    end
    return false
end

local function GSC.staffType(id)
	if GSC.superadminSearch(id) then
		return "superadmin"
	elseif GSC.adminSearch(id) then
		return "admin"
	elseif GSC.moderatorSearch(id) then
		return "moderator"
	end
end


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--



--------------------------------------------------------------------------------------------------------

------------------------------------------- FUNÇÕES PRINCIPAIS -----------------------------------------

--------------------------------------------------------------------------------------------------------
function GSC.hasID(id)
	for i, v in ipairs(GSC.specialGroupIDS) do
      if id == v then
      	return true
      end
    end
    return false
end

function GSC.specialGroupRemove(ply)
	if(GSC.hasID(ply:SteamID()))then
		RunConsoleCommand( "ulx","adduserid",ply:SteamID(),"vipdiamante" )
	end
end

function GSC.jobChangedGroup(ply , oldjob , newjob)
	if(GSC.hasID(ply:SteamID()))then
		if(GSC.staffType(ply:SteamID()) == "superadmin") then
			if newjob == DONO then
				RunConsoleCommand( "ulx","removeuserid",ply:SteamID() )
			else
				GSC.specialGroupRemove(ply)
			end
		elseif GSC.staffType(ply:SteamID()) == "admin" then
			if newjob == DONO then
				RunConsoleCommand( "ulx","adduserid",ply:SteamID(),"admin" )
			else
				GSC.specialGroupRemove(ply)
			end	
		elseif GSC.staffType(ply:SteamID()) == "moderator" then
			if newjob == DONO then
				RunConsoleCommand( "ulx","adduserid",ply:SteamID(),"moderator" )
			else
				GSC.specialGroupRemove(ply)
			end	
		end
	end
end
------------------------------------------------------------------------------------------------------


GSC.ArraySum(GSC.specialGroupIDS,LothusZ.superadminList)
GSC.ArraySum(LothusZ.specialGroupIDS,LothusZ.adminList)
GSC.ArraySum(LothusZ.specialGroupIDS,LothusZ.moderatorList)


hook.Add( "PlayerDisconnected", "remover_grupo_ao_sair" , GSC.specialGroupRemove )	
hook.Add( "OnPlayerChangedTeam", "mudar_grupo" , GSC.jobChangedGroup )
