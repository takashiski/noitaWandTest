import Xml;
import js.node.Fs;

class ModXml
{
    public static function main(){
        var root = Xml.createElement("Mod");
        root.set("name","wand test");
        root.set("description","mod description");
        root.set("request_no_api_restrictions","0");
        
        trace(root);
        Fs.writeFile("./mod/mod.xml",root.toString(),(err)->{trace(err);});
    }
}