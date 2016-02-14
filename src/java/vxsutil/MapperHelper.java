/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vxsutil;

import java.util.Map;

/**
 *
 * @author TBL
 */
public class MapperHelper {

    public String cleanMap(Map mp, String key, String defaultVal) {

        if (mp.containsKey(key)) {
            return mp.get(key).toString();

        } else {

            return defaultVal;
        }

    }

}
