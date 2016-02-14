/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package viewmodelhelpers;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import model.Item;
import model.ItemLevel;
import viewmodel.DataLoader;

/**
 *
 * @author TBL
 */
public class ProductsVH {

    String gridString;
    String gridLine;
    List mydata;

    Map<String, Object> gridData = new HashMap< String, Object>();
    Map<String, Object> rspgridData = new HashMap< String, Object>();

    Integer i;
    private String headers = "";
    private String colAlign = "";
    private String InitWidthsP = "";
    private String filterHeader = "";
    private String gridSorting = "";
    private String ColTypes = "";

    public String getGrid() {
        rspgridData = getProductLevels();
        gridString = " productsGrid.setColTypes(\"ro,ro,ro" + rspgridData.get("ColTypes") + "\");"
                + " productsGrid.setHeader(\"#,Code,Product Name" + rspgridData.get("headers") + "\");"
                + " productsGrid.setColAlign(\"left,left,left" + rspgridData.get("colAlign") + "\");"
                + "  productsGrid.setInitWidthsP(\"5,10,25" + rspgridData.get("InitWidthsP") + "\");"
                + "  productsGrid.attachHeader(\",#text_filter,#text_filter" + rspgridData.get("filterHeader") + "\");"
                + "  productsGrid.setColSorting(\"int,str,str" + rspgridData.get("gridSorting") + "\");";

        return gridString;
    }

    public Map<String, Object> getProductLevels() {

        try {
            DataLoader ME = new DataLoader();
            mydata = ME.getData("FROM ItemLevel WHERE life!=2");
            Integer colSize = mydata.size();
            if (!mydata.isEmpty()) {
                i = 1;

                //LOOP THROUGH THE GRID
                for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                    ItemLevel OBJ = (ItemLevel) iterator.next();

                    headers = headers + "," + OBJ.getLevelName();
                    colAlign = colAlign + ",left";
                    InitWidthsP = InitWidthsP + "," + 60 / colSize;
                    filterHeader = filterHeader + ",#text_filter";
                    gridSorting = gridSorting + ",str";
                    ColTypes = ColTypes + ",ro";
                    i++;
                }
            }

            gridData.put("headers", headers);
            gridData.put("colAlign", colAlign);
            gridData.put("InitWidthsP", InitWidthsP);
            gridData.put("filterHeader", filterHeader);
            gridData.put("gridSorting", gridSorting);
            gridData.put("ColTypes", ColTypes);

        } catch (Exception e) {

        }
        return gridData;

    }

    public String getDynamicGridData(Item OBJ, Integer levelId) {
        gridLine = "";
        String emptyLine = "\"\",";
        if (levelId >= 2) {
            gridLine += "\"" + OBJ.getItem().getItemName() + "\",";
        } else {
            gridLine += emptyLine;
        }

        if (levelId >= 3) {
            gridLine += "\"" + OBJ.getItem().getItem().getItemName() + "\",";
        } else {
            gridLine += emptyLine;
        }

        if (levelId >= 4) {
            gridLine += "\"" + OBJ.getItem().getItem().getItemName() + "\",";
        } else {
            gridLine += emptyLine;
        }

        if (levelId >= 5) {
            gridLine += "\"" + OBJ.getItem().getItem().getItemName() + "\",";
        } else {
            gridLine += emptyLine;
        }

        if (levelId >= 6) {
            gridLine += "\"" + OBJ.getItem().getItem().getItemName() + "\",";
        } else {
            gridLine += emptyLine;
        }

        return gridLine;

    }

}
