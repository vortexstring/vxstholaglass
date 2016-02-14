/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package viewmodel;
import java.math.BigInteger;
import java.util.Iterator;
import vxsutil.SessionFactoryHelper;
import model.*;
import modelv.*;
import java.util.List;
import logic.*;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author TBL
 */
public class DataLoader {
       
   List <String> Griddata;
   String rsp;
   List<String> hib_error;   
   Session session;
   SessionFactory factory; 
    Integer countRes;
    public void DataLoader(){

     }
    
  public List<String> getData(String query){
        
    
    
      Transaction tx = null;
    factory= SessionFactoryHelper.getsysDBUserSessionFactory();
     
      session = factory.openSession();
      try{
         tx = session.beginTransaction();
          Griddata = session.createQuery(query).list(); 
         tx.commit();
       
      }catch (HibernateException e) {
          hib_error.add(e.toString());
          if (tx!=null) tx.rollback();
          
         // Griddata=hib_error;
      }finally {
     //  hib_error.add("Request Execution failed");
   
      }
    return  Griddata;
    
   }
  
 // FROM Item AS I where I.item.itemId=5
  
public  Integer getCount(String query){
     
   
      Transaction tx = null;
    factory= SessionFactoryHelper.getsysDBUserSessionFactory();
     
      session = factory.openSession();
      try{
         tx = session.beginTransaction();
          Griddata = session.createSQLQuery(query).list();
         tx.commit();
       
   
      
      if(!Griddata.isEmpty()){
        
         for (Iterator iterator = Griddata.iterator(); iterator.hasNext();) {
                BigInteger OBJ = (BigInteger) iterator.next();
                countRes=OBJ.intValue();
         }
             }else{
        countRes=0;
      
        }
      
         }catch (Exception e) {
          hib_error.add(e.toString());
          if (tx!=null) tx.rollback();
         
      }
      
       session.close(); 
     return  countRes;
 
 }



  public void closeListSession(){
          session.close(); 
       
  }
  
  public boolean isSessionOpen(){
      
    return session.isConnected();
  }
}
