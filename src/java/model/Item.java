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
 * Item generated by hbm2java
 */
@Entity
@Table(name="item"
    ,catalog="vxsee"
)
public class Item  implements java.io.Serializable {


     private Integer itemId;
     private AllStatus allStatus;
     private ConCompany conCompany;
     private ConLife conLife;
     private ConUser conUserByCreatebyId;
     private ConUser conUserByWritebyId;
     private Item item;
     private ItemConfiguration itemConfiguration;
     private ItemLevel itemLevel;
     private String itemCode;
     private String itemName;
     private String itemIcon;
     private Integer itemSort;
     private Date createdt;
     private Date writedt;
     private Set<InvStockcountLine> invStockcountLines = new HashSet<InvStockcountLine>(0);
     private Set<PurchaseRequisitionLine> purchaseRequisitionLines = new HashSet<PurchaseRequisitionLine>(0);
     private Set<CrmPosLine> crmPosLinesForItemServiceId = new HashSet<CrmPosLine>(0);
     private Set<CrmSalesinvoiceLine> crmSalesinvoiceLinesForItemId = new HashSet<CrmSalesinvoiceLine>(0);
     private Set<CrmPosLine> crmPosLinesForItemId = new HashSet<CrmPosLine>(0);
     private Set<CrmQuoteLine> crmQuoteLinesForItemServiceId = new HashSet<CrmQuoteLine>(0);
     private Set<CrmQuoteLine> crmQuoteLinesForItemId = new HashSet<CrmQuoteLine>(0);
     private Set<PoDtl> poDtls = new HashSet<PoDtl>(0);
     private Set<CrmSalesorderLine> crmSalesorderLinesForItemId = new HashSet<CrmSalesorderLine>(0);
     private Set<CrmSalesorderLine> crmSalesorderLinesForItemServiceId = new HashSet<CrmSalesorderLine>(0);
     private Set<Item> items = new HashSet<Item>(0);
     private Set<ItemDimensions> itemDimensionses = new HashSet<ItemDimensions>(0);
     private Set<MfcJobcardLine> mfcJobcardLinesForItemId = new HashSet<MfcJobcardLine>(0);
     private Set<MfcJobcardLine> mfcJobcardLinesForItemServiceId = new HashSet<MfcJobcardLine>(0);
     private Set<ItemPurchase> itemPurchases = new HashSet<ItemPurchase>(0);
     private Set<PrcPurchaseOrderLine> prcPurchaseOrderLines = new HashSet<PrcPurchaseOrderLine>(0);
     private Set<CrmSalesinvoiceLine> crmSalesinvoiceLinesForItemServiceId = new HashSet<CrmSalesinvoiceLine>(0);
     private Set<InvAdjustments> invAdjustmentses = new HashSet<InvAdjustments>(0);
     private Set<ItemColour> itemColours = new HashSet<ItemColour>(0);
     private Set<ItemSaleDimensions> itemSaleDimensionses = new HashSet<ItemSaleDimensions>(0);
     private Set<InvGoodsreceivedLine> invGoodsreceivedLines = new HashSet<InvGoodsreceivedLine>(0);
     private Set<CrmDeliveryLine> crmDeliveryLinesForItemId = new HashSet<CrmDeliveryLine>(0);
     private Set<CrmDeliveryLine> crmDeliveryLinesForItemServiceId = new HashSet<CrmDeliveryLine>(0);
     private Set<ItemSale> itemSales = new HashSet<ItemSale>(0);
     private Set<ItemCustomPrices> itemCustomPriceses = new HashSet<ItemCustomPrices>(0);

    public Item() {
    }

