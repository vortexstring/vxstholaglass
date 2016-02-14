/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package viewmodel;
import vxsutil.SessionFactoryHelper;
import model.*;
import logic.*;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author TBL
 */
public class crud extends ConUser{
       
   List <String> Griddata;
   String rsp,feedback;
   List<String> hib_error;  
   int life;
    SessionFactory factory; 



    
  public String cruder(String FKprofile,int life){
         
        factory= SessionFactoryHelper.getsysDBUserSessionFactory();
             Session session = factory.openSession();
          Transaction tx = null;
             Integer recordID = null;

             try{
                 factory = new Configuration().configure().buildSessionFactory();
              }catch (Throwable ex) { 
                  feedback="Error";
              }
              try{
                tx = session.beginTransaction();

                ConUser dataModel = new ConUser();      
                dataModel.setSurname(this.getSurname());
                dataModel.setOtherName(this.getOtherName());

            if(FKprofile.equals("default")){
                    
                     ConLife lifeRec =  (ConLife)session.get(ConLife.class,life); 
                     dataModel.setConLife(lifeRec);    
                              
                }


                feedback="Saving Succesful";
                 recordID = (Integer) session.save(dataModel); 
                 tx.commit();

              }catch (HibernateException e) {
                 if (tx!=null) tx.rollback();
               // feedback=e.toString();
                 feedback="Saving Failed"+e.toString(); 
              }finally {
                // session.close(); 
              }

            return  feedback;
           }

  
    
  public String updater(String FKprofile,int key,int life){
         
        factory = new Configuration().configure().buildSessionFactory();    
             Session session = factory.openSession();
          Transaction tx = null;
             Integer recordID = null;

             try{
                 factory = new Configuration().configure().buildSessionFactory();
              }catch (Throwable ex) { 
                  feedback="Error";
              }
              try{
                tx = session.beginTransaction();
 
               ConUser dataModel =   (ConUser)session.get(ConUser.class,2); 
                dataModel.setSurname(this.getSurname());
                dataModel.setOtherName(this.getOtherName());
                   if(FKprofile.equals("default")){                  
                     ConLife lifeRec =  (ConLife)session.get(ConLife.class,life); 
                     dataModel.setConLife(lifeRec);               
                  }
                        feedback="Updating Succesful";
                       session.update(dataModel); 
         
                 tx.commit();

              }catch (HibernateException e) {
                 if (tx!=null) tx.rollback();
               // feedback=e.toString();
                 feedback="Updating Failed"+e.toString(); 
              }finally {
                session.close(); 
              }
            return  feedback;
           }

}