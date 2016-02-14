/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud_crm;

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



public class CrmQuoteCrud {
/**
* ***Compulsory fields*****
*/
String strid,feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata,returngridata,createbyid, writebyid,writedt,createdt;
Integer Ncreatebyid, Nwritebyid, id, i;
Date DTwritedt, DTcreatedt,Dquotedate;
List listdata, mydata;
Map <String, Object> data = new HashMap< String, Object >();
DateHelper DH = new DateHelper();
StringHelper SH = new StringHelper();
SessionFactory factory;
Session session;
CrmQuote dataModel;
Transaction tx = null;

/********Model specific variables************/

String quotecode,quotedate,ref,comment,customerid ,totalprice,totalvatableamount,vatamount;
Integer Ncustomerid ;
BigDecimal BDtotalprice,BDtotalvatableamount,BDvatamount ;


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
quotecode = SH.cleanInput(formData.get("quotecode").toString());
quotedate = SH.cleanInput(formData.get("quotedate").toString());
totalprice = SH.cleanInput(formData.get("totalprice").toString());
totalvatableamount = SH.cleanInput(formData.get("totalvatableamount").toString());
vatamount = SH.cleanInput(formData.get("vatamount").toString());
ref = SH.cleanInput(formData.get("ref").toString());
customerid = SH.cleanInput(formData.get("customerid").toString());
comment = SH.cleanInput(formData.get("comment").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Ncustomerid = Integer.valueOf(customerid);

//DATE VALUES
Dquotedate= DH.StrDatetoDate(quotedate);

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
dataModel = (CrmQuote) session.get(CrmQuote.class, id);
} else {
dataModel = new CrmQuote();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setQuoteCode(quotecode);
dataModel.setRef(ref);
dataModel.setComment(comment);
dataModel.setQuoteDate(Dquotedate);
BDtotalprice= new BigDecimal(totalprice);
dataModel.setTotalPrice(BDtotalprice);
BDtotalvatableamount= new BigDecimal(totalvatableamount);
dataModel.setTotalVatableAmount(BDtotalvatableamount);
BDvatamount= new BigDecimal(vatamount);
dataModel.setVatAmount(BDvatamount);
CrmCustomer crmcustomer = (CrmCustomer) session.get(CrmCustomer.class,Ncustomerid);
dataModel.setCrmCustomer(crmcustomer);
/*AllStatus allstatus = (AllStatus) session.get(AllStatus.class,Nstatusid);
dataModel.setAllStatus(allstatus);
CrmPos crmpos = (CrmPos) session.get(CrmPos.class,Nposid);
dataModel.setCrmPos(crmpos);
CrmQuote crmquote = (CrmQuote) session.get(CrmQuote.class,Nquoteid);
dataModel.setCrmQuote(crmquote);
CrmPos crmpos = (CrmPos) session.get(CrmPos.class,Nposid);
dataModel.setCrmPos(crmpos);
Item item = (Item) session.get(Item.class,Nitemid);
dataModel.setItem(item);
Item item = (Item) session.get(Item.class,Nitemserviceid);
dataModel.setItem(item);
ItemSale itemsale = (ItemSale) session.get(ItemSale.class,Nitemsaleid);
dataModel.setItemSale(itemsale);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Nuomid);
dataModel.setCrmUom(crmuom);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Ndimensionuomid);
dataModel.setCrmUom(crmuom);*/

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
returngridata = getCrmQuotedata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getCrmQuotedata(id);
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
private String getCrmQuotedata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM CrmQuote Where quoteId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
CrmQuote crmquote = (CrmQuote) iterator.next();
gridata = i + ","+crmquote.getQuoteCode() + "," + crmquote.getTotalPrice() + "," + crmquote.getTotalVatableAmount() + "," + crmquote.getVatAmount() + "," + crmquote.getRef() + "," + crmquote.getComment() + "," + crmquote.getCrmCustomer().getCustomerId() + "," + crmquote.getAllStatus().getStatusId() + "," + crmquote.getCrmPos().getPosId() + "," + crmquote.getCrmPos().getPosId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data

/*
public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map quotecoderules = new HashMap< String, Object>();
quotecoderules.put("required", "false");
quotecoderules.put("minlength", "0");
quotecoderules.put("maxlength", "20");
quotecoderules.put("isemail", "false");
quotecoderules.put("isalphanumeric", "true");
quotecoderules.put("isnumeric", "false");
quotecoderules.put("isinteger", "false");
quotecoderules.put("lengthmessage", "Length should be between "+quotecoderules.get("minlength")+" and "+quotecoderules.get("maxlength")+" " );
rules.put("quotecode",quotecoderules);

Map quotedaterules = new HashMap< String, Object>();
quotedaterules.put("required", "false");
quotedaterules.put("minlength", "0");
quotedaterules.put("maxlength", "20");
quotedaterules.put("isemail", "false");
quotedaterules.put("isalphanumeric", "false");
quotedaterules.put("isnumeric", "false");
quotedaterules.put("isinteger", "false");
quotedaterules.put("lengthmessage", "Length should be between "+quotedaterules.get("minlength")+" and "+quotedaterules.get("maxlength")+" " );
rules.put("quotedate",quotedaterules);

Map totalpricerules = new HashMap< String, Object>();
totalpricerules.put("required", "false");
totalpricerules.put("minlength", "0");
totalpricerules.put("maxlength", "20");
totalpricerules.put("isemail", "false");
totalpricerules.put("isalphanumeric", "false");
totalpricerules.put("isnumeric", "true");
totalpricerules.put("isinteger", "false");
totalpricerules.put("lengthmessage", "Length should be between "+totalpricerules.get("minlength")+" and "+totalpricerules.get("maxlength")+" " );
rules.put("totalprice",totalpricerules);

Map totalvatableamountrules = new HashMap< String, Object>();
totalvatableamountrules.put("required", "false");
totalvatableamountrules.put("minlength", "0");
totalvatableamountrules.put("maxlength", "20");
totalvatableamountrules.put("isemail", "false");
totalvatableamountrules.put("isalphanumeric", "false");
totalvatableamountrules.put("isnumeric", "false");
totalvatableamountrules.put("isinteger", "false");
totalvatableamountrules.put("lengthmessage", "Length should be between "+totalvatableamountrules.get("minlength")+" and "+totalvatableamountrules.get("maxlength")+" " );
rules.put("totalvatableamount",totalvatableamountrules);

Map vatamountrules = new HashMap< String, Object>();
vatamountrules.put("required", "false");
vatamountrules.put("minlength", "0");
vatamountrules.put("maxlength", "20");
vatamountrules.put("isemail", "false");
vatamountrules.put("isalphanumeric", "false");
vatamountrules.put("isnumeric", "false");
vatamountrules.put("isinteger", "false");
vatamountrules.put("lengthmessage", "Length should be between "+vatamountrules.get("minlength")+" and "+vatamountrules.get("maxlength")+" " );
rules.put("vatamount",vatamountrules);

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

Map customeridrules = new HashMap< String, Object>();
customeridrules.put("required", "false");
customeridrules.put("minlength", "0");
customeridrules.put("maxlength", "20");
customeridrules.put("isemail", "false");
customeridrules.put("isalphanumeric", "false");
customeridrules.put("isnumeric", "false");
customeridrules.put("isinteger", "false");
customeridrules.put("lengthmessage", "Length should be between "+customeridrules.get("minlength")+" and "+customeridrules.get("maxlength")+" " );
rules.put("customerid",customeridrules);

Map commentrules = new HashMap< String, Object>();
commentrules.put("required", "false");
commentrules.put("minlength", "0");
commentrules.put("maxlength", "20");
commentrules.put("isemail", "false");
commentrules.put("isalphanumeric", "false");
commentrules.put("isnumeric", "false");
commentrules.put("isinteger", "false");
commentrules.put("lengthmessage", "Length should be between "+commentrules.get("minlength")+" and "+commentrules.get("maxlength")+" " );
rules.put("comment",commentrules);


return rules;
} */}







