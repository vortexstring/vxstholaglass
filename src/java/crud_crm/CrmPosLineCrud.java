package crud_crm;

import viewmodel.*;
import model.*;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import vxsutil.SessionFactoryHelper;
import org.hibernate.HibernateException;
import org.hibernate.exception.*;
import java.lang.NullPointerException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import com.google.gson.*;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import vxsutil.DateHelper;
import vxsutil.MapperHelper;
import vxsutil.StringHelper;

public class CrmPosLineCrud {

    /**
     * ***Compulsory fields*****
     */
    String strid, feedback, writedate, createdate, msgtype, msg, actiontype, recId, gridata, returngridata, createbyid, writebyid, writedt, createdt;
    Integer Ncreatebyid, Nwritebyid, id, i;
    Date DTwritedt, DTcreatedt, Dqdate;
    List listdata, mydata;
    Map<String, Object> data = new HashMap< String, Object>();
    DateHelper DH = new DateHelper();
    StringHelper SH = new StringHelper();
    MapperHelper MH = new MapperHelper();

    SessionFactory factory;
    Session session;
    CrmPosLine dataModel;
    Transaction tx = null;

    /**
     * ******Model specific variables***********
     */
    String qdate, memo, ralno, posid, itemid, itemserviceid, itemsaleid, qty, uomid, dimensionuomid, status, price, discount, interest, percentdisc, percentint, amount, vatableamount, vatamount, uomqty, dimensionlength, dimensionwidth, dimensionthickness, dimensionthicknessnum, dimensionthicknessdenom, dimensionlengthnum, dimensionlengthdenom, dimensionwidthnum, dimensionwidthdenom;
    Integer Nposid, Nitemid, Nitemserviceid, Nitemsaleid, Nqty, Nuomid, Ndimensionuomid, Nstatus;
    BigDecimal BDprice, BDdiscount, BDinterest, BDpercentdisc, BDpercentint, BDamount, BDvatableamount, BDvatamount, BDuomqty, BDdimensionlength, BDdimensionwidth, BDdimensionthickness, BDdimensionthicknessnum, BDdimensionthicknessdenom, BDdimensionlengthnum, BDdimensionlengthdenom, BDdimensionwidthnum, BDdimensionwidthdenom;

//A PUBLIC METHOD TO PERFORM CREATE,UPDATE AND DELETE FUNCTIONALITY
    public Map<String, Object> cud(String action, Map formData) {

//Catch Model Errors
        try {
//IN CASE OF INVALID ACTION
            if (action.equals("c") || action.equals("u") || action.equals("d")) {
            } else {
                data.put("msgtype", "fail");
                data.put("msg", "Invalid Action type");
                return data;
            }

//Getting data from tha mapper
            strid = SH.cleanInput(MH.cleanMap(formData, "id", "0"));
            posid = SH.cleanInput(MH.cleanMap(formData, "posid", "0"));
            itemid = SH.cleanInput(MH.cleanMap(formData, "itemid", "0"));
            itemserviceid = SH.cleanInput(MH.cleanMap(formData, "itemserviceid", "0"));
            itemsaleid = SH.cleanInput(MH.cleanMap(formData, "itemsaleid", "0"));
            price = SH.cleanInput(MH.cleanMap(formData, "price", "0"));
            qty = SH.cleanInput(MH.cleanMap(formData, "qty", "0"));
            discount = SH.cleanInput(MH.cleanMap(formData, "discount", "0"));
            interest = SH.cleanInput(MH.cleanMap(formData, "interest", "0"));
            percentdisc = SH.cleanInput(MH.cleanMap(formData, "percentdisc", "0"));
            percentint = SH.cleanInput(MH.cleanMap(formData, "percentint", "0"));
            amount = SH.cleanInput(MH.cleanMap(formData, "amount", "0"));
            vatableamount = SH.cleanInput(MH.cleanMap(formData, "vatableamount", "0"));
            vatamount = SH.cleanInput(MH.cleanMap(formData, "vatamount", "0"));
            uomid = SH.cleanInput(MH.cleanMap(formData, "uomid", "0"));
            uomqty = SH.cleanInput(MH.cleanMap(formData, "uomqty", "0"));
            qdate = SH.cleanInput(MH.cleanMap(formData, "qdate", ""));
            memo = SH.cleanInput(MH.cleanMap(formData, "memo", ""));
            dimensionuomid = SH.cleanInput(MH.cleanMap(formData, "dimensionuomid", "0"));
            dimensionlength = SH.cleanInput(MH.cleanMap(formData, "dimensionlength", "0"));
            dimensionwidth = SH.cleanInput(MH.cleanMap(formData, "dimensionwidth", "0"));
            dimensionthickness = SH.cleanInput(MH.cleanMap(formData, "dimensionthickness", "0"));
            dimensionthicknessnum = SH.cleanInput(MH.cleanMap(formData, "dimensionthicknessnum", "0"));
            dimensionthicknessdenom = SH.cleanInput(MH.cleanMap(formData, "dimensionthicknessdenom", "0"));
            dimensionlengthnum = SH.cleanInput(MH.cleanMap(formData, "dimensionlengthnum", "0"));
            dimensionlengthdenom = SH.cleanInput(MH.cleanMap(formData, "dimensionlengthdenom", "0"));
            dimensionwidthnum = SH.cleanInput(MH.cleanMap(formData, "dimensionwidthnum", "0"));
            dimensionwidthdenom = SH.cleanInput(MH.cleanMap(formData, "dimensionwidthdenom", "0"));
            ralno = SH.cleanInput(MH.cleanMap(formData, "ralno", ""));
            status = SH.cleanInput(MH.cleanMap(formData, "status", "0"));
             //COMPULSORY FIELDS FROM THE MAPPER
            createbyid = SH.cleanInput(MH.cleanMap(formData, "createbyid", "0"));
            writebyid = SH.cleanInput(MH.cleanMap(formData, "writebyid", "0"));
            createdt = SH.cleanInput(MH.cleanMap(formData, "createdt", ""));
            writedt = SH.cleanInput(MH.cleanMap(formData, "writedt", ""));

            id = Integer.valueOf(strid);
            Nposid = Integer.valueOf(posid);
            Nitemid = Integer.valueOf(itemid);
            Nitemserviceid = Integer.valueOf(itemserviceid);
            Nitemsaleid = Integer.valueOf(itemsaleid);
            Nqty = Integer.valueOf(qty);
            Nuomid = Integer.valueOf(uomid);
            Ndimensionuomid = Integer.valueOf(dimensionuomid);
            Nstatus = Integer.valueOf(status);

            //DATE VALUES
            Dqdate = DH.StrDatetoDate(qdate);

            //DATE TIME VALUES
            DTcreatedt = DH.StrDatetimetoDatetime(createdt);
            DTwritedt = DH.StrDatetimetoDatetime(writedt);
            //Integer values
            Ncreatebyid = Integer.valueOf(createbyid);
            Nwritebyid = Integer.valueOf(writebyid);

            factory = SessionFactoryHelper.getsysDBUserSessionFactory();
            session = factory.openSession();
            try {
                tx = session.beginTransaction();
                /**
                 * **************CREATING THE MODEL INSTANCE***************
                 */
                if (action.equals("u") || action.equals("d")) {
                    dataModel = (CrmPosLine) session.get(CrmPosLine.class, id);
                } else {
                    dataModel = new CrmPosLine();
                }
                /**
                 * ***********ASSIGNING THE MODEL VALUES*****************
                 */
                if (action.equals("c") || action.equals("u")) {

                    dataModel.setQty(Nqty);
                    dataModel.setMemo(memo);
                    dataModel.setRalNo(ralno);
                    dataModel.setQdate(Dqdate);
                    BDprice = new BigDecimal(price);
                    dataModel.setPrice(BDprice);
                    BDdiscount = new BigDecimal(discount);
                    dataModel.setDiscount(BDdiscount);
                    BDinterest = new BigDecimal(interest);
                    dataModel.setInterest(BDinterest);
                    BDpercentdisc = new BigDecimal(percentdisc);
                    dataModel.setPercentDisc(BDpercentdisc);
                    BDpercentint = new BigDecimal(percentint);
                    dataModel.setPercentInt(BDpercentint);
                    BDamount = new BigDecimal(amount);
                    dataModel.setAmount(BDamount);
                    BDvatableamount = new BigDecimal(vatableamount);
                    dataModel.setVatableAmount(BDvatableamount);
                    BDvatamount = new BigDecimal(vatamount);
                    dataModel.setVatAmount(BDvatamount);
                    BDuomqty = new BigDecimal(uomqty);
                    dataModel.setUomQty(BDuomqty);
                    BDdimensionlength = new BigDecimal(dimensionlength);
                    dataModel.setDimensionLength(BDdimensionlength);
                    BDdimensionwidth = new BigDecimal(dimensionwidth);
                    dataModel.setDimensionWidth(BDdimensionwidth);
                    BDdimensionthickness = new BigDecimal(dimensionthickness);
                    dataModel.setDimensionThickness(BDdimensionthickness);
                    BDdimensionthicknessnum = new BigDecimal(dimensionthicknessnum);
                    dataModel.setDimensionThicknessNum(BDdimensionthicknessnum);
                    BDdimensionthicknessdenom = new BigDecimal(dimensionthicknessdenom);
                    dataModel.setDimensionThicknessDenom(BDdimensionthicknessdenom);
                    BDdimensionlengthnum = new BigDecimal(dimensionlengthnum);
                    dataModel.setDimensionLengthNum(BDdimensionlengthnum);
                    BDdimensionlengthdenom = new BigDecimal(dimensionlengthdenom);
                    dataModel.setDimensionLengthDenom(BDdimensionlengthdenom);
                    BDdimensionwidthnum = new BigDecimal(dimensionwidthnum);
                    dataModel.setDimensionWidthNum(BDdimensionwidthnum);
                    BDdimensionwidthdenom = new BigDecimal(dimensionwidthdenom);
                    dataModel.setDimensionWidthDenom(BDdimensionwidthdenom);
                    CrmPos crmpos = (CrmPos) session.get(CrmPos.class, Nposid);
                    dataModel.setCrmPos(crmpos);
                    Item item = (Item) session.get(Item.class, Nitemid);
                    dataModel.setItemByItemId(item);
                    Item item1 = (Item) session.get(Item.class, Nitemserviceid);
                    dataModel.setItemByItemServiceId(item1);
                    ItemSale itemsale = (ItemSale) session.get(ItemSale.class, Nitemsaleid);
                    dataModel.setItemSale(itemsale);
                    AllStatus allstatus = (AllStatus) session.get(AllStatus.class, Nstatus);
                    dataModel.setAllStatus(allstatus);
                    CrmUom crmuom = (CrmUom) session.get(CrmUom.class, Nuomid);
                    dataModel.setCrmUomByUomId(crmuom);
                    CrmUom crmuom1 = (CrmUom) session.get(CrmUom.class, Ndimensionuomid);
                    dataModel.setCrmUomByDimensionUomId(crmuom1);

                     //PRINT COMPULSORY SET METHODS
                    dataModel.setWritedt(DTwritedt);
                    ConUser writebyRec = (ConUser) session.get(ConUser.class, Nwritebyid);
                    dataModel.setConUserByWritebyId(writebyRec);
                    ConCompany companyRec = (ConCompany) session.get(ConCompany.class, 1);
                    dataModel.setConCompany(companyRec);

                    //PRINT CODE FOR DELETING A RECORD
                } else if (action.equals("d")) {
                    ConLife lifeRec = (ConLife) session.get(ConLife.class, 2);
                    dataModel.setConLife(lifeRec);
                }

                /**
                 * **********************CREATING THE FEEDBACK MESSAGE FOR THE
                 * CUD CLASS*********
                 */
                if (action.equals("c")) {
                    ConLife lifeRec = (ConLife) session.get(ConLife.class, 1);
                    dataModel.setConLife(lifeRec);
                    ConUser createbyRec = (ConUser) session.get(ConUser.class, Ncreatebyid);
                    dataModel.setConUserByCreatebyId(createbyRec);
                    dataModel.setCreatedt(DTcreatedt);
                    id = (Integer) session.save(dataModel);
                    tx.commit();
                    msg = "Insertion Succesful";
                    returngridata = getCrmPosLinedata(id);
                } else if (action.equals("u")) {
                    session.update(dataModel);
                    tx.commit();
                    msg = "Updating Succesful";
                    returngridata = getCrmPosLinedata(id);
                } else if (action.equals("d")) {
                    tx.commit();
                    session.update(dataModel);
                    msg = "Deletion Succesful";
                }
                data.put("msgtype", "success");
                data.put("msg", msg);
                data.put("actiontype", action);
                data.put("recId", strid);
                data.put("gridData", returngridata);
                /**
                 * ***************IN CASE AN ERROR OCCURS************
                 */
            } catch (DataException | ConstraintViolationException | JDBCConnectionException | SQLGrammarException e) {

                String msg = e.getCause().toString();
                if (tx != null) {
                    tx.rollback();
                }

                data.put("msgtype", "fail");
                if (action.equals("c")) {
                    data.put("msg", "Insertion Failed" + msg);
                } else if (action.equals("u")) {
                    data.put("msg", "Updating Failed" + msg);
                } else if (action.equals("d")) {
                    data.put("msg", "Deleting Failed" + msg);
                }
            } finally {
                session.close();
            }

        } catch (Exception e) {

            msg = e.toString() + " , " + e.getMessage();
            data.put("msgtype", "fail");
            data.put("msg", "Saving Error " + msg);
            if (this.isSessionActive()) {
                session.close();
            }
        }

        return data;
    }

