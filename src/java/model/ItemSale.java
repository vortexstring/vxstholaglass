package model;
// Generated Feb 9, 2016 11:32:40 AM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * ItemSale generated by hbm2java
 */
@Entity
@Table(name="item_sale"
    ,catalog="vxsee"
)
public class ItemSale  implements java.io.Serializable {


     private Integer itemSaleId;
     private AllCurrency allCurrency;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByWritebyId;
     private ConUser conUserByCreatebyId;
     private CrmUom crmUom;
     private FinVat finVat;
     private Item item;
     private BigDecimal unitPrice;
     private Date effectiveFrom;
     private Date effectiveTo;
     private BigDecimal minQty;
     private BigDecimal maxQty;
     private Date createdt;
     private Date writedt;
     private Set<CrmPosLine> crmPosLines = new HashSet<CrmPosLine>(0);
     private Set<CrmSalesorderLine> crmSalesorderLines = new HashSet<CrmSalesorderLine>(0);
     private Set<CrmDeliveryLine> crmDeliveryLines = new HashSet<CrmDeliveryLine>(0);
     private Set<CrmSalesinvoiceLine> crmSalesinvoiceLines = new HashSet<CrmSalesinvoiceLine>(0);
     private Set<MfcJobcardLine> mfcJobcardLines = new HashSet<MfcJobcardLine>(0);
     private Set<CrmQuoteLine> crmQuoteLines = new HashSet<CrmQuoteLine>(0);

    public ItemSale() {
    }

	
    public ItemSale(AllCurrency allCurrency, ConLife conLife, CrmUom crmUom, FinVat finVat, Item item, BigDecimal unitPrice, Date effectiveFrom, Date effectiveTo, BigDecimal minQty, BigDecimal maxQty) {
        this.allCurrency = allCurrency;
        this.conLife = conLife;
        this.crmUom = crmUom;
        this.finVat = finVat;
        this.item = item;
        this.unitPrice = unitPrice;
        this.effectiveFrom = effectiveFrom;
        this.effectiveTo = effectiveTo;
        this.minQty = minQty;
        this.maxQty = maxQty;
    }
    public ItemSale(AllCurrency allCurrency, ConCompany conCompany, ConLife conLife, ConUser conUserByWritebyId, ConUser conUserByCreatebyId, CrmUom crmUom, FinVat finVat, Item item, BigDecimal unitPrice, Date effectiveFrom, Date effectiveTo, BigDecimal minQty, BigDecimal maxQty, Date createdt, Date writedt, Set<CrmPosLine> crmPosLines, Set<CrmSalesorderLine> crmSalesorderLines, Set<CrmDeliveryLine> crmDeliveryLines, Set<CrmSalesinvoiceLine> crmSalesinvoiceLines, Set<MfcJobcardLine> mfcJobcardLines, Set<CrmQuoteLine> crmQuoteLines) {
       this.allCurrency = allCurrency;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByWritebyId = conUserByWritebyId;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.crmUom = crmUom;
       this.finVat = finVat;
       this.item = item;
       this.unitPrice = unitPrice;
       this.effectiveFrom = effectiveFrom;
       this.effectiveTo = effectiveTo;
       this.minQty = minQty;
       this.maxQty = maxQty;
       this.createdt = createdt;
       this.writedt = writedt;
       this.crmPosLines = crmPosLines;
       this.crmSalesorderLines = crmSalesorderLines;
       this.crmDeliveryLines = crmDeliveryLines;
       this.crmSalesinvoiceLines = crmSalesinvoiceLines;
       this.mfcJobcardLines = mfcJobcardLines;
       this.crmQuoteLines = crmQuoteLines;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="item_sale_id", unique=true, nullable=false)
    public Integer getItemSaleId() {
        return this.itemSaleId;
    }
    
    public void setItemSaleId(Integer itemSaleId) {
        this.itemSaleId = itemSaleId;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemSale")
    public Set<CrmPosLine> getCrmPosLines() {
        return this.crmPosLines;
    }
    
    public void setCrmPosLines(Set<CrmPosLine> crmPosLines) {
        this.crmPosLines = crmPosLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemSale")
    public Set<CrmSalesorderLine> getCrmSalesorderLines() {
        return this.crmSalesorderLines;
    }
    
    public void setCrmSalesorderLines(Set<CrmSalesorderLine> crmSalesorderLines) {
        this.crmSalesorderLines = crmSalesorderLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemSale")
    public Set<CrmDeliveryLine> getCrmDeliveryLines() {
        return this.crmDeliveryLines;
    }
    
    public void setCrmDeliveryLines(Set<CrmDeliveryLine> crmDeliveryLines) {
        this.crmDeliveryLines = crmDeliveryLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemSale")
    public Set<CrmSalesinvoiceLine> getCrmSalesinvoiceLines() {
        return this.crmSalesinvoiceLines;
    }
    
    public void setCrmSalesinvoiceLines(Set<CrmSalesinvoiceLine> crmSalesinvoiceLines) {
        this.crmSalesinvoiceLines = crmSalesinvoiceLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemSale")
    public Set<MfcJobcardLine> getMfcJobcardLines() {
        return this.mfcJobcardLines;
    }
    
    public void setMfcJobcardLines(Set<MfcJobcardLine> mfcJobcardLines) {
        this.mfcJobcardLines = mfcJobcardLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemSale")
    public Set<CrmQuoteLine> getCrmQuoteLines() {
        return this.crmQuoteLines;
    }
    
    public void setCrmQuoteLines(Set<CrmQuoteLine> crmQuoteLines) {
        this.crmQuoteLines = crmQuoteLines;
    }




}


