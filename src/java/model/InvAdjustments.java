package model;
// Generated Feb 9, 2016 11:32:40 AM by Hibernate Tools 4.3.1


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
 * InvAdjustments generated by hbm2java
 */
@Entity
@Table(name="inv_adjustments"
    ,catalog="vxsee"
)
public class InvAdjustments  implements java.io.Serializable {


     private Integer adjustmentId;
     private AllStatus allStatus;
     private CommonCombo commonCombo;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByWritebyId;
     private ConUser conUserByCreatebyId;
     private CrmUom crmUom;
     private InvStore invStore;
     private Item item;
     private String adjustmentCode;
     private Integer qty;
     private Integer units;
     private String adjustmentType;
     private String memo;
     private Date adjustmentDate;
     private Date createdt;
     private Date writedt;

    public InvAdjustments() {
    }

	
    public InvAdjustments(ConLife conLife) {
        this.conLife = conLife;
    }
    public InvAdjustments(AllStatus allStatus, CommonCombo commonCombo, ConCompany conCompany, ConLife conLife, ConUser conUserByWritebyId, ConUser conUserByCreatebyId, CrmUom crmUom, InvStore invStore, Item item, String adjustmentCode, Integer qty, Integer units, String adjustmentType, String memo, Date adjustmentDate, Date createdt, Date writedt) {
       this.allStatus = allStatus;
       this.commonCombo = commonCombo;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByWritebyId = conUserByWritebyId;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.crmUom = crmUom;
       this.invStore = invStore;
       this.item = item;
       this.adjustmentCode = adjustmentCode;
       this.qty = qty;
       this.units = units;
       this.adjustmentType = adjustmentType;
       this.memo = memo;
       this.adjustmentDate = adjustmentDate;
       this.createdt = createdt;
       this.writedt = writedt;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="adjustment_id", unique=true, nullable=false)
    public Integer getAdjustmentId() {
        return this.adjustmentId;
    }
    
    public void setAdjustmentId(Integer adjustmentId) {
        this.adjustmentId = adjustmentId;
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
    @JoinColumn(name="reason")
    public CommonCombo getCommonCombo() {
        return this.commonCombo;
    }
    
    public void setCommonCombo(CommonCombo commonCombo) {
        this.commonCombo = commonCombo;
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
    @JoinColumn(name="uom_id")
    public CrmUom getCrmUom() {
        return this.crmUom;
    }
    
    public void setCrmUom(CrmUom crmUom) {
        this.crmUom = crmUom;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="store_id")
    public InvStore getInvStore() {
        return this.invStore;
    }
    
    public void setInvStore(InvStore invStore) {
        this.invStore = invStore;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_id")
    public Item getItem() {
        return this.item;
    }
    
    public void setItem(Item item) {
        this.item = item;
    }

    
    @Column(name="adjustment_code", length=50)
    public String getAdjustmentCode() {
        return this.adjustmentCode;
    }
    
    public void setAdjustmentCode(String adjustmentCode) {
        this.adjustmentCode = adjustmentCode;
    }

    
    @Column(name="qty")
    public Integer getQty() {
        return this.qty;
    }
    
    public void setQty(Integer qty) {
        this.qty = qty;
    }

    
    @Column(name="units")
    public Integer getUnits() {
        return this.units;
    }
    
    public void setUnits(Integer units) {
        this.units = units;
    }

    
    @Column(name="adjustment_type", length=50)
    public String getAdjustmentType() {
        return this.adjustmentType;
    }
    
    public void setAdjustmentType(String adjustmentType) {
        this.adjustmentType = adjustmentType;
    }

    
    @Column(name="memo", length=50)
    public String getMemo() {
        return this.memo;
    }
    
    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="adjustment_date", length=10)
    public Date getAdjustmentDate() {
        return this.adjustmentDate;
    }
    
    public void setAdjustmentDate(Date adjustmentDate) {
        this.adjustmentDate = adjustmentDate;
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


