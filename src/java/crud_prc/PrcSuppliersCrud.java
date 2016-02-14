package crud_prc;

import viewmodel.*;
import model.*;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import vxsutil.SessionFactoryHelper;
import org.hibernate.HibernateException;
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

public class PrcSuppliersCrud {

    /**
     * ***Compulsory fields*****
     */
    String strid, feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata, returngridata, createbyid, writebyid, writedt, createdt;
    Integer Ncreatebyid, Nwritebyid, id, i;
    Date DTwritedt, DTcreatedt;
    List listdata, mydata;
    Map<String, Object> data = new HashMap< String, Object>();
    DateHelper DH = new DateHelper();
    StringHelper SH = new StringHelper();
    SessionFactory factory;
    PrcSuppliers dataModel;
    Transaction tx = null;

    /**
     * ******Model specific variables***********
     */
    String admndate, suppliercode, suppliername, othername, taxcode, pinno, location, contactperson, primarymobileno, primarylandline, primaryemail, boxaddress, boxaddresscode, boxaddresstown, physicaladdress, website, currencyid, paytermid, paymodeid, credit, creditlimit;
    Integer Ncurrencyid, Npaytermid, Npaymodeid;
    java.util.Date DTadmndate;
    boolean Bcredit;
    BigDecimal BDcreditlimit;

//A PUBLIC METHOD TO PERFORM CREATE,UPDATE AND DELETE FUNCTIONALITY
    public Map<String, Object> cud(String action, Map formData) {

//IN CASE OF INVALID ACTION
        if (action.equals("c") || action.equals("u") || action.equals("d")) {
        } else {
            data.put("msgtype", "fail");
            data.put("msg", "Invalid Action type");
            return data;
        }

//Getting data from tha mapper
        strid = SH.cleanInput(formData.get("id").toString());
        admndate = SH.cleanInput(formData.get("admndate").toString());
        suppliercode = SH.cleanInput(formData.get("suppliercode").toString());
        suppliername = SH.cleanInput(formData.get("suppliername").toString());
        othername = SH.cleanInput(formData.get("othername").toString());
        taxcode = SH.cleanInput(formData.get("taxcode").toString());
        pinno = SH.cleanInput(formData.get("pinno").toString());
        credit = SH.cleanInput(formData.get("credit").toString());
        creditlimit = SH.cleanInput(formData.get("creditlimit").toString());
        currencyid = SH.cleanInput(formData.get("currencyid").toString());
        paytermid = SH.cleanInput(formData.get("paytermid").toString());
        paymodeid = SH.cleanInput(formData.get("paymodeid").toString());
        location = SH.cleanInput(formData.get("location").toString());
        contactperson = SH.cleanInput(formData.get("contactperson").toString());
        primarymobileno = SH.cleanInput(formData.get("primarymobileno").toString());
        primarylandline = SH.cleanInput(formData.get("primarylandline").toString());
        primaryemail = SH.cleanInput(formData.get("primaryemail").toString());
        boxaddress = SH.cleanInput(formData.get("boxaddress").toString());
        boxaddresscode = SH.cleanInput(formData.get("boxaddresscode").toString());
        boxaddresstown = SH.cleanInput(formData.get("boxaddresstown").toString());
        physicaladdress = SH.cleanInput(formData.get("physicaladdress").toString());
        website = SH.cleanInput(formData.get("website").toString());
//COMPULSORY FIELDS FROM THE MAPPER
        createbyid = SH.cleanInput(formData.get("createbyid").toString());
        writebyid = SH.cleanInput(formData.get("writebyid").toString());
        createdt = SH.cleanInput(formData.get("createdt").toString());
        writedt = SH.cleanInput(formData.get("writedt").toString());

        id = Integer.valueOf(strid);
        Ncurrencyid = Integer.valueOf(currencyid);
        Npaytermid = Integer.valueOf(paytermid);
        Npaymodeid = Integer.valueOf(paymodeid);

//DATE VALUES
//DATE TIME VALUES
        DTcreatedt = DH.StrDatetimetoDatetime(createdt);
        DTwritedt = DH.StrDatetimetoDatetime(writedt);
//Integer values
        Ncreatebyid = Integer.valueOf(createbyid);
        Nwritebyid = Integer.valueOf(writebyid);

        DTadmndate = DH.StrDatetimetoDatetime(admndate);

        factory = SessionFactoryHelper.getsysDBUserSessionFactory();
        Session session = factory.openSession();
        try {
            tx = session.beginTransaction();
            /**
             * **************CREATING THE MODEL INSTANCE***************
             */
            if (action.equals("u") || action.equals("d")) {
                dataModel = (PrcSuppliers) session.get(PrcSuppliers.class, id);
            } else {
                dataModel = new PrcSuppliers();
            }
            /**
             * ***********ASSIGNING THE MODEL VALUES*****************
             */
            if (action.equals("c") || action.equals("u")) {
                dataModel.setSupplierCode(suppliercode);
                dataModel.setSupplierName(suppliername);
                dataModel.setOthername(othername);
                dataModel.setTaxcode(taxcode);
                dataModel.setPinno(pinno);
                dataModel.setLocation(location);
                dataModel.setContactPerson(contactperson);
                dataModel.setPrimaryMobileNo(primarymobileno);
                dataModel.setPrimaryLandline(primarylandline);
                dataModel.setPrimaryEmail(primaryemail);
                dataModel.setBoxAddress(boxaddress);
                dataModel.setBoxAddressCode(boxaddresscode);
                dataModel.setBoxAddressTown(boxaddresstown);
                dataModel.setPhysicalAddress(physicaladdress);
                dataModel.setWebsite(website);
                dataModel.setAdmnDate(DTadmndate);
                Bcredit = SH.stringToBoolean(credit);
                dataModel.setCredit(Bcredit);
                BDcreditlimit = new BigDecimal(creditlimit);
                dataModel.setCreditLimit(BDcreditlimit);
                AllCurrency allcurrency = (AllCurrency) session.get(AllCurrency.class, Ncurrencyid);
                dataModel.setAllCurrency(allcurrency);
                Payterm payterm = (Payterm) session.get(Payterm.class, Npaytermid);
                dataModel.setPayterm(payterm);
                Paymode paymode = (Paymode) session.get(Paymode.class, Npaymodeid);
                dataModel.setPaymode(paymode);

//PRINT COMPULSORY SET METHODS
                dataModel.setWritedt(DTwritedt);
                ConUser writebyRec = (ConUser) session.get(ConUser.class, Nwritebyid);
                dataModel.setConUserByWritebyId(writebyRec);
                ConCompany companyRec = (ConCompany) session.get(ConCompany.class, 1);
                dataModel.setConCompany(companyRec);

//PRINT CODE FOR DELETING A RECORD
            } else if (action.equals("d")) {
                ConLife lifeRec = (ConLife) session.get(ConLife.class, 2);
                dataModel.setConLife(lifeRec);
            }

            /**
             * **********************CREATING THE FEEDBACK MESSAGE FOR THE CUD CLASS*********
             */
            if (action.equals("c")) {
                ConLife lifeRec = (ConLife) session.get(ConLife.class, 1);
                dataModel.setConLife(lifeRec);
                ConUser createbyRec = (ConUser) session.get(ConUser.class, Ncreatebyid);
                dataModel.setConUserByCreatebyId(createbyRec);
                dataModel.setCreatedt(DTcreatedt);
                id = (Integer) session.save(dataModel);
                tx.commit();
                msg = "Insertion Succesful";
                returngridata = getPrcSuppliersdata(id);
            } else if (action.equals("u")) {
                session.update(dataModel);
                tx.commit();
                msg = "Updating Succesful";
                returngridata = getPrcSuppliersdata(id);
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
            /**
             * ***************IN CASE AN ERROR OCCURS************
             */
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }

            data.put("msgtype", "fail");
            if (action.equals("c")) {
                data.put("msg", "Insertion Failed" + e.toString());
            } else if (action.equals("u")) {
                data.put("msg", "Updating Failed" + e.toString());
            } else if (action.equals("d")) {
                data.put("msg", "Deleting Failed" + e.toString());
            }
        } finally {
            session.close();
        }
        return data;
    }

