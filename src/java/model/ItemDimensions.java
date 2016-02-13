package model;
// Generated Feb 16, 2016 7:40:44 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
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
 * ItemDimensions generated by hbm2java
 */
@Entity
@Table(name="item_dimensions"
    ,catalog="vxsee"
)
public class ItemDimensions  implements java.io.Serializable {


     private Integer itemDimensionId;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByCreatebyId;
     private ConUser conUserByWritebyId;
     private CrmUom crmUom;
     private Item item;
     private BigDecimal length;
     private BigDecimal lengthNum;
     private BigDecimal lengthDenom;
     private BigDecimal width;
     private BigDecimal widthNum;
     private BigDecimal widthDenom;
     private BigDecimal thickness;
     private BigDecimal thicknessNum;
     private BigDecimal thicknessDenom;
     private Date createdt;
     private Date writedt;

    public ItemDimensions() {
    }

	
    public ItemDimensions(BigDecimal length, BigDecimal lengthNum, BigDecimal lengthDenom, BigDecimal width, BigDecimal widthNum, BigDecimal widthDenom, BigDecimal thickness, BigDecimal thicknessNum, BigDecimal thicknessDenom) {
        this.length = length;
        this.lengthNum = lengthNum;
        this.lengthDenom = lengthDenom;
        this.width = width;
        this.widthNum = widthNum;
        this.widthDenom = widthDenom;
        this.thickness = thickness;
        this.thicknessNum = thicknessNum;
        this.thicknessDenom = thicknessDenom;
    }
    public ItemDimensions(ConCompany conCompany, ConLife conLife, ConUser conUserByCreatebyId, ConUser conUserByWritebyId, CrmUom crmUom, Item item, BigDecimal length, BigDecimal lengthNum, BigDecimal lengthDenom, BigDecimal width, BigDecimal widthNum, BigDecimal widthDenom, BigDecimal thickness, BigDecimal thicknessNum, BigDecimal thicknessDenom, Date createdt, Date writedt) {
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.conUserByWritebyId = conUserByWritebyId;
       this.crmUom = crmUom;
       this.item = item;
       this.length = length;
       this.lengthNum = lengthNum;
       this.lengthDenom = lengthDenom;
       this.width = width;
       this.widthNum = widthNum;
       this.widthDenom = widthDenom;
       this.thickness = thickness;
       this.thicknessNum = thicknessNum;
       this.thicknessDenom = thicknessDenom;
       this.createdt = createdt;
       this.writedt = writedt;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="item_dimension_id", unique=true, nullable=false)
    public Integer getItemDimensionId() {
        return this.itemDimensionId;
    }
    
    public void setItemDimensionId(Integer itemDimensionId) {
        this.itemDimensionId = itemDimensionId;
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

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="uom_id")
    public CrmUom getCrmUom() {
        return this.crmUom;
    }
    
    public void setCrmUom(CrmUom crmUom) {
        this.crmUom = crmUom;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_id")
    public Item getItem() {
        return this.item;
    }
    
    public void setItem(Item item) {
        this.item = item;
    }

    
    @Column(name="length", nullable=false, precision=10, scale=4)
    public BigDecimal getLength() {
        return this.length;
    }
    
    public void setLength(BigDecimal length) {
        this.length = length;
    }

    
    @Column(name="length_num", nullable=false, precision=10, scale=4)
    public BigDecimal getLengthNum() {
        return this.lengthNum;
    }
    
    public void setLengthNum(BigDecimal lengthNum) {
        this.lengthNum = lengthNum;
    }

    
    @Column(name="length_denom", nullable=false, precision=10, scale=4)
    public BigDecimal getLengthDenom() {
        return this.lengthDenom;
    }
    
    public void setLengthDenom(BigDecimal lengthDenom) {
        this.lengthDenom = lengthDenom;
    }

    
    @Column(name="width", nullable=false, precision=10, scale=4)
    public BigDecimal getWidth() {
        return this.width;
    }
    
    public void setWidth(BigDecimal width) {
        this.width = width;
    }

    
    @Column(name="width_num", nullable=false, precision=10, scale=4)
    public BigDecimal getWidthNum() {
        return this.widthNum;
    }
    
    public void setWidthNum(BigDecimal widthNum) {
        this.widthNum = widthNum;
    }

    
    @Column(name="width_denom", nullable=false, precision=10, scale=4)
    public BigDecimal getWidthDenom() {
        return this.widthDenom;
    }
    
    public void setWidthDenom(BigDecimal widthDenom) {
        this.widthDenom = widthDenom;
    }

    
    @Column(name="thickness", nullable=false, precision=10, scale=4)
    public BigDecimal getThickness() {
        return this.thickness;
    }
    
    public void setThickness(BigDecimal thickness) {
        this.thickness = thickness;
    }

    
    @Column(name="thickness_num", nullable=false, precision=10, scale=4)
    public BigDecimal getThicknessNum() {
        return this.thicknessNum;
    }
    
    public void setThicknessNum(BigDecimal thicknessNum) {
        this.thicknessNum = thicknessNum;
    }

    
    @Column(name="thickness_denom", nullable=false, precision=10, scale=4)
    public BigDecimal getThicknessDenom() {
        return this.thicknessDenom;
    }
    
    public void setThicknessDenom(BigDecimal thicknessDenom) {
        this.thicknessDenom = thicknessDenom;
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

