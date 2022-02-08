﻿; Wingman Crafting Labels - By DanMarzola

RefreshBaseList(type){
  CraftingBaseTypeSelector := type
  For k, v in Bases
  {
    if(type = "str_armour"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]),RegexFixLeadingZeros(3,v["properties"]["armour"]["min"]))
      }
    }else if(type = "dex_armour"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]),RegexFixLeadingZeros(3,v["properties"]["evasion"]["min"]))
      }
    }else if(type = "int_armour"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]),RegexFixLeadingZeros(3,v["properties"]["energy_shield"]["min"]))
      } 
    }else if(type = "str_dex_armour"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]),RegexFixLeadingZeros(3,v["properties"]["armour"]["min"]),RegexFixLeadingZeros(3,v["properties"]["evasion"]["min"]))
      }
    }else if(type = "str_int_armour"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]),RegexFixLeadingZeros(3,v["properties"]["armour"]["min"]),RegexFixLeadingZeros(3,v["properties"]["energy_shield"]["min"]))
      }
    }else if(type = "dex_int_armour"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]),RegexFixLeadingZeros(3,v["properties"]["evasion"]["min"]),RegexFixLeadingZeros(3,v["properties"]["energy_shield"]["min"]))
      }
    }else if(type = "amulet"){
      If (IndexOf(type,v["tags"]) && !IndexOf("talisman",v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]))
      }
    }else if(type = "belt"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]))
      }
    }else if(type = "ring"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]))
      }
    }else if(type = "weapon"){
      If (IndexOf(type,v["tags"])){
        LV_Add("",v["item_class"],v["name"],"0",RegexFixLeadingZeros(2,v["drop_level"]))
      }
    }
  }

  ;; Retrive bases from custom crafting bases json to check box
  Loop % LV_GetCount()
  {
    Index := A_Index
    LV_GetText(OutputVar, A_Index , 2)
    For k, v in WR.CustomCraftingBases[type]{
      if (v.BaseName == OutputVar){
        LV_Modify(Index,"Check",,,v.ILvL)
      }
    }
  }

  ;; Style
  Loop % LV_GetCount("Column")
  {
    LV_ModifyCol(A_Index,"AutoHdr")
  }
  LV_ModifyCol(1, 150)
  LV_ModifyCol(2, 150)
  LV_ModifyCol(4,"SortDesc")
  LV_ModifyCol(1,"Sort")
}
Return

RegexFixLeadingZeros(digits,content){
  if(content==""){
    content:=
  }
  else if(digits==2){
    Loop, 2
    {
      content := RegExReplace(content, "(?<!\d)\d(?!\d)", "0$0")
    }
  }else if(digits==3){
    Loop, 2
    {
      content := RegExReplace(content, "(?<!\d)\d(?!\d)", "00$0")
      content := RegExReplace(content, "(?<!\d)\d{2}(?!\d)", "0$0")
    }
  }
  return content
}

CraftingBaseSTRUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level|Base Armour
  RefreshBaseList("str_armour")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , Str Armour Bases
Return

CraftingBaseDEXUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level|Base Evasion
  RefreshBaseList("dex_armour")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , Dex Armour Bases
Return

CraftingBaseINTUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level|Base Energy Shield
  RefreshBaseList("int_armour")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , Int Armour Bases
Return

CraftingBaseSTRDEXUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level|Base Armour|Base Evasion
  RefreshBaseList("str_dex_armour")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , StrDex Armour Bases
Return

CraftingBaseSTRINTUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level|Base Armour|Base Energy Shield
  RefreshBaseList("str_int_armour")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , StrInt Armour Bases
Return

CraftingBaseDEXINTUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level|Base Evasion|Base Energy Shield
  RefreshBaseList("dex_int_armour")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , DexInt Armour Bases
Return

CraftingBaseAMULETUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level
  RefreshBaseList("amulet")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , Amulet Bases
Return

CraftingBaseRINGUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level
  RefreshBaseList("ring")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , Ring Bases
Return

CraftingBaseBELTUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level
  RefreshBaseList("belt")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , Belt Bases
Return

CraftingBaseWEAPONUI:
  Gui, CustomCraftingBaseUI1: New
  Gui, CustomCraftingBaseUI1: Default
  Gui, CustomCraftingBaseUI1: +AlwaysOnTop -MinimizeBox +LabelCustomUndesirable
  Gui, CustomCraftingBaseUI1: Add, ListView , w700 h300 -wrap -Multi Grid Checked vlistview1, Item Class|Base Name|Max ILvL Found|Drop Level
  RefreshBaseList("weapon")
  Gui, CustomCraftingBaseUI1: Add, Button, gSaveCraftingBase x+5 w120 h30 center, Save
  Gui, CustomCraftingBaseUI1: Add, Button, gResetCraftingBase w120 h30 center, Reset
  Gui, CustomCraftingBaseUI1: Show, , Belt Bases
Return

ResetCraftingBase:
  Loop % LV_GetCount()
  {
    LV_Modify(A_Index,"-Check")
  }
  WR.CustomCraftingBases[CraftingBaseTypeSelector] := []
  Settings("CustomCraftingBases","Save")
Return

SaveCraftingBase:
  RowNumber := 0
  WR.CustomCraftingBases[CraftingBaseTypeSelector] := []
  Loop
  {
    RowNumber := LV_GetNext(RowNumber,"C")
    if not RowNumber
      break
    LV_GetText(BaseName, RowNumber,2)
    aux:= {"BaseName":BaseName,"ILvL":"0","Quant":"0"}
    WR.CustomCraftingBases[CraftingBaseTypeSelector].Push(aux)
  }
  Settings("CustomCraftingBases","Save")

Return

;; Test Function to Feed Crafting Base Obj
CraftingBasesRequest(endAtRefresh := 0){
  If (AccountNameSTR = ""){
    AccountNameSTR := POE_RequestAccount().accountName
  }
  Object := POE_RequestStash(StashTabCrafting,0)
  ClearQuantCraftingBase()
  For k, v in Object.items
  {
    item := new ItemBuild(v,Object.quadLayout)
  }
Return
}

ClearQuantCraftingBase(){
  for ki,vi in ["str_armour","dex_armour","int_armour","str_dex_armour","str_int_armour","dex_int_armour","amulet","ring","belt","weapon"]{
    for k,v in WR.CustomCraftingBases[vi]{
      v.Quant:=0
      v.ILvL:=0
    }
  }
  Return
}
