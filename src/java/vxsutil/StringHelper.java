/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vxsutil;

/**
 *
 * @author TBL
 */
public class StringHelper {

    String response;
    Integer intresponse;

    public String cleanInput(String input) {

        response = input.replace("\"", "\\\"");
        response= response.replaceAll("\\s","");
        return response;
    }
    
    
    public String emptyString(String input){
       
         response="";
        return response;   
    }
     public String assignEmptyString(){
       
         response="";
        return response;   
    }
    
    public Integer emptyInteger(Integer input){
        if(input.equals(null) || input==0){
            
          intresponse=-1;  
            
        }   
        return intresponse;     
    }
    
    
       
    public String formCheckbox(boolean input){
        String stmt;
        if (input==true){
            stmt= ", checked:true";
        }else{
            stmt= ", checked:false";
        }
        return stmt;
    }
    
    public boolean stringToBoolean(String input){
        boolean resp;
        if(input.equals("1")){
            resp=true;
        }else{
            resp=false;
        }
        
      return resp;  
    }
    public String formRadio(String input,String radioValue){
                String stmt;
 if (input.equals(radioValue)){
            stmt= ", checked:true";
        }else{
            stmt= " ";
        }
        return stmt;
    }

}
