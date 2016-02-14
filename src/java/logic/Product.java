/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logic;

/**
 *
 * @author pharis wambui
 */
import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import model.*;
import viewmodel.DataLoader;

public class Product {

    DataLoader DL = new DataLoader();
    List mydata;
    String itemdata, price, datafilter, selectedoption;
    int i;

    public String getPriceWithUom(int itemid,int uomid) {
        itemdata = "{value:\"\" , text: \"\"},";
        StringBuilder pricesquery = new StringBuilder("FROM ItemSale where itemId='+itemid' AND uomId='+uomid'");
        pricesquery.append(" " + datafilter + " ");
        mydata = DL.getData(pricesquery.toString());
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            ItemSale DC = (ItemSale) iterator.next();
            //   if(DC.getProfileId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}
            itemdata = itemdata + "{value: \"" + DC.getItemSaleId() + "\", text: \"" + DC.getUnitPrice() + "\"" + selectedoption + "},";
        }
        DL.closeListSession();
        return itemdata;

    }
   /* public String getPriceWithUom(int itemid,int uomid) {
        itemdata = "{value:\"\" , text: \"\"},";
        StringBuilder pricesquery = new StringBuilder("FROM ItemSale where itemId='+itemid' AND uomId='+uomid'");
        pricesquery.append(" " + datafilter + " ");
        mydata = DL.getData(pricesquery.toString());
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            ItemSale DC = (ItemSale) iterator.next();
            //   if(DC.getProfileId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}
            itemdata = itemdata + "{value: \"" + DC.getItemSaleId() + "\", text: \"" + DC.getUnitPrice() + "\"" + selectedoption + "},";
        }
        DL.closeListSession();
        return itemdata;

    }
    public String getPriceWithUom(int itemid,int uomid) {
        itemdata = "{value:\"\" , text: \"\"},";
        StringBuilder pricesquery = new StringBuilder("FROM ItemSale where itemId='+itemid' AND uomId='+uomid'");
        pricesquery.append(" " + datafilter + " ");
        mydata = DL.getData(pricesquery.toString());
        for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
            ItemSale DC = (ItemSale) iterator.next();
            //   if(DC.getProfileId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}
            itemdata = itemdata + "{value: \"" + DC.getItemSaleId() + "\", text: \"" + DC.getUnitPrice() + "\"" + selectedoption + "},";
        }
        DL.closeListSession();
        return itemdata;

    }*/

}

