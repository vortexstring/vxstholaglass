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
 * ItemConfiguration generated by hbm2java
 */
@Entity
@Table(name="item_configuration"
    ,catalog="vxsee"
)
public class ItemConfiguration  implements java.io.Serializable {


     private Integer itemConfigurationId;
     private AllStatus allStatus;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByWritebyId;
     private ConUser conUserByCreatebyId;
     private String configurationName;
     private boolean hasColour;
     private boolean isPurchased;
     private boolean isProduction;
     private boolean isSold;
     private boolean hasDimensions;
     private boolean hasProductionTemplate;
     private Date createdt;
     private Date writedt;
     private Set<Item> items = new HashSet<Item>(0);

    public ItemConfiguration() {
    }

	
    public ItemConfiguration(boolean hasColour, boolean isPurchased, boolean isProduction, boolean isSold, boolean hasDimensions, boolean hasProductionTemplate) {
        this.hasColour = hasColour;
        this.isPurchased = isPurchased;
        this.isProduction = isProduction;
        this.isSold = isSold;
        this.hasDimensions = hasDimensions;
        this.hasProductionTemplate = hasProductionTemplate;
    }
    public ItemConfiguration(AllStatus allStatus, ConCompany conCompany, ConLife conLife, ConUser conUserByWritebyId, ConUser conUserByCreatebyId, String configurationName, boolean hasColour, boolean isPurchased, boolean isProduction, boolean isSold, boolean hasDimensions, boolean hasProductionTemplate, Date createdt, Date writedt, Set<Item> items) {
       this.allStatus = allStatus;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByWritebyId = conUserByWritebyId;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.configurationName = configurationName;
       this.hasColour = hasColour;
       this.isPurchased = isPurchased;
       this.isProduction = isProduction;
       this.isSold = isSold;
       this.hasDimensions = hasDimensions;
       this.hasProductionTemplate = hasProductionTemplate;
       this.createdt = createdt;
       this.writedt = writedt;
       this.items = items;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="item_configuration_id", unique=true, nullable=false)
    public Integer getItemConfigurationId() {
        return this.itemConfigurationId;
    }
    
    public void setItemConfigurationId(Integer itemConfigurationId) {
        this.itemConfigurationId = itemConfigurationId;
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

    
    @Column(name="configuration_name", length=50)
    public String getConfigurationName() {
        return this.configurationName;
    }
    
    public void setConfigurationName(String configurationName) {
        this.configurationName = configurationName;
    }

    
    @Column(name="has_colour", nullable=false)
    public boolean isHasColour() {
        return this.hasColour;
    }
    
    public void setHasColour(boolean hasColour) {
        this.hasColour = hasColour;
    }

    
    @Column(name="is_purchased", nullable=false)
    public boolean isIsPurchased() {
        return this.isPurchased;
    }
    
    public void setIsPurchased(boolean isPurchased) {
        this.isPurchased = isPurchased;
    }

    
    @Column(name="is_production", nullable=false)
    public boolean isIsProduction() {
        return this.isProduction;
    }
    
    public void setIsProduction(boolean isProduction) {
        this.isProduction = isProduction;
    }

    
    @Column(name="is_sold", nullable=false)
    public boolean isIsSold() {
        return this.isSold;
    }
    
    public void setIsSold(boolean isSold) {
        this.isSold = isSold;
    }

    
    @Column(name="has_dimensions", nullable=false)
    public boolean isHasDimensions() {
        return this.hasDimensions;
    }
    
    public void setHasDimensions(boolean hasDimensions) {
        this.hasDimensions = hasDimensions;
    }

    
    @Column(name="has_production_template", nullable=false)
    public boolean isHasProductionTemplate() {
        return this.hasProductionTemplate;
    }
    
    public void setHasProductionTemplate(boolean hasProductionTemplate) {
        this.hasProductionTemplate = hasProductionTemplate;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemConfiguration")
    public Set<Item> getItems() {
        return this.items;
    }
    
    public void setItems(Set<Item> items) {
        this.items = items;
    }




}

