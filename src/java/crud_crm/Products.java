/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud_crm;

import com.google.gson.Gson;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import vxsutil.SessionFactoryHelper;
import model.*;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import viewmodel.DataLoader;

/**
 *
 * @author pharis wambui
 */
public class Products {
java.util.Date dt = new java.util.Date();

    List<String> Griddata;
    List<String> mydata;
    String rsp, feedback;
    List<String> hib_error;
    int life, i;
    String strid, mydate,struserid, myfeedback, itemcode, itemname, stritemconfigurationid, stritemlevelid, strparentid, strstatus;
    Integer itemconfigurationid, itemlevelid,
            parentid, status, userid, id;
    //java.sql.Date CURRENT_TIMESTAMP;
    java.util.Date createdt;
    String msgtype, msg, actiontype, recId, gridata;
    String returngridata;
    SessionFactory factory;
    private String userdetails;
    Map<String, Object> data = new HashMap<String, Object>();
    Transaction tx = null;
    Integer recordID = null;
    Session session;
  
        public String inserter(String FKprofile, Map formData) {
        //GET DATA FROM THE MAPPER

        try {
           
            actiontype = "insert";
            itemcode = formData.get("itemcode").toString();
            itemname = formData.get("itemname").toString();
            struserid = formData.get("userid").toString();
            stritemconfigurationid = formData.get("itemconfigurationid").toString();
            stritemlevelid = formData.get("itemlevelid").toString();
            strparentid = formData.get("parentid").toString();
            strstatus = formData.get("status").toString();


            //CONVERT ALL THE IDS FROM STRING TO INTEGER
            itemconfigurationid = Integer.valueOf(stritemconfigurationid);
            itemlevelid = Integer.valueOf(stritemlevelid);
            parentid = Integer.valueOf(strparentid);
            status = Integer.valueOf(strstatus);
            userid = Integer.valueOf(struserid);
            id = Integer.valueOf(strid);

        } catch (Exception e) {

            msgtype = "fail";
            msg = "Saving failed" + e.getMessage();

        }

        try {
            factory = SessionFactoryHelper.getsysDBUserSessionFactory();
            session = factory.openSession();

            tx = session.beginTransaction();

             Item dataModel = new Item();
            dataModel.setItemCode(itemcode);
            dataModel.setItemName(itemname);

            AllStatus statusRec = (AllStatus) session.get(AllStatus.class, status);
            dataModel.setAllStatus(statusRec);
            Item itemRec = (Item) session.get(Item.class, parentid);
            dataModel.setItem(itemRec);
            ItemLevel itemlevelRec = (ItemLevel) session.get(ItemLevel.class, itemlevelid);
            dataModel.setItemLevel(itemlevelRec);
            ItemConfiguration itemconfigurationRec = (ItemConfiguration) session.get(ItemConfiguration.class, itemconfigurationid);
            dataModel.setItemConfiguration(itemconfigurationRec);
            

            ConUser writebyRec = (ConUser) session.get(ConUser.class, userid);
            dataModel.setConUserByWritebyId(writebyRec);
            ConUser createbyRec = (ConUser) session.get(ConUser.class, userid);
            dataModel.setConUserByCreatebyId(createbyRec);
            ConCompany companyRec = (ConCompany) session.get(ConCompany.class, 1);
            dataModel.setConCompany(companyRec);
            ConLife lifeRec = (ConLife) session.get(ConLife.class, 1);
            dataModel.setConLife(lifeRec);
            recordID = (Integer) session.save(dataModel);
            tx.commit();
                         data.put("msgtype", "success");
            data.put("msg", "Saving Succesful");
            data.put("actiontype", actiontype);
            data.put("recId", strid);
            data.put("gridData", returngridata);

            returngridata = getItemdata(id);

        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            // feedback=e.toString();
            msgtype = "fail";
            msg = "Saving Failed" + e.toString();
            recId = "";
        } finally {
            session.close();
        }

        data.put("msgtype", "success");
        data.put("msg", "savng done");
        data.put("actiontype", "delete");
        feedback = new Gson().toJson(data);

        //feedback = "{\"msgtype\":\"" + msgtype + "\",\"msg\":\"" + msg + "\",\"actiontype\":\"" + actiontype + "\",\"recId\":\"" + recId + "\",\"gridData\":\"" + returngridata + "\"}";
        return feedback;
    }


