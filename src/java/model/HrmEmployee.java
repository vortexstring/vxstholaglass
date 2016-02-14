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
 * HrmEmployee generated by hbm2java
 */
@Entity
@Table(name="hrm_employee"
    ,catalog="vxsee"
)
public class HrmEmployee  implements java.io.Serializable {


     private Integer employeeId;
     private ConLife conLife;
     private String employeeNo;
     private Date hiredate;
     private Integer postId;
     private int status;
     private String picture;
     private String firstName;
     private String middleName;
     private String lastName;
     private String initials;
     private String jobTitle;
     private String countyId;
     private String countryId;
     private Date birthDate;
     private String socialSecurityNo;
     private String healthInsuranceNo;
     private int gender;
     private String primaryMobileNo;
     private String otherMobileNo;
     private String primaryLandline;
     private String otherLandline;
     private String primaryEmail;
     private String otherEmail;
     private String boxAddress;
     private String boxAddressCode;
     private String boxAddressTown;
     private String physicalAddress;
     private Integer createbyId;
     private Date createdt;
     private Integer writebyId;
     private Date writedt;
     private Set<CrmCustomer> crmCustomers = new HashSet<CrmCustomer>(0);
     private Set<InvStore> invStores = new HashSet<InvStore>(0);

    public HrmEmployee() {
    }

	
    public HrmEmployee(String employeeNo, Date hiredate, int status, String firstName, String middleName, String lastName, String initials, String jobTitle, Date birthDate, String socialSecurityNo, String healthInsuranceNo, int gender) {
        this.employeeNo = employeeNo;
        this.hiredate = hiredate;
        this.status = status;
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.initials = initials;
        this.jobTitle = jobTitle;
        this.birthDate = birthDate;
        this.socialSecurityNo = socialSecurityNo;
        this.healthInsuranceNo = healthInsuranceNo;
        this.gender = gender;
    }
    public HrmEmployee(ConLife conLife, String employeeNo, Date hiredate, Integer postId, int status, String picture, String firstName, String middleName, String lastName, String initials, String jobTitle, String countyId, String countryId, Date birthDate, String socialSecurityNo, String healthInsuranceNo, int gender, String primaryMobileNo, String otherMobileNo, String primaryLandline, String otherLandline, String primaryEmail, String otherEmail, String boxAddress, String boxAddressCode, String boxAddressTown, String physicalAddress, Integer createbyId, Date createdt, Integer writebyId, Date writedt, Set<CrmCustomer> crmCustomers, Set<InvStore> invStores) {
       this.conLife = conLife;
       this.employeeNo = employeeNo;
       this.hiredate = hiredate;
       this.postId = postId;
       this.status = status;
       this.picture = picture;
       this.firstName = firstName;
       this.middleName = middleName;
       this.lastName = lastName;
       this.initials = initials;
       this.jobTitle = jobTitle;
       this.countyId = countyId;
       this.countryId = countryId;
       this.birthDate = birthDate;
       this.socialSecurityNo = socialSecurityNo;
       this.healthInsuranceNo = healthInsuranceNo;
       this.gender = gender;
       this.primaryMobileNo = primaryMobileNo;
       this.otherMobileNo = otherMobileNo;
       this.primaryLandline = primaryLandline;
       this.otherLandline = otherLandline;
       this.primaryEmail = primaryEmail;
       this.otherEmail = otherEmail;
       this.boxAddress = boxAddress;
       this.boxAddressCode = boxAddressCode;
       this.boxAddressTown = boxAddressTown;
       this.physicalAddress = physicalAddress;
       this.createbyId = createbyId;
       this.createdt = createdt;
       this.writebyId = writebyId;
       this.writedt = writedt;
       this.crmCustomers = crmCustomers;
       this.invStores = invStores;
    }
   
