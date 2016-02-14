/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vxsutil;

import static java.lang.System.out;
import java.util.Iterator;
import java.util.List;
import model.*;
import viewmodel.DataLoader;

/**
 *
 * @author TBL
 */
public class ComboHelper {

    DataLoader DL = new DataLoader();
    List mydata;
    String combodata,selectedoption;
    String selectstmt=", selected:true ";
    String emptyString="";
    int i;
        int defaultLife=3;

    boolean isclosed;
    public String LoadCombo(String param,String datafilter,Integer selected) {
         combodata="{value:\"\" , text: \"\"},";
         
        if(param.equals("profile")) {
            
                StringBuilder profilesquery = new StringBuilder("FROM ConProfiles");
              profilesquery.append(" "+datafilter+" ");
                mydata = DL.getData(profilesquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    ConProfiles DC = (ConProfiles) iterator.next();
                   if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                  if(DC.getProfileId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getProfileId() + "\", text: \"" + DC.getProfileName() + "\""+selectedoption+"},";
                }
        }
        
         else 
            if(param.equals("customer")) {
           
                
                StringBuilder statusquery = new StringBuilder("from CrmCustomer");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    CrmCustomer DC = (CrmCustomer) iterator.next();
                    if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getCustomerId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getCustomerId() + "\", text: \"" + DC.getSurname()+"-"+DC.getOthername()+ "\""+selectedoption+ "},";
                
                }
                }
        else 
            if(param.equals("salutation")) {
           
                
                StringBuilder statusquery = new StringBuilder("from CommonCombo where parent_id=1");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    CommonCombo DC = (CommonCombo) iterator.next();
                     if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getComboId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getComboId() + "\", text: \"" + DC.getComboName() + "\""+selectedoption+ "},";
                
                }
                }
            else 
            if(param.equals("reason")) {
           
                
                StringBuilder statusquery = new StringBuilder("from CommonCombo where parent_id=13");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    CommonCombo DC = (CommonCombo) iterator.next();
                     if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getComboId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getComboId() + "\", text: \"" + DC.getComboName() + "\""+selectedoption+ "},";
                
                }
                }
				   else  if(param.equals("status")) {
           
                StringBuilder statusquery = new StringBuilder("FROM AllStatus");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    AllStatus DC = (AllStatus) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getStatusId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getStatusId() + "\", text: \"" + DC.getDescription() + "\""+selectedoption+ "},";
                
                }
                }
            else  if(param.equals("statusid")) {
           
                StringBuilder statusquery = new StringBuilder("FROM AllStatus");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    AllStatus DC = (AllStatus) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getStatusId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getStatusId() + "\", text: \"" + DC.getDescription() + "\""+selectedoption+ "},";
                
                }
                }
				else  if(param.equals("user")) {
    
                StringBuilder userquery = new StringBuilder("FROM ConUser");
                userquery.append(" "+datafilter+" ");
                mydata = DL.getData(userquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    ConUser DC = (ConUser) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getUserId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getUserId() + "\", text: \"" + DC.getOtherName()+"-"+ DC.getSurname()+ "\""+selectedoption+"},";
                } 
         
        }
          else 
            if(param.equals("customercategory")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM CrmCustomerCategory");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    CrmCustomerCategory DC = (CrmCustomerCategory) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getCustomerCategoryId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getCustomerCategoryId()+ "\", text: \"" + DC.getCustomerCategoryName()+ "\""+selectedoption+ "},";
                
                }
            }
            else 
            if(param.equals("uom")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM CrmUom");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    CrmUom DC = (CrmUom) iterator.next();
                                       if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getUomId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getUomId()+ "\", text: \"" + DC.getUomName()+ "\""+selectedoption+ "},";
                
                }
            }
            else 
            if(param.equals("uomcategory")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM CrmUomCateg");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    CrmUomCateg DC = (CrmUomCateg) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getUomCategId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getUomCategId()+ "\", text: \"" + DC.getUomCategName()+ "\""+selectedoption+ "},";
                
                }
            }
        else 
            if(param.equals("hrmemployee")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM HrmEmployee");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    HrmEmployee DC = (HrmEmployee) iterator.next();
                                       if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getEmployeeId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getEmployeeId()+ "\", text: \"" + DC.getLastName()+"-"+ DC.getFirstName()+ "\""+selectedoption+"},";
                
                }
            }
             else 
            if(param.equals("item")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM Item where item_level_id =3");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    Item DC = (Item) iterator.next();
                    if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{
                    
                        if(DC.getItemId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getItemId()+ "\", text: \"" + DC.getItemName()+ "\""+selectedoption+"},";
                
                }
            }
			   else   if (param.equals("itemsaleid")) {
            StringBuilder itemquery = new StringBuilder("FROM ItemSale");
            itemquery.append(" " + datafilter + " ");
            mydata = DL.getData(itemquery.toString());
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                ItemSale DC = (ItemSale) iterator.next();
                if (selected.equals(0)) {
                    if (DC.getConLife().getLifeId().equals(defaultLife)) {
                        selectedoption = selectstmt.toString();
                    } else {
                        selectedoption = "";
                    }
                } else if (DC.getItemSaleId() == selected) {
                    selectedoption = selectstmt.toString();
                } else {
                    selectedoption = "";
                }

                combodata = combodata + "{value: \"" + DC.getItemSaleId() + "\", text: \"" + DC.getUnitPrice() + " per " + DC.getCrmUom().getUomName() + "\"" + selectedoption + "},";
            }
        }
        else 
            if(param.equals("productcategory")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM Item where item_level_id =2");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    Item DC = (Item) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getItemId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getItemId()+ "\", text: \"" + DC.getItemName()+ "\""+selectedoption+"},";
                
                }
            }
            else 
            if(param.equals("productclass")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM Item where item_level_id =1");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    Item DC = (Item) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getItemId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getItemId()+ "\", text: \"" + DC.getItemName()+ "\""+selectedoption+"},";
                
                }
            }
        else 
            if(param.equals("itemlevelid")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM ItemLevel");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    ItemLevel DC = (ItemLevel) iterator.next();
                    if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getItemLevelId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getItemLevelId()+ "\", text: \"" + DC.getLevelName()+ "\""+selectedoption+"},";
                
                }
            }
        else 
            if(param.equals("itemconfigurationid")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM ItemConfiguration");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    ItemConfiguration DC = (ItemConfiguration) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getItemConfigurationId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getItemConfigurationId()+ "\", text: \"" + DC.getConfigurationName()+ "\""+selectedoption+"},";
                
                }
            }
        else 
            if(param.equals("currency")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM AllCurrency");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    AllCurrency DC = (AllCurrency) iterator.next();
                     if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getCurrencyId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getCurrencyId()+ "\", text: \"" + DC.getCurrencyName()+ "\""+selectedoption+"},";
                
                }
                
            }
             else 
            if(param.equals("payterm")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM Payterm");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    Payterm DC = (Payterm) iterator.next();
                                       if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getPaytermId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getPaytermId()+ "\", text: \"" + DC.getPaytermName()+ "\""+selectedoption+"},";
                
                }
                
            }
            else 
            if(param.equals("bank")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM Bank");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    Bank DC = (Bank) iterator.next();
                     if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getBankId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getBankId()+ "\", text: \"" + DC.getBankName()+ "\""+selectedoption+"},";
                
                }
            }else 
            if(param.equals("paymode")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM Paymode");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    Paymode DC = (Paymode) iterator.next();
                                     if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getPaymodeId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getPaymodeId()+ "\", text: \"" + DC.getPaymodeName()+ "\""+selectedoption+"},";
                
                }
            }
           /* else 
            if(param.equals("paymode")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM Paymode");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    Paymode DC = (Paymode) iterator.next();
                                      if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getPaymodeId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getPaymodeId()+ "\", text: \"" + DC.getPaymodeName()+ "\""+selectedoption+"},";
                
                }
            }*/
        else 
            if(param.equals("suppliers")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM PrcSuppliers");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    PrcSuppliers DC = (PrcSuppliers) iterator.next();
                    if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getSupplierId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getSupplierId()+ "\", text: \"" + DC.getSupplierName()+"-"+DC.getSupplierName()+ "\""+selectedoption+"},";
                
                }
            }
            else 
            if(param.equals("purchaseorder")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM PrcPurchaseOrder");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    PrcPurchaseOrder DC = (PrcPurchaseOrder) iterator.next();
                    if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getPurchaseorderId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getPurchaseorderId()+ "\", text: \"" + DC.getPurchaseorderCode()+ "\""+selectedoption+"},";
                
                }
            }
             else 
            if(param.equals("salesorder")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM CrmSalesorder");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    CrmSalesorder DC = (CrmSalesorder) iterator.next();
                    if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getSalesorderId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getSalesorderId()+ "\", text: \"" + DC.getSalesorderCode()+ "\""+selectedoption+"},";
                
                }
            }
             else 
            if(param.equals("country")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM AllCountry");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    AllCountry DC = (AllCountry) iterator.next();
                     if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getCountryId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getCountryId()+ "\", text: \"" + DC.getCountryName()+ "\""+selectedoption+"},";
                
                }
            }
              else 
            if(param.equals("store")) {
           
                
                StringBuilder statusquery = new StringBuilder("FROM InvStore");
                statusquery.append(" "+datafilter+" ");
                mydata = DL.getData(statusquery.toString());
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    InvStore DC = (InvStore) iterator.next();
                     if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{

                    if(DC.getStoreId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}
                    combodata = combodata + "{value: \"" + DC.getStoreId()+ "\", text: \"" + DC.getStoreName()+ "\""+selectedoption+"},";
                
                }
            }
           
