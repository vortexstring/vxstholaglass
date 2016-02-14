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

public class ItemCrud {

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
    Item dataModel;
    Transaction tx = null;

    /**
     * ******Model specific variables***********
     */
    String itemcode, itemname, itemconfigurationid, itemlevelid, parentid;
    Integer Nitemconfigurationid, Nitemlevelid, Nparentid;

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
        itemcode = SH.cleanInput(formData.get("itemcode").toString());
        itemname = SH.cleanInput(formData.get("itemname").toString());
        itemconfigurationid = SH.cleanInput(formData.get("itemconfigurationid").toString());
        itemlevelid = SH.cleanInput(formData.get("itemlevelid").toString());
        parentid = SH.cleanInput(formData.get("parentid").toString());
//COMPULSORY FIELDS FROM THE MAPPER
        createbyid = SH.cleanInput(formData.get("createbyid").toString());
        writebyid = SH.cleanInput(formData.get("writebyid").toString());
        createdt = SH.cleanInput(formData.get("createdt").toString());
        writedt = SH.cleanInput(formData.get("writedt").toString());

        id = Integer.valueOf(strid);
        Nitemconfigurationid = Integer.valueOf(itemconfigurationid);
        Nitemlevelid = Integer.valueOf(itemlevelid);
        Nparentid = Integer.valueOf(parentid);

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
                dataModel = (Item) session.get(Item.class, id);
            } else {
                dataModel = new Item();
            }
            /**
             * ***********ASSIGNING THE MODEL VALUES*****************
             */
            if (action.equals("c") || action.equals("u")) {
                dataModel.setItemCode(itemcode);
                dataModel.setItemName(itemname);
                Item item = (Item) session.get(Item.class, Nitemlevelid);
                dataModel.setItem(item);
//Item item = (Item) session.get(Item.class,Nitemid);
//dataModel.setItem(item);

//Item item = (Item) session.get(Item.class,Nitemid);
//dataModel.setItem(item);
                ItemConfiguration itemconfiguration = (ItemConfiguration) session.get(ItemConfiguration.class, Nitemconfigurationid);
                dataModel.setItemConfiguration(itemconfiguration);

                Item item1 = (Item) session.get(Item.class, Nparentid);
                dataModel.setItem(item1);

//ItemLevel itemlevel = (ItemLevel) session.get(ItemLevel.class,Nitemlevelid);
//dataModel.setItemLevel(itemlevel);
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
                returngridata = getItemdata(id);
            } else if (action.equals("u")) {
                session.update(dataModel);
                tx.commit();
                msg = "Updating Succesful";
                returngridata = getItemdata(id);
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
    private String getItemdata(Integer id) {
        DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM Item Where itemId=" + id);
        mydata = ME.getData(myquery.toString());
        if (!mydata.isEmpty()) {
            i = 1;
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                Item item = (Item) iterator.next();
                gridata = i + "," + item.getItemCode() + "," + item.getItemName() + "," + item.getItem().getItemId() + "," + item.getItem().getItemId() + "," + item.getItem().getItemId() + "," + item.getItemConfiguration().getItemConfigurationId() + "," + item.getAllStatus().getStatusId() + "," + item.getItem().getItemId() + "," + item.getItemLevel().getItemLevelId() + "," + item.getItem().getItemId() + "," + item.getItem().getItemId() + "," + item.getItem().getItemId();
                i++;
            }
        }
        return gridata;
    }
}
