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



public class ItemConfigurationCrud {
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
ItemConfiguration dataModel;
Transaction tx = null;

/********Model specific variables************/

String configurationname,hascolour,ispurchased,isproduction,issold,hasdimensions,hasproductiontemplate ;
boolean Bhascolour,Bispurchased,Bisproduction,Bissold,Bhasdimensions,Bhasproductiontemplate ;


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
configurationname = SH.cleanInput(formData.get("configurationname").toString());
hascolour = SH.cleanInput(formData.get("hascolour").toString());
ispurchased = SH.cleanInput(formData.get("ispurchased").toString());
isproduction = SH.cleanInput(formData.get("isproduction").toString());
issold = SH.cleanInput(formData.get("issold").toString());
hasdimensions = SH.cleanInput(formData.get("hasdimensions").toString());
hasproductiontemplate = SH.cleanInput(formData.get("hasproductiontemplate").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);

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
dataModel = (ItemConfiguration) session.get(ItemConfiguration.class, id);
} else {
dataModel = new ItemConfiguration();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){

dataModel.setConfigurationName(configurationname);
Bhascolour=SH.stringToBoolean(hascolour);
dataModel.setHasColour(Bhascolour);
Bispurchased=SH.stringToBoolean(ispurchased);
dataModel.setIsPurchased(Bispurchased);
Bisproduction=SH.stringToBoolean(isproduction);
dataModel.setIsProduction(Bisproduction);
Bissold=SH.stringToBoolean(issold);
dataModel.setIsSold(Bissold);
Bhasdimensions=SH.stringToBoolean(hasdimensions);
dataModel.setHasDimensions(Bhasdimensions);
Bhasproductiontemplate=SH.stringToBoolean(hasproductiontemplate);
dataModel.setHasProductionTemplate(Bhasproductiontemplate);

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
returngridata = getItemConfigurationdata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getItemConfigurationdata(id);
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
private String getItemConfigurationdata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM ItemConfiguration Where itemConfigurationId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
ItemConfiguration itemconfiguration = (ItemConfiguration) iterator.next();
gridata = i + ","+itemconfiguration.getConfigurationName() + "," + itemconfiguration.isHasColour()+ "," + itemconfiguration.isIsPurchased()+ "," + itemconfiguration.isIsProduction()+ "," + itemconfiguration.isIsSold()+ "," + itemconfiguration.isHasDimensions()+ "," + itemconfiguration.isHasProductionTemplate();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data


public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map configurationnamerules = new HashMap< String, Object>();
configurationnamerules.put("required", "true");
configurationnamerules.put("minlength", "1");
configurationnamerules.put("maxlength", "50");
configurationnamerules.put("isemail", "false");
configurationnamerules.put("isalphanumeric", "false");
configurationnamerules.put("isnumeric", "false");
configurationnamerules.put("isinteger", "false");
configurationnamerules.put("lengthmessage", "Length should be between "+configurationnamerules.get("minlength")+" and "+configurationnamerules.get("maxlength")+" " );
rules.put("configurationname",configurationnamerules);

Map hascolourrules = new HashMap< String, Object>();
hascolourrules.put("required", "false");
hascolourrules.put("minlength", "0");
hascolourrules.put("maxlength", "1");
hascolourrules.put("isemail", "false");
hascolourrules.put("isalphanumeric", "false");
hascolourrules.put("isnumeric", "false");
hascolourrules.put("isinteger", "false");
hascolourrules.put("lengthmessage", "Length should be between "+hascolourrules.get("minlength")+" and "+hascolourrules.get("maxlength")+" " );
rules.put("hascolour",hascolourrules);

Map ispurchasedrules = new HashMap< String, Object>();
ispurchasedrules.put("required", "false");
ispurchasedrules.put("minlength", "0");
ispurchasedrules.put("maxlength", "1");
ispurchasedrules.put("isemail", "false");
ispurchasedrules.put("isalphanumeric", "false");
ispurchasedrules.put("isnumeric", "false");
ispurchasedrules.put("isinteger", "false");
ispurchasedrules.put("lengthmessage", "Length should be between "+ispurchasedrules.get("minlength")+" and "+ispurchasedrules.get("maxlength")+" " );
rules.put("ispurchased",ispurchasedrules);

Map isproductionrules = new HashMap< String, Object>();
isproductionrules.put("required", "false");
isproductionrules.put("minlength", "0");
isproductionrules.put("maxlength", "1");
isproductionrules.put("isemail", "false");
isproductionrules.put("isalphanumeric", "false");
isproductionrules.put("isnumeric", "false");
isproductionrules.put("isinteger", "false");
isproductionrules.put("lengthmessage", "Length should be between "+isproductionrules.get("minlength")+" and "+isproductionrules.get("maxlength")+" " );
rules.put("isproduction",isproductionrules);

Map issoldrules = new HashMap< String, Object>();
issoldrules.put("required", "false");
issoldrules.put("minlength", "0");
issoldrules.put("maxlength", "1");
issoldrules.put("isemail", "false");
issoldrules.put("isalphanumeric", "false");
issoldrules.put("isnumeric", "false");
issoldrules.put("isinteger", "false");
issoldrules.put("lengthmessage", "Length should be between "+issoldrules.get("minlength")+" and "+issoldrules.get("maxlength")+" " );
rules.put("issold",issoldrules);

Map hasdimensionsrules = new HashMap< String, Object>();
hasdimensionsrules.put("required", "false");
hasdimensionsrules.put("minlength", "0");
hasdimensionsrules.put("maxlength", "1");
hasdimensionsrules.put("isemail", "false");
hasdimensionsrules.put("isalphanumeric", "false");
hasdimensionsrules.put("isnumeric", "false");
hasdimensionsrules.put("isinteger", "false");
hasdimensionsrules.put("lengthmessage", "Length should be between "+hasdimensionsrules.get("minlength")+" and "+hasdimensionsrules.get("maxlength")+" " );
rules.put("hasdimensions",hasdimensionsrules);

Map hasproductiontemplaterules = new HashMap< String, Object>();
hasproductiontemplaterules.put("required", "false");
hasproductiontemplaterules.put("minlength", "0");
hasproductiontemplaterules.put("maxlength", "1");
hasproductiontemplaterules.put("isemail", "false");
hasproductiontemplaterules.put("isalphanumeric", "false");
hasproductiontemplaterules.put("isnumeric", "false");
hasproductiontemplaterules.put("isinteger", "false");
hasproductiontemplaterules.put("lengthmessage", "Length should be between "+hasproductiontemplaterules.get("minlength")+" and "+hasproductiontemplaterules.get("maxlength")+" " );
rules.put("hasproductiontemplate",hasproductiontemplaterules);


return rules;
} }