if(param.equals("itemid")) {
StringBuilder itemquery = new StringBuilder("FROM Item");
itemquery.append(" "+datafilter+" ");
mydata = DL.getData(itemquery.toString());
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
Item DC = (Item) iterator.next();
if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{
if(DC.getItemId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}

combodata = combodata + "{value: \"" + DC.getItemId()+ "\", text: \"" + DC.getItemCode()+ " " + DC.getItemName()+ "\""+selectedoption+"},";
}
}
else
if(param.equals("vatid")) {
StringBuilder finvatquery = new StringBuilder("FROM FinVat");
finvatquery.append(" "+datafilter+" ");
mydata = DL.getData(finvatquery.toString());
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
FinVat DC = (FinVat) iterator.next();
if(selected.equals(0)){ if(DC.getConLife().getLifeId().equals(defaultLife)){ selectedoption=selectstmt.toString();}else{selectedoption="";}}else{
if(DC.getVatId()==selected){selectedoption=selectstmt.toString();}else{selectedoption="";}}

combodata = combodata + "{value: \"" + DC.getVatId()+ "\", text: \"" + DC.getVatName()+ "\""+selectedoption+"},";
}
}


		   else{
                
               isclosed=true; 
                
            }
            if(isclosed==false){DL.closeListSession(); } //CLOSE THE SESSION FOR THE COMBOS CALLED
          
            return combodata;

       
    }
    
    
 public String GeneralCombo(String param,String datafilter,String selected){
 
 return "";
 }
    /*    if (!mydata.isEmpty()) {
     i = 0;
     out.println("{rows:[");
     //LOOP THROUGH THE GRID
     for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
     ConProfiles DC = (ConProfiles) iterator.next();
     out.println("{ id:" + DC.getProfileId() + ", data:[");

     out.println("\"" + DC.getProfileName() + "\"");
     out.println("]}");
     }
     out.println("]}");
     }

        
     */
}
