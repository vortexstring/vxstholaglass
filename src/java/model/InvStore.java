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
 * InvStore generated by hbm2java
 */
@Entity
@Table(name="inv_store"
    ,catalog="vxsee"
)
public class InvStore  implements java.io.Serializable {


     private Integer storeId;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByWritebyId;
     private ConUser conUserByCreatebyId;
     private HrmEmployee hrmEmployee;
     private String storeName;
     private String storePhone;
     private String description;
     private Date createdt;
     private Date writedt;
     private Set<InvAdjustments> invAdjustmentses = new HashSet<InvAdjustments>(0);
     private Set<InvStockcountLine> invStockcountLines = new HashSet<InvStockcountLine>(0);
     private Set<InvGoodsreceivedLine> invGoodsreceivedLines = new HashSet<InvGoodsreceivedLine>(0);

    public InvStore() {
    }

	
    public InvStore(ConLife conLife, String description) {
        this.conLife = conLife;
        this.description = description;
    }
    public InvStore(ConCompany conCompany, ConLife conLife, ConUser conUserByWritebyId, ConUser conUserByCreatebyId, HrmEmployee hrmEmployee, String storeName, String storePhone, String description, Date createdt, Date writedt, Set<InvAdjustments> invAdjustmentses, Set<InvStockcountLine> invStockcountLines, Set<InvGoodsreceivedLine> invGoodsreceivedLines) {
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByWritebyId = conUserByWritebyId;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.hrmEmployee = hrmEmployee;
       this.storeName = storeName;
       this.storePhone = storePhone;
       this.description = description;
       this.createdt = createdt;
       this.writedt = writedt;
       this.invAdjustmentses = invAdjustmentses;
       this.invStockcountLines = invStockcountLines;
       this.invGoodsreceivedLines = invGoodsreceivedLines;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="store_id", unique=true, nullable=false)
    public Integer getStoreId() {
        return this.storeId;
    }
    
    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
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
    @JoinColumn(name="store_manager")
    public HrmEmployee getHrmEmployee() {
        return this.hrmEmployee;
    }
    
    public void setHrmEmployee(HrmEmployee hrmEmployee) {
        this.hrmEmployee = hrmEmployee;
    }

    
    @Column(name="store_name", length=20)
    public String getStoreName() {
        return this.storeName;
    }
    
    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    
    @Column(name="store_phone", length=50)
    public String getStorePhone() {
        return this.storePhone;
    }
    
    public void setStorePhone(String storePhone) {
        this.storePhone = storePhone;
    }

    
    @Column(name="description", nullable=false, length=50)
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="invStore")
    public Set<InvAdjustments> getInvAdjustmentses() {
        return this.invAdjustmentses;
    }
    
    public void setInvAdjustmentses(Set<InvAdjustments> invAdjustmentses) {
        this.invAdjustmentses = invAdjustmentses;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="invStore")
    public Set<InvStockcountLine> getInvStockcountLines() {
        return this.invStockcountLines;
    }
    
    public void setInvStockcountLines(Set<InvStockcountLine> invStockcountLines) {
        this.invStockcountLines = invStockcountLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="invStore")
    public Set<InvGoodsreceivedLine> getInvGoodsreceivedLines() {
        return this.invGoodsreceivedLines;
    }
    
    public void setInvGoodsreceivedLines(Set<InvGoodsreceivedLine> invGoodsreceivedLines) {
        this.invGoodsreceivedLines = invGoodsreceivedLines;
    }




}


