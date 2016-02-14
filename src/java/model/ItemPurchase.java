package model;
// Generated Feb 9, 2016 11:32:40 AM by Hibernate Tools 4.3.1


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
 * ItemPurchase generated by hbm2java
 */
@Entity
@Table(name="item_purchase"
    ,catalog="vxsee"
)
public class ItemPurchase  implements java.io.Serializable {


     private Integer itemPurchaseId;
     private AllCurrency allCurrency;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByCreatebyId;
     private ConUser conUserByWritebyId;
     private CrmUom crmUom;
     private FinVat finVat;
     private Item item;
     private PrcSuppliers prcSuppliers;
     private BigDecimal unitPrice;
     private Date effectiveFrom;
     private Date effectiveTo;
     private BigDecimal minQty;
     private BigDecimal maxQty;
     private Date createdt;
     private Date writedt;

    public ItemPurchase() {
    }

	
    public ItemPurchase(AllCurrency allCurrency, ConLife conLife, CrmUom crmUom, FinVat finVat, Item item, PrcSuppliers prcSuppliers, BigDecimal unitPrice, Date effectiveFrom, Date effectiveTo, BigDecimal minQty, BigDecimal maxQty) {
        this.allCurrency = allCurrency;
        this.conLife = conLife;
        this.crmUom = crmUom;
        this.finVat = finVat;
        this.item = item;
        this.prcSuppliers = prcSuppliers;
        this.unitPrice = unitPrice;
        this.effectiveFrom = effectiveFrom;
        this.effectiveTo = effectiveTo;
        this.minQty = minQty;
        this.maxQty = maxQty;
    }
    public ItemPurchase(AllCurrency allCurrency, ConCompany conCompany, ConLife conLife, ConUser conUserByCreatebyId, ConUser conUserByWritebyId, CrmUom crmUom, FinVat finVat, Item item, PrcSuppliers prcSuppliers, BigDecimal unitPrice, Date effectiveFrom, Date effectiveTo, BigDecimal minQty, BigDecimal maxQty, Date createdt, Date writedt) {
       this.allCurrency = allCurrency;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.conUserByWritebyId = conUserByWritebyId;
       this.crmUom = crmUom;
       this.finVat = finVat;
       this.item = item;
       this.prcSuppliers = prcSuppliers;
       this.unitPrice = unitPrice;
       this.effectiveFrom = effectiveFrom;
       this.effectiveTo = effectiveTo;
       this.minQty = minQty;
       this.maxQty = maxQty;
       this.createdt = createdt;
       this.writedt = writedt;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="item_purchase_id", unique=true, nullable=false)
    public Integer getItemPurchaseId() {
        return this.itemPurchaseId;
    }
    
    public void setItemPurchaseId(Integer itemPurchaseId) {
        this.itemPurchaseId = itemPurchaseId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="currency_id", nullable=false)
    public AllCurrency getAllCurrency() {
        return this.allCurrency;
    }
    
    public void setAllCurrency(AllCurrency allCurrency) {
        this.allCurrency = allCurrency;
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
    @JoinColumn(name="life", nullable=false)
    public ConLife getConLife() {
        return this.conLife;
    }
    
    public void setConLife(ConLife conLife) {
        this.conLife = conLife;
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
    @JoinColumn(name="writeby_id")
    public ConUser getConUserByWritebyId() {
        return this.conUserByWritebyId;
    }
    
    public void setConUserByWritebyId(ConUser conUserByWritebyId) {
        this.conUserByWritebyId = conUserByWritebyId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="uom_id", nullable=false)
    public CrmUom getCrmUom() {
        return this.crmUom;
    }
    
    public void setCrmUom(CrmUom crmUom) {
        this.crmUom = crmUom;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="vat_id", nullable=false)
    public FinVat getFinVat() {
        return this.finVat;
    }
    
    public void setFinVat(FinVat finVat) {
        this.finVat = finVat;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_id", nullable=false)
    public Item getItem() {
        return this.item;
    }
    
    public void setItem(Item item) {
        this.item = item;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="supplier_id", nullable=false)
    public PrcSuppliers getPrcSuppliers() {
        return this.prcSuppliers;
    }
    
    public void setPrcSuppliers(PrcSuppliers prcSuppliers) {
        this.prcSuppliers = prcSuppliers;
    }

    
    @Column(name="unit_price", nullable=false, precision=10, scale=4)
    public BigDecimal getUnitPrice() {
        return this.unitPrice;
    }
    
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="effective_from", nullable=false, length=10)
    public Date getEffectiveFrom() {
        return this.effectiveFrom;
    }
    
    public void setEffectiveFrom(Date effectiveFrom) {
        this.effectiveFrom = effectiveFrom;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="effective_to", nullable=false, length=10)
    public Date getEffectiveTo() {
        return this.effectiveTo;
    }
    
    public void setEffectiveTo(Date effectiveTo) {
        this.effectiveTo = effectiveTo;
    }

    
    @Column(name="min_qty", nullable=false, precision=10, scale=4)
    public BigDecimal getMinQty() {
        return this.minQty;
    }
    
    public void setMinQty(BigDecimal minQty) {
        this.minQty = minQty;
    }

    
    @Column(name="max_qty", nullable=false, precision=10, scale=4)
    public BigDecimal getMaxQty() {
        return this.maxQty;
    }
    
    public void setMaxQty(BigDecimal maxQty) {
        this.maxQty = maxQty;
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


