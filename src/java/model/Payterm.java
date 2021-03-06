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
 * Payterm generated by hbm2java
 */
@Entity
@Table(name="payterm"
    ,catalog="vxsee"
)
public class Payterm  implements java.io.Serializable {


     private Integer paytermId;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByCreatebyId;
     private ConUser conUserByWritebyId;
     private String paytermName;
     private String comments;
     private Date createdt;
     private Date writedt;
     private Set<PrcSuppliers> prcSupplierses = new HashSet<PrcSuppliers>(0);
     private Set<CrmCustomer> crmCustomers = new HashSet<CrmCustomer>(0);

    public Payterm() {
    }

    public Payterm(ConCompany conCompany, ConLife conLife, ConUser conUserByCreatebyId, ConUser conUserByWritebyId, String paytermName, String comments, Date createdt, Date writedt, Set<PrcSuppliers> prcSupplierses, Set<CrmCustomer> crmCustomers) {
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.conUserByWritebyId = conUserByWritebyId;
       this.paytermName = paytermName;
       this.comments = comments;
       this.createdt = createdt;
       this.writedt = writedt;
       this.prcSupplierses = prcSupplierses;
       this.crmCustomers = crmCustomers;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="payterm_id", unique=true, nullable=false)
    public Integer getPaytermId() {
        return this.paytermId;
    }
    
    public void setPaytermId(Integer paytermId) {
        this.paytermId = paytermId;
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

    
    @Column(name="payterm_name", length=50)
    public String getPaytermName() {
        return this.paytermName;
    }
    
    public void setPaytermName(String paytermName) {
        this.paytermName = paytermName;
    }

    
    @Column(name="comments", length=50)
    public String getComments() {
        return this.comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="payterm")
    public Set<PrcSuppliers> getPrcSupplierses() {
        return this.prcSupplierses;
    }
    
    public void setPrcSupplierses(Set<PrcSuppliers> prcSupplierses) {
        this.prcSupplierses = prcSupplierses;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="payterm")
    public Set<CrmCustomer> getCrmCustomers() {
        return this.crmCustomers;
    }
    
    public void setCrmCustomers(Set<CrmCustomer> crmCustomers) {
        this.crmCustomers = crmCustomers;
    }




}


