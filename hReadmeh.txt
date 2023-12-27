//CDIBEAN
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSF/JSFManagedBean.java to edit this template
 */
package cdibean;

import ejb.VehiclepartsFacade;
import entity.Vehicleparts;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.List;
import javax.ejb.EJB;

/**
 *
 * @author Dell
 */
@Named(value = "vihiclesparts")
@SessionScoped
public class vihiclesparts implements Serializable {

    @EJB
    private VehiclepartsFacade vehiclepartsFacade;

    private Vehicleparts vehiclesparts = new Vehicleparts();
    
    /**
     * Creates a new instance of vihiclesparts
     */
    public vihiclesparts() {
    }

    public Vehicleparts getVehiclesparts() {
        return vehiclesparts;
    }

    public void setVehiclesparts(Vehicleparts vehiclesparts) {
        this.vehiclesparts = vehiclesparts;
    }
    
   
    
    public List<Vehicleparts> findall(){
        return this.vehiclepartsFacade.findAll();
    }
    
    public String addparts(){
        this.vehiclepartsFacade.create(vehiclesparts);
        this.vehiclesparts = new Vehicleparts();
        return"vihiclesparts";
    }

   
    
    public String editparts(Vehicleparts v){
     this.vehiclesparts=v;
     return "vihiclesparts";
    }
    
    public String updateparts(){
        this.vehiclepartsFacade.edit(vehiclesparts);
        this.vehiclesparts=vehiclesparts;
        return"vihiclesparts";
    }
    
    public void Removeparts(Vehicleparts vehiclesparts){
        this.vehiclepartsFacade.remove(vehiclesparts);
    }
}


//table
 <h:dataTable value="#{vihiclesparts.findall()}" var="item" styleClass="data-table">
         <h:column>
            <f:facet name="header"> ID</f:facet>
            #{item.partId}
        </h:column>
        <h:column>
            <f:facet name="header">Part Name</f:facet>
            #{item.name}
        </h:column>
        <h:column>
            <f:facet name="header">Description</f:facet>
            #{item.description}
        </h:column>         
        <h:column>
            <f:facet name="header">Amount</f:facet>
            #{item.price}
        </h:column>        
        <h:column>
            <f:facet name="header">Action</f:facet>
            <h:commandLink style="color: #00ff00" value="update" action="#{vihiclesparts.editparts(item)}" />
        </h:column>
        <h:column>
            <f:facet name="header">Action</f:facet>
            <h:commandLink style="color: #ff3300" value="Delete" action="#{vihiclesparts.Removeparts(item)}"/>
        </h:column>        
    </h:dataTable>

//form
 <h:outputLabel for="partsid" style="font-size: 20px; color: black;">Part Id</h:outputLabel>
        <h:inputText id="serviceName1" value="#{vihiclesparts.vehiclesparts.partId}" class="textbox" required="true"  style="font-size: 16px"/>
        
        <h:outputLabel for="serviceDescription" style="font-size: 20px; color: black;">Part Name</h:outputLabel>

        
        <h:inputText id="serviceName" value="#{vihiclesparts.vehiclesparts.name}" class="textbox" required="true"  style="font-size: 16px"/>
                  
        <h:outputLabel for="serviceDescription" style="font-size: 20px; color: black;">Amount</h:outputLabel>
       
        <h:inputText id="amount" value="#{vihiclesparts.vehiclesparts.price}" class="textboxamount" required="true"  style="font-size: 16px"/>
            
        
        <h:outputLabel for="serviceDescription" style="font-size: 20px; color: black;">Description</h:outputLabel>
        
        <h:inputText id="duration" value="#{vihiclesparts.vehiclesparts.description}" class="textboxid" style="font-size: 16px" title="Duration" />
                  
        
        <h:commandButton value="Submit" action="#{vihiclesparts.addparts()}" styleClass="custombutton" />
        <h:commandButton value="Upadte" action="#{vihiclesparts.updateparts()}" styleClass="custombutton"/>





//userlcdi
public List<User> findall(){
    
       return this.userFacade.findAll();
    }
    
    public String adduser(){
    
        this.userFacade.create(user);
        this.user = new User();
         updateCustomers();
        updateTotalCustomers();
        return "customers";
    }
    
    public String update(User u){
        this.user =u;
        return"customers";
    }
    public String updateu(){
        this.userFacade.edit(user);
        this.user = user;
        return"customers";
    }
    
    public void delet(User user){
        this.userFacade.remove(user);
    }
    
    
    
    private int loggedInUserId;
    
    
    public boolean login(String username, String password) {
        User user = userFacade.findUserByUsernameAndPassword(username, password);
        if (user != null) {
            loggedInUserId = user.getUserid();
            return true; // Successful login
        }
        return false; // Login failed
    }

//login

  @Inject
    private usercdi usercdi;

    
    private bookingcdi bookingcdi;
    
    
    
    /**
     * Creates a new instance of loginbean
     */
    public loginbean() {
    }
    
    
     private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public String login() {
        if (usercdi.login(username, password)) {
            return "home.jsf";
        } else {
            // Handle login failure
            return "login.xhtml";
        }
    }



//ejbacade
   public User findUserByUsernameAndPassword(String username, String password) {
        try {
            return em.createQuery(
                    "SELECT u FROM User u WHERE u.username = :username AND u.password = :password", User.class)
                    .setParameter("username", username)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null; // User not found
        }
    }
