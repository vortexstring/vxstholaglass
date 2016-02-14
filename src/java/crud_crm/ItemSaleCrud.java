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



public class ItemSaleCrud {
/**
* ***Compulsory fields*****
*/
String strid,feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata,returngridata,createbyid, writebyid,writedt,createdt;
Integer Ncreatebyid, Nwritebyid, id, i;
Date DTwritedt, DTcreatedt,Deffectivefrom,Deffectiveto;
List listdata, mydata;
Map <String, Object> data = new HashMap< String, Object >();
DateHelper DH = new DateHelper();
StringHelper SH = new StringHelper();
SessionFactory factory;
Session session;
ItemSale dataModel;
Transaction tx = null;

/********Model specific variables************/

String effectivefrom,effectiveto,itemid,uomid,currencyid,vatid ,unitprice,minqty,maxqty;
Integer Nitemid,Nuomid,Ncurrencyid,Nvatid ;
BigDecimal BDunitprice,BDminqty,BDmaxqty ;


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
uomid = SH.cleanInput(formData.get("uomid").toString());
unitprice = SH.cleanInput(formData.get("unitprice").toString());
currencyid = SH.cleanInput(formData.get("currencyid").toString());
vatid = SH.cleanInput(formData.get("vatid").toString());
effectivefrom = SH.cleanInput(formData.get("effectivefrom").toString());
effectiveto = SH.cleanInput(formData.get("effectiveto").toString());
minqty = SH.cleanInput(formData.get("minqty").toString());
maxqty = SH.cleanInput(formData.get("maxqty").toString());
//COMPULSORY FIELDS FROM THE MAPPER
createbyid = SH.cleanInput(formData.get("createbyid").toString());
writebyid = SH.cleanInput(formData.get("writebyid").toString());
createdt = SH.cleanInput(formData.get("createdt").toString());
writedt = SH.cleanInput(formData.get("writedt").toString());


id = Integer.valueOf(strid);
Nitemid = Integer.valueOf(itemid);
Nuomid = Integer.valueOf(uomid);
Ncurrencyid = Integer.valueOf(currencyid);
Nvatid = Integer.valueOf(vatid);

//DATE VALUES
Deffectivefrom= DH.StrDatetoDate(effectivefrom);
Deffectiveto= DH.StrDatetoDate(effectiveto);

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
dataModel = (ItemSale) session.get(ItemSale.class, id);
} else {
dataModel = new ItemSale();
}
/*************ASSIGNING THE MODEL VALUES******************/
if(action.equals("c") || action.equals("u")){

dataModel.setEffectiveFrom(Deffectivefrom);
dataModel.setEffectiveTo(Deffectiveto);
BDunitprice= new BigDecimal(unitprice);
dataModel.setUnitPrice(BDunitprice);
BDminqty= new BigDecimal(minqty);
dataModel.setMinQty(BDminqty);
BDmaxqty= new BigDecimal(maxqty);
dataModel.setMaxQty(BDmaxqty);
Item item = (Item) session.get(Item.class,Nitemid);
dataModel.setItem(item);
CrmUom crmuom = (CrmUom) session.get(CrmUom.class,Nuomid);
dataModel.setCrmUom(crmuom);
AllCurrency allcurrency = (AllCurrency) session.get(AllCurrency.class,Ncurrencyid);
dataModel.setAllCurrency(allcurrency);
FinVat finvat = (FinVat) session.get(FinVat.class,Nvatid);
dataModel.setFinVat(finvat);

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
returngridata = getItemSaledata(id);
} else if (action.equals("u")) {
session.update(dataModel);
tx.commit();
msg = "Updating Succesful";
returngridata = getItemSaledata(id);
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
private String getItemSaledata(Integer id) {
DataLoader ME = new DataLoader();
StringBuilder myquery = new StringBuilder("FROM ItemSale Where itemSaleId=" + id);
mydata = ME.getData(myquery.toString());
if (!mydata.isEmpty()) {
i = 1;
for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
ItemSale itemsale = (ItemSale) iterator.next();
gridata = i + ","+itemsale.getUnitPrice() + "," + itemsale.getMinQty() + "," + itemsale.getMaxQty() + "," + itemsale.getItem().getItemId() + "," + itemsale.getCrmUom().getUomId() + "," + itemsale.getAllCurrency().getCurrencyId() + "," + itemsale.getFinVat().getVatId();
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
itemidrules.put("maxlength", "30");
itemidrules.put("isemail", "false");
itemidrules.put("isalphanumeric", "false");
itemidrules.put("isnumeric", "false");
itemidrules.put("isinteger", "false");
itemidrules.put("lengthmessage", "Length should be between "+itemidrules.get("minlength")+" and "+itemidrules.get("maxlength")+" " );
rules.put("itemid",itemidrules);

Map uomidrules = new HashMap< String, Object>();
uomidrules.put("required", "true");
uomidrules.put("minlength", "1");
uomidrules.put("maxlength", "30");
uomidrules.put("isemail", "false");
uomidrules.put("isalphanumeric", "false");
uomidrules.put("isnumeric", "false");
uomidrules.put("isinteger", "false");
uomidrules.put("lengthmessage", "Length should be between "+uomidrules.get("minlength")+" and "+uomidrules.get("maxlength")+" " );
rules.put("uomid",uomidrules);

Map unitpricerules = new HashMap< String, Object>();
unitpricerules.put("required", "true");
unitpricerules.put("minlength", "1");
unitpricerules.put("maxlength", "10,4");
unitpricerules.put("isemail", "false");
unitpricerules.put("isalphanumeric", "false");
unitpricerules.put("isnumeric", "false");
unitpricerules.put("isinteger", "false");
unitpricerules.put("lengthmessage", "Length should be between "+unitpricerules.get("minlength")+" and "+unitpricerules.get("maxlength")+" " );
rules.put("unitprice",unitpricerules);

Map currencyidrules = new HashMap< String, Object>();
currencyidrules.put("required", "true");
currencyidrules.put("minlength", "1");
currencyidrules.put("maxlength", "30");
currencyidrules.put("isemail", "false");
currencyidrules.put("isalphanumeric", "false");
currencyidrules.put("isnumeric", "false");
currencyidrules.put("isinteger", "false");
currencyidrules.put("lengthmessage", "Length should be between "+currencyidrules.get("minlength")+" and "+currencyidrules.get("maxlength")+" " );
rules.put("currencyid",currencyidrules);

Map vatidrules = new HashMap< String, Object>();
vatidrules.put("required", "false");
vatidrules.put("minlength", "0");
vatidrules.put("maxlength", "30");
vatidrules.put("isemail", "false");
vatidrules.put("isalphanumeric", "false");
vatidrules.put("isnumeric", "false");
vatidrules.put("isinteger", "false");
vatidrules.put("lengthmessage", "Length should be between "+vatidrules.get("minlength")+" and "+vatidrules.get("maxlength")+" " );
rules.put("vatid",vatidrules);

Map effectivefromrules = new HashMap< String, Object>();
effectivefromrules.put("required", "true");
effectivefromrules.put("minlength", "1");
effectivefromrules.put("maxlength", "21");
effectivefromrules.put("isemail", "false");
effectivefromrules.put("isalphanumeric", "false");
effectivefromrules.put("isnumeric", "false");
effectivefromrules.put("isinteger", "false");
effectivefromrules.put("lengthmessage", "Length should be between "+effectivefromrules.get("minlength")+" and "+effectivefromrules.get("maxlength")+" " );
rules.put("effectivefrom",effectivefromrules);

Map effectivetorules = new HashMap< String, Object>();
effectivetorules.put("required", "false");
effectivetorules.put("minlength", "0");
effectivetorules.put("maxlength", "21");
effectivetorules.put("isemail", "false");
effectivetorules.put("isalphanumeric", "false");
effectivetorules.put("isnumeric", "false");
effectivetorules.put("isinteger", "false");
effectivetorules.put("lengthmessage", "Length should be between "+effectivetorules.get("minlength")+" and "+effectivetorules.get("maxlength")+" " );
rules.put("effectiveto",effectivetorules);

Map minqtyrules = new HashMap< String, Object>();
minqtyrules.put("required", "false");
minqtyrules.put("minlength", "0");
minqtyrules.put("maxlength", "10,4");
minqtyrules.put("isemail", "false");
minqtyrules.put("isalphanumeric", "false");
minqtyrules.put("isnumeric", "false");
minqtyrules.put("isinteger", "false");
minqtyrules.put("lengthmessage", "Length should be between "+minqtyrules.get("minlength")+" and "+minqtyrules.get("maxlength")+" " );
rules.put("minqty",minqtyrules);

Map maxqtyrules = new HashMap< String, Object>();
maxqtyrules.put("required", "false");
maxqtyrules.put("minlength", "0");
maxqtyrules.put("maxlength", "10,4");
maxqtyrules.put("isemail", "false");
maxqtyrules.put("isalphanumeric", "false");
maxqtyrules.put("isnumeric", "false");
maxqtyrules.put("isinteger", "false");
maxqtyrules.put("lengthmessage", "Length should be between "+maxqtyrules.get("minlength")+" and "+maxqtyrules.get("maxlength")+" " );
rules.put("maxqty",maxqtyrules);


return rules;
} }

