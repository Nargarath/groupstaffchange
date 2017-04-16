include( "groupchange/config.lua" )

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

---------------------------------------------- FUNÇÕES MOTORAS -----------------------------------------

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
local function LothusZ.ArraySum(a1,a2)
	for _,v in ipairs(a2) do 

  	  table.insert(a1, v)

	end
end

local function LothusZ.superadminSearch(id)
	for i, v in ipairs(LothusZ.superadminList) do
      if id == v then
      	return true
      end
    end
    return false
end

local function LothusZ.adminSearch(id)
	for i, v in ipairs(LothusZ.adminList) do
      if id == v then
      	return true
      end
    end
    return false
end

local function LothusZ.moderatorSearch(id)
	for i, v in ipairs(LothusZ.moderatorList) do
      if id == v then
      	return true
      end
    end
    return false
end

local function LothusZ.staffType(id)
	if LothusZ.superadminSearch(id) then
		return "superadmin"
	elseif LothusZ.adminSearch(id) then
		return "admin"
	elseif LothusZ.moderatorSearch(id) then
		return "moderator"
	end
end


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--



--------------------------------------------------------------------------------------------------------

------------------------------------------- FUNÇÕES PRINCIPAIS -----------------------------------------

--------------------------------------------------------------------------------------------------------
function LothusZ.hasID(id)
	for i, v in ipairs(LothusZ.specialGroupIDS) do
      if id == v then
      	return true
      end
    end
    return false
end

function LothusZ.specialGroupRemove(ply)
	if(LothusZ.hasID(ply:SteamID()))then
		RunConsoleCommand( "ulx","adduserid",ply:SteamID(),"vipdiamante" )
	end
end

function LothusZ.jobChangedGroup(ply , oldjob , newjob)
	if(LothusZ.hasID(ply:SteamID()))then
		if(LothusZ.staffType(ply:SteamID()) == "superadmin") then
			if newjob == DONO then
				RunConsoleCommand( "ulx","removeuserid",ply:SteamID() )
			else
				LothusZ.specialGroupRemove(ply)
			end
		elseif LothusZ.staffType(ply:SteamID()) == "admin" then
			if newjob == DONO then
				RunConsoleCommand( "ulx","adduserid",ply:SteamID(),"admin" )
			else
				LothusZ.specialGroupRemove(ply)
			end	
		elseif LothusZ.staffType(ply:SteamID()) == "moderator" then
			if newjob == DONO then
				RunConsoleCommand( "ulx","adduserid",ply:SteamID(),"moderator" )
			else
				LothusZ.specialGroupRemove(ply)
			end	
		end
	end
end
------------------------------------------------------------------------------------------------------


LothusZ.ArraySum(LothusZ.specialGroupIDS,LothusZ.superadminList)
LothusZ.ArraySum(LothusZ.specialGroupIDS,LothusZ.adminList)
LothusZ.ArraySum(LothusZ.specialGroupIDS,LothusZ.moderatorList)


hook.Add( "PlayerDisconnected", "remover_grupo_ao_sair" , LothusZ.specialGroupRemove )	
hook.Add( "OnPlayerChangedTeam", "mudar_grupo" , LothusZ.jobChangedGroup )
