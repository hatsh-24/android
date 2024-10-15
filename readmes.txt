//bean
@PersistenceContext(unitName = "msapu")
    EntityManager em;

    public Collection<TUsers> getAllUsers() {
        return em.createNamedQuery("TUsers.findAll").getResultList();
    }

    public void insertUser(TUsers user) {
    em.getTransaction().begin();  // Start transaction
    em.persist(user);             // Persist the user entity
    em.getTransaction().commit(); // Commit the transaction
}
    public void deleteUser(Long userId) {
    em.getTransaction().begin();  // Start transaction
    TUsers user = em.find(TUsers.class, userId); // Find the user by ID
    if (user != null) {
        em.remove(user);           // Remove the user entity
    }
    em.getTransaction().commit();  // Commit the transaction
}

//exampleservice

@GET
    @Path("/getHello")
    @Produces(MediaType.TEXT_HTML)
    public String getHello() {
        return "<h1>Hello WOrld</h1>";
    }

    @GET
    @Path("/getUsers")
    @Produces(MediaType.APPLICATION_JSON)
    public Collection<TUsers> getAllUsers() {
        return eb.getAllUsers();
    }

@POST
@Path("/addUser")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public Response insertUser(TUsers user) {
    boolean success = eb.insertUser(user);
    if (success) {
        return Response.status(Response.Status.CREATED).entity("User added successfully").build();
    } else {
        return Response.status(Response.Status.BAD_REQUEST).entity("Failed to add user").build();
    }
}

@DELETE
@Path("/deleteUser/{id}")
@Produces(MediaType.APPLICATION_JSON)
public Response deleteUser(@PathParam("id") int id) {
    boolean success = eb.deleteUser(id);
    if (success) {
        return Response.status(Response.Status.OK).entity("User deleted successfully").build();
    } else {
        return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
    }
}

//micro properties
apiUrl/mp-rest/url= http://localhost:8085/ResourceApp/rest/example

