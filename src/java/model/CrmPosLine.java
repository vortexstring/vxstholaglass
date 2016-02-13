package model;
// Generated Feb 16, 2016 7:40:44 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * CrmPosLine generated by hbm2java
 */
@Entity
@Table(name="crm_pos_line"
    ,catalog="vxsee"
)
public class CrmPosLine  implements java.io.Serializable {


     private Integer posLineId;
     private AllStatus allStatus;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByWritebyId;
     private ConUser conUserByCreatebyId;
     private CrmPos crmPos;
     private CrmUom crmUomByUomId;
     private CrmUom crmUomByDimensionUomId;
     private Item itemByItemServiceId;
     private Item itemByItemId;
     private ItemSale itemSale;
     private BigDecimal price;
     private Integer qty;
     private BigDecimal discount;
     private BigDecimal interest;
     private BigDecimal percentDisc;
     private BigDecimal percentInt;
     private BigDecimal amount;
     private BigDecimal vatableAmount;
     private BigDecimal vatAmount;
     private BigDecimal uomQty;
     private Date qdate;
     private String memo;
     private BigDecimal dimensionLength;
     private BigDecimal dimensionWidth;
     private BigDecimal dimensionThickness;
     private BigDecimal dimensionThicknessNum;
     private BigDecimal dimensionThicknessDenom;
     private BigDecimal dimensionLengthNum;
     private BigDecimal dimensionLengthDenom;
     private BigDecimal dimensionWidthNum;
     private BigDecimal dimensionWidthDenom;
     private String ralNo;
     private Date createdt;
     private Date writedt;

    public CrmPosLine() {
    }

    public CrmPosLine(AllStatus allStatus, ConCompany conCompany, ConLife conLife, ConUser conUserByWritebyId, ConUser conUserByCreatebyId, CrmPos crmPos, CrmUom crmUomByUomId, CrmUom crmUomByDimensionUomId, Item itemByItemServiceId, Item itemByItemId, ItemSale itemSale, BigDecimal price, Integer qty, BigDecimal discount, BigDecimal interest, BigDecimal percentDisc, BigDecimal percentInt, BigDecimal amount, BigDecimal vatableAmount, BigDecimal vatAmount, BigDecimal uomQty, Date qdate, String memo, BigDecimal dimensionLength, BigDecimal dimensionWidth, BigDecimal dimensionThickness, BigDecimal dimensionThicknessNum, BigDecimal dimensionThicknessDenom, BigDecimal dimensionLengthNum, BigDecimal dimensionLengthDenom, BigDecimal dimensionWidthNum, BigDecimal dimensionWidthDenom, String ralNo, Date createdt, Date writedt) {
       this.allStatus = allStatus;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByWritebyId = conUserByWritebyId;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.crmPos = crmPos;
       this.crmUomByUomId = crmUomByUomId;
       this.crmUomByDimensionUomId = crmUomByDimensionUomId;
       this.itemByItemServiceId = itemByItemServiceId;
       this.itemByItemId = itemByItemId;
       this.itemSale = itemSale;
       this.price = price;
       this.qty = qty;
       this.discount = discount;
       this.interest = interest;
       this.percentDisc = percentDisc;
       this.percentInt = percentInt;
       this.amount = amount;
       this.vatableAmount = vatableAmount;
       this.vatAmount = vatAmount;
       this.uomQty = uomQty;
       this.qdate = qdate;
       this.memo = memo;
       this.dimensionLength = dimensionLength;
       this.dimensionWidth = dimensionWidth;
       this.dimensionThickness = dimensionThickness;
       this.dimensionThicknessNum = dimensionThicknessNum;
       this.dimensionThicknessDenom = dimensionThicknessDenom;
       this.dimensionLengthNum = dimensionLengthNum;
       this.dimensionLengthDenom = dimensionLengthDenom;
       this.dimensionWidthNum = dimensionWidthNum;
       this.dimensionWidthDenom = dimensionWidthDenom;
       this.ralNo = ralNo;
       this.createdt = createdt;
       this.writedt = writedt;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="pos_line_id", unique=true, nullable=false)
    public Integer getPosLineId() {
        return this.posLineId;
    }
    
