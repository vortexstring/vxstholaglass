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
 * MfcJobcardLine generated by hbm2java
 */
@Entity
@Table(name="mfc_jobcard_line"
    ,catalog="vxsee"
)
public class MfcJobcardLine  implements java.io.Serializable {


     private Integer jobcardLineId;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByWritebyId;
     private ConUser conUserByCreatebyId;
     private CrmSalesorder crmSalesorder;
     private CrmUom crmUomByUomId;
     private CrmUom crmUomByDimensionUomId;
     private Item itemByItemId;
     private Item itemByItemServiceId;
     private ItemSale itemSale;
     private MfcJobcard mfcJobcard;
     private int qty;
     private BigDecimal uomQty;
     private Date qdate;
     private String memo;
     private BigDecimal dimensionLength;
     private BigDecimal dimensionWidth;
     private BigDecimal dimensionThickness;
     private BigDecimal dimensionLengthNum;
     private BigDecimal dimensionLengthDenom;
     private BigDecimal dimensionWidthNum;
     private BigDecimal dimensionWidthDenom;
     private String ralNo;
     private Date createdt;
     private Date writedt;

    public MfcJobcardLine() {
    }

	
    public MfcJobcardLine(int qty, BigDecimal uomQty, BigDecimal dimensionLengthNum, BigDecimal dimensionLengthDenom, BigDecimal dimensionWidthNum, BigDecimal dimensionWidthDenom) {
        this.qty = qty;
        this.uomQty = uomQty;
        this.dimensionLengthNum = dimensionLengthNum;
        this.dimensionLengthDenom = dimensionLengthDenom;
        this.dimensionWidthNum = dimensionWidthNum;
        this.dimensionWidthDenom = dimensionWidthDenom;
    }
    public MfcJobcardLine(ConCompany conCompany, ConLife conLife, ConUser conUserByWritebyId, ConUser conUserByCreatebyId, CrmSalesorder crmSalesorder, CrmUom crmUomByUomId, CrmUom crmUomByDimensionUomId, Item itemByItemId, Item itemByItemServiceId, ItemSale itemSale, MfcJobcard mfcJobcard, int qty, BigDecimal uomQty, Date qdate, String memo, BigDecimal dimensionLength, BigDecimal dimensionWidth, BigDecimal dimensionThickness, BigDecimal dimensionLengthNum, BigDecimal dimensionLengthDenom, BigDecimal dimensionWidthNum, BigDecimal dimensionWidthDenom, String ralNo, Date createdt, Date writedt) {
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByWritebyId = conUserByWritebyId;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.crmSalesorder = crmSalesorder;
       this.crmUomByUomId = crmUomByUomId;
       this.crmUomByDimensionUomId = crmUomByDimensionUomId;
       this.itemByItemId = itemByItemId;
       this.itemByItemServiceId = itemByItemServiceId;
       this.itemSale = itemSale;
       this.mfcJobcard = mfcJobcard;
       this.qty = qty;
       this.uomQty = uomQty;
       this.qdate = qdate;
       this.memo = memo;
       this.dimensionLength = dimensionLength;
       this.dimensionWidth = dimensionWidth;
       this.dimensionThickness = dimensionThickness;
       this.dimensionLengthNum = dimensionLengthNum;
       this.dimensionLengthDenom = dimensionLengthDenom;
       this.dimensionWidthNum = dimensionWidthNum;
       this.dimensionWidthDenom = dimensionWidthDenom;
       this.ralNo = ralNo;
       this.createdt = createdt;
       this.writedt = writedt;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="jobcard_line_id", unique=true, nullable=false)
    public Integer getJobcardLineId() {
        return this.jobcardLineId;
    }
    
    public void setJobcardLineId(Integer jobcardLineId) {
        this.jobcardLineId = jobcardLineId;
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
    @JoinColumn(name="salesorder_id")
    public CrmSalesorder getCrmSalesorder() {
        return this.crmSalesorder;
    }
    
    public void setCrmSalesorder(CrmSalesorder crmSalesorder) {
        this.crmSalesorder = crmSalesorder;
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
    @JoinColumn(name="item_id")
    public Item getItemByItemId() {
        return this.itemByItemId;
    }
    
    public void setItemByItemId(Item itemByItemId) {
        this.itemByItemId = itemByItemId;
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
    @JoinColumn(name="item_sale_id")
    public ItemSale getItemSale() {
        return this.itemSale;
    }
    
    public void setItemSale(ItemSale itemSale) {
        this.itemSale = itemSale;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="jobcard_id")
    public MfcJobcard getMfcJobcard() {
        return this.mfcJobcard;
    }
    
    public void setMfcJobcard(MfcJobcard mfcJobcard) {
        this.mfcJobcard = mfcJobcard;
    }

    
    @Column(name="qty", nullable=false)
    public int getQty() {
        return this.qty;
    }
    
    public void setQty(int qty) {
        this.qty = qty;
    }

    
    @Column(name="uom_qty", nullable=false, precision=10, scale=4)
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

    
    @Column(name="memo", length=65535)
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

    
    @Column(name="dimension_length_num", nullable=false, precision=10, scale=1)
    public BigDecimal getDimensionLengthNum() {
        return this.dimensionLengthNum;
    }
    
    public void setDimensionLengthNum(BigDecimal dimensionLengthNum) {
        this.dimensionLengthNum = dimensionLengthNum;
    }

    
    @Column(name="dimension_length_denom", nullable=false, precision=10, scale=1)
    public BigDecimal getDimensionLengthDenom() {
        return this.dimensionLengthDenom;
    }
    
    public void setDimensionLengthDenom(BigDecimal dimensionLengthDenom) {
        this.dimensionLengthDenom = dimensionLengthDenom;
    }

    
    @Column(name="dimension_width_num", nullable=false, precision=10, scale=1)
    public BigDecimal getDimensionWidthNum() {
        return this.dimensionWidthNum;
    }
    
    public void setDimensionWidthNum(BigDecimal dimensionWidthNum) {
        this.dimensionWidthNum = dimensionWidthNum;
    }

    
    @Column(name="dimension_width_denom", nullable=false, precision=10, scale=1)
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

