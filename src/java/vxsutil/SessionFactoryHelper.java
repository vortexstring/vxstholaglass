/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vxsutil;

//import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.*;
/*import org.hibernate.event.def.*;
import org.hibernate.event.*;
import org.hibernate.criterion.*;*

/**
 *
 * @author TBL
 */
public class SessionFactoryHelper {

    private static SessionFactory sysDBUserSessionFactory;

    static {
        try {
            // initialize  the sysDBUserSessionFactory object. 

            Configuration config = new Configuration();
            sysDBUserSessionFactory = config.configure().buildSessionFactory();
            
      
        } catch (Exception ex) {
            System.err.println("Failed to create sessionFactory object." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getsysDBUserSessionFactory() {
        return sysDBUserSessionFactory;
    }

}