    /**
     * **********A METHOD RETURN DATA IN CUSTOMIZED SPECIFIC DHTMLX GRID FORMAT************
     */
    private String getPrcSuppliersdata(Integer id) {
        DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM PrcSuppliers Where supplierId=" + id);
        mydata = ME.getData(myquery.toString());
        if (!mydata.isEmpty()) {
            i = 1;
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                PrcSuppliers prcsuppliers = (PrcSuppliers) iterator.next();
                gridata = i + "," + prcsuppliers.getSupplierCode() + "," + prcsuppliers.getSupplierName() + "," + prcsuppliers.getOthername() + "," + prcsuppliers.getTaxcode() + "," + prcsuppliers.getPinno() + "," + prcsuppliers.getCreditLimit() + "," + prcsuppliers.getLocation() + "," + prcsuppliers.getContactPerson() + "," + prcsuppliers.getPrimaryMobileNo() + "," + prcsuppliers.getPrimaryLandline() + "," + prcsuppliers.getPrimaryEmail() + "," + prcsuppliers.getBoxAddress() + "," + prcsuppliers.getBoxAddressCode() + "," + prcsuppliers.getBoxAddressTown() + "," + prcsuppliers.getPhysicalAddress() + "," + prcsuppliers.getWebsite() + "," + prcsuppliers.getCredit()+ "," + prcsuppliers.getAllCurrency().getCurrencyId() + "," + prcsuppliers.getPayterm().getPaytermId() + "," + prcsuppliers.getPaymode().getPaymodeId();
                i++;
            }
        }
        return gridata;
    }
}
