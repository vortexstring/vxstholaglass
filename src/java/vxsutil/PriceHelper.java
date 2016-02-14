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
public class PriceHelper {

    BigDecimal result;

    public BigDecimal calculateDiscount(BigDecimal amount, BigDecimal percentdisc) {
        BigDecimal divisor = new BigDecimal(100).setScale(5, BigDecimal.ROUND_HALF_UP);
        BigDecimal percentage = percentdisc.divide(divisor, 5, RoundingMode.CEILING);
        try {
            result = amount.multiply(percentage).setScale(5, BigDecimal.ROUND_HALF_UP);
        } catch (ArithmeticException e) {
            result = new BigDecimal(0);
        }

        return result;
    }

    public BigDecimal calculateInterest(BigDecimal amount, BigDecimal percentint) {
        BigDecimal divisor = new BigDecimal(100).setScale(5, BigDecimal.ROUND_HALF_UP);
        BigDecimal percentage = percentint.divide(divisor, 5, RoundingMode.CEILING);
        try {
            result = amount.multiply(percentage).setScale(5, BigDecimal.ROUND_HALF_UP);
        } catch (ArithmeticException e) {
            result = new BigDecimal(0);
        }

        return result;
    }
}
