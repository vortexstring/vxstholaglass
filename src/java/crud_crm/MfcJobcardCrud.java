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



public class MfcJobcardCrud {
/**
* ***Compulsory fields*****
*/
String strid,feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata,returngridata,createbyid, writebyid,writedt,createdt;
Integer Ncreatebyid, Nwritebyid, id, i;
Date DTwritedt, DTcreatedt,Djobcarddate,Dreviewdt,Dapprovedt;
List listdata, mydata;
Map <String, Object> data = new HashMap< String, Object >();
DateHelper DH = new DateHelper();
StringHelper SH = new StringHelper();
SessionFactory factory;
Session session;
MfcJobcard dataModel;
Transaction tx = null;

/********Model specific variables************/

String jobcardcode,jobcarddate,comment,reviewdt,approvedt,customerid,salesorderid,reviewedby,approvedby ;
Integer Ncustomerid,Nsalesorderid,Nreviewedby,Napprovedby ;


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
jobcardcode = SH.cleanInput(formData.get("jobcardcode").toString());
jobcarddate = SH.cleanInput(formData.get("jobcarddate").toString());
customerid = SH.cleanInput(formData.get("customerid").toString());
salesorderid = SH.cleanInput(formData.get("salesorderid").toString());
comment = SH.cleanInput(formData.get("comment").toString());
reviewedby = SH.cleanInput(formData.get("reviewedby").toString());
reviewdt = SH.cleanInput(formData.get("reviewdt").toString());
approvedby = SH.cleanInput(formData.get("approvedby").toString());
approvedt = SH.cleanInput(formData.get("approvedt").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Ncustomerid = Integer.valueOf(customerid);
Nsalesorderid = Integer.valueOf(salesorderid);
Nreviewedby = Integer.valueOf(reviewedby);
Napprovedby = Integer.valueOf(approvedby);

//DATE VALUES
Djobcarddate= DH.StrDatetoDate(jobcarddate);
Dreviewdt= DH.StrDatetoDate(reviewdt);
Dapprovedt= DH.StrDatetoDate(approvedt);

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
dataModel = (MfcJobcard) session.get(MfcJobcard.class, id);
} else {
dataModel = new MfcJobcard();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setJobcardCode(jobcardcode);
dataModel.setComment(comment);
dataModel.setJobcardDate(Djobcarddate);
dataModel.setReviewdt(Dreviewdt);
dataModel.setApprovedt(Dapprovedt);
ConUser conuser = (ConUser) session.get(ConUser.class,Napprovedby);
dataModel.setConUserByApprovedby(conuser);
CrmCustomer crmcustomer = (CrmCustomer) session.get(CrmCustomer.class,Ncustomerid);
dataModel.setCrmCustomer(crmcustomer);
//AllStatus allstatus = (AllStatus) session.get(AllStatus.class,Nstatusid);
//dataModel.setAllStatus(allstatus);
CrmSalesorder crmsalesorder = (CrmSalesorder) session.get(CrmSalesorder.class,Nsalesorderid);
dataModel.setCrmSalesorder(crmsalesorder);
ConUser conuser1 = (ConUser) session.get(ConUser.class,Nreviewedby);
dataModel.setConUserByReviewedby(conuser1);
/*CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Nuomid);
dataModel.setCrmUom(crmuom);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Ndimensionuomid);
dataModel.setCrmUom(crmuom);
MfcJobcard mfcjobcard = (MfcJobcard) session.get(MfcJobcard.class,Njobcardid);
dataModel.setMfcJobcard(mfcjobcard);
CrmSalesorder crmsalesorder = (CrmSalesorder) session.get(CrmSalesorder.class,Nsalesorderid);
dataModel.setCrmSalesorder(crmsalesorder);
/*Item item = (Item) session.get(Item.class,Nitemid);
dataModel.setItem(item);
Item item = (Item) session.get(Item.class,Nitemserviceid);
dataModel.setItem(item);
ItemSale itemsale = (ItemSale) session.get(ItemSale.class,Nitemsaleid);
dataModel.setItemSale(itemsale);
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
returngridata = getMfcJobcarddata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getMfcJobcarddata(id);
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
private String getMfcJobcarddata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM MfcJobcard Where jobcardId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
MfcJobcard mfcjobcard = (MfcJobcard) iterator.next();
gridata = i + ","+mfcjobcard.getJobcardCode() + "," + mfcjobcard.getComment() + "," + mfcjobcard.getConUserByApprovedby().getUserId() + "," + mfcjobcard.getCrmCustomer().getCustomerId() + "," + mfcjobcard.getAllStatus().getStatusId() + "," + mfcjobcard.getCrmSalesorder().getSalesorderId() + "," + mfcjobcard.getConUserByReviewedby().getUserId() + "," + mfcjobcard.getCrmSalesorder().getSalesorderId();
i++;
}
}
return gridata;
}
//PRINT THE Validation Data


/*public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map jobcardcoderules = new HashMap< String, Object>();
jobcardcoderules.put("required", "false");
jobcardcoderules.put("minlength", "0");
jobcardcoderules.put("maxlength", "20");
jobcardcoderules.put("isemail", "false");
jobcardcoderules.put("isalphanumeric", "false");
jobcardcoderules.put("isnumeric", "false");
jobcardcoderules.put("isinteger", "false");
jobcardcoderules.put("lengthmessage", "Length should be between "+jobcardcoderules.get("minlength")+" and "+jobcardcoderules.get("maxlength")+" " );
rules.put("jobcardcode",jobcardcoderules);

Map jobcarddaterules = new HashMap< String, Object>();
jobcarddaterules.put("required", "false");
jobcarddaterules.put("minlength", "0");
jobcarddaterules.put("maxlength", "20");
jobcarddaterules.put("isemail", "false");
jobcarddaterules.put("isalphanumeric", "false");
jobcarddaterules.put("isnumeric", "false");
jobcarddaterules.put("isinteger", "false");
jobcarddaterules.put("lengthmessage", "Length should be between "+jobcarddaterules.get("minlength")+" and "+jobcarddaterules.get("maxlength")+" " );
rules.put("jobcarddate",jobcarddaterules);

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

Map salesorderidrules = new HashMap< String, Object>();
salesorderidrules.put("required", "false");
salesorderidrules.put("minlength", "0");
salesorderidrules.put("maxlength", "20");
salesorderidrules.put("isemail", "false");
salesorderidrules.put("isalphanumeric", "false");
salesorderidrules.put("isnumeric", "false");
salesorderidrules.put("isinteger", "false");
salesorderidrules.put("lengthmessage", "Length should be between "+salesorderidrules.get("minlength")+" and "+salesorderidrules.get("maxlength")+" " );
rules.put("salesorderid",salesorderidrules);

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

Map reviewedbyrules = new HashMap< String, Object>();
reviewedbyrules.put("required", "false");
reviewedbyrules.put("minlength", "0");
reviewedbyrules.put("maxlength", "20");
reviewedbyrules.put("isemail", "false");
reviewedbyrules.put("isalphanumeric", "false");
reviewedbyrules.put("isnumeric", "false");
reviewedbyrules.put("isinteger", "false");
reviewedbyrules.put("lengthmessage", "Length should be between "+reviewedbyrules.get("minlength")+" and "+reviewedbyrules.get("maxlength")+" " );
rules.put("reviewedby",reviewedbyrules);

Map reviewdtrules = new HashMap< String, Object>();
reviewdtrules.put("required", "false");
reviewdtrules.put("minlength", "0");
reviewdtrules.put("maxlength", "20");
reviewdtrules.put("isemail", "false");
reviewdtrules.put("isalphanumeric", "false");
reviewdtrules.put("isnumeric", "false");
reviewdtrules.put("isinteger", "false");
reviewdtrules.put("lengthmessage", "Length should be between "+reviewdtrules.get("minlength")+" and "+reviewdtrules.get("maxlength")+" " );
rules.put("reviewdt",reviewdtrules);

Map approvedbyrules = new HashMap< String, Object>();
approvedbyrules.put("required", "false");
approvedbyrules.put("minlength", "0");
approvedbyrules.put("maxlength", "20");
approvedbyrules.put("isemail", "false");
approvedbyrules.put("isalphanumeric", "false");
approvedbyrules.put("isnumeric", "false");
approvedbyrules.put("isinteger", "false");
approvedbyrules.put("lengthmessage", "Length should be between "+approvedbyrules.get("minlength")+" and "+approvedbyrules.get("maxlength")+" " );
rules.put("approvedby",approvedbyrules);

Map approvedtrules = new HashMap< String, Object>();
approvedtrules.put("required", "false");
approvedtrules.put("minlength", "0");
approvedtrules.put("maxlength", "20");
approvedtrules.put("isemail", "false");
approvedtrules.put("isalphanumeric", "false");
approvedtrules.put("isnumeric", "false");
approvedtrules.put("isinteger", "false");
approvedtrules.put("lengthmessage", "Length should be between "+approvedtrules.get("minlength")+" and "+approvedtrules.get("maxlength")+" " );
rules.put("approvedt",approvedtrules);


return rules;
}*/ }

