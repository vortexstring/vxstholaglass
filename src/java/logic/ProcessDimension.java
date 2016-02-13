/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logic;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import model.ItemSale;
import viewmodel.DataLoader;
import vxsutil.DateHelper;
import vxsutil.MapperHelper;
import vxsutil.PriceHelper;
import vxsutil.UnitsHelper;
import vxsutil.VatHelper;

/**
 *
 * @author TBL
 */
public class ProcessDimension {

    DateHelper DH = new DateHelper();
    List mydata;
    MapperHelper MH = new MapperHelper();
    UnitsHelper UH = new UnitsHelper();
    PriceHelper PH = new PriceHelper();
    VatHelper VH = new VatHelper();
    String myquery;
    Integer duomid;
    BigDecimal BGdimensionlength = new BigDecimal(0);
    BigDecimal BGdimensionlengthnum = new BigDecimal(0);
    BigDecimal BGdimensionlengthdenom = new BigDecimal(0);

    BigDecimal BGdimensionwidth = new BigDecimal(0);
    BigDecimal BGdimensionwidthnum = new BigDecimal(0);
    BigDecimal BGdimensionwidthdenom = new BigDecimal(0);

    BigDecimal TGBGdimensionlength = new BigDecimal(0);
    BigDecimal TGBGdimensionlengthnum = new BigDecimal(0);
    BigDecimal TGBGdimensionlengthdenom = new BigDecimal(0);

    BigDecimal TGBGdimensionwidth = new BigDecimal(0);
    BigDecimal TGBGdimensionwidthnum = new BigDecimal(0);
    BigDecimal TGBGdimensionwidthdenom = new BigDecimal(0);

    BigDecimal BGpercentdisc = new BigDecimal(0);
    BigDecimal BGpercentint = new BigDecimal(0);

    BigDecimal vatrate = new BigDecimal(0);

    BigDecimal UomQty = new BigDecimal(0);
    BigDecimal Amount = new BigDecimal(0);
    BigDecimal LengthQuotient = new BigDecimal(0);
    BigDecimal widthQuotient = new BigDecimal(0);

    private BigDecimal BGqty;
    private Integer i;
    private Date DTnow;
    private String strNow;
    private String strNowshort;

    public Map<String, Object> calculate(Map dimen) {

        String dimensionuomid = MH.cleanMap(dimen, "dimensionuomid", "");
        String dimensionlength = MH.cleanMap(dimen, "dimensionlength", "");
        String dimensionlengthnum = MH.cleanMap(dimen, "dimensionlengthnum", "");
        String dimensionlengthdenom = MH.cleanMap(dimen, "dimensionlengthdenom", "");
        String qty = MH.cleanMap(dimen, "qty", "");
        String dimensionwidth = MH.cleanMap(dimen, "dimensionwidth", "");
        String dimensionwidthnum = MH.cleanMap(dimen, "dimensionwidthnum", "");
        String dimensionwidthdenom = MH.cleanMap(dimen, "dimensionwidthdenom", "");
        String uomid = MH.cleanMap(dimen, "uomid", "");
        String percentdisc = MH.cleanMap(dimen, "percentdisc", "");
        String amount = MH.cleanMap(dimen, "amount", "");
        String vatamount = MH.cleanMap(dimen, "vatamount", "");
        String qdate = MH.cleanMap(dimen, "qdate", "");
        String price = MH.cleanMap(dimen, "price", "");
        String percentint = MH.cleanMap(dimen, "percentint", "");
        String vatableamount = MH.cleanMap(dimen, "vatableamount", "");
        String uomqty = MH.cleanMap(dimen, "uomqty", "");
        String memo = MH.cleanMap(dimen, "memo", "");
        String discount = MH.cleanMap(dimen, "discount", "");
        String interest = MH.cleanMap(dimen, "interest", "");
        String dimensionthickness = MH.cleanMap(dimen, "dimensionthickness", "");
        String dimensionthicknessnum = MH.cleanMap(dimen, "dimensionthicknessnum", "");
        String dimensionthicknessdenom = MH.cleanMap(dimen, "dimensionthicknessdenom", "");
        String ralno = MH.cleanMap(dimen, "ralno", "");
        String status = MH.cleanMap(dimen, "status", "");
        String posid = MH.cleanMap(dimen, "posid", "");
        String itemid = MH.cleanMap(dimen, "itemid", "");
        String itemserviceid = MH.cleanMap(dimen, "itemserviceid", "");
        String itemsaleid = MH.cleanMap(dimen, "itemsaleid", "");
        String createdt = MH.cleanMap(dimen, "createdt", "");
        String writedt = MH.cleanMap(dimen, "writedt", "");
        String createbyid = MH.cleanMap(dimen, "createbyid", "");
        String writebyid = MH.cleanMap(dimen, "writebyid", "");
        String id = MH.cleanMap(dimen, "id", "-1");

        dimen.replace("uomqty", UomQty);
        dimen.put("pricecount", "0");

        dimen = getArea(dimen);

        return dimen;

    }

