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
 * InvStockcount generated by hbm2java
 */
@Entity
@Table(name="inv_stockcount"
    ,catalog="vxsee"
)
public class InvStockcount  implements java.io.Serializable {


     private Integer stockcountId;
     private AllStatus allStatus;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByCreatebyId;
     private ConUser conUserByWritebyId;
     private String stockcountCode;
     private Date stockcountDate;
     private String description;
     private Date createdt;
     private Date writedt;
     private Set<InvStockcountLine> invStockcountLines = new HashSet<InvStockcountLine>(0);

    public InvStockcount() {
    }

	
    public InvStockcount(ConLife conLife) {
        this.conLife = conLife;
    }
    public InvStockcount(AllStatus allStatus, ConCompany conCompany, ConLife conLife, ConUser conUserByCreatebyId, ConUser conUserByWritebyId, String stockcountCode, Date stockcountDate, String description, Date createdt, Date writedt, Set<InvStockcountLine> invStockcountLines) {
       this.allStatus = allStatus;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.conUserByWritebyId = conUserByWritebyId;
       this.stockcountCode = stockcountCode;
       this.stockcountDate = stockcountDate;
       this.description = description;
       this.createdt = createdt;
       this.writedt = writedt;
       this.invStockcountLines = invStockcountLines;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="stockcount_id", unique=true, nullable=false)
    public Integer getStockcountId() {
        return this.stockcountId;
    }
    
    public void setStockcountId(Integer stockcountId) {
        this.stockcountId = stockcountId;
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

    
    @Column(name="stockcount_code", length=50)
    public String getStockcountCode() {
        return this.stockcountCode;
    }
    
    public void setStockcountCode(String stockcountCode) {
        this.stockcountCode = stockcountCode;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="stockcount_date", length=19)
    public Date getStockcountDate() {
        return this.stockcountDate;
    }
    
    public void setStockcountDate(Date stockcountDate) {
        this.stockcountDate = stockcountDate;
    }

    
    @Column(name="description", length=50)
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="invStockcount")
    public Set<InvStockcountLine> getInvStockcountLines() {
        return this.invStockcountLines;
    }
    
    public void setInvStockcountLines(Set<InvStockcountLine> invStockcountLines) {
        this.invStockcountLines = invStockcountLines;
    }




}


