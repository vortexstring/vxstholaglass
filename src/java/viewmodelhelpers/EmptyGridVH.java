/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package viewmodelhelpers;

import static java.lang.System.out;

/**
 *
 * @author TBL
 */
public class EmptyGridVH {

    String grid,sep;
    int i;

    public String displayEmptyGrid(int cols) {
        grid="";
        grid += "{rows:[{ id:-1, data:[";
        grid += "\"\",";
        grid += "\"Zero Results found\",";
        for (i = 1; i <= (cols - 2); i++) {
            if(i<cols){sep=",";}else{sep="";}
            grid += "\"\""+sep+"";
            
        }
          
        grid += "]},]}";
        return grid;
    }

}
