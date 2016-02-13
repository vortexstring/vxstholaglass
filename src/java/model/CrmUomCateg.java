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
 * CrmUomCateg generated by hbm2java
 */
@Entity
@Table(name="crm_uom_categ"
    ,catalog="vxsee"
)
public class CrmUomCateg  implements java.io.Serializable {


     private Integer uomCategId;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByCreatebyId;
     private ConUser conUserByWritebyId;
     private String uomCategName;
     private Date createdt;
     private Date writedt;
     private Set<CrmUom> crmUoms = new HashSet<CrmUom>(0);

    public CrmUomCateg() {
    }

	
    public CrmUomCateg(String uomCategName) {
        this.uomCategName = uomCategName;
    }
    public CrmUomCateg(ConCompany conCompany, ConLife conLife, ConUser conUserByCreatebyId, ConUser conUserByWritebyId, String uomCategName, Date createdt, Date writedt, Set<CrmUom> crmUoms) {
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.conUserByWritebyId = conUserByWritebyId;
       this.uomCategName = uomCategName;
       this.createdt = createdt;
       this.writedt = writedt;
       this.crmUoms = crmUoms;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="uom_categ_id", unique=true, nullable=false)
    public Integer getUomCategId() {
        return this.uomCategId;
    }
    
    public void setUomCategId(Integer uomCategId) {
        this.uomCategId = uomCategId;
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

    
    @Column(name="uom_categ_name", nullable=false, length=50)
    public String getUomCategName() {
        return this.uomCategName;
    }
    
    public void setUomCategName(String uomCategName) {
        this.uomCategName = uomCategName;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="crmUomCateg")
    public Set<CrmUom> getCrmUoms() {
        return this.crmUoms;
    }
    
    public void setCrmUoms(Set<CrmUom> crmUoms) {
        this.crmUoms = crmUoms;
    }




}


