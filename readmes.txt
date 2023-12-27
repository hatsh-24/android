///////////////registrationbean:-

package Beans;

import Entity.Caruser;
import jakarta.ejb.Stateless;
import jakarta.ejb.LocalBean;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import java.util.List;

/**
 *
 * @author HP
 */
@Stateless
@LocalBean
public class RegistrationBean {

    @PersistenceContext(unitName = "carpu")
    private EntityManager entityManager;

    public void registerUser(Caruser caruser) {
        entityManager.persist(caruser);
    }
    
     public void deleteUser(int cid) {
        Caruser caruser = entityManager.find(Caruser.class,cid);
        if (caruser != null) {
            entityManager.remove(caruser);
        }
     }
     
    
        public List<Caruser> getAllcarusers() {
        return entityManager.createQuery("SELECT c FROM Caruser c",Caruser.class).getResultList();
    }
          
     
      public void updateCaruser(int cidToUpdate, String newName, String newEmail, String newPassword,String newPhone, String newAddress) {
        String sql = "UPDATE caruser SET cname = ?, cemail = ?, cpass = ?, cphone=?, caddress = ? WHERE cid = ?";
        entityManager.createNativeQuery(sql)
                 .setParameter(1, newName)
                 .setParameter(2, newEmail)
                 .setParameter(3, newPassword)
                 .setParameter(4, newPhone)
                 .setParameter(5, newAddress)
                 .setParameter(6, cidToUpdate)
                 .executeUpdate();
      }
      
      
      public boolean authenticateUser(String cname, String cpass) {
        try {
            // Use a native SQL query to check for a matching user
            String sql = "SELECT * FROM caruser WHERE cname = ? AND cpass = ?";
            List<?> result = entityManager.createNativeQuery(sql, Caruser.class)
                    .setParameter(1, cname)
                    .setParameter(2, cpass)
                    .getResultList();

            // If the result list is not empty, authentication is successful
            return !result.isEmpty();
        } catch (Exception e) {
            return false;
        }
    }
      
      public Caruser getUserByName(String cname) {
//          TypedQuery<Caruser>query= entityManager.createQuery(cq)
        TypedQuery<Caruser> query = entityManager.createQuery("SELECT c FROM Caruser c WHERE c.cname = :cname", Caruser.class);
        query.setParameter("cname", cname);

        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
     
      public Caruser getUserById(int cid) {
          return entityManager.find(Caruser.class, cid);
        
    }

    public void updateUser(Caruser updatedUser) {
        entityManager.merge(updatedUser);
    }
      
  
}


/////////////////userbean sertilized///////////////////////////



package Beans;

import Entity.Caruser;
import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Named;
import java.io.Serializable;


@Named(value = "userBean")
@SessionScoped
public class UserBean implements Serializable {

    private Caruser caruser = new Caruser();
    private int cidTODelete;
    private int cidToUpdate;
    private String newName;
    private String newEmail;
    private String newPassword;
    private String newPhone;
    
    private String newAddress;

    
    
    ///for update////
    public int getCidToUpdate() {
        return cidToUpdate;
    }

    public void setCidToUpdate(int cidToUpdate) {
        this.cidToUpdate = cidToUpdate;
    }

    public String getNewName() {
        return newName;
    }

    public void setNewName(String newName) {
        this.newName = newName;
    }

    public String getNewEmail() {
        return newEmail;
    }

