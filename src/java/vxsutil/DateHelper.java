/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vxsutil;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

/**
 *
 * @author TBL
 */
public class DateHelper {

    String replace1, replace2;
    DateFormat SimpleFormat;
    TimeZone timeZone;
    final Integer UTCOffsetHours;

    //Date passed in yyyy-MM-dd format is converted to a date object (Java.itil.date)
    public DateHelper() {

        timeZone = TimeZone.getDefault();
        UTCOffsetHours = (timeZone.getRawOffset() / 3600000);
    }

    public Integer getTimezoneOffsetHours() {

        return this.UTCOffsetHours;

    }

    public Date StrDatetoDate(String strDate) {

        try {
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            return df.parse(strDate);
        } catch (Exception e) {
            System.err.println(e);
            return null;
        }

    }

    //Date passed in yyyy-MM-dd format is converted to a date object (Java.itil.date)
    public Date StrDatetimetoDatetime(String strDatetime) {

        try {

            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            replace1 = strDatetime.replace("T", " ");
            replace2 = replace1.replace("Z", " ");
            return df.parse(replace2);

        } catch (Exception e) {
            System.err.println(e);
            return null;
        }

    }

    /**
     * ***************CONVERING THE DATE OBJECT TO STRING**************
     */
    public String DatetoStrDate(Date dateObj) {

        try {

            Calendar c = Calendar.getInstance();
            c.setTime(dateObj); // Now use the date passed
            c.add(Calendar.HOUR, UTCOffsetHours); // Adding 3 hours
            SimpleFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
            return SimpleFormat.format(c.getTime());

        } catch (Exception e) {
            System.err.println(e.getMessage());
            return null;
        }

    }

    public String DatetimetoStrDatetime(Date dateObj) {

        try {

            Calendar c = Calendar.getInstance();
            c.setTime(dateObj); // Now use the date passed
            c.add(Calendar.HOUR, UTCOffsetHours); // Adding 3 hours
            SimpleFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
            return SimpleFormat.format(c.getTime());

        } catch (Exception e) {
            System.err.println(e.getMessage());
            return null;
        }

    }

    
public Date convertToUTC(Date dateObj){
      try {

            Calendar c = Calendar.getInstance();
            c.setTime(dateObj); // Now use the date passed
            c.add(Calendar.HOUR,-UTCOffsetHours); // Removing the offset hours
            return c.getTime();

        } catch (Exception e) {
            System.err.println(e.getMessage());
            return null;
        }
}
public Date convertToUTCTwo(Date dateObj){
      try {

            Calendar c = Calendar.getInstance();
            c.setTime(dateObj); // Now use the date passed
            c.add(Calendar.YEAR,2);
            c.add(Calendar.HOUR,-UTCOffsetHours); // Removing the offset hours
            return c.getTime();

        } catch (Exception e) {
            System.err.println(e.getMessage());
            return null;
        }
}
}
