package crud_inv;

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

public class InvStoreCrud {

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
    InvStore dataModel;
    Transaction tx = null;

    /**
     * ******Model specific variables***********
     */
    String storename, storephone, description, storemanager;
    Integer Nstoremanager;

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
        storename = SH.cleanInput(formData.get("storename").toString());
        storephone = SH.cleanInput(formData.get("storephone").toString());
        storemanager = SH.cleanInput(formData.get("storemanager").toString());
        description = SH.cleanInput(formData.get("description").toString());
//COMPULSORY FIELDS FROM THE MAPPER
        createbyid = SH.cleanInput(formData.get("createbyid").toString());
        writebyid = SH.cleanInput(formData.get("writebyid").toString());
        createdt = SH.cleanInput(formData.get("createdt").toString());
        writedt = SH.cleanInput(formData.get("writedt").toString());

        id = Integer.valueOf(strid);
        Nstoremanager = Integer.valueOf(storemanager);

//DATE VALUES
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
                dataModel = (InvStore) session.get(InvStore.class, id);
            } else {
                dataModel = new InvStore();
            }
            /**
             * ***********ASSIGNING THE MODEL VALUES*****************
             */
            if (action.equals("c") || action.equals("u")) {
                dataModel.setStoreName(storename);
                dataModel.setStorePhone(storephone);
                dataModel.setDescription(description);
                HrmEmployee hrmemployee = (HrmEmployee) session.get(HrmEmployee.class, Nstoremanager);
                dataModel.setHrmEmployee(hrmemployee);

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
                returngridata = getInvStoredata(id);
            } else if (action.equals("u")) {
                session.update(dataModel);
                tx.commit();
                msg = "Updating Succesful";
                returngridata = getInvStoredata(id);
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
    private String getInvStoredata(Integer id) {
        DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM InvStore Where storeId=" + id);
        mydata = ME.getData(myquery.toString());
        if (!mydata.isEmpty()) {
            i = 1;
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                InvStore invstore = (InvStore) iterator.next();
                gridata = i + "," + invstore.getStoreName() + "," + invstore.getStorePhone() + "," + invstore.getDescription() + "," + invstore.getHrmEmployee().getEmployeeId();
                i++;
            }
        }
        return gridata;
    }
}