    public void setPosLineId(Integer posLineId) {
        this.posLineId = posLineId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="status")
    public AllStatus getAllStatus() {
        return this.allStatus;
    }
    
    public void setAllStatus(AllStatus allStatus) {
        this.allStatus = allStatus;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="company_id")
    public ConCompany getConCompany() {
        return this.conCompany;
    }
    
    public void setConCompany(ConCompany conCompany) {
        this.conCompany = conCompany;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="life")
    public ConLife getConLife() {
        return this.conLife;
    }
    
    public void setConLife(ConLife conLife) {
        this.conLife = conLife;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="writeby_id")
    public ConUser getConUserByWritebyId() {
        return this.conUserByWritebyId;
    }
    
    public void setConUserByWritebyId(ConUser conUserByWritebyId) {
        this.conUserByWritebyId = conUserByWritebyId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="createby_id")
    public ConUser getConUserByCreatebyId() {
        return this.conUserByCreatebyId;
    }
    
    public void setConUserByCreatebyId(ConUser conUserByCreatebyId) {
        this.conUserByCreatebyId = conUserByCreatebyId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="pos_id")
    public CrmPos getCrmPos() {
        return this.crmPos;
    }
    
    public void setCrmPos(CrmPos crmPos) {
        this.crmPos = crmPos;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="uom_id")
    public CrmUom getCrmUomByUomId() {
        return this.crmUomByUomId;
    }
    
    public void setCrmUomByUomId(CrmUom crmUomByUomId) {
        this.crmUomByUomId = crmUomByUomId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="dimension_uom_id")
    public CrmUom getCrmUomByDimensionUomId() {
        return this.crmUomByDimensionUomId;
    }
    
