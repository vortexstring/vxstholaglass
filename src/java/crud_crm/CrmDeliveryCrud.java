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



public class CrmDeliveryCrud {
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
CrmDelivery dataModel;
Transaction tx = null;

/********Model specific variables************/

String deliverycode,deliverydate,ref,comment,approvedate,customerid,salesorderid,approveby ,amount;
Integer Ncustomerid,Nsalesorderid,Napproveby ;
java.util.Date DTdeliverydate,DTapprovedate ;
BigDecimal BDamount ;


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
deliverycode = SH.cleanInput(formData.get("deliverycode").toString());
deliverydate = SH.cleanInput(formData.get("deliverydate").toString());
customerid = SH.cleanInput(formData.get("customerid").toString());
amount = SH.cleanInput(formData.get("amount").toString());
ref = SH.cleanInput(formData.get("ref").toString());
salesorderid = SH.cleanInput(formData.get("salesorderid").toString());
comment = SH.cleanInput(formData.get("comment").toString());
approveby = SH.cleanInput(formData.get("approveby").toString());
approvedate = SH.cleanInput(formData.get("approvedate").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Ncustomerid = Integer.valueOf(customerid);
Nsalesorderid = Integer.valueOf(salesorderid);
Napproveby = Integer.valueOf(approveby);

//DATE VALUES

//DATE TIME VALUES
DTcreatedt = DH.StrDatetimetoDatetime(createdt);
DTwritedt = DH.StrDatetimetoDatetime(writedt);
//Integer values
Ncreatebyid = Integer.valueOf(createbyid);
Nwritebyid = Integer.valueOf(writebyid);

DTdeliverydate= DH.StrDatetimetoDatetime(deliverydate);
DTapprovedate= DH.StrDatetimetoDatetime(approvedate);

factory = SessionFactoryHelper.getsysDBUserSessionFactory();
session = factory.openSession();
try {
tx = session.beginTransaction();
/****************CREATING THE MODEL INSTANCE****************/
if (action.equals("u") || action.equals("d")) {
dataModel = (CrmDelivery) session.get(CrmDelivery.class, id);
} else {
dataModel = new CrmDelivery();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){
dataModel.setDeliveryCode(deliverycode);
dataModel.setRef(ref);
dataModel.setComment(comment);
dataModel.setDeliveryDate(DTdeliverydate);
dataModel.setApprovedate(DTapprovedate);
BDamount= new BigDecimal(amount);
dataModel.setAmount(BDamount);
CrmSalesorder crmsalesorder = (CrmSalesorder) session.get(CrmSalesorder.class,Nsalesorderid);
dataModel.setCrmSalesorder(crmsalesorder);
//AllStatus allstatus = (AllStatus) session.get(AllStatus.class,Nstatus);
//dataModel.setAllStatus(allstatus);
CrmCustomer crmcustomer = (CrmCustomer) session.get(CrmCustomer.class,Ncustomerid);
dataModel.setCrmCustomer(crmcustomer);
ConUser conuser = (ConUser) session.get(ConUser.class,Napproveby);
dataModel.setConUserByApproveby(conuser);
/*CrmDelivery crmdelivery = (CrmDelivery) session.get(CrmDelivery.class,Ndeliveryid);
dataModel.setCrmDelivery(crmdelivery);
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
returngridata = getCrmDeliverydata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getCrmDeliverydata(id);
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
private String getCrmDeliverydata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM CrmDelivery Where deliveryId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
CrmDelivery crmdelivery = (CrmDelivery) iterator.next();
gridata = i + ","+crmdelivery.getDeliveryCode() + "," + crmdelivery.getAmount() + "," + crmdelivery.getRef() + "," + crmdelivery.getComment() + "," + crmdelivery.getCrmSalesorder().getSalesorderId() + "," + crmdelivery.getAllStatus().getStatusId() + "," + crmdelivery.getCrmCustomer().getCustomerId() + "," + crmdelivery.getConUserByApproveby().getUserId() ;
i++;
}
}
return gridata;
}
//PRINT THE Validation Data


/*public Map validation(String Industry){

Map rules = new HashMap< String, Object>();
Map deliverycoderules = new HashMap< String, Object>();
deliverycoderules.put("required", "false");
deliverycoderules.put("minlength", "0");
deliverycoderules.put("maxlength", "20");
deliverycoderules.put("isemail", "false");
deliverycoderules.put("isalphanumeric", "false");
deliverycoderules.put("isnumeric", "false");
deliverycoderules.put("isinteger", "false");
deliverycoderules.put("lengthmessage", "Length should be between "+deliverycoderules.get("minlength")+" and "+deliverycoderules.get("maxlength")+" " );
rules.put("deliverycode",deliverycoderules);

Map deliverydaterules = new HashMap< String, Object>();
deliverydaterules.put("required", "false");
deliverydaterules.put("minlength", "0");
deliverydaterules.put("maxlength", "20");
deliverydaterules.put("isemail", "false");
deliverydaterules.put("isalphanumeric", "false");
deliverydaterules.put("isnumeric", "false");
deliverydaterules.put("isinteger", "false");
deliverydaterules.put("lengthmessage", "Length should be between "+deliverydaterules.get("minlength")+" and "+deliverydaterules.get("maxlength")+" " );
rules.put("deliverydate",deliverydaterules);

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

Map amountrules = new HashMap< String, Object>();
amountrules.put("required", "false");
amountrules.put("minlength", "0");
amountrules.put("maxlength", "20");
amountrules.put("isemail", "false");
amountrules.put("isalphanumeric", "false");
amountrules.put("isnumeric", "false");
amountrules.put("isinteger", "false");
amountrules.put("lengthmessage", "Length should be between "+amountrules.get("minlength")+" and "+amountrules.get("maxlength")+" " );
rules.put("amount",amountrules);

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

Map approvebyrules = new HashMap< String, Object>();
approvebyrules.put("required", "false");
approvebyrules.put("minlength", "0");
approvebyrules.put("maxlength", "20");
approvebyrules.put("isemail", "false");
approvebyrules.put("isalphanumeric", "false");
approvebyrules.put("isnumeric", "false");
approvebyrules.put("isinteger", "false");
approvebyrules.put("lengthmessage", "Length should be between "+approvebyrules.get("minlength")+" and "+approvebyrules.get("maxlength")+" " );
rules.put("approveby",approvebyrules);

Map approvedaterules = new HashMap< String, Object>();
approvedaterules.put("required", "false");
approvedaterules.put("minlength", "0");
approvedaterules.put("maxlength", "20");
approvedaterules.put("isemail", "false");
approvedaterules.put("isalphanumeric", "false");
approvedaterules.put("isnumeric", "false");
approvedaterules.put("isinteger", "false");
approvedaterules.put("lengthmessage", "Length should be between "+approvedaterules.get("minlength")+" and "+approvedaterules.get("maxlength")+" " );
rules.put("approvedate",approvedaterules);


return rules;
} */}