//interface
// Method to get all users
    @GET
    @Path("/getUsers")
    @Produces(MediaType.APPLICATION_JSON)
    public Collection<TUsers> getAllUsers();

    // Method to insert a user
    @POST
    @Path("/addUser")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public boolean insertUser(TUsers user);

    // Method to delete a user
    @DELETE
    @Path("/deleteUser/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public boolean deleteUser(@PathParam("id") int id);

java -jar payara-micro-5.2022.2.jar --deploy MSAApp/artifact/MSAApp.war --port 8085



//python
def product_or_sum(num1, num2):
    product = num1 * num2
    if product > 1000:
        return num1 + num2
    return product

def sum_of_current_previous():
    previous_num = 0
    for i in range(10):
        sum_result = previous_num + i
        print(f"Current number: {i}, Previous number: {previous_num}, Sum: {sum_result}")
        previous_num = i

def even_index_chars(input_string):
    return input_string[::2]

def check_first_last_same(input_list):
    return input_list[0] == input_list[-1] if input_list else False

def combine_odd_even(list1, list2):
    odd_elements = list1[1::2]  
    even_elements = list2[0::2]  
    return odd_elements + even_elements

def modify_list(input_list):
    if len(input_list) > 4:
        element = input_list.pop(4)
        input_list.insert(2, element)
        input_list.append(element)
    return input_list

def slice_and_reverse(input_list):
    chunk_size = len(input_list) // 3
    chunks = [input_list[i:i + chunk_size] for i in range(0, len(input_list), chunk_size)]
    return [chunk[::-1] for chunk in chunks]

def count_occurrences(input_list):
    count_dict = {}
    for item in input_list:
        count_dict[item] = count_dict.get(item, 0) + 1
    return count_dict

def add_list_to_set(given_set, input_list):
    given_set.update(input_list)
    return given_set

def print_pattern():
    for i in range(1, 6):
        for j in range(1, i+1):
            print(j, end=" ")
        print()

def sum_upto_n(n):
    return sum(range(1, n+1))

def divisible_by_five(input_list):
    for num in input_list:
        if num > 150:
            break
        if num % 5 == 0:
            print(num)

def reverse_list(input_list):
    reversed_list = []
    for i in range(len(input_list)-1, -1, -1):
        reversed_list.append(input_list[i])
    return reversed_list

def prime_numbers_in_range(start, end):
    primes = []
    for num in range(start, end+1):
        if num > 1:  
            for i in range(2, int(num**0.5)+1):
                if num % i == 0:
                    break
            else:
                primes.append(num)
    return primes

print(product_or_sum(20, 50)) 
print(product_or_sum(40, 30))  
sum_of_current_previous()
print(even_index_chars("hello"))  
print(check_first_last_same([10, 20, 30, 10])) 
print(check_first_last_same([10, 20, 30, 40]))  
print(combine_odd_even([10, 20, 30, 40], [1, 2, 3, 4]))  
print(modify_list([1, 2, 3, 4, 5, 6])) 
print(slice_and_reverse([1, 2, 3, 4, 5, 6, 7, 8, 9]))  
print(count_occurrences([10, 20, 10, 30, 10])) 
print(add_list_to_set({'yellow', 'orange'}, ['blue', 'black']))  
print_pattern()
print(sum_upto_n(5)) 
divisible_by_five([10, 25, 35, 200, 50]) 
print(reverse_list([10, 20, 30, 40]))  
print(prime_numbers_in_range(10, 50))  

//pnd
import pandas as pd
import os

csv_file = 'users.csv'

def add_user():
    name = input("Enter name: ")
    email = input("Enter email: ")

    file_exists = os.path.isfile(csv_file)
 
    df = pd.DataFrame([[name, email]], columns=['Name', 'Email'])
    df.to_csv(csv_file, mode='a', header=not file_exists, index=False)
    print(f"User {name} added.")

def read_users():
    if os.path.exists(csv_file):
        df = pd.read_csv(csv_file)
        print("\nCurrent Users in CSV:\n", df)
    else:
        print("No users found, CSV file does not exist yet.")
def update_user():
    if os.path.exists(csv_file):
        df = pd.read_csv(csv_file)
        name_to_update = input("Enter the name of the user to update: ")
        
        if name_to_update in df['Name'].values:
            new_email = input("Enter new email: ")
            df.loc[df['Name'] == name_to_update, 'Email'] = new_email
            df.to_csv(csv_file, index=False)
            print(f"User {name_to_update} updated.")
        else:
            print(f"User {name_to_update} not found.")
    else:
        print("CSV file not found, no users to update.")

def main():
    while True:
        print("\n1. Add User\n2. Read Users\n3. Update User\n4. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            add_user()
        elif choice == '2':
            read_users()
        elif choice == '3':
            update_user()
        elif choice == '4':
            print("Exiting...")
            break
        else:
            print("Invalid choice, try again.")

if __name__ == "__main__":
    main()


//csv
import csv
import os

def write_to_csv(filename, name, email):
    with open(filename, mode='a', newline='') as file:
        writer = csv.writer(file)
        writer.writerow([name, email])
    print(f"Data written to {filename}: Name: {name}, Email: {email}")

def read_from_csv(filename):
    if not os.path.exists(filename):
        print("File not found.")
        return []
    
    with open(filename, mode='r') as file:
        reader = csv.reader(file)
        data = list(reader)
        print("Current data in the CSV file:")
        for row in data:
            print(f"Name: {row[0]}, Email: {row[1]}")
    return data

def update_csv(filename, old_name, new_name, new_email):
    updated_data = []
    found = False

    with open(filename, mode='r') as file:
        reader = csv.reader(file)
        for row in reader:
            if row[0] == old_name:
                updated_data.append([new_name, new_email])
                found = True
                print(f"Updated {old_name} to {new_name} with email {new_email}.")
            else:
                updated_data.append(row)

    if not found:
        print(f"{old_name} not found in the CSV file.")

    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(updated_data)

def main():
    filename = 'user_data.csv'
    

    name = input("Enter your name: ")
    email = input("Enter your email: ")
    write_to_csv(filename, name, email)

    read_from_csv(filename)

    update_choice = input("Do you want to update an entry? (yes/no): ").strip().lower()
    if update_choice == 'yes':
        old_name = input("Enter the name you want to update: ")
        new_name = input("Enter the new name: ")
        new_email = input("Enter the new email: ")
        update_csv(filename, old_name, new_name, new_email)

        read_from_csv(filename)

if __name__ == "__main__":
    main()



//bank
import csv

# Base class
class BankAccount:
    def __init__(self, account_number, name, initial_deposit):
        self.account_number = account_number
        self.name = name
        self.balance = initial_deposit

    def deposit(self, amount):
        self.balance += amount
        print(f"Deposited {amount}. New balance: {self.balance}")

    def withdraw(self, amount):
        if amount > self.balance:
            print("Insufficient balance.")
        else:
            self.balance -= amount
            print(f"Withdrew {amount}. New balance: {self.balance}")

    def check_balance(self):
        print(f"Account Balance for {self.name}: {self.balance}")

# Inherited class for Savings Account
class SavingsAccount(BankAccount):
    interest_rate = 6.5  # Annual interest rate

    def __init__(self, account_number, name, initial_deposit):
        super().__init__(account_number, name, initial_deposit)

    def apply_interest(self):
        interest = self.balance * (SavingsAccount.interest_rate / 100)
        self.balance += interest
        print(f"Interest applied. New balance: {self.balance}")

# Inherited class for Current Account with different types
class CurrentAccount(BankAccount):
    def __init__(self, account_number, name, initial_deposit, program_type):
        super().__init__(account_number, name, initial_deposit)
        self.program_type = program_type
        self.balance_requirement = self.set_balance_requirement(program_type)
        self.interest_rate = "NA"  # No interest for current accounts

    def set_balance_requirement(self, program_type):
        if program_type == 'Premium':
            return 500000
        elif program_type == 'Zero2One':
            return 100000

    def check_balance_requirement(self):
        if self.balance < self.balance_requirement:
            print(f"Balance below required minimum of {self.balance_requirement}.")
        else:
            print(f"Balance requirement met. Current balance: {self.balance}")

# Class to manage Bank operations
class Bank:
    def __init__(self):
        self.accounts = []

    def add_account(self, account):
        self.accounts.append(account)
        self.save_to_csv()
        print(f"Account added for {account.name}.")

    def delete_account(self, account_number):
        self.accounts = [account for account in self.accounts if account.account_number != account_number]
        self.save_to_csv()
        print(f"Account {account_number} deleted.")

    def update_account(self, account_number, name=None, deposit=None):
        for account in self.accounts:
            if account.account_number == account_number:
                if name:
                    account.name = name
                if deposit:
                    account.balance = deposit
                print(f"Account {account_number} updated.")
                self.save_to_csv()
                return
        print(f"Account {account_number} not found.")

    def save_to_csv(self):
        with open('bank_accounts.csv', 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(['Account Number', 'Name', 'Balance', 'Account Type'])
            for account in self.accounts:
                if isinstance(account, SavingsAccount):
                    writer.writerow([account.account_number, account.name, account.balance, 'Savings'])
                elif isinstance(account, CurrentAccount):
                    writer.writerow([account.account_number, account.name, account.balance, 'Current', account.program_type])

# Main logic to interact with users
def main():
    bank = Bank()

    while True:
        print("\n1. Add Account\n2. Delete Account\n3. Update Account\n4. Check Balance\n5. Deposit\n6. Withdraw\n7. Exit")
        choice = int(input("Enter your choice: "))

        if choice == 1:
            account_type = input("Enter account type (Savings/Current): ").strip().lower()
            account_number = input("Enter account number: ")
            name = input("Enter account holder name: ")
            initial_deposit = float(input("Enter initial deposit: "))

            if account_type == 'savings':
                account = SavingsAccount(account_number, name, initial_deposit)
            elif account_type == 'current':
                program_type = input("Enter program type (Premium/Zero2One): ").strip()
                account = CurrentAccount(account_number, name, initial_deposit, program_type)
            else:
                print("Invalid account type.")
                continue

            bank.add_account(account)

        elif choice == 2:
            account_number = input("Enter account number to delete: ")
            bank.delete_account(account_number)

        elif choice == 3:
            account_number = input("Enter account number to update: ")
            name = input("Enter new name (or press Enter to skip): ")
            deposit = input("Enter new deposit (or press Enter to skip): ")
            deposit = float(deposit) if deposit else None
            bank.update_account(account_number, name, deposit)

        elif choice == 4:
            account_number = input("Enter account number: ")
            for account in bank.accounts:
                if account.account_number == account_number:
                    account.check_balance()
                    break
            else:
                print(f"Account {account_number} not found.")

        elif choice == 5:
            account_number = input("Enter account number: ")
            amount = float(input("Enter amount to deposit: "))
            for account in bank.accounts:
                if account.account_number == account_number:
                    account.deposit(amount)
                    break
            else:
                print(f"Account {account_number} not found.")

        elif choice == 6:
            account_number = input("Enter account number: ")
            amount = float(input("Enter amount to withdraw: "))
            for account in bank.accounts:
                if account.account_number == account_number:
                    account.withdraw(amount)
                    break
            else:
                print(f"Account {account_number} not found.")

        elif choice == 7:
            print("Exiting...")
            break

        else:
            print("Invalid choice. Try again.")

if __name__ == "__main__":
    main()
..
..
class Car:
    def __init__(self, make, model, year, price, available=True):
        self.make = make
        self.model = model
        self.year = year
        self.price = price
        self.available = available

    def display_info(self):
        availability = "Available" if self.available else "Sold"
        return f"{self.year} {self.make} {self.model} - ${self.price} ({availability})"


class Showroom:
    def __init__(self, name):
        self.name = name
        self.cars = []

    def add_car(self, car):
        self.cars.append(car)
        print(f"Added {car.display_info()} to the showroom.")

    def remove_car(self, index):
        if 0 <= index < len(self.cars):
            removed_car = self.cars.pop(index)
            print(f"Removed {removed_car.display_info()} from the showroom.")
        else:
            print("Car index not found.")

    def display_cars(self):
        if not self.cars:
            print("No cars available in the showroom.")
            return
        print(f"Cars available in {self.name}:")
        for idx, car in enumerate(self.cars):
            print(f"{idx}. {car.display_info()}")

    def sell_car(self, index):
        if 0 <= index < len(self.cars) and self.cars[index].available:
            self.cars[index].available = False
            print(f"Sold {self.cars[index].display_info()}.")
        else:
            print("Car not available for sale.")


class Customer:
    def __init__(self, name):
        self.name = name


def main():
    showroom = Showroom("Super Cars")

    while True:
        print("\nCar Showroom Management System")
        print("1. Add Car")
        print("2. Display Cars")
        print("3. Remove Car")
        print("4. Sell Car")
        print("5. Exit")
        choice = input("Choose an option: ")

        if choice == '1':
            make = input("Enter car make: ")
            model = input("Enter car model: ")
            year = input("Enter car year: ")
            price = float(input("Enter car price: "))
            car = Car(make, model, year, price)
            showroom.add_car(car)

        elif choice == '2':
            showroom.display_cars()

        elif choice == '3':
            showroom.display_cars()
            try:
                index = int(input("Enter the index of the car to remove: "))
                showroom.remove_car(index)
            except ValueError:
                print("Please enter a valid index.")

        elif choice == '4':
            showroom.display_cars()
            try:
                index = int(input("Enter the index of the car to sell: "))
                showroom.sell_car(index)
            except ValueError:
                print("Please enter a valid index.")

        elif choice == '5':
            print("Exiting the system. Goodbye!")
            break

        else:
            print("Invalid choice. Please select again.")


if __name__ == "__main__":
    main()

.....

class CarCRUD:
    def __init__(self):
        self.cars = []

    # Method to add a new car
    def add_car(self):
        car_id = input("Enter car ID: ")
        make = input("Enter car make: ")
        model = input("Enter car model: ")
        year = input("Enter car year: ")

        car = {
            "id": car_id,
            "make": make,
            "model": model,
            "year": year
        }
        self.cars.append(car)
        print(f"Car {car_id} added successfully!\n")

    # Method to display all cars
    def display_cars(self):
        if not self.cars:
            print("No cars available.\n")
            return
        print("Current list of cars:")
        for car in self.cars:
            print(f"ID: {car['id']}, Make: {car['make']}, Model: {car['model']}, Year: {car['year']}")
        print()

    # Method to update a car by its ID
    def update_car(self):
        car_id = input("Enter car ID to update: ")

        for car in self.cars:
            if car['id'] == car_id:
                new_make = input("Enter new car make (leave blank to keep current): ")
                new_model = input("Enter new car model (leave blank to keep current): ")
                new_year = input("Enter new car year (leave blank to keep current): ")

                if new_make:
                    car['make'] = new_make
                if new_model:
                    car['model'] = new_model
                if new_year:
                    car['year'] = new_year

                print(f"Car {car_id} updated successfully!\n")
                return
        print(f"Car with ID {car_id} not found.\n")

    # Method to delete a car by its ID
    def delete_car(self):
        car_id = input("Enter car ID to delete: ")

        for car in self.cars:
            if car['id'] == car_id:
                self.cars.remove(car)
                print(f"Car {car_id} deleted successfully!\n")
                return
        print(f"Car with ID {car_id} not found.\n")

    # Method to interact with the user
    def main_menu(self):
        while True:
            print("Car CRUD Menu:")
            print("1. Add Car")
            print("2. Display Cars")
            print("3. Update Car")
            print("4. Delete Car")
            print("5. Exit")

            choice = input("Enter your choice: ")

            if choice == '1':
                self.add_car()
            elif choice == '2':
                self.display_cars()
            elif choice == '3':
                self.update_car()
            elif choice == '4':
                self.delete_car()
            elif choice == '5':
                print("Exiting the program.")
                break
            else:
                print("Invalid choice, please try again.\n")


# Instantiate the CarCRUD class and start the program
if __name__ == "__main__":
    car_crud_app = CarCRUD()
    car_crud_app.main_menu()
