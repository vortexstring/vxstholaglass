package model;
// Generated Feb 9, 2016 11:32:40 AM by Hibernate Tools 4.3.1


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
 * ItemSaleDimensions generated by hbm2java
 */
@Entity
@Table(name="item_sale_dimensions"
    ,catalog="vxsee"
)
public class ItemSaleDimensions  implements java.io.Serializable {


     private Integer itemDimensionId;
     private Item item;
     private Integer posLineId;
     private Integer quoteLineId;
     private Integer productionOrderLineId;
     private Integer jobcardLineId;
     private Integer salesOrderLineId;
     private BigDecimal length;
     private BigDecimal lengthNum;
     private BigDecimal lengthDenom;
     private BigDecimal width;
     private BigDecimal widthNum;
     private BigDecimal widthDenom;
     private BigDecimal thickness;
     private BigDecimal thicknessNum;
     private BigDecimal thicknessDenom;
     private int uomId;
     private int life;
     private Integer createbyId;
     private Date createdt;
     private Integer writebyId;
     private Date writedt;
     private Integer companyId;

    public ItemSaleDimensions() {
    }

	
    public ItemSaleDimensions(Item item, BigDecimal length, BigDecimal lengthNum, BigDecimal lengthDenom, BigDecimal width, BigDecimal widthNum, BigDecimal widthDenom, BigDecimal thickness, BigDecimal thicknessNum, BigDecimal thicknessDenom, int uomId, int life) {
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
        this.uomId = uomId;
        this.life = life;
    }
    public ItemSaleDimensions(Item item, Integer posLineId, Integer quoteLineId, Integer productionOrderLineId, Integer jobcardLineId, Integer salesOrderLineId, BigDecimal length, BigDecimal lengthNum, BigDecimal lengthDenom, BigDecimal width, BigDecimal widthNum, BigDecimal widthDenom, BigDecimal thickness, BigDecimal thicknessNum, BigDecimal thicknessDenom, int uomId, int life, Integer createbyId, Date createdt, Integer writebyId, Date writedt, Integer companyId) {
       this.item = item;
       this.posLineId = posLineId;
       this.quoteLineId = quoteLineId;
       this.productionOrderLineId = productionOrderLineId;
       this.jobcardLineId = jobcardLineId;
       this.salesOrderLineId = salesOrderLineId;
       this.length = length;
       this.lengthNum = lengthNum;
       this.lengthDenom = lengthDenom;
       this.width = width;
       this.widthNum = widthNum;
       this.widthDenom = widthDenom;
       this.thickness = thickness;
       this.thicknessNum = thicknessNum;
       this.thicknessDenom = thicknessDenom;
       this.uomId = uomId;
       this.life = life;
       this.createbyId = createbyId;
       this.createdt = createdt;
       this.writebyId = writebyId;
       this.writedt = writedt;
       this.companyId = companyId;
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
    @JoinColumn(name="item_id", nullable=false)
    public Item getItem() {
        return this.item;
    }
    
    public void setItem(Item item) {
        this.item = item;
    }

    
    @Column(name="pos_line_id")
    public Integer getPosLineId() {
        return this.posLineId;
    }
    
    public void setPosLineId(Integer posLineId) {
        this.posLineId = posLineId;
    }

    
    @Column(name="quote_line_id")
    public Integer getQuoteLineId() {
        return this.quoteLineId;
    }
    
    public void setQuoteLineId(Integer quoteLineId) {
        this.quoteLineId = quoteLineId;
    }

    
    @Column(name="production_order_line_id")
    public Integer getProductionOrderLineId() {
        return this.productionOrderLineId;
    }
    
    public void setProductionOrderLineId(Integer productionOrderLineId) {
        this.productionOrderLineId = productionOrderLineId;
    }

    
    @Column(name="jobcard_line_id")
    public Integer getJobcardLineId() {
        return this.jobcardLineId;
    }
    
    public void setJobcardLineId(Integer jobcardLineId) {
        this.jobcardLineId = jobcardLineId;
    }

    
    @Column(name="sales_order_line_id")
    public Integer getSalesOrderLineId() {
        return this.salesOrderLineId;
    }
    
    public void setSalesOrderLineId(Integer salesOrderLineId) {
        this.salesOrderLineId = salesOrderLineId;
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

    
    @Column(name="uom_id", nullable=false)
    public int getUomId() {
        return this.uomId;
    }
    
    public void setUomId(int uomId) {
        this.uomId = uomId;
    }

    
    @Column(name="life", nullable=false)
    public int getLife() {
        return this.life;
    }
    
    public void setLife(int life) {
        this.life = life;
    }

    
    @Column(name="createby_id")
    public Integer getCreatebyId() {
        return this.createbyId;
    }
    
    public void setCreatebyId(Integer createbyId) {
        this.createbyId = createbyId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="createdt", length=19)
    public Date getCreatedt() {
        return this.createdt;
    }
    
    public void setCreatedt(Date createdt) {
        this.createdt = createdt;
    }

    
    @Column(name="writeby_id")
    public Integer getWritebyId() {
        return this.writebyId;
    }
    
    public void setWritebyId(Integer writebyId) {
        this.writebyId = writebyId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="writedt", length=19)
    public Date getWritedt() {
        return this.writedt;
    }
    
    public void setWritedt(Date writedt) {
        this.writedt = writedt;
    }

    
    @Column(name="company_id")
    public Integer getCompanyId() {
        return this.companyId;
    }
    
    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }




}


