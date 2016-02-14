package model;
// Generated Feb 9, 2016 11:32:40 AM by Hibernate Tools 4.3.1


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
 * InvGoodsreceived generated by hbm2java
 */
@Entity
@Table(name="inv_goodsreceived"
    ,catalog="vxsee"
)
public class InvGoodsreceived  implements java.io.Serializable {


     private Integer grnId;
     private AllStatus allStatus;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByCreatebyId;
     private ConUser conUserByWritebyId;
     private PrcPurchaseOrder prcPurchaseOrder;
     private PrcSuppliers prcSuppliers;
     private String grnCode;
     private Date grnDate;
     private Date grnPrepareDate;
     private String grmMemo;
     private String grnRef;
     private String deliveryNo;
     private String batchNo;
     private Date deliverynoteDate;
     private String deliverynoteRef;
     private Date createdt;
     private Date writedt;
     private Set<InvGoodsreceivedLine> invGoodsreceivedLines = new HashSet<InvGoodsreceivedLine>(0);

    public InvGoodsreceived() {
    }

	
    public InvGoodsreceived(ConLife conLife) {
        this.conLife = conLife;
    }
    public InvGoodsreceived(AllStatus allStatus, ConCompany conCompany, ConLife conLife, ConUser conUserByCreatebyId, ConUser conUserByWritebyId, PrcPurchaseOrder prcPurchaseOrder, PrcSuppliers prcSuppliers, String grnCode, Date grnDate, Date grnPrepareDate, String grmMemo, String grnRef, String deliveryNo, String batchNo, Date deliverynoteDate, String deliverynoteRef, Date createdt, Date writedt, Set<InvGoodsreceivedLine> invGoodsreceivedLines) {
       this.allStatus = allStatus;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.conUserByWritebyId = conUserByWritebyId;
       this.prcPurchaseOrder = prcPurchaseOrder;
       this.prcSuppliers = prcSuppliers;
       this.grnCode = grnCode;
       this.grnDate = grnDate;
       this.grnPrepareDate = grnPrepareDate;
       this.grmMemo = grmMemo;
       this.grnRef = grnRef;
       this.deliveryNo = deliveryNo;
       this.batchNo = batchNo;
       this.deliverynoteDate = deliverynoteDate;
       this.deliverynoteRef = deliverynoteRef;
       this.createdt = createdt;
       this.writedt = writedt;
       this.invGoodsreceivedLines = invGoodsreceivedLines;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="grn_id", unique=true, nullable=false)
    public Integer getGrnId() {
        return this.grnId;
    }
    
    public void setGrnId(Integer grnId) {
        this.grnId = grnId;
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
    @JoinColumn(name="purchaseorder_id")
    public PrcPurchaseOrder getPrcPurchaseOrder() {
        return this.prcPurchaseOrder;
    }
    
    public void setPrcPurchaseOrder(PrcPurchaseOrder prcPurchaseOrder) {
        this.prcPurchaseOrder = prcPurchaseOrder;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="supplier_id")
    public PrcSuppliers getPrcSuppliers() {
        return this.prcSuppliers;
    }
    
    public void setPrcSuppliers(PrcSuppliers prcSuppliers) {
        this.prcSuppliers = prcSuppliers;
    }

    
    @Column(name="grn_code", length=50)
    public String getGrnCode() {
        return this.grnCode;
    }
    
    public void setGrnCode(String grnCode) {
        this.grnCode = grnCode;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="grn_date", length=10)
    public Date getGrnDate() {
        return this.grnDate;
    }
    
    public void setGrnDate(Date grnDate) {
        this.grnDate = grnDate;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="grn_prepare_date", length=10)
    public Date getGrnPrepareDate() {
        return this.grnPrepareDate;
    }
    
    public void setGrnPrepareDate(Date grnPrepareDate) {
        this.grnPrepareDate = grnPrepareDate;
    }

    
    @Column(name="grm_memo", length=50)
    public String getGrmMemo() {
        return this.grmMemo;
    }
    
    public void setGrmMemo(String grmMemo) {
        this.grmMemo = grmMemo;
    }

    
    @Column(name="grn_ref", length=50)
    public String getGrnRef() {
        return this.grnRef;
    }
    
    public void setGrnRef(String grnRef) {
        this.grnRef = grnRef;
    }

    
    @Column(name="delivery_no", length=50)
    public String getDeliveryNo() {
        return this.deliveryNo;
    }
    
    public void setDeliveryNo(String deliveryNo) {
        this.deliveryNo = deliveryNo;
    }

    
    @Column(name="batch_no", length=50)
    public String getBatchNo() {
        return this.batchNo;
    }
    
    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="deliverynote_date", length=19)
    public Date getDeliverynoteDate() {
        return this.deliverynoteDate;
    }
    
    public void setDeliverynoteDate(Date deliverynoteDate) {
        this.deliverynoteDate = deliverynoteDate;
    }

    
    @Column(name="deliverynote_ref", length=50)
    public String getDeliverynoteRef() {
        return this.deliverynoteRef;
    }
    
    public void setDeliverynoteRef(String deliverynoteRef) {
        this.deliverynoteRef = deliverynoteRef;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="invGoodsreceived")
    public Set<InvGoodsreceivedLine> getInvGoodsreceivedLines() {
        return this.invGoodsreceivedLines;
    }
    
    public void setInvGoodsreceivedLines(Set<InvGoodsreceivedLine> invGoodsreceivedLines) {
        this.invGoodsreceivedLines = invGoodsreceivedLines;
    }




}


