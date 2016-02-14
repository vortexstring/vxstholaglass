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
 * @author TBL
 */
public class UnitsHelper {

    public BigDecimal mmTofeet(BigDecimal mm) {

        BigDecimal divisor = new BigDecimal(305).setScale(5, BigDecimal.ROUND_HALF_UP);
        BigDecimal result = new BigDecimal(0).setScale(5, BigDecimal.ROUND_HALF_UP);

        try {
            result = mm.divide(divisor, 5, RoundingMode.CEILING);
        } catch (ArithmeticException e) {

        }
        return result;
    }

    public BigDecimal cmTofeet(BigDecimal cm) {
        BigDecimal divisor = new BigDecimal(30.5).setScale(5, BigDecimal.ROUND_HALF_UP);
        BigDecimal result = new BigDecimal(0).setScale(5, BigDecimal.ROUND_HALF_UP);

        try {
            result = cm.divide(divisor, 5, RoundingMode.CEILING);
        } catch (ArithmeticException e) {

        }
        return result;

    }

    public BigDecimal inchesTofeet(BigDecimal inch) {

        BigDecimal divisor = new BigDecimal(12).setScale(5, BigDecimal.ROUND_HALF_UP);
        BigDecimal result = new BigDecimal(0).setScale(5, BigDecimal.ROUND_HALF_UP);

        try {
            result = inch.divide(divisor, 5, RoundingMode.CEILING);
        } catch (ArithmeticException e) {

        }
        return result;

    }

    public BigDecimal mtrsTofeet(BigDecimal mtrs) {

        BigDecimal divisor = new BigDecimal(0.305).setScale(5, BigDecimal.ROUND_HALF_UP);
        BigDecimal result = new BigDecimal(0).setScale(5, BigDecimal.ROUND_HALF_UP);

        try {
            result = mtrs.divide(divisor, 5, RoundingMode.CEILING);
        } catch (ArithmeticException e) {

        }
        return result;

    }

    public BigDecimal feetTofeet(BigDecimal feet) {

        BigDecimal divisor = new BigDecimal(1).setScale(5, BigDecimal.ROUND_HALF_UP);
        BigDecimal result = new BigDecimal(0).setScale(5, BigDecimal.ROUND_HALF_UP);

        try {
            result = feet.divide(divisor, 5, RoundingMode.CEILING);
        } catch (ArithmeticException e) {

        }
        return result;

    }
}
