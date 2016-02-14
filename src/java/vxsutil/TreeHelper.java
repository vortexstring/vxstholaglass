/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vxsutil;

/**
 *
 * @author TBL
 */
import static java.lang.System.out;
import java.util.Iterator;
import java.util.List;
import model.Item;

import viewmodel.DataLoader;

public class TreeHelper {

    String myq, userdetails,itemname;
    List mydata;
    Integer i,itemid;
    Integer childcount;
    String treeList;

    public String printnode(Integer parentid) {
    treeList="";
        try{
        DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM Item AS I where  I.item.itemId="+parentid);

        mydata = ME.getData(myquery.toString());
 
    if (!mydata.isEmpty()) {
            i = 1;

            //LOOP THROUGH THE GRID
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                Item OBJ = (Item) iterator.next();
                itemid=OBJ.getItemId();
                itemname= OBJ.getItemName();
                
                 //treeList=i+""+treeList+" "+itemid+"---"+itemname;  
                 // childcount = ME.getCount("SELECT COUNT(itemId)  FROM Item AS I where  I.item.itemId="+itemid);
                  childcount = ME.getCount("select count(item0_.item_id) as col_0_0_ from vxsee.item item0_ where item0_.parent_id="+itemid);
                
                   if (childcount > 0)
                        {

                        treeList=treeList+"{id:"+itemid+", text:\""+itemname+"\", item:[ "+printnode(itemid)+"]},";
                                              
                        }else{
                           
                        treeList=treeList+printChild(itemid,itemname);   
                       } 
                
                    i++;
            }

        }
        
   
        
        
     }catch(Exception e){
            
            String my_error=e.getCause().toString();
        }
        
        return treeList;
        
    }
    
    
   public String  printChild(Integer id,String desc){
       
       return "{id:" + id + ",text:\"" +desc+ "\"},"; 
   }
    
    
    
}
