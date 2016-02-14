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



public class InvAdjustmentsCrud {
/**
* ***Compulsory fields*****
*/
String strid,feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata,returngridata,createbyid, writebyid,writedt,createdt;
Integer Ncreatebyid, Nwritebyid, id, i;
Date DTwritedt, DTcreatedt,Dadjustmentdate;
List listdata, mydata;
Map <String, Object> data = new HashMap< String, Object >();
DateHelper DH = new DateHelper();
StringHelper SH = new StringHelper();
SessionFactory factory;
Session session;
InvAdjustments dataModel;
Transaction tx = null;

/********Model specific variables************/

String adjustmentcode,adjustmenttype,memo,adjustmentdate,itemid,storeid,uomid,qty,units,reason ;
Integer Nitemid,Nstoreid,Nuomid,Nqty,Nunits,Nreason ;


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
adjustmentcode = SH.cleanInput(formData.get("adjustmentcode").toString());
itemid = SH.cleanInput(formData.get("itemid").toString());
storeid = SH.cleanInput(formData.get("storeid").toString());
uomid = SH.cleanInput(formData.get("uomid").toString());
qty = SH.cleanInput(formData.get("qty").toString());
units = SH.cleanInput(formData.get("units").toString());
adjustmenttype = SH.cleanInput(formData.get("adjustmenttype").toString());
reason = SH.cleanInput(formData.get("reason").toString());
memo = SH.cleanInput(formData.get("memo").toString());
adjustmentdate = SH.cleanInput(formData.get("adjustmentdate").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Nitemid = Integer.valueOf(itemid);
Nstoreid = Integer.valueOf(storeid);
Nuomid = Integer.valueOf(uomid);
Nqty = Integer.valueOf(qty);
Nunits = Integer.valueOf(units);
Nreason = Integer.valueOf(reason);

//DATE VALUES
Dadjustmentdate= DH.StrDatetoDate(adjustmentdate);

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
dataModel = (InvAdjustments) session.get(InvAdjustments.class, id);
} else {
dataModel = new InvAdjustments();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setAdjustmentCode(adjustmentcode);
dataModel.setQty(Nqty);
dataModel.setUnits(Nunits);
dataModel.setAdjustmentType(adjustmenttype);
dataModel.setMemo(memo);
dataModel.setAdjustmentDate(Dadjustmentdate);
Item item = (Item) session.get(Item.class,Nitemid);
dataModel.setItem(item);
InvStore invstore = (InvStore) session.get(InvStore.class,Nstoreid);
dataModel.setInvStore(invstore);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Nuomid);
dataModel.setCrmUom(crmuom);
/*AllStatus allstatus = (AllStatus) session.get(AllStatus.class,Nstatus);
dataModel.setAllStatus(allstatus);*/
CommonCombo commoncombo = (CommonCombo) session.get(CommonCombo.class,Nreason);
dataModel.setCommonCombo(commoncombo);

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
returngridata = getInvAdjustmentsdata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getInvAdjustmentsdata(id);
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
private String getInvAdjustmentsdata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM InvAdjustments Where adjustmentId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
InvAdjustments invadjustments = (InvAdjustments) iterator.next();
gridata = i + ","+invadjustments.getAdjustmentCode() + "," + invadjustments.getQty() + "," + invadjustments.getUnits() + "," + invadjustments.getAdjustmentType() + "," + invadjustments.getMemo() + "," + invadjustments.getItem().getItemId() + "," + invadjustments.getInvStore().getStoreId() + "," + invadjustments.getCrmUom().getUomId() + "," + invadjustments.getCommonCombo().getComboId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data

/*
public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map adjustmentcoderules = new HashMap< String, Object>();
adjustmentcoderules.put("required", "false");
adjustmentcoderules.put("minlength", "0");
adjustmentcoderules.put("maxlength", "20");
adjustmentcoderules.put("isemail", "false");
adjustmentcoderules.put("isalphanumeric", "false");
adjustmentcoderules.put("isnumeric", "false");
adjustmentcoderules.put("isinteger", "false");
adjustmentcoderules.put("lengthmessage", "Length should be between "+adjustmentcoderules.get("minlength")+" and "+adjustmentcoderules.get("maxlength")+" " );
rules.put("adjustmentcode",adjustmentcoderules);

Map itemidrules = new HashMap< String, Object>();
itemidrules.put("required", "true");
itemidrules.put("minlength", "1");
itemidrules.put("maxlength", "20");
itemidrules.put("isemail", "false");
itemidrules.put("isalphanumeric", "false");
itemidrules.put("isnumeric", "false");
itemidrules.put("isinteger", "false");
itemidrules.put("lengthmessage", "Length should be between "+itemidrules.get("minlength")+" and "+itemidrules.get("maxlength")+" " );
rules.put("itemid",itemidrules);

Map storeidrules = new HashMap< String, Object>();
storeidrules.put("required", "true");
storeidrules.put("minlength", "1");
storeidrules.put("maxlength", "20");
storeidrules.put("isemail", "false");
storeidrules.put("isalphanumeric", "false");
storeidrules.put("isnumeric", "false");
storeidrules.put("isinteger", "false");
storeidrules.put("lengthmessage", "Length should be between "+storeidrules.get("minlength")+" and "+storeidrules.get("maxlength")+" " );
rules.put("storeid",storeidrules);

Map uomidrules = new HashMap< String, Object>();
uomidrules.put("required", "false");
uomidrules.put("minlength", "0");
uomidrules.put("maxlength", "20");
uomidrules.put("isemail", "false");
uomidrules.put("isalphanumeric", "false");
uomidrules.put("isnumeric", "false");
uomidrules.put("isinteger", "false");
uomidrules.put("lengthmessage", "Length should be between "+uomidrules.get("minlength")+" and "+uomidrules.get("maxlength")+" " );
rules.put("uomid",uomidrules);

Map qtyrules = new HashMap< String, Object>();
qtyrules.put("required", "false");
qtyrules.put("minlength", "0");
qtyrules.put("maxlength", "20");
qtyrules.put("isemail", "false");
qtyrules.put("isalphanumeric", "false");
qtyrules.put("isnumeric", "false");
qtyrules.put("isinteger", "false");
qtyrules.put("lengthmessage", "Length should be between "+qtyrules.get("minlength")+" and "+qtyrules.get("maxlength")+" " );
rules.put("qty",qtyrules);

Map unitsrules = new HashMap< String, Object>();
unitsrules.put("required", "false");
unitsrules.put("minlength", "0");
unitsrules.put("maxlength", "20");
unitsrules.put("isemail", "false");
unitsrules.put("isalphanumeric", "false");
unitsrules.put("isnumeric", "false");
unitsrules.put("isinteger", "false");
unitsrules.put("lengthmessage", "Length should be between "+unitsrules.get("minlength")+" and "+unitsrules.get("maxlength")+" " );
rules.put("units",unitsrules);

Map adjustmenttyperules = new HashMap< String, Object>();
adjustmenttyperules.put("required", "true");
adjustmenttyperules.put("minlength", "1");
adjustmenttyperules.put("maxlength", "20");
adjustmenttyperules.put("isemail", "false");
adjustmenttyperules.put("isalphanumeric", "false");
adjustmenttyperules.put("isnumeric", "false");
adjustmenttyperules.put("isinteger", "false");
adjustmenttyperules.put("lengthmessage", "Length should be between "+adjustmenttyperules.get("minlength")+" and "+adjustmenttyperules.get("maxlength")+" " );
rules.put("adjustmenttype",adjustmenttyperules);

Map reasonrules = new HashMap< String, Object>();
reasonrules.put("required", "false");
reasonrules.put("minlength", "0");
reasonrules.put("maxlength", "20");
reasonrules.put("isemail", "false");
reasonrules.put("isalphanumeric", "false");
reasonrules.put("isnumeric", "false");
reasonrules.put("isinteger", "false");
reasonrules.put("lengthmessage", "Length should be between "+reasonrules.get("minlength")+" and "+reasonrules.get("maxlength")+" " );
rules.put("reason",reasonrules);

Map memorules = new HashMap< String, Object>();
memorules.put("required", "false");
memorules.put("minlength", "0");
memorules.put("maxlength", "20");
memorules.put("isemail", "false");
memorules.put("isalphanumeric", "false");
memorules.put("isnumeric", "false");
memorules.put("isinteger", "false");
memorules.put("lengthmessage", "Length should be between "+memorules.get("minlength")+" and "+memorules.get("maxlength")+" " );
rules.put("memo",memorules);

Map adjustmentdaterules = new HashMap< String, Object>();
adjustmentdaterules.put("required", "false");
adjustmentdaterules.put("minlength", "0");
adjustmentdaterules.put("maxlength", "20");
adjustmentdaterules.put("isemail", "false");
adjustmentdaterules.put("isalphanumeric", "false");
adjustmentdaterules.put("isnumeric", "false");
adjustmentdaterules.put("isinteger", "false");
adjustmentdaterules.put("lengthmessage", "Length should be between "+adjustmentdaterules.get("minlength")+" and "+adjustmentdaterules.get("maxlength")+" " );
rules.put("adjustmentdate",adjustmentdaterules);


return rules;
} */}