     @Id @GeneratedValue(strategy=IDENTITY)

    
    @Column(name="employee_id", unique=true, nullable=false)
    public Integer getEmployeeId() {
        return this.employeeId;
    }
    
    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="life")
    public ConLife getConLife() {
        return this.conLife;
    }
    
    public void setConLife(ConLife conLife) {
        this.conLife = conLife;
    }

    
    @Column(name="employee_no", nullable=false, length=20)
    public String getEmployeeNo() {
        return this.employeeNo;
    }
    
    public void setEmployeeNo(String employeeNo) {
        this.employeeNo = employeeNo;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="hiredate", nullable=false, length=10)
    public Date getHiredate() {
        return this.hiredate;
    }
    
    public void setHiredate(Date hiredate) {
        this.hiredate = hiredate;
    }

    
    @Column(name="post_id")
    public Integer getPostId() {
        return this.postId;
    }
    
    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    
    @Column(name="status", nullable=false)
    public int getStatus() {
        return this.status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }

    
    @Column(name="picture", length=50)
    public String getPicture() {
        return this.picture;
    }
    
    public void setPicture(String picture) {
        this.picture = picture;
    }

    
    @Column(name="first_name", nullable=false, length=30)
    public String getFirstName() {
        return this.firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    
    @Column(name="middle_name", nullable=false, length=30)
    public String getMiddleName() {
        return this.middleName;
    }
    
    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    
    @Column(name="last_name", nullable=false, length=30)
    public String getLastName() {
        return this.lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    
    @Column(name="initials", nullable=false, length=30)
    public String getInitials() {
        return this.initials;
    }
    
    public void setInitials(String initials) {
        this.initials = initials;
    }

    
    @Column(name="job_title", nullable=false, length=30)
    public String getJobTitle() {
        return this.jobTitle;
    }
    
    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    
    @Column(name="county_id", length=50)
    public String getCountyId() {
        return this.countyId;
    }
    
    public void setCountyId(String countyId) {
        this.countyId = countyId;
    }

    
    @Column(name="country_id", length=50)
    public String getCountryId() {
        return this.countryId;
    }
    
    public void setCountryId(String countryId) {
        this.countryId = countryId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="birth_date", nullable=false, length=19)
    public Date getBirthDate() {
        return this.birthDate;
    }
    
    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    
    @Column(name="social_security_no", nullable=false, length=30)
    public String getSocialSecurityNo() {
        return this.socialSecurityNo;
    }
    
    public void setSocialSecurityNo(String socialSecurityNo) {
        this.socialSecurityNo = socialSecurityNo;
    }

    
    @Column(name="health_insurance_no", nullable=false, length=50)
    public String getHealthInsuranceNo() {
        return this.healthInsuranceNo;
    }
    
    public void setHealthInsuranceNo(String healthInsuranceNo) {
        this.healthInsuranceNo = healthInsuranceNo;
    }

    
    @Column(name="gender", nullable=false)
    public int getGender() {
        return this.gender;
    }
    
    public void setGender(int gender) {
        this.gender = gender;
    }

    
    @Column(name="primary_mobile_no", length=50)
    public String getPrimaryMobileNo() {
        return this.primaryMobileNo;
    }
    
    public void setPrimaryMobileNo(String primaryMobileNo) {
        this.primaryMobileNo = primaryMobileNo;
    }

    
    @Column(name="other_mobile_no", length=50)
    public String getOtherMobileNo() {
        return this.otherMobileNo;
    }
    
    public void setOtherMobileNo(String otherMobileNo) {
        this.otherMobileNo = otherMobileNo;
    }

    
    @Column(name="primary_landline", length=50)
    public String getPrimaryLandline() {
        return this.primaryLandline;
    }
    
    public void setPrimaryLandline(String primaryLandline) {
        this.primaryLandline = primaryLandline;
    }

    
    @Column(name="other_landline", length=50)
    public String getOtherLandline() {
        return this.otherLandline;
    }
    
    public void setOtherLandline(String otherLandline) {
        this.otherLandline = otherLandline;
    }

    
    @Column(name="primary_email", length=50)
    public String getPrimaryEmail() {
        return this.primaryEmail;
    }
    
    public void setPrimaryEmail(String primaryEmail) {
        this.primaryEmail = primaryEmail;
    }

    
    @Column(name="other_email", length=50)
    public String getOtherEmail() {
        return this.otherEmail;
    }
    
    public void setOtherEmail(String otherEmail) {
        this.otherEmail = otherEmail;
    }

    
    @Column(name="box_address", length=50)
    public String getBoxAddress() {
        return this.boxAddress;
    }
    
    public void setBoxAddress(String boxAddress) {
        this.boxAddress = boxAddress;
    }

    
    @Column(name="box_address_code", length=10)
    public String getBoxAddressCode() {
        return this.boxAddressCode;
    }
    
    public void setBoxAddressCode(String boxAddressCode) {
        this.boxAddressCode = boxAddressCode;
    }

    
    @Column(name="box_address_town", length=50)
    public String getBoxAddressTown() {
        return this.boxAddressTown;
    }
    
    public void setBoxAddressTown(String boxAddressTown) {
        this.boxAddressTown = boxAddressTown;
    }

    
    @Column(name="physical_address", length=50)
    public String getPhysicalAddress() {
        return this.physicalAddress;
    }
    
    public void setPhysicalAddress(String physicalAddress) {
        this.physicalAddress = physicalAddress;
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

@OneToMany(fetch=FetchType.LAZY, mappedBy="hrmEmployee")
    public Set<CrmCustomer> getCrmCustomers() {
        return this.crmCustomers;
    }
    
    public void setCrmCustomers(Set<CrmCustomer> crmCustomers) {
        this.crmCustomers = crmCustomers;
    }

@OneToMany(fetch=FetchType.LAZY, mappedBy="hrmEmployee")
    public Set<InvStore> getInvStores() {
        return this.invStores;
    }
    
    public void setInvStores(Set<InvStore> invStores) {
        this.invStores = invStores;
    }




}