    public Item(AllStatus allStatus, ConCompany conCompany, ConLife conLife, ConUser conUserByCreatebyId, ConUser conUserByWritebyId, Item item, ItemConfiguration itemConfiguration, ItemLevel itemLevel, String itemCode, String itemName, String itemIcon, Integer itemSort, Date createdt, Date writedt, Set<InvStockcountLine> invStockcountLines, Set<PurchaseRequisitionLine> purchaseRequisitionLines, Set<CrmPosLine> crmPosLinesForItemServiceId, Set<CrmSalesinvoiceLine> crmSalesinvoiceLinesForItemId, Set<CrmPosLine> crmPosLinesForItemId, Set<CrmQuoteLine> crmQuoteLinesForItemServiceId, Set<CrmQuoteLine> crmQuoteLinesForItemId, Set<PoDtl> poDtls, Set<CrmSalesorderLine> crmSalesorderLinesForItemId, Set<CrmSalesorderLine> crmSalesorderLinesForItemServiceId, Set<Item> items, Set<ItemDimensions> itemDimensionses, Set<MfcJobcardLine> mfcJobcardLinesForItemId, Set<MfcJobcardLine> mfcJobcardLinesForItemServiceId, Set<ItemPurchase> itemPurchases, Set<PrcPurchaseOrderLine> prcPurchaseOrderLines, Set<CrmSalesinvoiceLine> crmSalesinvoiceLinesForItemServiceId, Set<InvAdjustments> invAdjustmentses, Set<ItemColour> itemColours, Set<ItemSaleDimensions> itemSaleDimensionses, Set<InvGoodsreceivedLine> invGoodsreceivedLines, Set<CrmDeliveryLine> crmDeliveryLinesForItemId, Set<CrmDeliveryLine> crmDeliveryLinesForItemServiceId, Set<ItemSale> itemSales, Set<ItemCustomPrices> itemCustomPriceses) {
       this.allStatus = allStatus;
       this.conCompany = conCompany;
       this.conLife = conLife;
       this.conUserByCreatebyId = conUserByCreatebyId;
       this.conUserByWritebyId = conUserByWritebyId;
       this.item = item;
       this.itemConfiguration = itemConfiguration;
       this.itemLevel = itemLevel;
       this.itemCode = itemCode;
       this.itemName = itemName;
       this.itemIcon = itemIcon;
       this.itemSort = itemSort;
       this.createdt = createdt;
       this.writedt = writedt;
       this.invStockcountLines = invStockcountLines;
       this.purchaseRequisitionLines = purchaseRequisitionLines;
       this.crmPosLinesForItemServiceId = crmPosLinesForItemServiceId;
       this.crmSalesinvoiceLinesForItemId = crmSalesinvoiceLinesForItemId;
       this.crmPosLinesForItemId = crmPosLinesForItemId;
       this.crmQuoteLinesForItemServiceId = crmQuoteLinesForItemServiceId;
       this.crmQuoteLinesForItemId = crmQuoteLinesForItemId;
       this.poDtls = poDtls;
       this.crmSalesorderLinesForItemId = crmSalesorderLinesForItemId;
       this.crmSalesorderLinesForItemServiceId = crmSalesorderLinesForItemServiceId;
       this.items = items;
       this.itemDimensionses = itemDimensionses;
       this.mfcJobcardLinesForItemId = mfcJobcardLinesForItemId;
       this.mfcJobcardLinesForItemServiceId = mfcJobcardLinesForItemServiceId;
       this.itemPurchases = itemPurchases;
       this.prcPurchaseOrderLines = prcPurchaseOrderLines;
       this.crmSalesinvoiceLinesForItemServiceId = crmSalesinvoiceLinesForItemServiceId;
       this.invAdjustmentses = invAdjustmentses;
       this.itemColours = itemColours;
       this.itemSaleDimensionses = itemSaleDimensionses;
       this.invGoodsreceivedLines = invGoodsreceivedLines;
       this.crmDeliveryLinesForItemId = crmDeliveryLinesForItemId;
       this.crmDeliveryLinesForItemServiceId = crmDeliveryLinesForItemServiceId;
       this.itemSales = itemSales;
       this.itemCustomPriceses = itemCustomPriceses;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="item_id", unique=true, nullable=false)
    public Integer getItemId() {
        return this.itemId;
    }
    
