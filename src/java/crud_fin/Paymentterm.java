/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud_fin;

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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import vxsutil.DateHelper;
import vxsutil.StringHelper;

/**
 *
 * @author TBL
 */
public class Paymentterm {

    List<String> Griddata;
    List<String> mydata;
    String rsp, feedback;
    List<String> hib_error;
    int life, i;
    String strid, paytermname, comments, struserid, myfeedback;
    Integer userid, id;
    String msgtype, msg, actiontype, recId, gridata;
    String returngridata;
    SessionFactory factory;
    private String userdetails;
    Map<String, Object> data = new HashMap<String, Object>();
    String expirydate, startdate;
    Date thisdate, datestartate;
    DateHelper DH = new DateHelper();
    Payterm dataModel;
    Transaction tx = null;
    Integer recordID = null;
    StringHelper SH;

    public String cud(String action, Map formData) {

        SH = new StringHelper();
        //IN CASE OF INVALID ACTION 
        if (action.equals("c") || action.equals("u") || action.equals("d")) {
        } else {
            data.put("msgtype", "fail");
            data.put("msg", "Invalid Action type");
            feedback = new Gson().toJson(data);
            return feedback;
        }
        //Getting data from tha mapper   
        strid = SH.cleanInput(formData.get("id").toString());
        paytermname = SH.cleanInput(formData.get("paytermname").toString());
        comments = SH.cleanInput(formData.get("comments").toString());
        struserid = SH.cleanInput(formData.get("userid").toString());

        //CONVERT ALL THE IDS FROM STRING TO INTEGER
        userid = Integer.valueOf(struserid);
        id = Integer.valueOf(strid);

        factory = SessionFactoryHelper.getsysDBUserSessionFactory();
        Session session = factory.openSession();
        try {
            tx = session.beginTransaction();
            /**
             * **************CREATING THE MODEL INSTANCE***************
             */
            if (action.equals("u") || action.equals("d")) {
                dataModel = (Payterm) session.get(Payterm.class, id);
            } else {
                dataModel = new Payterm();
            }

            /**
             * ***********ASSIGNING THE MODEL VALUES*****************
             */
            if (action.equals("c") || action.equals("u")) {

                dataModel.setPaytermName(paytermname);
                dataModel.setComments(comments);
                

                /**
                 * ***MANDATORY***************
                 */
                ConUser writebyRec = (ConUser) session.get(ConUser.class, userid);
                dataModel.setConUserByWritebyId(writebyRec);
                ConUser createbyRec = (ConUser) session.get(ConUser.class, userid);
                dataModel.setConUserByCreatebyId(createbyRec);
                ConCompany companyRec = (ConCompany) session.get(ConCompany.class, 1);
                dataModel.setConCompany(companyRec);
                ConLife lifeRec = (ConLife) session.get(ConLife.class, 1);
                dataModel.setConLife(lifeRec);
            } else if (action.equals("d")) {
                ConLife lifeRec = (ConLife) session.get(ConLife.class, 2);
                dataModel.setConLife(lifeRec);
            }

            /**
             * **********************CREATING THE FEEDBACK MESSAGE FOR THE CUD CLASS*********
             */
            if (action.equals("c")) {
                id = (Integer) session.save(dataModel);
                msg = "Insertion Succesful";
                returngridata = getPaytermdata(id);
            } else if (action.equals("u")) {
                session.update(dataModel);
                msg = "Updating Succesful";
                returngridata = getPaytermdata(id);
            } else if (action.equals("d")) {
                session.update(dataModel);
                msg = "Deletion Succesful";
            }
            tx.commit();

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

        feedback = new Gson().toJson(data);
        return feedback;
    }

    /**
     * **********A METHOD RETURN DATA IN CUSTOMIZED SPECIFIC DHTMLX GRID FORMAT************
     */
    private String getPaytermdata(Integer id) {

        DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM Payterm Where paytermId=" + id);
        mydata = ME.getData(myquery.toString());
        if (!mydata.isEmpty()) {
            i = 1;
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                Payterm OBJ = (Payterm) iterator.next();
                // userdetails = OBJ.getConUserByUserId().getSurname() + " " + OBJ.getConUserByUserId().getOtherName();
                gridata = i + "," + OBJ.getPaytermName() + "," + OBJ.getComments();
                i++;
            }
        }
        return gridata;
    }

}
