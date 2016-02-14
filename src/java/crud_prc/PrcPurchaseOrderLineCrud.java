/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package crud_prc;

import viewmodel.*;
import model.*;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import vxsutil.SessionFactoryHelper;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.google.gson.*;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import vxsutil.DateHelper;
import vxsutil.StringHelper;



public class PrcPurchaseOrderLineCrud {
/**
* ***Compulsory fields*****
*/
String strid,feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata,returngridata,createbyid, writebyid,writedt,createdt;
Integer Ncreatebyid, Nwritebyid, id, i;
Date DTwritedt, DTcreatedt;
List listdata, mydata;
Map <String, Object> data = new HashMap< String, Object >();
DateHelper DH = new DateHelper();
StringHelper SH = new StringHelper();
SessionFactory factory;
PrcPurchaseOrderLine dataModel;
Transaction tx = null;

/********Model specific variables************/

String memo,purchaseorderid,itemid,qty,uomid ,price,amount;
Integer Npurchaseorderid,Nitemid,Nqty,Nuomid ;
BigDecimal BDprice,BDamount ;


//A PUBLIC METHOD TO PERFORM CREATE,UPDATE AND DELETE FUNCTIONALITY
public Map<String, Object> cud(String action, Map formData) {

//IN CASE OF INVALID ACTION
if(action.equals("c") || action.equals("u") || action.equals("d")){
} else {
data.put("msgtype", "fail");
data.put("msg", "Invalid Action type");
return data;
}


//Getting data from tha mapper
strid = SH.cleanInput(formData.get("id").toString());
purchaseorderid = SH.cleanInput(formData.get("purchaseorderid").toString());
itemid = SH.cleanInput(formData.get("itemid").toString());
qty = SH.cleanInput(formData.get("qty").toString());
price = SH.cleanInput(formData.get("price").toString());
amount = SH.cleanInput(formData.get("amount").toString());
uomid = SH.cleanInput(formData.get("uomid").toString());
memo = SH.cleanInput(formData.get("memo").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Npurchaseorderid = Integer.valueOf(purchaseorderid);
Nitemid = Integer.valueOf(itemid);
Nqty = Integer.valueOf(qty);
Nuomid = Integer.valueOf(uomid);

//DATE VALUES

//DATE TIME VALUES
DTcreatedt = DH.StrDatetimetoDatetime(createdt);
DTwritedt = DH.StrDatetimetoDatetime(writedt);
//Integer values
Ncreatebyid = Integer.valueOf(createbyid);
Nwritebyid = Integer.valueOf(writebyid);


factory = SessionFactoryHelper.getsysDBUserSessionFactory();
Session session = factory.openSession();
try {
tx = session.beginTransaction();
/****************CREATING THE MODEL INSTANCE****************/
if (action.equals("u") || action.equals("d")) {
dataModel = (PrcPurchaseOrderLine) session.get(PrcPurchaseOrderLine.class, id);
} else {
dataModel = new PrcPurchaseOrderLine();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setQty(Nqty);
dataModel.setMemo(memo);
BDprice= new BigDecimal(price);
dataModel.setPrice(BDprice);
BDamount= new BigDecimal(amount);
dataModel.setAmount(BDamount);
Item item = (Item) session.get(Item.class,Nitemid);
dataModel.setItem(item);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Nuomid);
dataModel.setCrmUom(crmuom);
PrcPurchaseOrder prcpurchaseorder = (PrcPurchaseOrder) session.get(PrcPurchaseOrder.class,Npurchaseorderid);
dataModel.setPrcPurchaseOrder(prcpurchaseorder);

//PRINT COMPULSORY SET METHODS
dataModel.setWritedt(DTwritedt);
ConUser writebyRec = (ConUser) session.get(ConUser.class, Nwritebyid);
dataModel.setConUserByWritebyId(writebyRec);
ConCompany companyRec = (ConCompany) session.get(ConCompany.class, 1);
dataModel.setConCompany(companyRec);

//PRINT CODE FOR DELETING A RECORD
}else if (action.equals("d")) {
ConLife lifeRec = (ConLife) session.get(ConLife.class, 2);
dataModel.setConLife(lifeRec);
}

/************************CREATING THE FEEDBACK MESSAGE FOR THE CUD CLASS**********/
if (action.equals("c")) {
ConLife lifeRec = (ConLife) session.get(ConLife.class, 1);
dataModel.setConLife(lifeRec);
ConUser createbyRec = (ConUser) session.get(ConUser.class, Ncreatebyid);
dataModel.setConUserByCreatebyId(createbyRec);
dataModel.setCreatedt(DTcreatedt);
id = (Integer) session.save(dataModel);
tx.commit();
msg = "Insertion Succesful";
returngridata = getPrcPurchaseOrderLinedata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getPrcPurchaseOrderLinedata(id);
} else if (action.equals("d")) {
tx.commit();
session.update(dataModel);
msg = "Deletion Succesful";
}
data.put("msgtype", "success");
data.put("msg", msg);
data.put("actiontype", action);
data.put("recId", strid);
data.put("gridData", returngridata);
/*****************IN CASE AN ERROR OCCURS*************/
} catch (HibernateException e) {
if (tx != null) {
tx.rollback();
}

data.put("msgtype", "fail");
if (action.equals("c")) {
data.put("msg", "Insertion Failed" + e.toString());
} else if (action.equals("u")) {
data.put("msg", "Updating Failed" + e.toString());
} else if (action.equals("d")) {
data.put("msg", "Deleting Failed" + e.toString());
}
} finally {
session.close();
}
return data;
}
/************A METHOD RETURN DATA IN CUSTOMIZED SPECIFIC DHTMLX GRID FORMAT*************/
private String getPrcPurchaseOrderLinedata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM PrcPurchaseOrderLine Where purchaseorderLineId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
PrcPurchaseOrderLine prcpurchaseorderline = (PrcPurchaseOrderLine) iterator.next();
gridata = i + ","+prcpurchaseorderline.getQty() + "," + prcpurchaseorderline.getPrice() + "," + prcpurchaseorderline.getAmount() + "," + prcpurchaseorderline.getMemo() + "," + prcpurchaseorderline.getItem().getItemId() + "," + prcpurchaseorderline.getCrmUom().getUomId() + "," + prcpurchaseorderline.getPrcPurchaseOrder().getPurchaseorderId();
i++;
}
}
return gridata;
}
}