    public void setItemId(Integer itemId) {
        this.itemId = itemId;
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
    @JoinColumn(name="parent_id")
    public Item getItem() {
        return this.item;
    }
    
    public void setItem(Item item) {
        this.item = item;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_configuration_id")
    public ItemConfiguration getItemConfiguration() {
        return this.itemConfiguration;
    }
    
    public void setItemConfiguration(ItemConfiguration itemConfiguration) {
        this.itemConfiguration = itemConfiguration;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="item_level_id")
    public ItemLevel getItemLevel() {
        return this.itemLevel;
    }
    
    public void setItemLevel(ItemLevel itemLevel) {
        this.itemLevel = itemLevel;
    }

    
    @Column(name="item_code", length=50)
    public String getItemCode() {
        return this.itemCode;
    }
    
    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    
    @Column(name="item_name", length=50)
    public String getItemName() {
        return this.itemName;
    }
    
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    
    @Column(name="item_icon", length=50)
    public String getItemIcon() {
        return this.itemIcon;
    }
    
    public void setItemIcon(String itemIcon) {
        this.itemIcon = itemIcon;
    }

    
    @Column(name="item_sort")
    public Integer getItemSort() {
        return this.itemSort;
    }
    
    public void setItemSort(Integer itemSort) {
        this.itemSort = itemSort;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<InvStockcountLine> getInvStockcountLines() {
        return this.invStockcountLines;
    }
    
    public void setInvStockcountLines(Set<InvStockcountLine> invStockcountLines) {
        this.invStockcountLines = invStockcountLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<PurchaseRequisitionLine> getPurchaseRequisitionLines() {
        return this.purchaseRequisitionLines;
    }
    
    public void setPurchaseRequisitionLines(Set<PurchaseRequisitionLine> purchaseRequisitionLines) {
        this.purchaseRequisitionLines = purchaseRequisitionLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemServiceId")
    public Set<CrmPosLine> getCrmPosLinesForItemServiceId() {
        return this.crmPosLinesForItemServiceId;
    }
    
    public void setCrmPosLinesForItemServiceId(Set<CrmPosLine> crmPosLinesForItemServiceId) {
        this.crmPosLinesForItemServiceId = crmPosLinesForItemServiceId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemId")
    public Set<CrmSalesinvoiceLine> getCrmSalesinvoiceLinesForItemId() {
        return this.crmSalesinvoiceLinesForItemId;
    }
    
    public void setCrmSalesinvoiceLinesForItemId(Set<CrmSalesinvoiceLine> crmSalesinvoiceLinesForItemId) {
        this.crmSalesinvoiceLinesForItemId = crmSalesinvoiceLinesForItemId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemId")
    public Set<CrmPosLine> getCrmPosLinesForItemId() {
        return this.crmPosLinesForItemId;
    }
    
    public void setCrmPosLinesForItemId(Set<CrmPosLine> crmPosLinesForItemId) {
        this.crmPosLinesForItemId = crmPosLinesForItemId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemServiceId")
    public Set<CrmQuoteLine> getCrmQuoteLinesForItemServiceId() {
        return this.crmQuoteLinesForItemServiceId;
    }
    
    public void setCrmQuoteLinesForItemServiceId(Set<CrmQuoteLine> crmQuoteLinesForItemServiceId) {
        this.crmQuoteLinesForItemServiceId = crmQuoteLinesForItemServiceId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemId")
    public Set<CrmQuoteLine> getCrmQuoteLinesForItemId() {
        return this.crmQuoteLinesForItemId;
    }
    
    public void setCrmQuoteLinesForItemId(Set<CrmQuoteLine> crmQuoteLinesForItemId) {
        this.crmQuoteLinesForItemId = crmQuoteLinesForItemId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<PoDtl> getPoDtls() {
        return this.poDtls;
    }
    
    public void setPoDtls(Set<PoDtl> poDtls) {
        this.poDtls = poDtls;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemId")
    public Set<CrmSalesorderLine> getCrmSalesorderLinesForItemId() {
        return this.crmSalesorderLinesForItemId;
    }
    
    public void setCrmSalesorderLinesForItemId(Set<CrmSalesorderLine> crmSalesorderLinesForItemId) {
        this.crmSalesorderLinesForItemId = crmSalesorderLinesForItemId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemServiceId")
    public Set<CrmSalesorderLine> getCrmSalesorderLinesForItemServiceId() {
        return this.crmSalesorderLinesForItemServiceId;
    }
    
    public void setCrmSalesorderLinesForItemServiceId(Set<CrmSalesorderLine> crmSalesorderLinesForItemServiceId) {
        this.crmSalesorderLinesForItemServiceId = crmSalesorderLinesForItemServiceId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<Item> getItems() {
        return this.items;
    }
    
    public void setItems(Set<Item> items) {
        this.items = items;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<ItemDimensions> getItemDimensionses() {
        return this.itemDimensionses;
    }
    
    public void setItemDimensionses(Set<ItemDimensions> itemDimensionses) {
        this.itemDimensionses = itemDimensionses;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemId")
    public Set<MfcJobcardLine> getMfcJobcardLinesForItemId() {
        return this.mfcJobcardLinesForItemId;
    }
    
    public void setMfcJobcardLinesForItemId(Set<MfcJobcardLine> mfcJobcardLinesForItemId) {
        this.mfcJobcardLinesForItemId = mfcJobcardLinesForItemId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemServiceId")
    public Set<MfcJobcardLine> getMfcJobcardLinesForItemServiceId() {
        return this.mfcJobcardLinesForItemServiceId;
    }
    
    public void setMfcJobcardLinesForItemServiceId(Set<MfcJobcardLine> mfcJobcardLinesForItemServiceId) {
        this.mfcJobcardLinesForItemServiceId = mfcJobcardLinesForItemServiceId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<ItemPurchase> getItemPurchases() {
        return this.itemPurchases;
    }
    
    public void setItemPurchases(Set<ItemPurchase> itemPurchases) {
        this.itemPurchases = itemPurchases;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<PrcPurchaseOrderLine> getPrcPurchaseOrderLines() {
        return this.prcPurchaseOrderLines;
    }
    
    public void setPrcPurchaseOrderLines(Set<PrcPurchaseOrderLine> prcPurchaseOrderLines) {
        this.prcPurchaseOrderLines = prcPurchaseOrderLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemServiceId")
    public Set<CrmSalesinvoiceLine> getCrmSalesinvoiceLinesForItemServiceId() {
        return this.crmSalesinvoiceLinesForItemServiceId;
    }
    
    public void setCrmSalesinvoiceLinesForItemServiceId(Set<CrmSalesinvoiceLine> crmSalesinvoiceLinesForItemServiceId) {
        this.crmSalesinvoiceLinesForItemServiceId = crmSalesinvoiceLinesForItemServiceId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<InvAdjustments> getInvAdjustmentses() {
        return this.invAdjustmentses;
    }
    
    public void setInvAdjustmentses(Set<InvAdjustments> invAdjustmentses) {
        this.invAdjustmentses = invAdjustmentses;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<ItemColour> getItemColours() {
        return this.itemColours;
    }
    
    public void setItemColours(Set<ItemColour> itemColours) {
        this.itemColours = itemColours;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<ItemSaleDimensions> getItemSaleDimensionses() {
        return this.itemSaleDimensionses;
    }
    
    public void setItemSaleDimensionses(Set<ItemSaleDimensions> itemSaleDimensionses) {
        this.itemSaleDimensionses = itemSaleDimensionses;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<InvGoodsreceivedLine> getInvGoodsreceivedLines() {
        return this.invGoodsreceivedLines;
    }
    
    public void setInvGoodsreceivedLines(Set<InvGoodsreceivedLine> invGoodsreceivedLines) {
        this.invGoodsreceivedLines = invGoodsreceivedLines;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemId")
    public Set<CrmDeliveryLine> getCrmDeliveryLinesForItemId() {
        return this.crmDeliveryLinesForItemId;
    }
    
    public void setCrmDeliveryLinesForItemId(Set<CrmDeliveryLine> crmDeliveryLinesForItemId) {
        this.crmDeliveryLinesForItemId = crmDeliveryLinesForItemId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="itemByItemServiceId")
    public Set<CrmDeliveryLine> getCrmDeliveryLinesForItemServiceId() {
        return this.crmDeliveryLinesForItemServiceId;
    }
    
    public void setCrmDeliveryLinesForItemServiceId(Set<CrmDeliveryLine> crmDeliveryLinesForItemServiceId) {
        this.crmDeliveryLinesForItemServiceId = crmDeliveryLinesForItemServiceId;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<ItemSale> getItemSales() {
        return this.itemSales;
    }
    
    public void setItemSales(Set<ItemSale> itemSales) {
        this.itemSales = itemSales;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="item")
    public Set<ItemCustomPrices> getItemCustomPriceses() {
        return this.itemCustomPriceses;
    }
    
    public void setItemCustomPriceses(Set<ItemCustomPrices> itemCustomPriceses) {
        this.itemCustomPriceses = itemCustomPriceses;
    }




}