    //Perform the calculations of the dimensions
    private Map getArea(Map dimen) {

        //Get the length dimensios
        BGqty = new BigDecimal(MH.cleanMap(dimen, "qty", ""));
        BGdimensionlength = new BigDecimal(MH.cleanMap(dimen, "dimensionlength", ""));
        BGdimensionlengthnum = new BigDecimal(MH.cleanMap(dimen, "dimensionlengthnum", ""));
        BGdimensionlengthdenom = new BigDecimal(MH.cleanMap(dimen, "dimensionlengthdenom", ""));

        //Get the width dimensions
        BGdimensionwidth = new BigDecimal(MH.cleanMap(dimen, "dimensionwidth", ""));
        BGdimensionwidthnum = new BigDecimal(MH.cleanMap(dimen, "dimensionwidthnum", ""));
        BGdimensionwidthdenom = new BigDecimal(MH.cleanMap(dimen, "dimensionwidthdenom", ""));

        //get the percentage discount
        BGpercentdisc = new BigDecimal(MH.cleanMap(dimen, "percentdisc", ""));
        BGpercentint = new BigDecimal(MH.cleanMap(dimen, "percentint", ""));

        String dimensionuomid = MH.cleanMap(dimen, "dimensionuomid", "");
        if (!dimensionuomid.isEmpty()) {

            duomid = Integer.parseInt(dimensionuomid);
        }

        switch (duomid) {

            case 1: //MM TO FEET

                TGBGdimensionlength = UH.mmTofeet(BGdimensionlength);
                TGBGdimensionlengthnum = UH.mmTofeet(BGdimensionlengthnum);
                TGBGdimensionlengthdenom = UH.mmTofeet(BGdimensionlengthdenom);

                TGBGdimensionwidth = UH.mmTofeet(BGdimensionwidth);
                TGBGdimensionwidthnum = UH.mmTofeet(BGdimensionwidthnum);
                TGBGdimensionwidthdenom = UH.mmTofeet(BGdimensionwidthdenom);

                break;

            case 2: //CM TO FEET

                TGBGdimensionlength = UH.cmTofeet(BGdimensionlength);
                TGBGdimensionlengthnum = UH.cmTofeet(BGdimensionlengthnum);
                TGBGdimensionlengthdenom = UH.cmTofeet(BGdimensionlengthdenom);

                TGBGdimensionwidth = UH.cmTofeet(BGdimensionwidth);
                TGBGdimensionwidthnum = UH.cmTofeet(BGdimensionwidthnum);
                TGBGdimensionwidthdenom = UH.cmTofeet(BGdimensionwidthdenom);
                break;

            case 3: //FEET TO FEET

                TGBGdimensionlength = UH.feetTofeet(BGdimensionlength);
                TGBGdimensionlengthnum = UH.feetTofeet(BGdimensionlengthnum);
                TGBGdimensionlengthdenom = UH.feetTofeet(BGdimensionlengthdenom);

                TGBGdimensionwidth = UH.feetTofeet(BGdimensionwidth);
                TGBGdimensionwidthnum = UH.feetTofeet(BGdimensionwidthnum);
                TGBGdimensionwidthdenom = UH.feetTofeet(BGdimensionwidthdenom);
                break;
            case 6: //INCHES TO FEET

                TGBGdimensionlength = UH.inchesTofeet(BGdimensionlength);
                TGBGdimensionlengthnum = UH.inchesTofeet(BGdimensionlengthnum);
                TGBGdimensionlengthdenom = UH.inchesTofeet(BGdimensionlengthdenom);

                TGBGdimensionwidth = UH.inchesTofeet(BGdimensionwidth);
                TGBGdimensionwidthnum = UH.inchesTofeet(BGdimensionwidthnum);
                TGBGdimensionwidthdenom = UH.inchesTofeet(BGdimensionwidthdenom);
                break;
            case 7: //M TO FEET

                TGBGdimensionlength = UH.mtrsTofeet(BGdimensionlength);
                TGBGdimensionlengthnum = UH.mtrsTofeet(BGdimensionlengthnum);
                TGBGdimensionlengthdenom = UH.mtrsTofeet(BGdimensionlengthdenom);

                TGBGdimensionwidth = UH.mtrsTofeet(BGdimensionwidth);
                TGBGdimensionwidthnum = UH.mtrsTofeet(BGdimensionwidthnum);
                TGBGdimensionwidthdenom = UH.mtrsTofeet(BGdimensionwidthdenom);
                break;

        }

        //Performe Area Calculations
        LengthQuotient = TGBGdimensionlengthnum.remainder(TGBGdimensionlengthdenom);
        widthQuotient = TGBGdimensionwidthnum.remainder(TGBGdimensionwidthdenom);

        UomQty = TGBGdimensionlength.add(LengthQuotient, MathContext.UNLIMITED).multiply(TGBGdimensionwidth.add(widthQuotient, MathContext.UNLIMITED));
        dimen.replace("uomqty", UomQty);

        dimen = setProductSaleDetails(dimen);
        return dimen;

    }

