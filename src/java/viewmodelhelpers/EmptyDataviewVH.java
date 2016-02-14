/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package viewmodelhelpers;

/**
 *
 * @author pharis wambui
 */
public class EmptyDataviewVH {
     String dataview,sep;
    int i;

    public String displayEmptyDataview(int cols) {
        dataview="";
        dataview += "{rows:[{ id:-1, data:[";
        dataview += "\"\",";
        dataview += "\"Zero Results found\",";
        for (i = 1; i <= (cols - 2); i++) {
            if(i<cols){sep=",";}else{sep="";}
            dataview += "\"\""+sep+"";
            
        }
          
        dataview += "]},]}";
        return dataview;
    }

}
