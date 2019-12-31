import lua.Lua;
import lua.Table;
import noita.Files;
import noita.Noita;
import noita.Flags;
import noita.Entity;
import noita.PerkList;
import noita.EventFunctions;
import noita.wand.Spells;
import noita.gun.procedural.GunActionUtils;

class Main
{
  static function OnPlayerSpawned(player_entity:EntityId)
  {
    var inventory=null;
    var playerChildEntities=Entity.GetAllChildren(player_entity);
    if(playerChildEntities!=null)
    {
        Table.foreach(playerChildEntities,(i,childEntity)->
        {
            final childEntityName=Entity.GetName(childEntity);
            if(childEntityName=="inventory_quick")
            {
                inventory=childEntity;
                untyped __lua__("GamePrint(childEntity)");
            }
        });
    }
    else 
    {
        Noita.GamePrint("player has no child");
    }
    if(inventory!=null)
    {
        final inventoryItems=Entity.GetAllChildren(inventory);
        if(inventoryItems!=null)
        {
            Table.foreach(inventoryItems,(i,item)->
            {
                Noita.GameKillInventoryItem(player_entity,item);
                Noita.GamePrint("remove");
            });
        } 
        final wand1=Entity.Load("./wand_good_1.xml");
        Entity.AddChild(inventory,wand1);
        Noita.GamePrint("got wand1");

        final item_entity1 = Entity.Load("data/entities/items/pickup/potion_water.xml");
        Entity.AddChild(inventory,item_entity1);
        Noita.GamePrint("got water");
        final item_entity2 = Entity.Load("data/entities/items/pickup/potion_water.xml");
        Entity.AddChild(inventory,item_entity2);
        Noita.GamePrint("got water");
    }			
    else 
    {
        Noita.GamePrint("inventory is empty");
    }
    Noita.GamePrintImportant( "You got power!!!","by Mod" );
  }

    static function hasAlreadyRun(modName:String):Bool
    {
        if(Noita.GameHasFlagRun(modName))return true;
        Noita.GameHasFlagRun(modName);
        return false;
    }
  public static function main()
  {
        Noita.dofile(Files.perk);
        Noita.dofile(Files.gunActionUtils);

        Lua.rawset(untyped __lua__("_G"),EventFunctionsName.OnPlayerSpawned,Main.OnPlayerSpawned);
 
  }
}