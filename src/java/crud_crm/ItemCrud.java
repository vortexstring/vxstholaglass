/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
    Session session;
    Item dataModel;
    Transaction tx = null;

    /**
     * ******Model specific variables***********
     */
    String itemcode, itemname, itemicon, itemconfigurationid, itemlevelid, parentid, status;
    Integer Nitemconfigurationid, Nitemlevelid, Nparentid, Nstatus;

//A PUBLIC METHOD TO PERFORM CREATE,UPDATE AND DELETE FUNCTIONALITY
    public Map<String, Object> cud(String action, Map formData) {

//Catch Model Errors
        try {
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
            itemicon = SH.cleanInput(formData.get("itemicon").toString());
            itemconfigurationid = SH.cleanInput(formData.get("itemconfigurationid").toString());
            itemlevelid = SH.cleanInput(formData.get("itemlevelid").toString());
            parentid = SH.cleanInput(formData.get("parentid").toString());
            status = SH.cleanInput(formData.get("status").toString());
//COMPULSORY FIELDS FROM THE MAPPER
            createbyid = SH.cleanInput(formData.get("createbyid").toString());
            writebyid = SH.cleanInput(formData.get("writebyid").toString());
            createdt = SH.cleanInput(formData.get("createdt").toString());
            writedt = SH.cleanInput(formData.get("writedt").toString());

            id = Integer.valueOf(strid);
            Nitemconfigurationid = Integer.valueOf(itemconfigurationid);
            Nitemlevelid = Integer.valueOf(itemlevelid);
            Nparentid = Integer.valueOf(parentid);
            Nstatus = Integer.valueOf(status);

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
                    dataModel.setItemIcon(itemicon);
                    ItemConfiguration itemconfiguration = (ItemConfiguration) session.get(ItemConfiguration.class, Nitemconfigurationid);
                    dataModel.setItemConfiguration(itemconfiguration);
                    AllStatus allstatus = (AllStatus) session.get(AllStatus.class, Nstatus);
                    dataModel.setAllStatus(allstatus);
                    Item item = (Item) session.get(Item.class, Nparentid);
                    dataModel.setItem(item);
                    ItemLevel itemlevel = (ItemLevel) session.get(ItemLevel.class, Nitemlevelid);
                    dataModel.setItemLevel(itemlevel);

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
                 * **********************CREATING THE FEEDBACK MESSAGE FOR THE
                 * CUD CLASS*********
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

            msg = e.toString() + " , " + e.getMessage();
            data.put("msgtype", "fail");
            data.put("msg", "Saving Error " + msg);
            if (this.isSessionActive()) {
                session.close();
            }
        }

        return data;
    }

    private boolean isSessionActive() {
        try {
            if (session.isOpen() || session.isDirty() || session.isConnected()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
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
                gridata = i + "," + item.getItemCode() + "," + item.getItemName() + "," + item.getItemIcon() + "," + item.getItemConfiguration().getItemConfigurationId() + "," + item.getAllStatus().getStatusId() + "," + item.getItem().getItemId() + "," + item.getItemLevel().getItemLevelId();
                i++;
            }
        }
        return gridata;
    }
//PRINT THE Validation Data

    public Map validation(String Industry) {

        Map rules = new HashMap< String, Object>();
        Map itemcoderules = new HashMap< String, Object>();
        itemcoderules.put("required", "true");
        itemcoderules.put("minlength", "1");
        itemcoderules.put("maxlength", "50");
        itemcoderules.put("isemail", "false");
        itemcoderules.put("isalphanumeric", "false");
        itemcoderules.put("isnumeric", "false");
        itemcoderules.put("isinteger", "false");
        itemcoderules.put("lengthmessage", "Length should be between " + itemcoderules.get("minlength") + " and " + itemcoderules.get("maxlength") + " ");
        rules.put("itemcode", itemcoderules);

        Map itemnamerules = new HashMap< String, Object>();
        itemnamerules.put("required", "true");
        itemnamerules.put("minlength", "1");
        itemnamerules.put("maxlength", "50");
        itemnamerules.put("isemail", "false");
        itemnamerules.put("isalphanumeric", "false");
        itemnamerules.put("isnumeric", "false");
        itemnamerules.put("isinteger", "false");
        itemnamerules.put("lengthmessage", "Length should be between " + itemnamerules.get("minlength") + " and " + itemnamerules.get("maxlength") + " ");
        rules.put("itemname", itemnamerules);

        Map itemiconrules = new HashMap< String, Object>();
        itemiconrules.put("required", "false");
        itemiconrules.put("minlength", "0");
        itemiconrules.put("maxlength", "50");
        itemiconrules.put("isemail", "false");
        itemiconrules.put("isalphanumeric", "false");
        itemiconrules.put("isnumeric", "false");
        itemiconrules.put("isinteger", "false");
        itemiconrules.put("lengthmessage", "Length should be between " + itemiconrules.get("minlength") + " and " + itemiconrules.get("maxlength") + " ");
        rules.put("itemicon", itemiconrules);

        Map itemconfigurationidrules = new HashMap< String, Object>();
        itemconfigurationidrules.put("required", "true");
        itemconfigurationidrules.put("minlength", "1");
        itemconfigurationidrules.put("maxlength", "50");
        itemconfigurationidrules.put("isemail", "false");
        itemconfigurationidrules.put("isalphanumeric", "false");
        itemconfigurationidrules.put("isnumeric", "false");
        itemconfigurationidrules.put("isinteger", "false");
        itemconfigurationidrules.put("lengthmessage", "Length should be between " + itemconfigurationidrules.get("minlength") + " and " + itemconfigurationidrules.get("maxlength") + " ");
        rules.put("itemconfigurationid", itemconfigurationidrules);

        Map itemlevelidrules = new HashMap< String, Object>();
        itemlevelidrules.put("required", "true");
        itemlevelidrules.put("minlength", "1");
        itemlevelidrules.put("maxlength", "50");
        itemlevelidrules.put("isemail", "false");
        itemlevelidrules.put("isalphanumeric", "false");
        itemlevelidrules.put("isnumeric", "false");
        itemlevelidrules.put("isinteger", "false");
        itemlevelidrules.put("lengthmessage", "Length should be between " + itemlevelidrules.get("minlength") + " and " + itemlevelidrules.get("maxlength") + " ");
        rules.put("itemlevelid", itemlevelidrules);

        Map parentidrules = new HashMap< String, Object>();
        parentidrules.put("required", "true");
        parentidrules.put("minlength", "1");
        parentidrules.put("maxlength", "50");
        parentidrules.put("isemail", "false");
        parentidrules.put("isalphanumeric", "false");
        parentidrules.put("isnumeric", "false");
        parentidrules.put("isinteger", "false");
        parentidrules.put("lengthmessage", "Length should be between " + parentidrules.get("minlength") + " and " + parentidrules.get("maxlength") + " ");
        rules.put("parentid", parentidrules);

        Map statusrules = new HashMap< String, Object>();
        statusrules.put("required", "true");
        statusrules.put("minlength", "1");
        statusrules.put("maxlength", "50");
        statusrules.put("isemail", "false");
        statusrules.put("isalphanumeric", "false");
        statusrules.put("isnumeric", "false");
        statusrules.put("isinteger", "false");
        statusrules.put("lengthmessage", "Length should be between " + statusrules.get("minlength") + " and " + statusrules.get("maxlength") + " ");
        rules.put("status", statusrules);

        return rules;
    }
}