    public String updater(String FKprofile, Map formData) {

        try {

            struserid = formData.get("userid").toString();
            stritemconfigurationid = formData.get("itemconfigurationid").toString();
            stritemlevelid = formData.get("itemlevelid").toString();
            strparentid = formData.get("parentid").toString();
            strstatus = formData.get("status").toString();

            actiontype = "update";
            strid = formData.get("id").toString();
            itemcode = formData.get("itemcode").toString();
            itemname = formData.get("itemname").toString();
            mydate=formData.get("createdt").toString();
            //CONVERT ALL THE IDS FROM STRING TO INTEGER
            itemconfigurationid = Integer.valueOf(stritemconfigurationid);
            itemlevelid = Integer.valueOf(stritemlevelid);
            parentid = Integer.valueOf(strparentid);
            status = Integer.valueOf(strstatus);
            userid = Integer.valueOf(struserid);
            id = Integer.valueOf(strid);

        } catch (Exception e) {
            data.put("msgtype", "fail");
            data.put("msg", "Failed" + e.getMessage());
            feedback = new Gson().toJson(data);
            return feedback;
        }

        try {


            factory = SessionFactoryHelper.getsysDBUserSessionFactory();
            session = factory.openSession();
            tx = session.beginTransaction();

            Item dataModel = (Item) session.get(Item.class, id);
            dataModel.setItemCode(itemcode);
            dataModel.setItemName(itemname);

            AllStatus statusRec = (AllStatus) session.get(AllStatus.class, status);
            dataModel.setAllStatus(statusRec);
            Item itemRec = (Item) session.get(Item.class, parentid);
            dataModel.setItem(itemRec);
            ItemLevel itemlevelRec = (ItemLevel) session.get(ItemLevel.class, itemlevelid);
            dataModel.setItemLevel(itemlevelRec);
            ItemConfiguration itemconfigurationRec = (ItemConfiguration) session.get(ItemConfiguration.class, itemconfigurationid);
            dataModel.setItemConfiguration(itemconfigurationRec);
            
           // createdt=convertStringToDate(mydate);

            dataModel.setCreatedt(createdt);
            //MANDATORY FIELDS
            ConUser writebyRec = (ConUser) session.get(ConUser.class, userid);
            dataModel.setConUserByWritebyId(writebyRec);
            ConUser createbyRec = (ConUser) session.get(ConUser.class, userid);
            dataModel.setConUserByCreatebyId(createbyRec);
            ConCompany companyRec = (ConCompany) session.get(ConCompany.class, 1);
            dataModel.setConCompany(companyRec);
            ConLife lifeRec = (ConLife) session.get(ConLife.class, 1);
            dataModel.setConLife(lifeRec);
            session.update(dataModel);
            tx.commit();
            data.put("msgtype", "success");
            data.put("msg", "Updating Succesful");
            data.put("actiontype", actiontype);
            data.put("recId", strid);
            data.put("gridData", returngridata);

            returngridata = getItemdata(id);

        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }

            data.put("msgtype", "fail");
            data.put("msg", "Updating Failed" + e.toString());

        } finally {
            session.close();
        }

        feedback = new Gson().toJson(data);

        return feedback;
    }

    public String deleter(String FKprofile, Map formData) {
        try {
            actiontype = "delete";
            strid = formData.get("id").toString();

            id = Integer.valueOf(strid);
        } catch (Exception e) {
            data.put("msgtype", "fail");
            data.put("msg", "Failed" + e.getMessage());
            feedback = new Gson().toJson(data);
            return feedback;
        }
        try {
            factory = SessionFactoryHelper.getsysDBUserSessionFactory();
            session = factory.openSession();

            tx = session.beginTransaction();

            Item dataModel = (Item) session.get(Item.class, id);

            ConLife lifeRec = (ConLife) session.get(ConLife.class, 2);
            dataModel.setConLife(lifeRec);
            session.update(dataModel);
            tx.commit();
            data.put("msgtype", "success");
            data.put("msg", "Deleting Succesful");
            data.put("actiontype", actiontype);
            data.put("recId", strid);
            data.put("gridData", returngridata);

            returngridata = getItemdata(id);

        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            data.put("msgtype", "fail");
            data.put("msg", "Updating Failed" + e.toString());
        } finally {
            session.close();
        }
        //feedback = "{\"msgtype\":\"" + msgtype + "\",\"msg\":\"" + msg + "\",\"actiontype\":\"" + actiontype + "\",\"recId\":\"" + recId + "\",\"gridData\":\"" + returngridata + "\"}";
        feedback = new Gson().toJson(data);
        return feedback;
    }

    private String getItemdata(Integer id) {

        DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM Item Where itemId=" + id);
        mydata = ME.getData(myquery.toString());
        if (!mydata.isEmpty()) {
            i = 1;
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                Item OBJ = (Item) iterator.next();
                //userdetails = OBJ.getHrmEmployee().getFirstName() + " " + OBJ.getHrmEmployee().getLastName();
                gridata = i + "," + OBJ.getItemCode() + "," + OBJ.getItemName() + "," + OBJ.getItem().getItemName() + "," + OBJ.getItem().getItem().getItemName() + "," + OBJ.getItemName();
                i++;
            }
        }
        return gridata;
    }
      /*  public Date convertStringToDate(String dateString)
{
    Date mydate = null;
     DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try{
        mydate = df.parse(dateString);
       // formatteddate = dfo.
    }
    catch ( Exception ex ){
        System.out.println(ex);
    }
    return mydate;
}*/
}


//    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//             createdt = sdf.format(dt);
//  
