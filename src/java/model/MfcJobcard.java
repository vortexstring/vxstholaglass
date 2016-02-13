package model;
// Generated Feb 16, 2016 7:40:44 PM by Hibernate Tools 4.3.1


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
 * MfcJobcard generated by hbm2java
 */
@Entity
@Table(name="mfc_jobcard"
    ,catalog="vxsee"
)
public class MfcJobcard  implements java.io.Serializable {


     private Integer jobcardId;
     private AllStatus allStatus;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByApprovedby;
     private ConUser conUserByReviewedby;
     private ConUser conUserByWritebyId;
     private ConUser conUserByCreatebyId;
     private CrmCustomer crmCustomer;
     private CrmSalesorder crmSalesorder;
     private String jobcardCode;
     private Date jobcardDate;
     private String comment;
     private boolean closed;
     private Date reviewdt;
     private Date approvedt;
     private Date createdt;
     private Date writedt;
     private Set<MfcJobcardLine> mfcJobcardLines = new HashSet<MfcJobcardLine>(0);

    public MfcJobcard() {
    }

	
    public MfcJobcard(boolean closed) {
        this.closed = closed;
    }
    public MfcJobcard(AllStatus allStatus, ConCompany conCompany, ConLife conLife, ConUser conUserByApprovedby, ConUser conUserByReviewedby, ConUser conUserByWritebyId, ConUser conUserByCreatebyId, CrmCustomer crmCustomer, CrmSalesorder crmSalesorder, String jobcardCode, Date jobcardDate, String comment, boolean closed, Date reviewdt, Date approvedt, Date createdt, Date writedt, Set<MfcJobcardLine> mfcJobcardLines) {
       this.allStatus = allStatus;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByApprovedby = conUserByApprovedby;
       this.conUserByReviewedby = conUserByReviewedby;
       this.conUserByWritebyId = conUserByWritebyId;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.crmCustomer = crmCustomer;
       this.crmSalesorder = crmSalesorder;
       this.jobcardCode = jobcardCode;
       this.jobcardDate = jobcardDate;
       this.comment = comment;
       this.closed = closed;
       this.reviewdt = reviewdt;
       this.approvedt = approvedt;
       this.createdt = createdt;
       this.writedt = writedt;
       this.mfcJobcardLines = mfcJobcardLines;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="jobcard_id", unique=true, nullable=false)
    public Integer getJobcardId() {
        return this.jobcardId;
    }
    
    public void setJobcardId(Integer jobcardId) {
        this.jobcardId = jobcardId;
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
    @JoinColumn(name="customer_id")
    public CrmCustomer getCrmCustomer() {
        return this.crmCustomer;
    }
    
    public void setCrmCustomer(CrmCustomer crmCustomer) {
        this.crmCustomer = crmCustomer;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="salesorder_id")
    public CrmSalesorder getCrmSalesorder() {
        return this.crmSalesorder;
    }
    
    public void setCrmSalesorder(CrmSalesorder crmSalesorder) {
        this.crmSalesorder = crmSalesorder;
    }

    
    @Column(name="jobcard_code", length=100)
    public String getJobcardCode() {
        return this.jobcardCode;
    }
    
    public void setJobcardCode(String jobcardCode) {
        this.jobcardCode = jobcardCode;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="jobcard_date", length=10)
    public Date getJobcardDate() {
        return this.jobcardDate;
    }
    
    public void setJobcardDate(Date jobcardDate) {
        this.jobcardDate = jobcardDate;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="mfcJobcard")
    public Set<MfcJobcardLine> getMfcJobcardLines() {
        return this.mfcJobcardLines;
    }
    
    public void setMfcJobcardLines(Set<MfcJobcardLine> mfcJobcardLines) {
        this.mfcJobcardLines = mfcJobcardLines;
    }




}