    private Map setProductSaleDetails(Map productsale) {

        BigDecimal UnitPrice = new BigDecimal(0);
        BigDecimal Qty = new BigDecimal(productsale.get("qty").toString());
        BigDecimal UomQty = new BigDecimal(productsale.get("uomqty").toString());
        Integer itemqtycountignoremax;
        itemqtycountignoremax = 0;

        Integer itemid = Integer.parseInt(MH.cleanMap(productsale, "itemid", "0"));
        Integer uomid = Integer.parseInt(MH.cleanMap(productsale, "uomid", "0"));

        DTnow = DH.convertToUTC(Calendar.getInstance().getTime());
        strNow = DH.DatetimetoStrDatetime(DTnow);
        strNowshort = DH.DatetoStrDate(DTnow);
        DataLoader ME = new DataLoader();
        //Check if the maximum qty  has a zero o by pass the maximum qty
        BigDecimal myzero = new BigDecimal("0");
        String sql = "select count(itemsale0_.item_sale_id) as col_0_0_ from vxsee.item_sale itemsale0_ where itemsale0_.item_id=" + itemid + " and itemsale0_.min_qty<=" + UomQty + " and itemsale0_.max_qty=" + myzero;
        itemqtycountignoremax = ME.getCount(sql);

        if (itemqtycountignoremax > 0) {
            myquery = " FROM ItemSale WHERE item.itemId=" + itemid + " and crmUom.uomId=" + uomid + " and minQty<=" + UomQty + " and effectiveFrom<='" + strNowshort + "' and  effectiveTo>='" + strNowshort + "'";

        } else {
            myquery = " FROM ItemSale WHERE item.itemId=" + itemid + " and crmUom.uomId=" + uomid + " and minQty<=" + UomQty + " and maxQty>=" + UomQty + " and  effectiveFrom<='" + strNowshort + "' and  effectiveTo>='" + strNowshort + "'";

        }

        mydata = ME.getData(myquery);
        if (mydata.size() == 0) {
            productsale.put("error_msg", "There are no existig prices  for the product with the entered sales parameter");

            //CHECK IF TE PRODUCT EXISTS
            Integer itemcount = ME.getCount("select count(itemsale0_.item_sale_id) as col_0_0_ from vxsee.item_sale itemsale0_ where itemsale0_.item_id=" + itemid);

            if (itemcount == 0) {
                productsale.replace("error_msg", "There are no existig prices  for the product");
            } else {

                //CHECK THE QUANTITY,IF THEY EXIST IN THE PRICE EXIST
                Integer itemqtycount = ME.getCount("select count(itemsale0_.item_sale_id) as col_0_0_ from vxsee.item_sale itemsale0_ where itemsale0_.item_id=" + itemid + " and itemsale0_.min_qty<=" + UomQty + " and itemsale0_.max_qty>=" + UomQty);

                if (itemqtycount == 0) {
                    productsale.replace("error_msg", "The Sale Units Quantity is out of range!");
                } else {
                    //CHECK THE DATES ,IF THEY EXIST IN THE PRICE EXIST                 
                    Integer itemdatecount = ME.getCount("select count(itemsale0_.item_sale_id) as col_0_0_ from vxsee.item_sale itemsale0_ where itemsale0_.item_id=" + itemid + " and itemsale0_.effective_from<='" + strNowshort + "' and itemsale0_.effective_to>='" + strNowshort + "'");

                    if (itemdatecount == 0) {
                        productsale.replace("error_msg", "There prices validity dates are out of range!");
                    }

                }
            }

        }

        if (mydata.size() > 1) {
            productsale.replace("error_msg", "There are " + mydata.size() + "duplicate and conflicting  prices for the product");
        }

        i = 0;
        if (!mydata.isEmpty()) {
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                ItemSale OBJ = (ItemSale) iterator.next();

                productsale.replace("itemsaleid", OBJ.getItemSaleId().toString());
                productsale.replace("uomid", OBJ.getCrmUom().getUomId().toString());
                productsale.replace("price", OBJ.getUnitPrice().toString());
                productsale.replace("percentdisc", OBJ.getUnitPrice());
                productsale.replace("percentint", OBJ.getUnitPrice().toString());
                productsale.replace("vatid", OBJ.getFinVat().getVatId());
                productsale.replace("vatamount", OBJ.getUnitPrice().toString());
                productsale.replace("qdate", strNow);
                productsale.put("vatrate", OBJ.getFinVat().getVatRate().toString());
                UnitPrice = OBJ.getUnitPrice();
                i++;
            }
            ME.closeListSession();
        }

        Amount = UnitPrice.multiply(Qty).multiply(UomQty);

        BigDecimal DiscountAmt = PH.calculateDiscount(Amount, BGpercentdisc);
        productsale.replace("percentdisc", BGpercentdisc.toString());
        productsale.replace("discount", DiscountAmt.toString());

        BigDecimal InterestAmt = PH.calculateInterest(Amount, BGpercentint);
        productsale.replace("percentint", BGpercentint.toString());
        productsale.replace("interest", InterestAmt.toString());

        vatrate = new BigDecimal(productsale.get("vatrate").toString());
        BigDecimal VatableAmt = VH.calculateVatableAmt(Amount, InterestAmt, vatrate);

        productsale.replace("vatableamount", VatableAmt.toString());

        BigDecimal VatAmt = VH.calculateVatAmt(Amount, InterestAmt, vatrate);
        productsale.replace("vatamount", VatAmt.toString());

        //deduct the discount and add the interesr
        BigDecimal NetAmount = Amount.add(InterestAmt).subtract(DiscountAmt);

        productsale.replace("pricecount", mydata.size());
        productsale.replace("amount", NetAmount.toString());

        return productsale;
    }

}
