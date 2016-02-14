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

public class PrcPurchaseOrderCrud {

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
    PrcPurchaseOrder dataModel;
    Transaction tx = null;

    /**
     * ******Model specific variables***********
     */
    String purchaseordercode, purchaseorderdate, purchaseorderduedate, ref, comment, approvedate, supplierid, approvedby, tax, amount;
    Integer Nsupplierid, Napprovedby;
    BigDecimal BDtax, BDamount;
Date         Dpurchaseorderdate,Dpurchaseorderduedate,Dapprovedate;

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
        purchaseordercode = SH.cleanInput(formData.get("purchaseordercode").toString());
        purchaseorderdate = SH.cleanInput(formData.get("purchaseorderdate").toString());
        purchaseorderduedate = SH.cleanInput(formData.get("purchaseorderduedate").toString());
        ref = SH.cleanInput(formData.get("ref").toString());
        supplierid = SH.cleanInput(formData.get("supplierid").toString());
        tax = SH.cleanInput(formData.get("tax").toString());
        amount = SH.cleanInput(formData.get("amount").toString());
        comment = SH.cleanInput(formData.get("comment").toString());
        approvedby = SH.cleanInput(formData.get("approvedby").toString());
        approvedate = SH.cleanInput(formData.get("approvedate").toString());
//COMPULSORY FIELDS FROM THE MAPPER
        createbyid = SH.cleanInput(formData.get("createbyid").toString());
        writebyid = SH.cleanInput(formData.get("writebyid").toString());
        createdt = SH.cleanInput(formData.get("createdt").toString());
        writedt = SH.cleanInput(formData.get("writedt").toString());

        id = Integer.valueOf(strid);
        Nsupplierid = Integer.valueOf(supplierid);
        Napprovedby = Integer.valueOf(approvedby);

//DATE VALUES
        Dpurchaseorderdate = DH.StrDatetoDate(purchaseorderdate);
        Dpurchaseorderduedate = DH.StrDatetoDate(purchaseorderduedate);
        Dapprovedate = DH.StrDatetoDate(approvedate);

//DATE TIME VALUES
        DTcreatedt = DH.StrDatetimetoDatetime(createdt);
        DTwritedt = DH.StrDatetimetoDatetime(writedt);
//Integer values
        Ncreatebyid = Integer.valueOf(createbyid);
        Nwritebyid = Integer.valueOf(writebyid);

        factory = SessionFactoryHelper.getsysDBUserSessionFactory();
        Session session = factory.openSession();
        try {
            tx = session.beginTransaction();
            /**
             * **************CREATING THE MODEL INSTANCE***************
             */
            if (action.equals("u") || action.equals("d")) {
                dataModel = (PrcPurchaseOrder) session.get(PrcPurchaseOrder.class, id);
            } else {
                dataModel = new PrcPurchaseOrder();
            }
            /**
             * ***********ASSIGNING THE MODEL VALUES*****************
             */
            if (action.equals("c") || action.equals("u")) {
                dataModel.setPurchaseorderCode(purchaseordercode);
                dataModel.setRef(ref);
                dataModel.setComment(comment);
                dataModel.setPurchaseorderDate(Dpurchaseorderdate);
                dataModel.setPurchaseorderDuedate(Dpurchaseorderduedate);
                dataModel.setApprovedate(Dapprovedate);
                BDtax = new BigDecimal(tax);
                dataModel.setTax(BDtax);
                BDamount = new BigDecimal(amount);
                dataModel.setAmount(BDamount);
                PrcSuppliers prcsuppliers = (PrcSuppliers) session.get(PrcSuppliers.class, Nsupplierid);
                dataModel.setPrcSuppliers(prcsuppliers);
                //AllStatus allstatus = (AllStatus) session.get(AllStatus.class, Nstatus);
               // dataModel.setAllStatus(allstatus);
                ConUser conuser = (ConUser) session.get(ConUser.class, Napprovedby);
                dataModel.setConUserByApprovedby(conuser);
              //  Item item = (Item) session.get(Item.class, Nitemid);
                //dataModel.setItem(item);
               // CrmUom crmuom = (CrmUom) session.get(CrmUom.class, Nuomid);
               // dataModel.setCrmUom(crmuom);
                //PrcPurchaseOrder prcpurchaseorder = (PrcPurchaseOrder) session.get(PrcPurchaseOrder.class, Npurchaseorderid);
               // dataModel.se(prcpurchaseorder);

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
                returngridata = getPrcPurchaseOrderdata(id);
            } else if (action.equals("u")) {
                session.update(dataModel);
                tx.commit();
                msg = "Updating Succesful";
                returngridata = getPrcPurchaseOrderdata(id);
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
    private String getPrcPurchaseOrderdata(Integer id) {
        DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM PrcPurchaseOrder Where purchaseorderId=" + id);
        mydata = ME.getData(myquery.toString());
        if (!mydata.isEmpty()) {
            i = 1;
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                PrcPurchaseOrder prcpurchaseorder = (PrcPurchaseOrder) iterator.next();
                gridata = i + "," + prcpurchaseorder.getPurchaseorderCode() + "," + prcpurchaseorder.getRef() + "," + prcpurchaseorder.getTax() + "," + prcpurchaseorder.getAmount() + "," + prcpurchaseorder.getComment() + "," + prcpurchaseorder.getPrcSuppliers().getSupplierId() + "," + prcpurchaseorder.getConUserByApprovedby().getUserId();
                i++;
            }
        }
        return gridata;
    }
}
