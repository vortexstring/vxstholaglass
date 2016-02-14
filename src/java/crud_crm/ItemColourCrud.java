/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud_crm;

/**
 *
 * @author TBL
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



public class ItemColourCrud {
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
Session session;
ItemColour dataModel;
Transaction tx = null;

/********Model specific variables************/

String ralno,colourcode,colourname,itemid ;
Integer Nitemid ;


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
itemid = SH.cleanInput(formData.get("itemid").toString());
ralno = SH.cleanInput(formData.get("ralno").toString());
colourcode = SH.cleanInput(formData.get("colourcode").toString());
colourname = SH.cleanInput(formData.get("colourname").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Nitemid = Integer.valueOf(itemid);

//DATE VALUES

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
dataModel = (ItemColour) session.get(ItemColour.class, id);
} else {
dataModel = new ItemColour();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){

dataModel.setRalNo(ralno);
dataModel.setColourCode(colourcode);
dataModel.setColourName(colourname);
Item item = (Item) session.get(Item.class,Nitemid);
dataModel.setItem(item);

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
returngridata = getItemColourdata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getItemColourdata(id);
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
private String getItemColourdata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM ItemColour Where itemColourId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
ItemColour itemcolour = (ItemColour) iterator.next();
gridata = i + ","+itemcolour.getRalNo()+ "," + itemcolour.getColourCode() + "," + itemcolour.getColourName() + "," + itemcolour.getItem().getItemId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data


public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map itemidrules = new HashMap< String, Object>();
itemidrules.put("required", "false");
itemidrules.put("minlength", "0");
itemidrules.put("maxlength", "50");
itemidrules.put("isemail", "false");
itemidrules.put("isalphanumeric", "false");
itemidrules.put("isnumeric", "false");
itemidrules.put("isinteger", "false");
itemidrules.put("lengthmessage", "Length should be between "+itemidrules.get("minlength")+" and "+itemidrules.get("maxlength")+" " );
rules.put("itemid",itemidrules);

Map ralnorules = new HashMap< String, Object>();
ralnorules.put("required", "true");
ralnorules.put("minlength", "1");
ralnorules.put("maxlength", "30");
ralnorules.put("isemail", "false");
ralnorules.put("isalphanumeric", "false");
ralnorules.put("isnumeric", "false");
ralnorules.put("isinteger", "false");
ralnorules.put("lengthmessage", "Length should be between "+ralnorules.get("minlength")+" and "+ralnorules.get("maxlength")+" " );
rules.put("ralno",ralnorules);

Map colourcoderules = new HashMap< String, Object>();
colourcoderules.put("required", "true");
colourcoderules.put("minlength", "1");
colourcoderules.put("maxlength", "30");
colourcoderules.put("isemail", "false");
colourcoderules.put("isalphanumeric", "false");
colourcoderules.put("isnumeric", "false");
colourcoderules.put("isinteger", "false");
colourcoderules.put("lengthmessage", "Length should be between "+colourcoderules.get("minlength")+" and "+colourcoderules.get("maxlength")+" " );
rules.put("colourcode",colourcoderules);

Map colournamerules = new HashMap< String, Object>();
colournamerules.put("required", "false");
colournamerules.put("minlength", "0");
colournamerules.put("maxlength", "30");
colournamerules.put("isemail", "false");
colournamerules.put("isalphanumeric", "false");
colournamerules.put("isnumeric", "false");
colournamerules.put("isinteger", "false");
colournamerules.put("lengthmessage", "Length should be between "+colournamerules.get("minlength")+" and "+colournamerules.get("maxlength")+" " );
rules.put("colourname",colournamerules);


return rules;
} }
