package model;
// Generated Feb 16, 2016 7:40:44 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * PrcSupplierQuotes generated by hbm2java
 */
@Entity
@Table(name="prc_supplier_quotes"
    ,catalog="vxsee"
)
public class PrcSupplierQuotes  implements java.io.Serializable {


     private Integer supplierQuoteId;
     private Date supplierQuoteDate;
     private Integer supplierId;
     private Integer itemHierachyLevelId;
     private Integer uomId;
     private BigDecimal pricePerUom;
     private Integer vatId;
     private BigDecimal minAmount;
     private BigDecimal maxAmount;
     private Integer life;
     private Integer createbyId;
     private Date createdt;
     private Integer writebyId;
     private Date writedt;
     private Integer companyId;

    public PrcSupplierQuotes() {
    }

	
    public PrcSupplierQuotes(Date supplierQuoteDate, BigDecimal pricePerUom, BigDecimal minAmount, BigDecimal maxAmount, Date createdt, Date writedt) {
        this.supplierQuoteDate = supplierQuoteDate;
        this.pricePerUom = pricePerUom;
        this.minAmount = minAmount;
        this.maxAmount = maxAmount;
        this.createdt = createdt;
        this.writedt = writedt;
    }
    public PrcSupplierQuotes(Date supplierQuoteDate, Integer supplierId, Integer itemHierachyLevelId, Integer uomId, BigDecimal pricePerUom, Integer vatId, BigDecimal minAmount, BigDecimal maxAmount, Integer life, Integer createbyId, Date createdt, Integer writebyId, Date writedt, Integer companyId) {
       this.supplierQuoteDate = supplierQuoteDate;
       this.supplierId = supplierId;
       this.itemHierachyLevelId = itemHierachyLevelId;
       this.uomId = uomId;
       this.pricePerUom = pricePerUom;
       this.vatId = vatId;
       this.minAmount = minAmount;
       this.maxAmount = maxAmount;
       this.life = life;
       this.createbyId = createbyId;
       this.createdt = createdt;
       this.writebyId = writebyId;
       this.writedt = writedt;
       this.companyId = companyId;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="supplier_quote_id", unique=true, nullable=false)
    public Integer getSupplierQuoteId() {
        return this.supplierQuoteId;
    }
    
    public void setSupplierQuoteId(Integer supplierQuoteId) {
        this.supplierQuoteId = supplierQuoteId;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="supplier_quote_date", nullable=false, length=10)
    public Date getSupplierQuoteDate() {
        return this.supplierQuoteDate;
    }
    
    public void setSupplierQuoteDate(Date supplierQuoteDate) {
        this.supplierQuoteDate = supplierQuoteDate;
    }

    
    @Column(name="supplier_id")
    public Integer getSupplierId() {
        return this.supplierId;
    }
    
    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    
    @Column(name="item_hierachy_level_id")
    public Integer getItemHierachyLevelId() {
        return this.itemHierachyLevelId;
    }
    
    public void setItemHierachyLevelId(Integer itemHierachyLevelId) {
        this.itemHierachyLevelId = itemHierachyLevelId;
    }

    
    @Column(name="uom_id")
    public Integer getUomId() {
        return this.uomId;
    }
    
    public void setUomId(Integer uomId) {
        this.uomId = uomId;
    }

    
    @Column(name="price_per_uom", nullable=false, precision=10, scale=4)
    public BigDecimal getPricePerUom() {
        return this.pricePerUom;
    }
    
    public void setPricePerUom(BigDecimal pricePerUom) {
        this.pricePerUom = pricePerUom;
    }

    
    @Column(name="vat_id")
    public Integer getVatId() {
        return this.vatId;
    }
    
    public void setVatId(Integer vatId) {
        this.vatId = vatId;
    }

    
    @Column(name="min_amount", nullable=false, precision=38, scale=20)
    public BigDecimal getMinAmount() {
        return this.minAmount;
    }
    
    public void setMinAmount(BigDecimal minAmount) {
        this.minAmount = minAmount;
    }

    
    @Column(name="max_amount", nullable=false, precision=38, scale=20)
    public BigDecimal getMaxAmount() {
        return this.maxAmount;
    }
    
    public void setMaxAmount(BigDecimal maxAmount) {
        this.maxAmount = maxAmount;
    }

    
    @Column(name="life")
    public Integer getLife() {
        return this.life;
    }
    
    public void setLife(Integer life) {
        this.life = life;
    }

    
    @Column(name="createby_id")
    public Integer getCreatebyId() {
        return this.createbyId;
    }
    
    public void setCreatebyId(Integer createbyId) {
        this.createbyId = createbyId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="createdt", nullable=false, length=19)
    public Date getCreatedt() {
        return this.createdt;
    }
    
    public void setCreatedt(Date createdt) {
        this.createdt = createdt;
    }

    
    @Column(name="writeby_id")
    public Integer getWritebyId() {
        return this.writebyId;
    }
    
    public void setWritebyId(Integer writebyId) {
        this.writebyId = writebyId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="writedt", nullable=false, length=19)
    public Date getWritedt() {
        return this.writedt;
    }
    
    public void setWritedt(Date writedt) {
        this.writedt = writedt;
    }

    
    @Column(name="company_id")
    public Integer getCompanyId() {
        return this.companyId;
    }
    
    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }




}