    public void setNewEmail(String newEmail) {
        this.newEmail = newEmail;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getNewPhone() {
        return newPhone;
    }

    public void setNewPhone(String newPhone) {
        this.newPhone = newPhone;
    }

    public String getNewAddress() {
        return newAddress;
    }

    public void setNewAddress(String newAddress) {
        this.newAddress = newAddress;
    }

  
   
    /////for delete/////

    public int getCidTODelete() {
        return cidTODelete;
    }

    public void setCidTODelete(int cidTODelete) {
        this.cidTODelete = cidTODelete;
    }

    
    
    
    
    
    ////for insert//
    
    public Caruser getCaruser() {
        return caruser;
    }

    public void setCaruser(Caruser caruser) {
        this.caruser = caruser;
    }
   
    public String getCname() {
        return caruser.getCname();
    }

    public void setCname(String cname) {
       caruser.setCname(cname);
    }

    public String getCemail() {
        return caruser.getCemail();
        
    }

    public void setCemail(String cemail) {
         caruser.setCemail(cemail);
    }

    public String getCpass() {
        return caruser.getCpass();
    }

    public void setCpass(String cpass) {
        caruser.setCpass(cpass);
    }
    
    public String getCphone() {
        return caruser.getCphone();
        
    }

    public void setCphone(String cphone) {
        caruser.setCphone(cphone);
//        this.cphone = cphone;
    }

    public String getCaddress() {
        return caruser.getCaddress();
    }

    public void setCaddress(String caddress) {
        caruser.setCaddress(caddress);
    }
   
    public UserBean() {
    }
    
}

/////////////////registrer controller///////////////////////////////


package Beans;

import Entity.Caruser;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import java.util.List;



@Named(value = "registrationController")
@Dependent
public class RegistrationController {

    /**
     * Creates a new instance of RegistrationController
     */
    public RegistrationController() {
    }
    
     @Inject
    private UserBean userBean;

    @Inject
    private RegistrationBean registrationBean;

    public String register() {
        registrationBean.registerUser(userBean.getCaruser());
        // You can perform additional actions or navigation here
        return "WebLogin.xhtml";
    }
    
    public String delete() {
        int cidToDelete = userBean.getCidTODelete();
        registrationBean.deleteUser(cidToDelete);
        // You can perform additional actions or navigation here
        return "success.xhtml";
    }
    
    public List<Caruser> getAllcarusers() {
        return registrationBean.getAllcarusers();
    }
    
     public String updateUser() {
        int cidToUpdate = userBean.getCidToUpdate();
        String newName = userBean.getNewName();
        String newEmail = userBean.getNewEmail();
        String newPassword = userBean.getNewPassword();
        String newPhone = userBean.getNewPhone();
        String newAddress = userBean.getNewAddress();

        registrationBean.updateCaruser(cidToUpdate, newName, newEmail, newPassword, newPhone, newAddress);
//        registrationBean.updateCaruser(cidToUpdate, newName, newEmail, newPassword, newPhone, newAddress);
        // You can perform additional actions or navigation here
        return "success.xhtml";
    
     }
    
    
private Caruser caruser;
private int cid;
      public void loadUser() {
         
          caruser =registrationBean.getUserById(cid);
//        user = userSessionBean.getUserById(userId);
    }


    public Caruser getCaruser() {
        return caruser;
    }

    public void setCaruser(Caruser caruser) {
        this.caruser = caruser;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }
     
    
    public String updatecUser() {
        registrationBean.updateUser(caruser);
//        userSessionBean.updateUser(user);
        return "Adminnavbar.xhtml"; // Redirect to a success page
    }
     
    
    
    public UserBean getUserBean() {
        return userBean;
    }

    public void setUserBean(UserBean userBean) {
        this.userBean = userBean;
    }
    
    
}

///////////////////////////////////loginbean///////////////////////////

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSF/JSFManagedBean.java to edit this template
 */
package Beans;

import Entity.Caruser;
import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Named;
import java.io.Serializable;

/**
 *
 * @author HP
 */
@Named(value = "loginBean")
@SessionScoped
public class LoginBean implements Serializable {
    
    private Caruser currentUser;

    public Caruser getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(Caruser currentUser) {
        this.currentUser = currentUser;
    }
    
    
    
    
      private String cname;
      private String cpass;

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCpass() {
        return cpass;
    }

    public void setCpass(String cpass) {
        this.cpass = cpass;
    }
      
      
    /**
     * Creates a new instance of LoginBean
     */
    public LoginBean() {
    }
    
}

//////////////////////Login Controller///////////////////

@Named(value = "loginController")
@Dependent
public class LoginController {
    
    @Inject
    private LoginBean loginBean;
    


    @Inject
    private RegistrationBean registrationBean;

    public String login() {
        String cname = loginBean.getCname();
        String cpass = loginBean.getCpass();

        // Implement your authentication logic here
        // For simplicity, let's assume the existence of a method in RegistrationBean
        // that checks if a user with the provided cname and cpass exists
        Caruser caruser = registrationBean.getUserByName(cname);
        
        if(caruser != null && registrationBean.authenticateUser(cname, cpass)){
            loginBean.setCurrentUser(caruser);
            return "WebHome.xhtml";
            }else{
            return "WebUserregistration.xhtml";
        }
    }



/////////////////////////insert jsf//////////////
 <h:body>
        Hello from Facelets
         <h:form>
               
