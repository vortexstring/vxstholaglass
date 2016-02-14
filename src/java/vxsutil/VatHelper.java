/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vxsutil;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 *
 * @author PETER
 */
public class VatHelper {

    BigDecimal result;

    public BigDecimal calculateVatableAmt(BigDecimal Amount, BigDecimal InterestAmt, BigDecimal vatrate) {

        BigDecimal vatablerate = new BigDecimal(1).setScale(5, BigDecimal.ROUND_HALF_UP).add(vatrate.divide(new BigDecimal(100)));
        //   BigDecimal percentage = percentdisc.divide(divisor, 5, RoundingMode.CEILING);
        Amount=Amount.add(InterestAmt);
        try {
       
                    
            result = Amount.divide(vatablerate, 5, RoundingMode.CEILING);
        } catch (ArithmeticException e) {
            result = new BigDecimal(0);
        }

        return result;
    }
    public BigDecimal calculateVatAmt(BigDecimal Amount, BigDecimal InterestAmt, BigDecimal vatrate){
        BigDecimal Vatableamount=this.calculateVatableAmt(Amount, InterestAmt, vatrate);
        BigDecimal quotient=vatrate.divide(new BigDecimal(100), 5, RoundingMode.CEILING);
        return Vatableamount.multiply(quotient);
                
        
}
}