    public void setCrmUomByDimensionUomId(CrmUom crmUomByDimensionUomId) {
        this.crmUomByDimensionUomId = crmUomByDimensionUomId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_service_id")
    public Item getItemByItemServiceId() {
        return this.itemByItemServiceId;
    }
    
    public void setItemByItemServiceId(Item itemByItemServiceId) {
        this.itemByItemServiceId = itemByItemServiceId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_id")
    public Item getItemByItemId() {
        return this.itemByItemId;
    }
    
    public void setItemByItemId(Item itemByItemId) {
        this.itemByItemId = itemByItemId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_sale_id")
    public ItemSale getItemSale() {
        return this.itemSale;
    }
    
    public void setItemSale(ItemSale itemSale) {
        this.itemSale = itemSale;
    }

    
    @Column(name="price", precision=10)
    public BigDecimal getPrice() {
        return this.price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    
    @Column(name="qty")
    public Integer getQty() {
        return this.qty;
    }
    
    public void setQty(Integer qty) {
        this.qty = qty;
    }

    
    @Column(name="discount", precision=10)
    public BigDecimal getDiscount() {
        return this.discount;
    }
    
    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
    }

    
    @Column(name="interest", precision=10)
    public BigDecimal getInterest() {
        return this.interest;
    }
    
    public void setInterest(BigDecimal interest) {
        this.interest = interest;
    }

    
    @Column(name="percent_disc", precision=10, scale=4)
    public BigDecimal getPercentDisc() {
        return this.percentDisc;
    }
    
    public void setPercentDisc(BigDecimal percentDisc) {
        this.percentDisc = percentDisc;
    }

    
    @Column(name="percent_int", precision=10, scale=4)
    public BigDecimal getPercentInt() {
        return this.percentInt;
    }
    
    public void setPercentInt(BigDecimal percentInt) {
        this.percentInt = percentInt;
    }

    
    @Column(name="amount", precision=10)
    public BigDecimal getAmount() {
        return this.amount;
    }
    
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    
    @Column(name="vatable_amount", precision=10)
    public BigDecimal getVatableAmount() {
        return this.vatableAmount;
    }
    
    public void setVatableAmount(BigDecimal vatableAmount) {
        this.vatableAmount = vatableAmount;
    }

    
    @Column(name="vat_amount", precision=10)
    public BigDecimal getVatAmount() {
        return this.vatAmount;
    }
    
    public void setVatAmount(BigDecimal vatAmount) {
        this.vatAmount = vatAmount;
    }

    
    @Column(name="uom_qty", precision=10, scale=4)
    public BigDecimal getUomQty() {
        return this.uomQty;
    }
    
    public void setUomQty(BigDecimal uomQty) {
        this.uomQty = uomQty;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="qdate", length=10)
    public Date getQdate() {
        return this.qdate;
    }
    
    public void setQdate(Date qdate) {
        this.qdate = qdate;
    }

    
    @Column(name="memo", length=50)
    public String getMemo() {
        return this.memo;
    }
    
    public void setMemo(String memo) {
        this.memo = memo;
    }

    
    @Column(name="dimension_length", precision=10, scale=1)
    public BigDecimal getDimensionLength() {
        return this.dimensionLength;
    }
    
    public void setDimensionLength(BigDecimal dimensionLength) {
        this.dimensionLength = dimensionLength;
    }

    
    @Column(name="dimension_width", precision=10, scale=1)
    public BigDecimal getDimensionWidth() {
        return this.dimensionWidth;
    }
    
    public void setDimensionWidth(BigDecimal dimensionWidth) {
        this.dimensionWidth = dimensionWidth;
    }

    
    @Column(name="dimension_thickness", precision=10, scale=1)
    public BigDecimal getDimensionThickness() {
        return this.dimensionThickness;
    }
    
    public void setDimensionThickness(BigDecimal dimensionThickness) {
        this.dimensionThickness = dimensionThickness;
    }

    
    @Column(name="dimension_thickness_num", precision=10, scale=4)
    public BigDecimal getDimensionThicknessNum() {
        return this.dimensionThicknessNum;
    }
    
    public void setDimensionThicknessNum(BigDecimal dimensionThicknessNum) {
        this.dimensionThicknessNum = dimensionThicknessNum;
    }

    
    @Column(name="dimension_thickness_denom", precision=10, scale=4)
    public BigDecimal getDimensionThicknessDenom() {
        return this.dimensionThicknessDenom;
    }
    
    public void setDimensionThicknessDenom(BigDecimal dimensionThicknessDenom) {
        this.dimensionThicknessDenom = dimensionThicknessDenom;
    }

    
    @Column(name="dimension_length_num", precision=10, scale=1)
    public BigDecimal getDimensionLengthNum() {
        return this.dimensionLengthNum;
    }
    
    public void setDimensionLengthNum(BigDecimal dimensionLengthNum) {
        this.dimensionLengthNum = dimensionLengthNum;
    }

    
    @Column(name="dimension_length_denom", precision=10, scale=1)
    public BigDecimal getDimensionLengthDenom() {
        return this.dimensionLengthDenom;
    }
    
    public void setDimensionLengthDenom(BigDecimal dimensionLengthDenom) {
        this.dimensionLengthDenom = dimensionLengthDenom;
    }

    
    @Column(name="dimension_width_num", precision=10, scale=1)
    public BigDecimal getDimensionWidthNum() {
        return this.dimensionWidthNum;
    }
    
    public void setDimensionWidthNum(BigDecimal dimensionWidthNum) {
        this.dimensionWidthNum = dimensionWidthNum;
    }

    
    @Column(name="dimension_width_denom", precision=10, scale=1)
    public BigDecimal getDimensionWidthDenom() {
        return this.dimensionWidthDenom;
    }
    
    public void setDimensionWidthDenom(BigDecimal dimensionWidthDenom) {
        this.dimensionWidthDenom = dimensionWidthDenom;
    }

    
    @Column(name="ral_no", length=50)
    public String getRalNo() {
        return this.ralNo;
    }
    
    public void setRalNo(String ralNo) {
        this.ralNo = ralNo;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="createdt", length=19)
    public Date getCreatedt() {
        return this.createdt;
    }
    
    public void setCreatedt(Date createdt) {
        this.createdt = createdt;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="writedt", length=19)
    public Date getWritedt() {
        return this.writedt;
    }
    
    public void setWritedt(Date writedt) {
        this.writedt = writedt;
    }




}


