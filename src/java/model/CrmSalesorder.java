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
 * CrmSalesorder generated by hbm2java
 */
@Entity
@Table(name="crm_salesorder"
    ,catalog="vxsee"
)
public class CrmSalesorder  implements java.io.Serializable {


     private Integer salesorderId;
     private AllStatus allStatus;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByWritebyId;
     private ConUser conUserByCreatebyId;
     private ConUser conUserByApprovedby;
     private ConUser conUserByReviewedby;
     private CrmCustomer crmCustomer;
     private CrmPos crmPos;
     private CrmQuote crmQuote;
     private String salesorderCode;
     private Date salesorderDate;
     private BigDecimal totalPrice;
     private BigDecimal totalDiscount;
     private BigDecimal totalInterest;
     private Long amount;
     private BigDecimal totalVatableAmount;
     private BigDecimal vatAmount;
     private String ref;
     private String comment;
     private boolean closed;
     private Date reviewdt;
     private Date approvedt;
     private Date createdt;
     private Date writedt;
     private Set<CrmSalesinvoice> crmSalesinvoices = new HashSet<CrmSalesinvoice>(0);
     private Set<MfcJobcard> mfcJobcards = new HashSet<MfcJobcard>(0);
     private Set<CrmSalesinvoiceLine> crmSalesinvoiceLines = new HashSet<CrmSalesinvoiceLine>(0);
     private Set<CrmDelivery> crmDeliveries = new HashSet<CrmDelivery>(0);
     private Set<CrmSalesorderLine> crmSalesorderLines = new HashSet<CrmSalesorderLine>(0);
     private Set<MfcJobcardLine> mfcJobcardLines = new HashSet<MfcJobcardLine>(0);

    public CrmSalesorder() {
    }

	
    public CrmSalesorder(ConCompany conCompany, BigDecimal totalPrice, BigDecimal totalDiscount, BigDecimal totalInterest, BigDecimal totalVatableAmount, BigDecimal vatAmount, boolean closed) {
        this.conCompany = conCompany;
        this.totalPrice = totalPrice;
        this.totalDiscount = totalDiscount;
        this.totalInterest = totalInterest;
        this.totalVatableAmount = totalVatableAmount;
        this.vatAmount = vatAmount;
        this.closed = closed;
    }
    public CrmSalesorder(AllStatus allStatus, ConCompany conCompany, ConLife conLife, ConUser conUserByWritebyId, ConUser conUserByCreatebyId, ConUser conUserByApprovedby, ConUser conUserByReviewedby, CrmCustomer crmCustomer, CrmPos crmPos, CrmQuote crmQuote, String salesorderCode, Date salesorderDate, BigDecimal totalPrice, BigDecimal totalDiscount, BigDecimal totalInterest, Long amount, BigDecimal totalVatableAmount, BigDecimal vatAmount, String ref, String comment, boolean closed, Date reviewdt, Date approvedt, Date createdt, Date writedt, Set<CrmSalesinvoice> crmSalesinvoices, Set<MfcJobcard> mfcJobcards, Set<CrmSalesinvoiceLine> crmSalesinvoiceLines, Set<CrmDelivery> crmDeliveries, Set<CrmSalesorderLine> crmSalesorderLines, Set<MfcJobcardLine> mfcJobcardLines) {
       this.allStatus = allStatus;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByWritebyId = conUserByWritebyId;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.conUserByApprovedby = conUserByApprovedby;
       this.conUserByReviewedby = conUserByReviewedby;
       this.crmCustomer = crmCustomer;
       this.crmPos = crmPos;
       this.crmQuote = crmQuote;
       this.salesorderCode = salesorderCode;
       this.salesorderDate = salesorderDate;
       this.totalPrice = totalPrice;
       this.totalDiscount = totalDiscount;
       this.totalInterest = totalInterest;
       this.amount = amount;
       this.totalVatableAmount = totalVatableAmount;
       this.vatAmount = vatAmount;
       this.ref = ref;
       this.comment = comment;
       this.closed = closed;
       this.reviewdt = reviewdt;
       this.approvedt = approvedt;
       this.createdt = createdt;
       this.writedt = writedt;
       this.crmSalesinvoices = crmSalesinvoices;
       this.mfcJobcards = mfcJobcards;
       this.crmSalesinvoiceLines = crmSalesinvoiceLines;
       this.crmDeliveries = crmDeliveries;
       this.crmSalesorderLines = crmSalesorderLines;
       this.mfcJobcardLines = mfcJobcardLines;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="salesorder_id", unique=true, nullable=false)
    public Integer getSalesorderId() {
        return this.salesorderId;
    }
    
    public void setSalesorderId(Integer salesorderId) {
        this.salesorderId = salesorderId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="status_id")
    public AllStatus getAllStatus() {
        return this.allStatus;
    }
    
    public void setAllStatus(AllStatus allStatus) {
        this.allStatus = allStatus;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="company_id", nullable=false)
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
    @JoinColumn(name="approvedby")
    public ConUser getConUserByApprovedby() {
        return this.conUserByApprovedby;
    }
    
    public void setConUserByApprovedby(ConUser conUserByApprovedby) {
        this.conUserByApprovedby = conUserByApprovedby;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="reviewedby")
    public ConUser getConUserByReviewedby() {
        return this.conUserByReviewedby;
    }
    
