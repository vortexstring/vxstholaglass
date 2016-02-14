/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud_inv;

/**
 *
 * @author pharis wambui
 */

import viewmodel.*;
import model.*;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import vxsutil.SessionFactoryHelper;
import org.hibernate.HibernateException;
import org.hibernate.exception.*;
import java.lang.NullPointerException;
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



public class InvGoodsreceivedCrud {
/**
* ***Compulsory fields*****
*/
String strid,feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata,returngridata,createbyid, writebyid,writedt,createdt;
Integer Ncreatebyid, Nwritebyid, id, i;
Date DTwritedt, DTcreatedt,Dgrndate;
List listdata, mydata;
Map <String, Object> data = new HashMap< String, Object >();
DateHelper DH = new DateHelper();
StringHelper SH = new StringHelper();
SessionFactory factory;
Session session;
InvGoodsreceived dataModel;
Transaction tx = null;

/********Model specific variables************/

String grncode,grndate,grmmemo,grnref,deliveryno,batchno,supplierid,purchaseorderid ;
Integer Nsupplierid,Npurchaseorderid ;


//A PUBLIC METHOD TO PERFORM CREATE,UPDATE AND DELETE FUNCTIONALITY
public Map<String, Object> cud(String action, Map formData) {

//Catch Model Errors
try {
//IN CASE OF INVALID ACTION
if(action.equals("c") || action.equals("u") || action.equals("d")){
} else {
data.put("msgtype", "fail");
data.put("msg", "Invalid Action type");
return data;
}


//Getting data from tha mapper
strid = SH.cleanInput(formData.get("id").toString());
grncode = SH.cleanInput(formData.get("grncode").toString());
grndate = SH.cleanInput(formData.get("grndate").toString());
grmmemo = SH.cleanInput(formData.get("grmmemo").toString());
grnref = SH.cleanInput(formData.get("grnref").toString());
deliveryno = SH.cleanInput(formData.get("deliveryno").toString());
supplierid = SH.cleanInput(formData.get("supplierid").toString());
purchaseorderid = SH.cleanInput(formData.get("purchaseorderid").toString());
batchno = SH.cleanInput(formData.get("batchno").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Nsupplierid = Integer.valueOf(supplierid);
Npurchaseorderid = Integer.valueOf(purchaseorderid);

//DATE VALUES
Dgrndate= DH.StrDatetoDate(grndate);

//DATE TIME VALUES
DTcreatedt = DH.StrDatetimetoDatetime(createdt);
DTwritedt = DH.StrDatetimetoDatetime(writedt);
//Integer values
Ncreatebyid = Integer.valueOf(createbyid);
Nwritebyid = Integer.valueOf(writebyid);


factory = SessionFactoryHelper.getsysDBUserSessionFactory();
session = factory.openSession();
try {
tx = session.beginTransaction();
/****************CREATING THE MODEL INSTANCE****************/
if (action.equals("u") || action.equals("d")) {
dataModel = (InvGoodsreceived) session.get(InvGoodsreceived.class, id);
} else {
dataModel = new InvGoodsreceived();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setGrnCode(grncode);
dataModel.setGrmMemo(grmmemo);
dataModel.setGrnRef(grnref);
dataModel.setDeliveryNo(deliveryno);
dataModel.setBatchNo(batchno);
dataModel.setGrnDate(Dgrndate);
PrcSuppliers prcsuppliers = (PrcSuppliers) session.get(PrcSuppliers.class,Nsupplierid);
dataModel.setPrcSuppliers(prcsuppliers);
PrcPurchaseOrder prcpurchaseorder = (PrcPurchaseOrder) session.get(PrcPurchaseOrder.class,Npurchaseorderid);
dataModel.setPrcPurchaseOrder(prcpurchaseorder);
/*AllStatus allstatus = (AllStatus) session.get(AllStatus.class,Nstatus);
dataModel.setAllStatus(allstatus);
InvStore invstore = (InvStore) session.get(InvStore.class,Nstoreid);
dataModel.setInvStore(invstore);
InvGoodsreceived invgoodsreceived = (InvGoodsreceived) session.get(InvGoodsreceived.class,Ngrnid);
dataModel.setInvGoodsreceived(invgoodsreceived);
/*Item item = (Item) session.get(Item.class,Nitemid);
dataModel.setItem(item);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Npurchaseuomid);
dataModel.setCrmUom(crmuom);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Nreceiveduomid);
dataModel.setCrmUom(crmuom);
AllStatus allstatus = (AllStatus) session.get(AllStatus.class,Nstatus);
dataModel.setAllStatus(allstatus);
*/
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
returngridata = getInvGoodsreceiveddata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getInvGoodsreceiveddata(id);
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
} catch (DataException | ConstraintViolationException | JDBCConnectionException | SQLGrammarException e) {

String msg = e.getCause().toString();
if (tx != null) {
tx.rollback();
}

data.put("msgtype", "fail");
if (action.equals("c")) {
data.put("msg", "Insertion Failed" + msg);
} else if (action.equals("u")) {
data.put("msg", "Updating Failed" + msg);
} else if (action.equals("d")) {
data.put("msg", "Deleting Failed" + msg);
}
} finally {
session.close();
}


} catch (Exception e) {

msg = e.toString()+" , "+ e.getMessage();
data.put("msgtype", "fail");
data.put("msg", "Saving Error " + msg);
if(this.isSessionActive()){session.close();}
}

return data;
}


private boolean isSessionActive(){
try{
if(session.isOpen() || session.isDirty() || session.isConnected()){
return true;
}else{ return false; }
}catch(Exception e){
return false;
}
}

/************A METHOD RETURN DATA IN CUSTOMIZED SPECIFIC DHTMLX GRID FORMAT*************/
private String getInvGoodsreceiveddata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM InvGoodsreceived Where grnId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
InvGoodsreceived invgoodsreceived = (InvGoodsreceived) iterator.next();
gridata = i + ","+invgoodsreceived.getGrnCode() + "," + invgoodsreceived.getGrmMemo() + "," + invgoodsreceived.getGrnRef() + "," + invgoodsreceived.getDeliveryNo() + "," + invgoodsreceived.getBatchNo() + "," + invgoodsreceived.getPrcSuppliers().getSupplierId() + "," + invgoodsreceived.getPrcPurchaseOrder().getPurchaseorderId() + "," + invgoodsreceived.getAllStatus().getStatusId() + "," + invgoodsreceived.getAllStatus().getStatusId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data


/*public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map grncoderules = new HashMap< String, Object>();
grncoderules.put("required", "false");
grncoderules.put("minlength", "0");
grncoderules.put("maxlength", "20");
grncoderules.put("isemail", "false");
grncoderules.put("isalphanumeric", "false");
grncoderules.put("isnumeric", "false");
grncoderules.put("isinteger", "false");
grncoderules.put("lengthmessage", "Length should be between "+grncoderules.get("minlength")+" and "+grncoderules.get("maxlength")+" " );
rules.put("grncode",grncoderules);

Map grndaterules = new HashMap< String, Object>();
grndaterules.put("required", "false");
grndaterules.put("minlength", "0");
grndaterules.put("maxlength", "20");
grndaterules.put("isemail", "false");
grndaterules.put("isalphanumeric", "false");
grndaterules.put("isnumeric", "false");
grndaterules.put("isinteger", "false");
grndaterules.put("lengthmessage", "Length should be between "+grndaterules.get("minlength")+" and "+grndaterules.get("maxlength")+" " );
rules.put("grndate",grndaterules);

Map grmmemorules = new HashMap< String, Object>();
grmmemorules.put("required", "false");
grmmemorules.put("minlength", "0");
grmmemorules.put("maxlength", "20");
grmmemorules.put("isemail", "false");
grmmemorules.put("isalphanumeric", "false");
grmmemorules.put("isnumeric", "false");
grmmemorules.put("isinteger", "false");
grmmemorules.put("lengthmessage", "Length should be between "+grmmemorules.get("minlength")+" and "+grmmemorules.get("maxlength")+" " );
rules.put("grmmemo",grmmemorules);

Map grnrefrules = new HashMap< String, Object>();
grnrefrules.put("required", "false");
grnrefrules.put("minlength", "0");
grnrefrules.put("maxlength", "20");
grnrefrules.put("isemail", "false");
grnrefrules.put("isalphanumeric", "false");
grnrefrules.put("isnumeric", "false");
grnrefrules.put("isinteger", "false");
grnrefrules.put("lengthmessage", "Length should be between "+grnrefrules.get("minlength")+" and "+grnrefrules.get("maxlength")+" " );
rules.put("grnref",grnrefrules);

Map deliverynorules = new HashMap< String, Object>();
deliverynorules.put("required", "true");
deliverynorules.put("minlength", "1");
deliverynorules.put("maxlength", "20");
deliverynorules.put("isemail", "false");
deliverynorules.put("isalphanumeric", "false");
deliverynorules.put("isnumeric", "false");
deliverynorules.put("isinteger", "false");
deliverynorules.put("lengthmessage", "Length should be between "+deliverynorules.get("minlength")+" and "+deliverynorules.get("maxlength")+" " );
rules.put("deliveryno",deliverynorules);

Map supplieridrules = new HashMap< String, Object>();
supplieridrules.put("required", "false");
supplieridrules.put("minlength", "0");
supplieridrules.put("maxlength", "20");
supplieridrules.put("isemail", "false");
supplieridrules.put("isalphanumeric", "false");
supplieridrules.put("isnumeric", "false");
supplieridrules.put("isinteger", "false");
supplieridrules.put("lengthmessage", "Length should be between "+supplieridrules.get("minlength")+" and "+supplieridrules.get("maxlength")+" " );
rules.put("supplierid",supplieridrules);

Map purchaseorderidrules = new HashMap< String, Object>();
purchaseorderidrules.put("required", "false");
purchaseorderidrules.put("minlength", "0");
purchaseorderidrules.put("maxlength", "20");
purchaseorderidrules.put("isemail", "false");
purchaseorderidrules.put("isalphanumeric", "false");
purchaseorderidrules.put("isnumeric", "false");
purchaseorderidrules.put("isinteger", "false");
purchaseorderidrules.put("lengthmessage", "Length should be between "+purchaseorderidrules.get("minlength")+" and "+purchaseorderidrules.get("maxlength")+" " );
rules.put("purchaseorderid",purchaseorderidrules);

Map batchnorules = new HashMap< String, Object>();
batchnorules.put("required", "false");
batchnorules.put("minlength", "0");
batchnorules.put("maxlength", "20");
batchnorules.put("isemail", "false");
batchnorules.put("isalphanumeric", "false");
batchnorules.put("isnumeric", "false");
batchnorules.put("isinteger", "false");
batchnorules.put("lengthmessage", "Length should be between "+batchnorules.get("minlength")+" and "+batchnorules.get("maxlength")+" " );
rules.put("batchno",batchnorules);


return rules;
} */}

