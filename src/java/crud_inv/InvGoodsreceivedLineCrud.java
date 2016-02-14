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



public class InvGoodsreceivedLineCrud {
/**
* ***Compulsory fields*****
*/
String strid,feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata,returngridata,createbyid, writebyid,writedt,createdt;
Integer Ncreatebyid, Nwritebyid, id, i;
Date DTwritedt, DTcreatedt,Drecieveddate;
List listdata, mydata;
Map <String, Object> data = new HashMap< String, Object >();
DateHelper DH = new DateHelper();
StringHelper SH = new StringHelper();
SessionFactory factory;
Session session;
InvGoodsreceivedLine dataModel;
Transaction tx = null;

/********Model specific variables************/

String recieveddate,ref,batchno,purchaseqty,grnid,itemid,purchaseuomid,purchaseunits,receiveduomid,receivedqty,receivedunits,storeid ,purchaseuomqty,purchaseprice,receivedprice,receiveduomqty;
Integer Ngrnid,Nitemid,Npurchaseuomid,Npurchaseunits,Nreceiveduomid,Nreceivedqty,Nreceivedunits,Nstoreid ;
BigDecimal BDpurchaseuomqty,BDpurchaseprice,BDreceivedprice,BDreceiveduomqty ;


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
grnid = SH.cleanInput(formData.get("grnid").toString());
recieveddate = SH.cleanInput(formData.get("recieveddate").toString());
ref = SH.cleanInput(formData.get("ref").toString());
itemid = SH.cleanInput(formData.get("itemid").toString());
batchno = SH.cleanInput(formData.get("batchno").toString());
purchaseqty = SH.cleanInput(formData.get("purchaseqty").toString());
purchaseuomqty = SH.cleanInput(formData.get("purchaseuomqty").toString());
purchaseuomid = SH.cleanInput(formData.get("purchaseuomid").toString());
purchaseunits = SH.cleanInput(formData.get("purchaseunits").toString());
purchaseprice = SH.cleanInput(formData.get("purchaseprice").toString());
receiveduomid = SH.cleanInput(formData.get("receiveduomid").toString());
receivedqty = SH.cleanInput(formData.get("receivedqty").toString());
receivedunits = SH.cleanInput(formData.get("receivedunits").toString());
receivedprice = SH.cleanInput(formData.get("receivedprice").toString());
receiveduomqty = SH.cleanInput(formData.get("receiveduomqty").toString());
storeid = SH.cleanInput(formData.get("storeid").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Ngrnid = Integer.valueOf(grnid);
Nitemid = Integer.valueOf(itemid);
Npurchaseuomid = Integer.valueOf(purchaseuomid);
Npurchaseunits = Integer.valueOf(purchaseunits);
Nreceiveduomid = Integer.valueOf(receiveduomid);
Nreceivedqty = Integer.valueOf(receivedqty);
Nreceivedunits = Integer.valueOf(receivedunits);
Nstoreid = Integer.valueOf(storeid);

//DATE VALUES
Drecieveddate= DH.StrDatetoDate(recieveddate);

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
dataModel = (InvGoodsreceivedLine) session.get(InvGoodsreceivedLine.class, id);
} else {
dataModel = new InvGoodsreceivedLine();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setRef(ref);
dataModel.setBatchNo(batchno);
dataModel.setPurchaseqty(purchaseqty);
dataModel.setPurchaseunits(Npurchaseunits);
dataModel.setReceivedqty(Nreceivedqty);
dataModel.setReceivedunits(Nreceivedunits);
dataModel.setRecievedDate(Drecieveddate);
BDpurchaseuomqty= new BigDecimal(purchaseuomqty);
dataModel.setPurchaseuomQty(BDpurchaseuomqty);
BDpurchaseprice= new BigDecimal(purchaseprice);
dataModel.setPurchasePrice(BDpurchaseprice);
BDreceivedprice= new BigDecimal(receivedprice);
dataModel.setReceivedprice(BDreceivedprice);
BDreceiveduomqty= new BigDecimal(receiveduomqty);
dataModel.setReceiveduomQty(BDreceiveduomqty);
InvStore invstore = (InvStore) session.get(InvStore.class,Nstoreid);
dataModel.setInvStore(invstore);
InvGoodsreceived invgoodsreceived = (InvGoodsreceived) session.get(InvGoodsreceived.class,Ngrnid);
dataModel.setInvGoodsreceived(invgoodsreceived);
Item item = (Item) session.get(Item.class,Nitemid);
dataModel.setItem(item);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Npurchaseuomid);
dataModel.setCrmUomByPurchaseuomId(crmuom);
CrmUom crmuom1 = (CrmUom) session.get(CrmUom.class,Nreceiveduomid);
dataModel.setCrmUomByReceiveduomId(crmuom1);
/*AllStatus allstatus = (AllStatus) session.get(AllStatus.class,Nstatus);
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
returngridata = getInvGoodsreceivedLinedata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getInvGoodsreceivedLinedata(id);
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
private String getInvGoodsreceivedLinedata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM InvGoodsreceivedLine Where grnLineId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
InvGoodsreceivedLine invgoodsreceivedline = (InvGoodsreceivedLine) iterator.next();
gridata = i + ","+invgoodsreceivedline.getRef() + "," + invgoodsreceivedline.getBatchNo() + "," + invgoodsreceivedline.getPurchaseqty() + "," + invgoodsreceivedline.getPurchaseuomQty() + "," + invgoodsreceivedline.getPurchaseunits() + "," + invgoodsreceivedline.getPurchasePrice() + "," + invgoodsreceivedline.getReceivedqty() + "," + invgoodsreceivedline.getReceivedunits() + "," + invgoodsreceivedline.getReceivedprice() + "," + invgoodsreceivedline.getReceiveduomQty() + "," + invgoodsreceivedline.getInvStore().getStoreId() + "," + invgoodsreceivedline.getInvGoodsreceived().getGrnId() + "," + invgoodsreceivedline.getItem().getItemId() + "," + invgoodsreceivedline.getCrmUomByPurchaseuomId().getUomId() + "," + invgoodsreceivedline.getCrmUomByReceiveduomId().getUomId() + "," + invgoodsreceivedline.getAllStatus().getStatusId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data


/*public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map grnidrules = new HashMap< String, Object>();
grnidrules.put("required", "false");
grnidrules.put("minlength", "0");
grnidrules.put("maxlength", "20");
grnidrules.put("isemail", "false");
grnidrules.put("isalphanumeric", "false");
grnidrules.put("isnumeric", "false");
grnidrules.put("isinteger", "false");
grnidrules.put("lengthmessage", "Length should be between "+grnidrules.get("minlength")+" and "+grnidrules.get("maxlength")+" " );
rules.put("grnid",grnidrules);

Map recieveddaterules = new HashMap< String, Object>();
recieveddaterules.put("required", "false");
recieveddaterules.put("minlength", "0");
recieveddaterules.put("maxlength", "20");
recieveddaterules.put("isemail", "false");
recieveddaterules.put("isalphanumeric", "false");
recieveddaterules.put("isnumeric", "false");
recieveddaterules.put("isinteger", "false");
recieveddaterules.put("lengthmessage", "Length should be between "+recieveddaterules.get("minlength")+" and "+recieveddaterules.get("maxlength")+" " );
rules.put("recieveddate",recieveddaterules);

Map refrules = new HashMap< String, Object>();
refrules.put("required", "false");
refrules.put("minlength", "0");
refrules.put("maxlength", "20");
refrules.put("isemail", "false");
refrules.put("isalphanumeric", "false");
refrules.put("isnumeric", "false");
refrules.put("isinteger", "false");
refrules.put("lengthmessage", "Length should be between "+refrules.get("minlength")+" and "+refrules.get("maxlength")+" " );
rules.put("ref",refrules);

Map itemidrules = new HashMap< String, Object>();
itemidrules.put("required", "false");
itemidrules.put("minlength", "0");
itemidrules.put("maxlength", "20");
itemidrules.put("isemail", "false");
itemidrules.put("isalphanumeric", "false");
itemidrules.put("isnumeric", "false");
itemidrules.put("isinteger", "false");
itemidrules.put("lengthmessage", "Length should be between "+itemidrules.get("minlength")+" and "+itemidrules.get("maxlength")+" " );
rules.put("itemid",itemidrules);

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

Map purchaseqtyrules = new HashMap< String, Object>();
purchaseqtyrules.put("required", "false");
purchaseqtyrules.put("minlength", "0");
purchaseqtyrules.put("maxlength", "20");
purchaseqtyrules.put("isemail", "false");
purchaseqtyrules.put("isalphanumeric", "false");
purchaseqtyrules.put("isnumeric", "false");
purchaseqtyrules.put("isinteger", "false");
purchaseqtyrules.put("lengthmessage", "Length should be between "+purchaseqtyrules.get("minlength")+" and "+purchaseqtyrules.get("maxlength")+" " );
rules.put("purchaseqty",purchaseqtyrules);

Map purchaseuomqtyrules = new HashMap< String, Object>();
purchaseuomqtyrules.put("required", "false");
purchaseuomqtyrules.put("minlength", "0");
purchaseuomqtyrules.put("maxlength", "20");
purchaseuomqtyrules.put("isemail", "false");
purchaseuomqtyrules.put("isalphanumeric", "false");
purchaseuomqtyrules.put("isnumeric", "false");
purchaseuomqtyrules.put("isinteger", "false");
purchaseuomqtyrules.put("lengthmessage", "Length should be between "+purchaseuomqtyrules.get("minlength")+" and "+purchaseuomqtyrules.get("maxlength")+" " );
rules.put("purchaseuomqty",purchaseuomqtyrules);

Map purchaseuomidrules = new HashMap< String, Object>();
purchaseuomidrules.put("required", "false");
purchaseuomidrules.put("minlength", "0");
purchaseuomidrules.put("maxlength", "20");
purchaseuomidrules.put("isemail", "false");
purchaseuomidrules.put("isalphanumeric", "false");
purchaseuomidrules.put("isnumeric", "false");
purchaseuomidrules.put("isinteger", "false");
purchaseuomidrules.put("lengthmessage", "Length should be between "+purchaseuomidrules.get("minlength")+" and "+purchaseuomidrules.get("maxlength")+" " );
rules.put("purchaseuomid",purchaseuomidrules);

Map purchaseunitsrules = new HashMap< String, Object>();
purchaseunitsrules.put("required", "false");
purchaseunitsrules.put("minlength", "0");
purchaseunitsrules.put("maxlength", "20");
purchaseunitsrules.put("isemail", "false");
purchaseunitsrules.put("isalphanumeric", "false");
purchaseunitsrules.put("isnumeric", "false");
purchaseunitsrules.put("isinteger", "false");
purchaseunitsrules.put("lengthmessage", "Length should be between "+purchaseunitsrules.get("minlength")+" and "+purchaseunitsrules.get("maxlength")+" " );
rules.put("purchaseunits",purchaseunitsrules);

Map purchasepricerules = new HashMap< String, Object>();
purchasepricerules.put("required", "false");
purchasepricerules.put("minlength", "0");
purchasepricerules.put("maxlength", "20");
purchasepricerules.put("isemail", "false");
purchasepricerules.put("isalphanumeric", "false");
purchasepricerules.put("isnumeric", "false");
purchasepricerules.put("isinteger", "false");
purchasepricerules.put("lengthmessage", "Length should be between "+purchasepricerules.get("minlength")+" and "+purchasepricerules.get("maxlength")+" " );
rules.put("purchaseprice",purchasepricerules);

Map receiveduomidrules = new HashMap< String, Object>();
receiveduomidrules.put("required", "false");
receiveduomidrules.put("minlength", "0");
receiveduomidrules.put("maxlength", "20");
receiveduomidrules.put("isemail", "false");
receiveduomidrules.put("isalphanumeric", "false");
receiveduomidrules.put("isnumeric", "false");
receiveduomidrules.put("isinteger", "false");
receiveduomidrules.put("lengthmessage", "Length should be between "+receiveduomidrules.get("minlength")+" and "+receiveduomidrules.get("maxlength")+" " );
rules.put("receiveduomid",receiveduomidrules);

Map receivedqtyrules = new HashMap< String, Object>();
receivedqtyrules.put("required", "false");
receivedqtyrules.put("minlength", "0");
receivedqtyrules.put("maxlength", "20");
receivedqtyrules.put("isemail", "false");
receivedqtyrules.put("isalphanumeric", "false");
receivedqtyrules.put("isnumeric", "false");
receivedqtyrules.put("isinteger", "false");
receivedqtyrules.put("lengthmessage", "Length should be between "+receivedqtyrules.get("minlength")+" and "+receivedqtyrules.get("maxlength")+" " );
rules.put("receivedqty",receivedqtyrules);

Map receivedunitsrules = new HashMap< String, Object>();
receivedunitsrules.put("required", "false");
receivedunitsrules.put("minlength", "0");
receivedunitsrules.put("maxlength", "20");
receivedunitsrules.put("isemail", "false");
receivedunitsrules.put("isalphanumeric", "false");
receivedunitsrules.put("isnumeric", "false");
receivedunitsrules.put("isinteger", "false");
receivedunitsrules.put("lengthmessage", "Length should be between "+receivedunitsrules.get("minlength")+" and "+receivedunitsrules.get("maxlength")+" " );
rules.put("receivedunits",receivedunitsrules);

Map receivedpricerules = new HashMap< String, Object>();
receivedpricerules.put("required", "false");
receivedpricerules.put("minlength", "0");
receivedpricerules.put("maxlength", "20");
receivedpricerules.put("isemail", "false");
receivedpricerules.put("isalphanumeric", "false");
receivedpricerules.put("isnumeric", "false");
receivedpricerules.put("isinteger", "false");
receivedpricerules.put("lengthmessage", "Length should be between "+receivedpricerules.get("minlength")+" and "+receivedpricerules.get("maxlength")+" " );
rules.put("receivedprice",receivedpricerules);

Map receiveduomqtyrules = new HashMap< String, Object>();
receiveduomqtyrules.put("required", "false");
receiveduomqtyrules.put("minlength", "0");
receiveduomqtyrules.put("maxlength", "20");
receiveduomqtyrules.put("isemail", "false");
receiveduomqtyrules.put("isalphanumeric", "false");
receiveduomqtyrules.put("isnumeric", "false");
receiveduomqtyrules.put("isinteger", "false");
receiveduomqtyrules.put("lengthmessage", "Length should be between "+receiveduomqtyrules.get("minlength")+" and "+receiveduomqtyrules.get("maxlength")+" " );
rules.put("receiveduomqty",receiveduomqtyrules);

Map storeidrules = new HashMap< String, Object>();
storeidrules.put("required", "false");
storeidrules.put("minlength", "0");
storeidrules.put("maxlength", "20");
storeidrules.put("isemail", "false");
storeidrules.put("isalphanumeric", "false");
storeidrules.put("isnumeric", "false");
storeidrules.put("isinteger", "false");
storeidrules.put("lengthmessage", "Length should be between "+storeidrules.get("minlength")+" and "+storeidrules.get("maxlength")+" " );
rules.put("storeid",storeidrules);


return rules;
} */}




 