    public void setConUserByReviewedby(ConUser conUserByReviewedby) {
        this.conUserByReviewedby = conUserByReviewedby;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="customer_id")
    public CrmCustomer getCrmCustomer() {
        return this.crmCustomer;
    }
    
    public void setCrmCustomer(CrmCustomer crmCustomer) {
        this.crmCustomer = crmCustomer;
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
    @JoinColumn(name="quote_id")
    public CrmQuote getCrmQuote() {
        return this.crmQuote;
    }
    
    public void setCrmQuote(CrmQuote crmQuote) {
        this.crmQuote = crmQuote;
    }

    
    @Column(name="salesorder_code", length=100)
    public String getSalesorderCode() {
        return this.salesorderCode;
    }
    
    public void setSalesorderCode(String salesorderCode) {
        this.salesorderCode = salesorderCode;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="salesorder_date", length=10)
    public Date getSalesorderDate() {
        return this.salesorderDate;
    }
    
    public void setSalesorderDate(Date salesorderDate) {
        this.salesorderDate = salesorderDate;
    }

    
    @Column(name="total_price", nullable=false, precision=10)
    public BigDecimal getTotalPrice() {
        return this.totalPrice;
    }
    
    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    
    @Column(name="total_discount", nullable=false, precision=10)
    public BigDecimal getTotalDiscount() {
        return this.totalDiscount;
    }
    
    public void setTotalDiscount(BigDecimal totalDiscount) {
        this.totalDiscount = totalDiscount;
    }

    
    @Column(name="total_interest", nullable=false, precision=10)
    public BigDecimal getTotalInterest() {
        return this.totalInterest;
    }
    
    public void setTotalInterest(BigDecimal totalInterest) {
        this.totalInterest = totalInterest;
    }

    
    @Column(name="amount", precision=10, scale=0)
    public Long getAmount() {
        return this.amount;
    }
    
    public void setAmount(Long amount) {
        this.amount = amount;
    }

    
    @Column(name="total_vatable_amount", nullable=false, precision=10)
    public BigDecimal getTotalVatableAmount() {
        return this.totalVatableAmount;
    }
    
    public void setTotalVatableAmount(BigDecimal totalVatableAmount) {
        this.totalVatableAmount = totalVatableAmount;
    }

    
    @Column(name="vat_amount", nullable=false, precision=10)
    public BigDecimal getVatAmount() {
        return this.vatAmount;
    }
    
    public void setVatAmount(BigDecimal vatAmount) {
        this.vatAmount = vatAmount;
    }

    
    @Column(name="ref", length=65535)
    public String getRef() {
        return this.ref;
    }
    
    public void setRef(String ref) {
        this.ref = ref;
    }

    
    @Column(name="comment", length=65535)
    public String getComment() {
        return this.comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }

    
    @Column(name="closed", nullable=false)
    public boolean isClosed() {
        return this.closed;
    }
    
    public void setClosed(boolean closed) {
        this.closed = closed;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="reviewdt", length=10)
    public Date getReviewdt() {
        return this.reviewdt;
    }
    
    public void setReviewdt(Date reviewdt) {
        this.reviewdt = reviewdt;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="approvedt", length=10)
    public Date getApprovedt() {
        return this.approvedt;
    }
    
    public void setApprovedt(Date approvedt) {
        this.approvedt = approvedt;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="crmSalesorder")
    public Set<CrmSalesinvoice> getCrmSalesinvoices() {
        return this.crmSalesinvoices;
    }
    
    public void setCrmSalesinvoices(Set<CrmSalesinvoice> crmSalesinvoices) {
        this.crmSalesinvoices = crmSalesinvoices;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="crmSalesorder")
    public Set<MfcJobcard> getMfcJobcards() {
        return this.mfcJobcards;
    }
    
    public void setMfcJobcards(Set<MfcJobcard> mfcJobcards) {
        this.mfcJobcards = mfcJobcards;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="crmSalesorder")
    public Set<CrmSalesinvoiceLine> getCrmSalesinvoiceLines() {
        return this.crmSalesinvoiceLines;
    }
    
    public void setCrmSalesinvoiceLines(Set<CrmSalesinvoiceLine> crmSalesinvoiceLines) {
        this.crmSalesinvoiceLines = crmSalesinvoiceLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="crmSalesorder")
    public Set<CrmDelivery> getCrmDeliveries() {
        return this.crmDeliveries;
    }
    
    public void setCrmDeliveries(Set<CrmDelivery> crmDeliveries) {
        this.crmDeliveries = crmDeliveries;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="crmSalesorder")
    public Set<CrmSalesorderLine> getCrmSalesorderLines() {
        return this.crmSalesorderLines;
    }
    
    public void setCrmSalesorderLines(Set<CrmSalesorderLine> crmSalesorderLines) {
        this.crmSalesorderLines = crmSalesorderLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="crmSalesorder")
    public Set<MfcJobcardLine> getMfcJobcardLines() {
        return this.mfcJobcardLines;
    }
    
    public void setMfcJobcardLines(Set<MfcJobcardLine> mfcJobcardLines) {
        this.mfcJobcardLines = mfcJobcardLines;
    }




}


