/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vxsutil;

import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import model.ConObjectrights;
import viewmodel.DataLoader;

/**
 *
 * @author TBL
 */
public class RightsHelper {

    Map<String, Object> data = new HashMap<String, Object>();
    List<String> listdata;
    String feedback;
    private boolean canview, canadd, canedit, candel, canauthorize, canapprove, canexport;

    public String getRightsdata(String objName, Integer userprofile) {

        DataLoader DL = new DataLoader();
        StringBuilder myquery = new StringBuilder(" from ConObjectrights as CO where  CO.conObjects.objectName ='" + objName + "'");
        listdata = DL.getData(myquery.toString());
        if (!listdata.isEmpty()) {
            for (Iterator iterator = listdata.iterator(); iterator.hasNext();) {
                ConObjectrights OBJ = (ConObjectrights) iterator.next();
                data.put("canview", OBJ.isCanview());
                data.put("canadd", OBJ.isCanadd());
                data.put("canedit", OBJ.isCanedit());
                data.put("candel", OBJ.isCandel());
                data.put("canauthorize", OBJ.isCanauthorize());
                data.put("canapprove", OBJ.isCanapprove());
                data.put("canexport", OBJ.isCanexport());
            }
        }
        feedback = new Gson().toJson(data);
        return feedback;
    }

    public void fetchRightsdata(String objName, Integer userprofile) {

        DataLoader DL = new DataLoader();
        StringBuilder myquery = new StringBuilder(" from ConObjectrights as CO where  CO.conObjects.objectName ='" + objName + "'");
        listdata = DL.getData(myquery.toString());
        if (!listdata.isEmpty()) {
            for (Iterator iterator = listdata.iterator(); iterator.hasNext();) {
                ConObjectrights OBJ = (ConObjectrights) iterator.next();
                canview = OBJ.isCanview();
                canadd = OBJ.isCanadd();
                canedit = OBJ.isCanedit();
                candel = OBJ.isCandel();
                canauthorize = OBJ.isCanauthorize();
                canapprove = OBJ.isCanapprove();
                canexport = OBJ.isCanexport();
            }
        }

    }

    public String formRightsStmt(boolean formRight) {
        String stmt;
        if (formRight == true) {
            stmt = " disabled:false ";
        } else {
            stmt = " disabled:true ";
        }
        return stmt;

    }

    public boolean isCanview() {
        return canview;
    }

    public boolean isCanadd() {
        return canadd;
    }

    public boolean isCanedit() {
        return canedit;
    }

    public boolean isCandel() {
        return candel;
    }

    public boolean isCanauthorize() {
        return canauthorize;
    }

    public boolean isCanapprove() {
        return canapprove;
    }

    public boolean isCanexport() {
        return canexport;
    }

}