        <h:outputLabel for="cname">Name:</h:outputLabel>
        <h:inputText id="cname" value="#{userBean.cname}" required="true" />

        <h:outputLabel for="cemail">Email:</h:outputLabel>
        <h:inputText id="cemail" value="#{userBean.cemail}" required="true" />

        <h:outputLabel for="cpass">Password:</h:outputLabel>
        <h:inputSecret id="cpass" value="#{userBean.cpass}" required="true" />
        
        <h:outputLabel for="cphone">Phone:</h:outputLabel>
        <h:inputSecret id="cphone" value="#{userBean.cphone}" required="true" />
        
        <h:outputLabel for="caddress">Address:</h:outputLabel>
        <h:inputText id="caddress" value="#{userBean.caddress}" required="true" />

        <h:commandButton value="Register" action="#{registrationController.register()}" />
    </h:form>
    </h:body>



////////////////show////////////////

<style>
            
    /* Style for the entire table */
table {
    padding-left: 250px;
    width: 100%;
    /*border-collapse: collapse;*/
    margin-bottom: 20px;
}

/* Style for table headers */
th {
    background-color: #14213d;
    color: white;
    padding: 10px;
}

/* Style for table cells */
td {
    border: 1px solid #ddd;
    padding: 8px;
}

/* Style for alternating rows */
tr:nth-child(even) {
    background-color: #f2f2f2;
}

/* Hover effect on rows */
tr:hover {
    background-color: #ddd;
}

    </style>

 <h:body>
        <!--Hello from Facelets-->
        
         <h2>User List</h2>
         <h:dataTable value="#{registrationController.allcarusers}" var="user">
        <h:column>
            <f:facet name="header">id</f:facet>
            #{user.cid}
        </h:column>
             
        <h:column>
            <f:facet name="header">Name</f:facet>
            #{user.cname}
        </h:column>
        <h:column>
            <f:facet name="header">Email</f:facet>
            #{user.cemail}
        </h:column>
        <h:column>
            <f:facet name="header">Phone</f:facet>
            #{user.cphone}
        </h:column>     
        <h:column>
            <f:facet name="header">Address</f:facet>
            #{user.caddress}
        </h:column>
        <!-- Add more columns as needed -->
    </h:dataTable>
    </h:body>



/////////////////delete///////////////////////
 <h:body>
        <h:form>
        <h:outputLabel for="cidToDelete">CID to Delete:</h:outputLabel>
        <h:inputText id="cidToDelete" value="#{userBean.cidTODelete}" required="true" />
        <h:commandButton value="Delete" action="#{registrationController.delete()}" />
        </h:form>
        Hello from Facelets
    </h:body>



/////////////////////////////////update///////////////////////

 <h:form>
        <h:outputLabel for="cidToUpdate">CID to Update:</h:outputLabel>
        <h:inputText id="cidToUpdate" value="#{userBean.cidToUpdate}" required="true" />

        <!-- Add fields for the update operation (excluding cid) -->
        <h:outputLabel for="newName">New Name:</h:outputLabel>
        <h:inputText id="newName" value="#{userBean.newName}" required="true" />

        <h:outputLabel for="newEmail">New Email:</h:outputLabel>
        <h:inputText id="newEmail" value="#{userBean.newEmail}" required="true" />

        <h:outputLabel for="newPassword">New Password:</h:outputLabel>
        <h:inputSecret id="newPassword" value="#{userBean.newPassword}" required="true" />

        <h:outputLabel for="newPhone">New Phone:</h:outputLabel>
        <h:inputSecret id="newPhone" value="#{userBean.newPhone}" required="true" />

        <h:outputLabel for="newAddress">New Address:</h:outputLabel>
        <h:inputText id="newAddress" value="#{userBean.newAddress}" required="true" />

        <!-- Button to trigger the update operation -->
        <h:commandButton value="Update" action="#{registrationController.updateUser}" />
    </h:form>











