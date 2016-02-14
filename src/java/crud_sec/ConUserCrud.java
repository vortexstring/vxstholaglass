/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud_sec;

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



public class ConUserCrud {
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
ConUser dataModel;
Transaction tx = null;

/********Model specific variables************/

String surname,othername,profileid,status ;
Integer Nprofileid,Nstatus ;


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
surname = SH.cleanInput(formData.get("surname").toString());
othername = SH.cleanInput(formData.get("othername").toString());
profileid = SH.cleanInput(formData.get("profileid").toString());
status = SH.cleanInput(formData.get("status").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Nprofileid = Integer.valueOf(profileid);
Nstatus = Integer.valueOf(status);

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
dataModel = (ConUser) session.get(ConUser.class, id);
} else {
dataModel = new ConUser();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setSurname(surname);
dataModel.setOtherName(othername);
ConProfiles conprofiles = (ConProfiles) session.get(ConProfiles.class,Nprofileid);
dataModel.setConProfiles(conprofiles);
AllStatus allstatus = (AllStatus) session.get(AllStatus.class,Nstatus);
dataModel.setAllStatus(allstatus);

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
returngridata = getConUserdata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getConUserdata(id);
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
private String getConUserdata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM ConUser Where userId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
ConUser conuser = (ConUser) iterator.next();
gridata = i + ","+conuser.getSurname() + "," + conuser.getOtherName() + "," + conuser.getConProfiles().getProfileId() + "," + conuser.getAllStatus().getStatusId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data


/*public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map surnamerules = new HashMap< String, Object>();
surnamerules.put("required", "true");
surnamerules.put("minlength", "1");
surnamerules.put("maxlength", "20");
surnamerules.put("isemail", "false");
surnamerules.put("isalphanumeric", "false");
surnamerules.put("isnumeric", "false");
surnamerules.put("isinteger", "false");
surnamerules.put("lengthmessage", "Length should be between "+surnamerules.get("minlength")+" and "+surnamerules.get("maxlength")+" " );
rules.put("surname",surnamerules);

Map othernamerules = new HashMap< String, Object>();
othernamerules.put("required", "true");
othernamerules.put("minlength", "1");
othernamerules.put("maxlength", "20");
othernamerules.put("isemail", "false");
othernamerules.put("isalphanumeric", "false");
othernamerules.put("isnumeric", "false");
othernamerules.put("isinteger", "false");
othernamerules.put("lengthmessage", "Length should be between "+othernamerules.get("minlength")+" and "+othernamerules.get("maxlength")+" " );
rules.put("othername",othernamerules);

Map profileidrules = new HashMap< String, Object>();
profileidrules.put("required", "true");
profileidrules.put("minlength", "1");
profileidrules.put("maxlength", "20");
profileidrules.put("isemail", "false");
profileidrules.put("isalphanumeric", "false");
profileidrules.put("isnumeric", "false");
profileidrules.put("isinteger", "false");
profileidrules.put("lengthmessage", "Length should be between "+profileidrules.get("minlength")+" and "+profileidrules.get("maxlength")+" " );
rules.put("profileid",profileidrules);

Map statusrules = new HashMap< String, Object>();
statusrules.put("required", "false");
statusrules.put("minlength", "0");
statusrules.put("maxlength", "20");
statusrules.put("isemail", "false");
statusrules.put("isalphanumeric", "false");
statusrules.put("isnumeric", "false");
statusrules.put("isinteger", "false");
statusrules.put("lengthmessage", "Length should be between "+statusrules.get("minlength")+" and "+statusrules.get("maxlength")+" " );
rules.put("status",statusrules);


return rules;
}*/ }












