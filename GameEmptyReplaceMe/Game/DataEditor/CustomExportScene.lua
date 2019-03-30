LogInfo( "Starting export.\n" )

-- JSON lua functions taken from here: https://gist.github.com/tylerneylon/59f4bcf316be525b30ab
local json = require( "DataEditor/json" )

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint( tbl, indent )
    if not indent then indent = 0 end
    for k, v in pairs( tbl ) do
        formatting = string.rep( "  ", indent ) .. k .. ": "
        if type( v ) == "table" then
            LogInfo( formatting )
            tprint( v, indent+1 )
        elseif type( v ) == 'boolean' then
            LogInfo( formatting .. tostring(v) )
        else
            LogInfo( formatting .. v )
        end
    end
end

function WriteStringToFile( filename, stringToExport )
    local file = io.open( filename, "w" )
    io.output( file )
    io.write( stringToExport )
    io.close( file )
end

function ExportFlags( gameObject )
    local jFlags = {}
    for i=0,31 do
        local flag = gameObject:GetFlagStringIfSet( i )
        if( flag ~= nil ) then
            jFlags[#jFlags+1] = flag
        end
    end

    return jFlags
end

function ExportComponents( gameObject )
    local jComponents = {}
    local index = 0
    while( true ) do
        local component = gameObject:GetComponentByIndex( index )
        index = index + 1
        if( component == nil ) then
            break
        end

        if( component:IsA( "CameraComponent" ) or
            component:IsA( "CameraComponent" ) ) then
        
        else
            -- Export Base Properties.
            jComponents[#jComponents+1] = {}
            jComponents[#jComponents]["Type"] = component:GetTypeName()
            --jComponents[#jComponents]["ID"] = component:GetID()
            --jComponents[#jComponents]["Enabled"] = component:IsEnabled()
        
            if( component:IsA( "2DCollisionObjectComponent" ) ) then
                component2DCollision = CastAs_Component2DCollisionObject( component )
                jComponents[#jComponents]["PrimitiveType"] = component2DCollision:GetPrimitiveTypeName()
                jComponents[#jComponents]["Static"] = component2DCollision:IsStatic()
                jComponents[#jComponents]["FixedRotation"] = component2DCollision:IsFixedRotation()
                jComponents[#jComponents]["Density"] = component2DCollision:GetDensity()
                jComponents[#jComponents]["IsSensor"] = component2DCollision:IsSensor()
                jComponents[#jComponents]["Friction"] = component2DCollision:GetFriction()
                jComponents[#jComponents]["Restitution"] = component2DCollision:GetRestitution()
            end

            if( component:IsA( "SpriteComponent" ) ) then
                component2DCollision = CastAs_Component2DCollisionObject( component )
                jComponents[#jComponents]["Material"] = component2DCollision:GetPrimitiveTypeName()
                jComponents[#jComponents]["Texture"] = component2DCollision:IsStatic()
                jComponents[#jComponents]["Shader"] = component2DCollision:IsFixedRotation()
                jComponents[#jComponents]["Color"] = component2DCollision:GetDensity()
            end
        end
    end

    return jComponents
end

function ExportGameObject( gameObject )
    local jGameObject = {}
    jGameObject["Name"] = gameObject:GetName()

    local transform = gameObject:GetTransform()
    if( transform ~= nil ) then
        -- Export Pos/Rot/Scale.
        jGameObject["Pos"] = { transform:GetWorldPosition().x, transform:GetWorldPosition().y, transform:GetWorldPosition().z }
        jGameObject["Rot"] = { transform:GetWorldRotation().x, transform:GetWorldRotation().y, transform:GetWorldRotation().z }
        jGameObject["Scale"] = { transform:GetWorldScale().x, transform:GetWorldScale().y, transform:GetWorldScale().z }

        -- Export Flags.
        local jFlags = ExportFlags( gameObject )
        if( #jFlags > 0 ) then
            jGameObject["Flags"] = jFlags
        end

        -- Export Components.
        local jComponents = ExportComponents( gameObject )
        if( #jComponents > 0 ) then
            jGameObject["Components"] = jComponents
        end
    end

    -- Export children.
    local childGO = gameObject:GetFirstChild()
    if( childGO ~= nil ) then
        -- TODO:
        -- Create child array.
        -- Call ExportGameObject for each add to the array.
    end

    return jGameObject
end

function ExportScene( filename, sceneIndex )
    local jRoot = {}
    local jGameObjectList = {}
    jRoot['GameObjects'] = jGameObjectList

    -- Export GameObjects.
    local gameObject = ComponentSystemManager:Editor_GetFirstGameObjectFromScene( sceneIndex )
    while( gameObject ~= nil ) do
        jGameObjectList[#jGameObjectList+1] = ExportGameObject( gameObject )
        gameObject = gameObject:GetNextGameObjectInList()
    end

    local jsonString = json.stringify( jRoot, false )

    WriteStringToFile( filename, jsonString )
end

local RootFolder = "./"
local SceneName = "test.exportedScene"
local sceneIndex = 0

ExportScene( RootFolder .. SceneName, sceneIndex )

LogInfo( "Export done!\n" )