    private boolean isSessionActive() {
        try {
            if (session.isOpen() || session.isDirty() || session.isConnected()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * **********A METHOD RETURN DATA IN CUSTOMIZED SPECIFIC DHTMLX GRID FORMAT************
     */
    private String getCrmPosLinedata(Integer id) {
        DataLoader ME = new DataLoader();
        StringBuilder myquery = new StringBuilder("FROM CrmPosLine Where posLineId=" + id);
        mydata = ME.getData(myquery.toString());
        if (!mydata.isEmpty()) {
            i = 1;
            for (Iterator iterator = mydata.iterator(); iterator.hasNext();) {
                CrmPosLine crmposline = (CrmPosLine) iterator.next();
                  gridata = i + "," + crmposline.getItemByItemId().getItem().getItemName() + "--" + crmposline.getItemByItemId().getItemName() +"," + crmposline.getQty() + "," + crmposline.getUomQty() + " " + crmposline.getItemSale().getCrmUom().getUomName() + "," + crmposline.getVatableAmount() + "," + crmposline.getVatAmount() + "," + crmposline.getDiscount() + "," + crmposline.getInterest() + "," + crmposline.getAmount();

                i++;
            }
        }
        return gridata;
    }
//PRINT THE Validation Data

    public Map validation(String Industry) {

        Map rules = new HashMap< String, Object>();
        Map posidrules = new HashMap< String, Object>();
        posidrules.put("required", "false");
        posidrules.put("minlength", "0");
        posidrules.put("maxlength", "5");
        posidrules.put("isemail", "false");
        posidrules.put("isalphanumeric", "false");
        posidrules.put("isnumeric", "false");
        posidrules.put("isinteger", "false");
        posidrules.put("lengthmessage", "Length should be between " + posidrules.get("minlength") + " and " + posidrules.get("maxlength") + " ");
        rules.put("posid", posidrules);

        Map itemidrules = new HashMap< String, Object>();
        itemidrules.put("required", "false");
        itemidrules.put("minlength", "0");
        itemidrules.put("maxlength", "50");
        itemidrules.put("isemail", "false");
        itemidrules.put("isalphanumeric", "false");
        itemidrules.put("isnumeric", "false");
        itemidrules.put("isinteger", "false");
        itemidrules.put("lengthmessage", "Length should be between " + itemidrules.get("minlength") + " and " + itemidrules.get("maxlength") + " ");
        rules.put("itemid", itemidrules);

        Map itemserviceidrules = new HashMap< String, Object>();
        itemserviceidrules.put("required", "false");
        itemserviceidrules.put("minlength", "0");
        itemserviceidrules.put("maxlength", "4");
        itemserviceidrules.put("isemail", "false");
        itemserviceidrules.put("isalphanumeric", "false");
        itemserviceidrules.put("isnumeric", "false");
        itemserviceidrules.put("isinteger", "false");
        itemserviceidrules.put("lengthmessage", "Length should be between " + itemserviceidrules.get("minlength") + " and " + itemserviceidrules.get("maxlength") + " ");
        rules.put("itemserviceid", itemserviceidrules);

        Map itemsaleidrules = new HashMap< String, Object>();
        itemsaleidrules.put("required", "false");
        itemsaleidrules.put("minlength", "0");
        itemsaleidrules.put("maxlength", "50");
        itemsaleidrules.put("isemail", "false");
        itemsaleidrules.put("isalphanumeric", "false");
        itemsaleidrules.put("isnumeric", "false");
        itemsaleidrules.put("isinteger", "false");
        itemsaleidrules.put("lengthmessage", "Length should be between " + itemsaleidrules.get("minlength") + " and " + itemsaleidrules.get("maxlength") + " ");
        rules.put("itemsaleid", itemsaleidrules);

        Map pricerules = new HashMap< String, Object>();
        pricerules.put("required", "false");
        pricerules.put("minlength", "0");
        pricerules.put("maxlength", "10,2");
        pricerules.put("isemail", "false");
        pricerules.put("isalphanumeric", "false");
        pricerules.put("isnumeric", "false");
        pricerules.put("isinteger", "false");
        pricerules.put("lengthmessage", "Length should be between " + pricerules.get("minlength") + " and " + pricerules.get("maxlength") + " ");
        rules.put("price", pricerules);

        Map qtyrules = new HashMap< String, Object>();
        qtyrules.put("required", "false");
        qtyrules.put("minlength", "0");
        qtyrules.put("maxlength", "4");
        qtyrules.put("isemail", "false");
        qtyrules.put("isalphanumeric", "false");
        qtyrules.put("isnumeric", "false");
        qtyrules.put("isinteger", "false");
        qtyrules.put("lengthmessage", "Length should be between " + qtyrules.get("minlength") + " and " + qtyrules.get("maxlength") + " ");
        rules.put("qty", qtyrules);

        Map discountrules = new HashMap< String, Object>();
        discountrules.put("required", "false");
        discountrules.put("minlength", "0");
        discountrules.put("maxlength", "10,2");
        discountrules.put("isemail", "false");
        discountrules.put("isalphanumeric", "false");
        discountrules.put("isnumeric", "false");
        discountrules.put("isinteger", "false");
        discountrules.put("lengthmessage", "Length should be between " + discountrules.get("minlength") + " and " + discountrules.get("maxlength") + " ");
        rules.put("discount", discountrules);

        Map interestrules = new HashMap< String, Object>();
        interestrules.put("required", "false");
        interestrules.put("minlength", "0");
        interestrules.put("maxlength", "10,2");
        interestrules.put("isemail", "false");
        interestrules.put("isalphanumeric", "false");
        interestrules.put("isnumeric", "false");
        interestrules.put("isinteger", "false");
        interestrules.put("lengthmessage", "Length should be between " + interestrules.get("minlength") + " and " + interestrules.get("maxlength") + " ");
        rules.put("interest", interestrules);

        Map percentdiscrules = new HashMap< String, Object>();
        percentdiscrules.put("required", "false");
        percentdiscrules.put("minlength", "0");
        percentdiscrules.put("maxlength", "10,4");
        percentdiscrules.put("isemail", "false");
        percentdiscrules.put("isalphanumeric", "false");
        percentdiscrules.put("isnumeric", "false");
        percentdiscrules.put("isinteger", "false");
        percentdiscrules.put("lengthmessage", "Length should be between " + percentdiscrules.get("minlength") + " and " + percentdiscrules.get("maxlength") + " ");
        rules.put("percentdisc", percentdiscrules);

        Map percentintrules = new HashMap< String, Object>();
        percentintrules.put("required", "false");
        percentintrules.put("minlength", "0");
        percentintrules.put("maxlength", "10,4");
        percentintrules.put("isemail", "false");
        percentintrules.put("isalphanumeric", "false");
        percentintrules.put("isnumeric", "false");
        percentintrules.put("isinteger", "false");
        percentintrules.put("lengthmessage", "Length should be between " + percentintrules.get("minlength") + " and " + percentintrules.get("maxlength") + " ");
        rules.put("percentint", percentintrules);

        Map amountrules = new HashMap< String, Object>();
        amountrules.put("required", "false");
        amountrules.put("minlength", "0");
        amountrules.put("maxlength", "10,2");
        amountrules.put("isemail", "false");
        amountrules.put("isalphanumeric", "false");
        amountrules.put("isnumeric", "false");
        amountrules.put("isinteger", "false");
        amountrules.put("lengthmessage", "Length should be between " + amountrules.get("minlength") + " and " + amountrules.get("maxlength") + " ");
        rules.put("amount", amountrules);

        Map vatableamountrules = new HashMap< String, Object>();
        vatableamountrules.put("required", "false");
        vatableamountrules.put("minlength", "0");
        vatableamountrules.put("maxlength", "10,2");
        vatableamountrules.put("isemail", "false");
        vatableamountrules.put("isalphanumeric", "false");
        vatableamountrules.put("isnumeric", "false");
        vatableamountrules.put("isinteger", "false");
        vatableamountrules.put("lengthmessage", "Length should be between " + vatableamountrules.get("minlength") + " and " + vatableamountrules.get("maxlength") + " ");
        rules.put("vatableamount", vatableamountrules);

        Map vatamountrules = new HashMap< String, Object>();
        vatamountrules.put("required", "false");
        vatamountrules.put("minlength", "0");
        vatamountrules.put("maxlength", "10,2");
        vatamountrules.put("isemail", "false");
        vatamountrules.put("isalphanumeric", "false");
        vatamountrules.put("isnumeric", "false");
        vatamountrules.put("isinteger", "false");
        vatamountrules.put("lengthmessage", "Length should be between " + vatamountrules.get("minlength") + " and " + vatamountrules.get("maxlength") + " ");
        rules.put("vatamount", vatamountrules);

        Map uomidrules = new HashMap< String, Object>();
        uomidrules.put("required", "false");
        uomidrules.put("minlength", "0");
        uomidrules.put("maxlength", "50");
        uomidrules.put("isemail", "false");
        uomidrules.put("isalphanumeric", "false");
        uomidrules.put("isnumeric", "false");
        uomidrules.put("isinteger", "false");
        uomidrules.put("lengthmessage", "Length should be between " + uomidrules.get("minlength") + " and " + uomidrules.get("maxlength") + " ");
        rules.put("uomid", uomidrules);

        Map uomqtyrules = new HashMap< String, Object>();
        uomqtyrules.put("required", "false");
        uomqtyrules.put("minlength", "0");
        uomqtyrules.put("maxlength", "10,4");
        uomqtyrules.put("isemail", "false");
        uomqtyrules.put("isalphanumeric", "false");
        uomqtyrules.put("isnumeric", "false");
        uomqtyrules.put("isinteger", "false");
        uomqtyrules.put("lengthmessage", "Length should be between " + uomqtyrules.get("minlength") + " and " + uomqtyrules.get("maxlength") + " ");
        rules.put("uomqty", uomqtyrules);

        Map qdaterules = new HashMap< String, Object>();
        qdaterules.put("required", "false");
        qdaterules.put("minlength", "0");
        qdaterules.put("maxlength", "21");
        qdaterules.put("isemail", "false");
        qdaterules.put("isalphanumeric", "false");
        qdaterules.put("isnumeric", "false");
        qdaterules.put("isinteger", "false");
        qdaterules.put("lengthmessage", "Length should be between " + qdaterules.get("minlength") + " and " + qdaterules.get("maxlength") + " ");
        rules.put("qdate", qdaterules);

        Map memorules = new HashMap< String, Object>();
        memorules.put("required", "false");
        memorules.put("minlength", "0");
        memorules.put("maxlength", "50");
        memorules.put("isemail", "false");
        memorules.put("isalphanumeric", "false");
        memorules.put("isnumeric", "false");
        memorules.put("isinteger", "false");
        memorules.put("lengthmessage", "Length should be between " + memorules.get("minlength") + " and " + memorules.get("maxlength") + " ");
        rules.put("memo", memorules);

        Map dimensionuomidrules = new HashMap< String, Object>();
        dimensionuomidrules.put("required", "true");
        dimensionuomidrules.put("minlength", "1");
        dimensionuomidrules.put("maxlength", "50");
        dimensionuomidrules.put("isemail", "false");
        dimensionuomidrules.put("isalphanumeric", "false");
        dimensionuomidrules.put("isnumeric", "false");
        dimensionuomidrules.put("isinteger", "false");
        dimensionuomidrules.put("lengthmessage", "Length should be between " + dimensionuomidrules.get("minlength") + " and " + dimensionuomidrules.get("maxlength") + " ");
        rules.put("dimensionuomid", dimensionuomidrules);

        Map dimensionlengthrules = new HashMap< String, Object>();
        dimensionlengthrules.put("required", "false");
        dimensionlengthrules.put("minlength", "0");
        dimensionlengthrules.put("maxlength", "10,1");
        dimensionlengthrules.put("isemail", "false");
        dimensionlengthrules.put("isalphanumeric", "false");
        dimensionlengthrules.put("isnumeric", "false");
        dimensionlengthrules.put("isinteger", "false");
        dimensionlengthrules.put("lengthmessage", "Length should be between " + dimensionlengthrules.get("minlength") + " and " + dimensionlengthrules.get("maxlength") + " ");
        rules.put("dimensionlength", dimensionlengthrules);

        Map dimensionwidthrules = new HashMap< String, Object>();
        dimensionwidthrules.put("required", "false");
        dimensionwidthrules.put("minlength", "0");
        dimensionwidthrules.put("maxlength", "10,1");
        dimensionwidthrules.put("isemail", "false");
        dimensionwidthrules.put("isalphanumeric", "false");
        dimensionwidthrules.put("isnumeric", "false");
        dimensionwidthrules.put("isinteger", "false");
        dimensionwidthrules.put("lengthmessage", "Length should be between " + dimensionwidthrules.get("minlength") + " and " + dimensionwidthrules.get("maxlength") + " ");
        rules.put("dimensionwidth", dimensionwidthrules);

        Map dimensionthicknessrules = new HashMap< String, Object>();
        dimensionthicknessrules.put("required", "false");
        dimensionthicknessrules.put("minlength", "0");
        dimensionthicknessrules.put("maxlength", "10,1");
        dimensionthicknessrules.put("isemail", "false");
        dimensionthicknessrules.put("isalphanumeric", "false");
        dimensionthicknessrules.put("isnumeric", "false");
        dimensionthicknessrules.put("isinteger", "false");
        dimensionthicknessrules.put("lengthmessage", "Length should be between " + dimensionthicknessrules.get("minlength") + " and " + dimensionthicknessrules.get("maxlength") + " ");
        rules.put("dimensionthickness", dimensionthicknessrules);

        Map dimensionthicknessnumrules = new HashMap< String, Object>();
        dimensionthicknessnumrules.put("required", "false");
        dimensionthicknessnumrules.put("minlength", "0");
        dimensionthicknessnumrules.put("maxlength", "10,4");
        dimensionthicknessnumrules.put("isemail", "false");
        dimensionthicknessnumrules.put("isalphanumeric", "false");
        dimensionthicknessnumrules.put("isnumeric", "false");
        dimensionthicknessnumrules.put("isinteger", "false");
        dimensionthicknessnumrules.put("lengthmessage", "Length should be between " + dimensionthicknessnumrules.get("minlength") + " and " + dimensionthicknessnumrules.get("maxlength") + " ");
        rules.put("dimensionthicknessnum", dimensionthicknessnumrules);

        Map dimensionthicknessdenomrules = new HashMap< String, Object>();
        dimensionthicknessdenomrules.put("required", "false");
        dimensionthicknessdenomrules.put("minlength", "0");
        dimensionthicknessdenomrules.put("maxlength", "10,4");
        dimensionthicknessdenomrules.put("isemail", "false");
        dimensionthicknessdenomrules.put("isalphanumeric", "false");
        dimensionthicknessdenomrules.put("isnumeric", "false");
        dimensionthicknessdenomrules.put("isinteger", "false");
        dimensionthicknessdenomrules.put("lengthmessage", "Length should be between " + dimensionthicknessdenomrules.get("minlength") + " and " + dimensionthicknessdenomrules.get("maxlength") + " ");
        rules.put("dimensionthicknessdenom", dimensionthicknessdenomrules);

        Map dimensionlengthnumrules = new HashMap< String, Object>();
        dimensionlengthnumrules.put("required", "false");
        dimensionlengthnumrules.put("minlength", "0");
        dimensionlengthnumrules.put("maxlength", "10,1");
        dimensionlengthnumrules.put("isemail", "false");
        dimensionlengthnumrules.put("isalphanumeric", "false");
        dimensionlengthnumrules.put("isnumeric", "false");
        dimensionlengthnumrules.put("isinteger", "false");
        dimensionlengthnumrules.put("lengthmessage", "Length should be between " + dimensionlengthnumrules.get("minlength") + " and " + dimensionlengthnumrules.get("maxlength") + " ");
        rules.put("dimensionlengthnum", dimensionlengthnumrules);

        Map dimensionlengthdenomrules = new HashMap< String, Object>();
        dimensionlengthdenomrules.put("required", "false");
        dimensionlengthdenomrules.put("minlength", "0");
        dimensionlengthdenomrules.put("maxlength", "10,1");
        dimensionlengthdenomrules.put("isemail", "false");
        dimensionlengthdenomrules.put("isalphanumeric", "false");
        dimensionlengthdenomrules.put("isnumeric", "false");
        dimensionlengthdenomrules.put("isinteger", "false");
        dimensionlengthdenomrules.put("lengthmessage", "Length should be between " + dimensionlengthdenomrules.get("minlength") + " and " + dimensionlengthdenomrules.get("maxlength") + " ");
        rules.put("dimensionlengthdenom", dimensionlengthdenomrules);

        Map dimensionwidthnumrules = new HashMap< String, Object>();
        dimensionwidthnumrules.put("required", "false");
        dimensionwidthnumrules.put("minlength", "0");
        dimensionwidthnumrules.put("maxlength", "10,1");
        dimensionwidthnumrules.put("isemail", "false");
        dimensionwidthnumrules.put("isalphanumeric", "false");
        dimensionwidthnumrules.put("isnumeric", "false");
        dimensionwidthnumrules.put("isinteger", "false");
        dimensionwidthnumrules.put("lengthmessage", "Length should be between " + dimensionwidthnumrules.get("minlength") + " and " + dimensionwidthnumrules.get("maxlength") + " ");
        rules.put("dimensionwidthnum", dimensionwidthnumrules);

        Map dimensionwidthdenomrules = new HashMap< String, Object>();
        dimensionwidthdenomrules.put("required", "false");
        dimensionwidthdenomrules.put("minlength", "0");
        dimensionwidthdenomrules.put("maxlength", "10,1");
        dimensionwidthdenomrules.put("isemail", "false");
        dimensionwidthdenomrules.put("isalphanumeric", "false");
        dimensionwidthdenomrules.put("isnumeric", "false");
        dimensionwidthdenomrules.put("isinteger", "false");
        dimensionwidthdenomrules.put("lengthmessage", "Length should be between " + dimensionwidthdenomrules.get("minlength") + " and " + dimensionwidthdenomrules.get("maxlength") + " ");
        rules.put("dimensionwidthdenom", dimensionwidthdenomrules);

        Map ralnorules = new HashMap< String, Object>();
        ralnorules.put("required", "false");
        ralnorules.put("minlength", "0");
        ralnorules.put("maxlength", "50");
        ralnorules.put("isemail", "false");
        ralnorules.put("isalphanumeric", "false");
        ralnorules.put("isnumeric", "false");
        ralnorules.put("isinteger", "false");
        ralnorules.put("lengthmessage", "Length should be between " + ralnorules.get("minlength") + " and " + ralnorules.get("maxlength") + " ");
        rules.put("ralno", ralnorules);

        Map statusrules = new HashMap< String, Object>();
        statusrules.put("required", "false");
        statusrules.put("minlength", "0");
        statusrules.put("maxlength", "50");
        statusrules.put("isemail", "false");
        statusrules.put("isalphanumeric", "false");
        statusrules.put("isnumeric", "false");
        statusrules.put("isinteger", "false");
        statusrules.put("lengthmessage", "Length should be between " + statusrules.get("minlength") + " and " + statusrules.get("maxlength") + " ");
        rules.put("status", statusrules);

        return rules;
    }
}
