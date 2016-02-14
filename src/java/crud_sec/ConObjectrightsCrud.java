/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud_sec;

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



public class ConObjectrightsCrud {
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
ConObjectrights dataModel;
Transaction tx = null;

/********Model specific variables************/

Integer Nprofileid,Nobjectid ;
boolean Bcanview,Bcanadd,Bcanedit,Bcandel,Bcanauthorize,Bcanapprove,Bcanexport ;
String canview,canadd,canedit,candel,canauthorize,canapprove,canexport,profileid,objectid; 


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
profileid = SH.cleanInput(formData.get("profileid").toString());
objectid = SH.cleanInput(formData.get("objectid").toString());
canview = SH.cleanInput(formData.get("canview").toString());
canadd = SH.cleanInput(formData.get("canadd").toString());
canedit = SH.cleanInput(formData.get("canedit").toString());
candel = SH.cleanInput(formData.get("candel").toString());
canauthorize = SH.cleanInput(formData.get("canauthorize").toString());
canapprove = SH.cleanInput(formData.get("canapprove").toString());
canexport = SH.cleanInput(formData.get("canexport").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Nprofileid = Integer.valueOf(profileid);
Nobjectid = Integer.valueOf(objectid);

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
dataModel = (ConObjectrights) session.get(ConObjectrights.class, id);
} else {
dataModel = new ConObjectrights();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
Bcanview=SH.stringToBoolean(canview);
dataModel.setCanview(Bcanview);
Bcanadd=SH.stringToBoolean(canadd);
dataModel.setCanadd(Bcanadd);
Bcanedit=SH.stringToBoolean(canedit);
dataModel.setCanedit(Bcanedit);
Bcandel=SH.stringToBoolean(candel);
dataModel.setCandel(Bcandel);
Bcanauthorize=SH.stringToBoolean(canauthorize);
dataModel.setCanauthorize(Bcanauthorize);
Bcanapprove=SH.stringToBoolean(canapprove);
dataModel.setCanapprove(Bcanapprove);
Bcanexport=SH.stringToBoolean(canexport);
dataModel.setCanexport(Bcanexport);
ConProfiles conprofiles = (ConProfiles) session.get(ConProfiles.class,Nprofileid);
dataModel.setConProfiles(conprofiles);
ConObjects conobjects = (ConObjects) session.get(ConObjects.class,Nobjectid);
dataModel.setConObjects(conobjects);

//PRINT COMPULSORY SET METHODS
dataModel.setWritedt(DTwritedt);
ConUser writebyRec = (ConUser) session.get(ConUser.class, Nwritebyid);
dataModel.setConUserByWritebyId(writebyRec);
/*ConCompany companyRec = (ConCompany) session.get(ConCompany.class, 1);
dataModel.setConCompany(companyRec);*/

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
returngridata = getConObjectrightsdata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getConObjectrightsdata(id);
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
private String getConObjectrightsdata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM ConObjectrights Where objectRightsId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
ConObjectrights conobjectrights = (ConObjectrights) iterator.next();
gridata = i + ","+conobjectrights.isCanview() + "," + conobjectrights.isCanadd() + "," + conobjectrights.isCanedit() + "," + conobjectrights.isCandel() + "," + conobjectrights.isCanauthorize() + "," + conobjectrights.isCanapprove() + "," + conobjectrights.isCanexport() + "," + conobjectrights.getConProfiles().getProfileId() + "," + conobjectrights.getConObjects().getObjectId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data


public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map profileidrules = new HashMap< String, Object>();
profileidrules.put("required", "false");
profileidrules.put("minlength", "0");
profileidrules.put("maxlength", "50");
profileidrules.put("isemail", "false");
profileidrules.put("isalphanumeric", "false");
profileidrules.put("isnumeric", "false");
profileidrules.put("isinteger", "false");
profileidrules.put("lengthmessage", "Length should be between "+profileidrules.get("minlength")+" and "+profileidrules.get("maxlength")+" " );
rules.put("profileid",profileidrules);

Map objectidrules = new HashMap< String, Object>();
objectidrules.put("required", "false");
objectidrules.put("minlength", "0");
objectidrules.put("maxlength", "50");
objectidrules.put("isemail", "false");
objectidrules.put("isalphanumeric", "false");
objectidrules.put("isnumeric", "false");
objectidrules.put("isinteger", "false");
objectidrules.put("lengthmessage", "Length should be between "+objectidrules.get("minlength")+" and "+objectidrules.get("maxlength")+" " );
rules.put("objectid",objectidrules);

Map canviewrules = new HashMap< String, Object>();
canviewrules.put("required", "false");
canviewrules.put("minlength", "0");
canviewrules.put("maxlength", "1");
canviewrules.put("isemail", "false");
canviewrules.put("isalphanumeric", "false");
canviewrules.put("isnumeric", "false");
canviewrules.put("isinteger", "false");
canviewrules.put("lengthmessage", "Length should be between "+canviewrules.get("minlength")+" and "+canviewrules.get("maxlength")+" " );
rules.put("canview",canviewrules);

Map canaddrules = new HashMap< String, Object>();
canaddrules.put("required", "false");
canaddrules.put("minlength", "0");
canaddrules.put("maxlength", "1");
canaddrules.put("isemail", "false");
canaddrules.put("isalphanumeric", "false");
canaddrules.put("isnumeric", "false");
canaddrules.put("isinteger", "false");
canaddrules.put("lengthmessage", "Length should be between "+canaddrules.get("minlength")+" and "+canaddrules.get("maxlength")+" " );
rules.put("canadd",canaddrules);

Map caneditrules = new HashMap< String, Object>();
caneditrules.put("required", "false");
caneditrules.put("minlength", "0");
caneditrules.put("maxlength", "1");
caneditrules.put("isemail", "false");
caneditrules.put("isalphanumeric", "false");
caneditrules.put("isnumeric", "false");
caneditrules.put("isinteger", "false");
caneditrules.put("lengthmessage", "Length should be between "+caneditrules.get("minlength")+" and "+caneditrules.get("maxlength")+" " );
rules.put("canedit",caneditrules);

Map candelrules = new HashMap< String, Object>();
candelrules.put("required", "false");
candelrules.put("minlength", "0");
candelrules.put("maxlength", "1");
candelrules.put("isemail", "false");
candelrules.put("isalphanumeric", "false");
candelrules.put("isnumeric", "false");
candelrules.put("isinteger", "false");
candelrules.put("lengthmessage", "Length should be between "+candelrules.get("minlength")+" and "+candelrules.get("maxlength")+" " );
rules.put("candel",candelrules);

Map canauthorizerules = new HashMap< String, Object>();
canauthorizerules.put("required", "false");
canauthorizerules.put("minlength", "0");
canauthorizerules.put("maxlength", "1");
canauthorizerules.put("isemail", "false");
canauthorizerules.put("isalphanumeric", "false");
canauthorizerules.put("isnumeric", "false");
canauthorizerules.put("isinteger", "false");
canauthorizerules.put("lengthmessage", "Length should be between "+canauthorizerules.get("minlength")+" and "+canauthorizerules.get("maxlength")+" " );
rules.put("canauthorize",canauthorizerules);

Map canapproverules = new HashMap< String, Object>();
canapproverules.put("required", "false");
canapproverules.put("minlength", "0");
canapproverules.put("maxlength", "1");
canapproverules.put("isemail", "false");
canapproverules.put("isalphanumeric", "false");
canapproverules.put("isnumeric", "false");
canapproverules.put("isinteger", "false");
canapproverules.put("lengthmessage", "Length should be between "+canapproverules.get("minlength")+" and "+canapproverules.get("maxlength")+" " );
rules.put("canapprove",canapproverules);

Map canexportrules = new HashMap< String, Object>();
canexportrules.put("required", "false");
canexportrules.put("minlength", "0");
canexportrules.put("maxlength", "1");
canexportrules.put("isemail", "false");
canexportrules.put("isalphanumeric", "false");
canexportrules.put("isnumeric", "false");
canexportrules.put("isinteger", "false");
canexportrules.put("lengthmessage", "Length should be between "+canexportrules.get("minlength")+" and "+canexportrules.get("maxlength")+" " );
rules.put("canexport",canexportrules);


return rules;
} }



