
/*****************START PRINTING THE CRUDER*************/
package crud_crm;

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



public class CrmCustomerCrud {
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
CrmCustomer dataModel;
Transaction tx = null;

/********Model specific variables************/

String admndate,customercode,surname,othername,vatno,pinno,memo,contactperson,primarymobileno,primarylandline,primaryemail,boxaddress,boxaddresscode,boxaddresstown,physicaladdress,title,idno,countryid,customercategoryid,agentid,paytermid,credit ,creditlimit;
Integer Ntitle,Nidno,Ncountryid,Ncustomercategoryid,Nagentid,Npaytermid ;
java.util.Date DTadmndate ;
boolean Bcredit ;
BigDecimal BDcreditlimit ;


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
admndate = SH.cleanInput(formData.get("admndate").toString());
customercode = SH.cleanInput(formData.get("customercode").toString());
surname = SH.cleanInput(formData.get("surname").toString());
othername = SH.cleanInput(formData.get("othername").toString());
title = SH.cleanInput(formData.get("title").toString());
idno = SH.cleanInput(formData.get("idno").toString());
vatno = SH.cleanInput(formData.get("vatno").toString());
pinno = SH.cleanInput(formData.get("pinno").toString());
memo = SH.cleanInput(formData.get("memo").toString());
countryid = SH.cleanInput(formData.get("countryid").toString());
customercategoryid = SH.cleanInput(formData.get("customercategoryid").toString());
agentid = SH.cleanInput(formData.get("agentid").toString());
credit = SH.cleanInput(formData.get("credit").toString());
creditlimit = SH.cleanInput(formData.get("creditlimit").toString());
paytermid = SH.cleanInput(formData.get("paytermid").toString());
contactperson = SH.cleanInput(formData.get("contactperson").toString());
primarymobileno = SH.cleanInput(formData.get("primarymobileno").toString());
primarylandline = SH.cleanInput(formData.get("primarylandline").toString());
primaryemail = SH.cleanInput(formData.get("primaryemail").toString());
boxaddress = SH.cleanInput(formData.get("boxaddress").toString());
boxaddresscode = SH.cleanInput(formData.get("boxaddresscode").toString());
boxaddresstown = SH.cleanInput(formData.get("boxaddresstown").toString());
physicaladdress = SH.cleanInput(formData.get("physicaladdress").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Ntitle = Integer.valueOf(title);
Nidno = Integer.valueOf(idno);
Ncountryid = Integer.valueOf(countryid);
Ncustomercategoryid = Integer.valueOf(customercategoryid);
Nagentid = Integer.valueOf(agentid);
Npaytermid = Integer.valueOf(paytermid);

//DATE VALUES

//DATE TIME VALUES
DTcreatedt = DH.StrDatetimetoDatetime(createdt);
DTwritedt = DH.StrDatetimetoDatetime(writedt);
//Integer values
Ncreatebyid = Integer.valueOf(createbyid);
Nwritebyid = Integer.valueOf(writebyid);

DTadmndate= DH.StrDatetimetoDatetime(admndate);

factory = SessionFactoryHelper.getsysDBUserSessionFactory();
session = factory.openSession();
try {
tx = session.beginTransaction();
/****************CREATING THE MODEL INSTANCE****************/
if (action.equals("u") || action.equals("d")) {
dataModel = (CrmCustomer) session.get(CrmCustomer.class, id);
} else {
dataModel = new CrmCustomer();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setCustomerCode(customercode);
dataModel.setSurname(surname);
dataModel.setOthername(othername);
dataModel.setIdNo(Nidno);
dataModel.setVatNo(vatno);
dataModel.setPinNo(pinno);
dataModel.setMemo(memo);
dataModel.setContactPerson(contactperson);
dataModel.setPrimaryMobileNo(primarymobileno);
dataModel.setPrimaryLandline(primarylandline);
dataModel.setPrimaryEmail(primaryemail);
dataModel.setBoxAddress(boxaddress);
dataModel.setBoxAddressCode(boxaddresscode);
dataModel.setBoxAddressTown(boxaddresstown);
dataModel.setPhysicalAddress(physicaladdress);
dataModel.setAdmnDate(DTadmndate);
Bcredit=SH.stringToBoolean(credit);
dataModel.setCredit(Bcredit);
BDcreditlimit= new BigDecimal(creditlimit);
dataModel.setCreditLimit(BDcreditlimit);
CrmCustomerCategory crmcustomercategory = (CrmCustomerCategory) session.get(CrmCustomerCategory.class,Ncustomercategoryid);
dataModel.setCrmCustomerCategory(crmcustomercategory);
HrmEmployee hrmemployee = (HrmEmployee) session.get(HrmEmployee.class,Nagentid);
dataModel.setHrmEmployee(hrmemployee);
Payterm payterm = (Payterm) session.get(Payterm.class,Npaytermid);
dataModel.setPayterm(payterm);
AllCountry allcountry = (AllCountry) session.get(AllCountry.class,Ncountryid);
dataModel.setAllCountry(allcountry);
CommonCombo commoncombo = (CommonCombo) session.get(CommonCombo.class,Ntitle);
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
returngridata = getCrmCustomerdata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getCrmCustomerdata(id);
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
private String getCrmCustomerdata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM CrmCustomer Where customerId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
CrmCustomer crmcustomer = (CrmCustomer) iterator.next();
gridata = i + ","+crmcustomer.getCustomerCode() + "," + crmcustomer.getSurname() + "," + crmcustomer.getOthername() + "," + crmcustomer.getIdNo() + "," + crmcustomer.getVatNo() + "," + crmcustomer.getPinNo() + "," + crmcustomer.getMemo() + "," + crmcustomer.getCreditLimit() + "," + crmcustomer.getContactPerson() + "," + crmcustomer.getPrimaryMobileNo() + "," + crmcustomer.getPrimaryLandline() + "," + crmcustomer.getPrimaryEmail() + "," + crmcustomer.getBoxAddress() + "," + crmcustomer.getBoxAddressCode() + "," + crmcustomer.getBoxAddressTown() + "," + crmcustomer.getPhysicalAddress() + "," + crmcustomer.getCredit() + "," + crmcustomer.getCrmCustomerCategory().getCustomerCategoryId() + "," + crmcustomer.getHrmEmployee().getEmployeeId() + "," + crmcustomer.getPayterm().getPaytermId() + "," + crmcustomer.getAllCountry().getCountryId() + "," + crmcustomer.getCommonCombo().getComboId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data




public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map admndaterules = new HashMap< String, Object>();
admndaterules.put("required", "false");
admndaterules.put("minlength", "0");
admndaterules.put("maxlength", "21");
admndaterules.put("isemail", "false");
admndaterules.put("isalphanumeric", "false");
admndaterules.put("isnumeric", "false");
admndaterules.put("isinteger", "false");
admndaterules.put("lengthmessage", "Length should be between "+admndaterules.get("minlength")+" and "+admndaterules.get("maxlength")+" " );
rules.put("admndate",admndaterules);

Map customercoderules = new HashMap< String, Object>();
customercoderules.put("required", "false");
customercoderules.put("minlength", "0");
customercoderules.put("maxlength", "15");
customercoderules.put("isemail", "false");
customercoderules.put("isalphanumeric", "false");
customercoderules.put("isnumeric", "false");
customercoderules.put("isinteger", "false");
customercoderules.put("lengthmessage", "Length should be between "+customercoderules.get("minlength")+" and "+customercoderules.get("maxlength")+" " );
rules.put("customercode",customercoderules);

Map surnamerules = new HashMap< String, Object>();
surnamerules.put("required", "false");
surnamerules.put("minlength", "0");
surnamerules.put("maxlength", "20");
surnamerules.put("isemail", "false");
surnamerules.put("isalphanumeric", "false");
surnamerules.put("isnumeric", "false");
surnamerules.put("isinteger", "false");
surnamerules.put("lengthmessage", "Length should be between "+surnamerules.get("minlength")+" and "+surnamerules.get("maxlength")+" " );
rules.put("surname",surnamerules);

Map othernamerules = new HashMap< String, Object>();
othernamerules.put("required", "false");
othernamerules.put("minlength", "0");
othernamerules.put("maxlength", "40");
othernamerules.put("isemail", "false");
othernamerules.put("isalphanumeric", "false");
othernamerules.put("isnumeric", "false");
othernamerules.put("isinteger", "false");
othernamerules.put("lengthmessage", "Length should be between "+othernamerules.get("minlength")+" and "+othernamerules.get("maxlength")+" " );
rules.put("othername",othernamerules);

Map titlerules = new HashMap< String, Object>();
titlerules.put("required", "false");
titlerules.put("minlength", "0");
titlerules.put("maxlength", "50");
titlerules.put("isemail", "false");
titlerules.put("isalphanumeric", "false");
titlerules.put("isnumeric", "false");
titlerules.put("isinteger", "false");
titlerules.put("lengthmessage", "Length should be between "+titlerules.get("minlength")+" and "+titlerules.get("maxlength")+" " );
rules.put("title",titlerules);

Map idnorules = new HashMap< String, Object>();
idnorules.put("required", "false");
idnorules.put("minlength", "0");
idnorules.put("maxlength", "50");
idnorules.put("isemail", "false");
idnorules.put("isalphanumeric", "false");
idnorules.put("isnumeric", "false");
idnorules.put("isinteger", "false");
idnorules.put("lengthmessage", "Length should be between "+idnorules.get("minlength")+" and "+idnorules.get("maxlength")+" " );
rules.put("idno",idnorules);

Map vatnorules = new HashMap< String, Object>();
vatnorules.put("required", "false");
vatnorules.put("minlength", "0");
vatnorules.put("maxlength", "50");
vatnorules.put("isemail", "false");
vatnorules.put("isalphanumeric", "false");
vatnorules.put("isnumeric", "false");
vatnorules.put("isinteger", "false");
vatnorules.put("lengthmessage", "Length should be between "+vatnorules.get("minlength")+" and "+vatnorules.get("maxlength")+" " );
rules.put("vatno",vatnorules);

Map pinnorules = new HashMap< String, Object>();
pinnorules.put("required", "false");
pinnorules.put("minlength", "0");
pinnorules.put("maxlength", "50");
pinnorules.put("isemail", "false");
pinnorules.put("isalphanumeric", "false");
pinnorules.put("isnumeric", "false");
pinnorules.put("isinteger", "false");
pinnorules.put("lengthmessage", "Length should be between "+pinnorules.get("minlength")+" and "+pinnorules.get("maxlength")+" " );
rules.put("pinno",pinnorules);

Map memorules = new HashMap< String, Object>();
memorules.put("required", "false");
memorules.put("minlength", "0");
memorules.put("maxlength", "200");
memorules.put("isemail", "false");
memorules.put("isalphanumeric", "false");
memorules.put("isnumeric", "false");
memorules.put("isinteger", "false");
memorules.put("lengthmessage", "Length should be between "+memorules.get("minlength")+" and "+memorules.get("maxlength")+" " );
rules.put("memo",memorules);

Map countryidrules = new HashMap< String, Object>();
countryidrules.put("required", "false");
countryidrules.put("minlength", "0");
countryidrules.put("maxlength", "50");
countryidrules.put("isemail", "false");
countryidrules.put("isalphanumeric", "false");
countryidrules.put("isnumeric", "false");
countryidrules.put("isinteger", "false");
countryidrules.put("lengthmessage", "Length should be between "+countryidrules.get("minlength")+" and "+countryidrules.get("maxlength")+" " );
rules.put("countryid",countryidrules);

Map customercategoryidrules = new HashMap< String, Object>();
customercategoryidrules.put("required", "false");
customercategoryidrules.put("minlength", "0");
customercategoryidrules.put("maxlength", "50");
customercategoryidrules.put("isemail", "false");
customercategoryidrules.put("isalphanumeric", "false");
customercategoryidrules.put("isnumeric", "false");
customercategoryidrules.put("isinteger", "false");
customercategoryidrules.put("lengthmessage", "Length should be between "+customercategoryidrules.get("minlength")+" and "+customercategoryidrules.get("maxlength")+" " );
rules.put("customercategoryid",customercategoryidrules);

Map agentidrules = new HashMap< String, Object>();
agentidrules.put("required", "false");
agentidrules.put("minlength", "0");
agentidrules.put("maxlength", "50");
agentidrules.put("isemail", "false");
agentidrules.put("isalphanumeric", "false");
agentidrules.put("isnumeric", "false");
agentidrules.put("isinteger", "false");
agentidrules.put("lengthmessage", "Length should be between "+agentidrules.get("minlength")+" and "+agentidrules.get("maxlength")+" " );
rules.put("agentid",agentidrules);

Map creditrules = new HashMap< String, Object>();
creditrules.put("required", "false");
creditrules.put("minlength", "0");
creditrules.put("maxlength", "1");
creditrules.put("isemail", "false");
creditrules.put("isalphanumeric", "false");
creditrules.put("isnumeric", "false");
creditrules.put("isinteger", "false");
creditrules.put("lengthmessage", "Length should be between "+creditrules.get("minlength")+" and "+creditrules.get("maxlength")+" " );
rules.put("credit",creditrules);

Map creditlimitrules = new HashMap< String, Object>();
creditlimitrules.put("required", "false");
creditlimitrules.put("minlength", "0");
creditlimitrules.put("maxlength", "38,20");
creditlimitrules.put("isemail", "false");
creditlimitrules.put("isalphanumeric", "false");
creditlimitrules.put("isnumeric", "false");
creditlimitrules.put("isinteger", "false");
creditlimitrules.put("lengthmessage", "Length should be between "+creditlimitrules.get("minlength")+" and "+creditlimitrules.get("maxlength")+" " );
rules.put("creditlimit",creditlimitrules);

Map paytermidrules = new HashMap< String, Object>();
paytermidrules.put("required", "false");
paytermidrules.put("minlength", "0");
paytermidrules.put("maxlength", "50");
paytermidrules.put("isemail", "false");
paytermidrules.put("isalphanumeric", "false");
paytermidrules.put("isnumeric", "false");
paytermidrules.put("isinteger", "false");
paytermidrules.put("lengthmessage", "Length should be between "+paytermidrules.get("minlength")+" and "+paytermidrules.get("maxlength")+" " );
rules.put("paytermid",paytermidrules);

Map contactpersonrules = new HashMap< String, Object>();
contactpersonrules.put("required", "false");
contactpersonrules.put("minlength", "0");
contactpersonrules.put("maxlength", "50");
contactpersonrules.put("isemail", "false");
contactpersonrules.put("isalphanumeric", "false");
contactpersonrules.put("isnumeric", "false");
contactpersonrules.put("isinteger", "false");
contactpersonrules.put("lengthmessage", "Length should be between "+contactpersonrules.get("minlength")+" and "+contactpersonrules.get("maxlength")+" " );
rules.put("contactperson",contactpersonrules);

Map primarymobilenorules = new HashMap< String, Object>();
primarymobilenorules.put("required", "false");
primarymobilenorules.put("minlength", "0");
primarymobilenorules.put("maxlength", "50");
primarymobilenorules.put("isemail", "false");
primarymobilenorules.put("isalphanumeric", "false");
primarymobilenorules.put("isnumeric", "false");
primarymobilenorules.put("isinteger", "false");
primarymobilenorules.put("lengthmessage", "Length should be between "+primarymobilenorules.get("minlength")+" and "+primarymobilenorules.get("maxlength")+" " );
rules.put("primarymobileno",primarymobilenorules);

Map primarylandlinerules = new HashMap< String, Object>();
primarylandlinerules.put("required", "false");
primarylandlinerules.put("minlength", "0");
primarylandlinerules.put("maxlength", "50");
primarylandlinerules.put("isemail", "false");
primarylandlinerules.put("isalphanumeric", "false");
primarylandlinerules.put("isnumeric", "false");
primarylandlinerules.put("isinteger", "false");
primarylandlinerules.put("lengthmessage", "Length should be between "+primarylandlinerules.get("minlength")+" and "+primarylandlinerules.get("maxlength")+" " );
rules.put("primarylandline",primarylandlinerules);

Map primaryemailrules = new HashMap< String, Object>();
primaryemailrules.put("required", "false");
primaryemailrules.put("minlength", "0");
primaryemailrules.put("maxlength", "50");
primaryemailrules.put("isemail", "false");
primaryemailrules.put("isalphanumeric", "false");
primaryemailrules.put("isnumeric", "false");
primaryemailrules.put("isinteger", "false");
primaryemailrules.put("lengthmessage", "Length should be between "+primaryemailrules.get("minlength")+" and "+primaryemailrules.get("maxlength")+" " );
rules.put("primaryemail",primaryemailrules);

Map boxaddressrules = new HashMap< String, Object>();
boxaddressrules.put("required", "false");
boxaddressrules.put("minlength", "0");
boxaddressrules.put("maxlength", "50");
boxaddressrules.put("isemail", "false");
boxaddressrules.put("isalphanumeric", "false");
boxaddressrules.put("isnumeric", "false");
boxaddressrules.put("isinteger", "false");
boxaddressrules.put("lengthmessage", "Length should be between "+boxaddressrules.get("minlength")+" and "+boxaddressrules.get("maxlength")+" " );
rules.put("boxaddress",boxaddressrules);

Map boxaddresscoderules = new HashMap< String, Object>();
boxaddresscoderules.put("required", "false");
boxaddresscoderules.put("minlength", "0");
boxaddresscoderules.put("maxlength", "10");
boxaddresscoderules.put("isemail", "false");
boxaddresscoderules.put("isalphanumeric", "false");
boxaddresscoderules.put("isnumeric", "false");
boxaddresscoderules.put("isinteger", "false");
boxaddresscoderules.put("lengthmessage", "Length should be between "+boxaddresscoderules.get("minlength")+" and "+boxaddresscoderules.get("maxlength")+" " );
rules.put("boxaddresscode",boxaddresscoderules);

Map boxaddresstownrules = new HashMap< String, Object>();
boxaddresstownrules.put("required", "false");
boxaddresstownrules.put("minlength", "0");
boxaddresstownrules.put("maxlength", "50");
boxaddresstownrules.put("isemail", "false");
boxaddresstownrules.put("isalphanumeric", "false");
boxaddresstownrules.put("isnumeric", "false");
boxaddresstownrules.put("isinteger", "false");
boxaddresstownrules.put("lengthmessage", "Length should be between "+boxaddresstownrules.get("minlength")+" and "+boxaddresstownrules.get("maxlength")+" " );
rules.put("boxaddresstown",boxaddresstownrules);

Map physicaladdressrules = new HashMap< String, Object>();
physicaladdressrules.put("required", "false");
physicaladdressrules.put("minlength", "0");
physicaladdressrules.put("maxlength", "50");
physicaladdressrules.put("isemail", "false");
physicaladdressrules.put("isalphanumeric", "false");
physicaladdressrules.put("isnumeric", "false");
physicaladdressrules.put("isinteger", "false");
physicaladdressrules.put("lengthmessage", "Length should be between "+physicaladdressrules.get("minlength")+" and "+physicaladdressrules.get("maxlength")+" " );
rules.put("physicaladdress",physicaladdressrules);


return rules;
} 

}




