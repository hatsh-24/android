using System;
using System.Collections.Generic;

// Define the generic interface for CRUD operations
public interface ICrudOperations<T>
{
    void Add(T item);
    void Update(T item);
    void Delete(T item);
    void DisplayAll();
}

// Define the Student class
public class Student
{
    public int Id { get; set; }
    public string Name { get; set; }
}

// Define the Teacher class
public class Teacher
{
    public int Id { get; set; }
    public string Name { get; set; }
}

// Define the Course class
public class Course
{
    public int Id { get; set; }
    public string Name { get; set; }
}

// Implement the generic interface in a class
public class CrudOperations<T> : ICrudOperations<T>
{
    private List<T> itemList;

    public CrudOperations()
    {
        itemList = new List<T>();
    }

    public void Add(T item)
    {
        itemList.Add(item);
        Console.WriteLine("Item added successfully.");
    }

    public void Update(T item)
    {
        // Implement update logic based on your requirements
        Console.WriteLine("Item updated successfully.");
    }

    public void Delete(T item)
    {
        itemList.Remove(item);
        Console.WriteLine("Item deleted successfully.");
    }

    public void DisplayAll()
    {
        Console.WriteLine("Items in the list:");
        foreach (var item in itemList)
        {
            Console.WriteLine(item);
        }
    }
}

class Program
{
    static void Main()
    {
        // Create instances of CrudOperations for each type
        var studentCrud = new CrudOperations<Student>();
        var teacherCrud = new CrudOperations<Teacher>();
        var courseCrud = new CrudOperations<Course>();

        int choice;
        do
        {
            Console.WriteLine("\nMenu:");
            Console.WriteLine("1. Add");
            Console.WriteLine("2. Update");
            Console.WriteLine("3. Delete");
            Console.WriteLine("4. Display All");
            Console.WriteLine("5. Exit");

            Console.Write("Enter your choice (1-5): ");
            if (int.TryParse(Console.ReadLine(), out choice))
            {
                switch (choice)
                {
                    case 1:
                        Console.WriteLine("\nEnter details:");
                        Console.Write("ID: ");
                        int id = int.Parse(Console.ReadLine());
                        Console.Write("Name: ");
                        string name = Console.ReadLine();

                        Console.WriteLine("\nSelect type:");
                        Console.WriteLine("1. Student");
                        Console.WriteLine("2. Teacher");
                        Console.WriteLine("3. Course");
                        Console.Write("Enter your choice (1-3): ");
                        int typeChoice = int.Parse(Console.ReadLine());

                        switch (typeChoice)
                        {
                            case 1:
                                studentCrud.Add(new Student { Id = id, Name = name });
                                break;
                            case 2:
                                teacherCrud.Add(new Teacher { Id = id, Name = name });
                                break;
                            case 3:
                                courseCrud.Add(new Course { Id = id, Name = name });
                                break;
                            default:
                                Console.WriteLine("Invalid choice");
                                break;
                        }
                        break;

                    case 2:
                        // Implement update logic based on your requirements
                        Console.WriteLine("Update operation not implemented in this example.");
                        break;

                    case 3:
                        Console.WriteLine("\nEnter details to delete:");
                        Console.Write("ID: ");
                        int deleteId = int.Parse(Console.ReadLine());

                        Console.WriteLine("\nSelect type to delete:");
                        Console.WriteLine("1. Student");
                        Console.WriteLine("2. Teacher");
                        Console.WriteLine("3. Course");
                        Console.Write("Enter your choice (1-3): ");
                        int deleteTypeChoice = int.Parse(Console.ReadLine());

                        switch (deleteTypeChoice)
                        {
                            case 1:
                                studentCrud.Delete(new Student { Id = deleteId });
                                break;
                            case 2:
                                teacherCrud.Delete(new Teacher { Id = deleteId });
                                break;
                            case 3:
                                courseCrud.Delete(new Course { Id = deleteId });
                                break;
                            default:
                                Console.WriteLine("Invalid choice");
                                break;
                        }
                        break;

                    case 4:
                        Console.WriteLine("\nDisplaying all items:");
                        studentCrud.DisplayAll();
                        teacherCrud.DisplayAll();
                        courseCrud.DisplayAll();
                        break;

                    case 5:
                        Console.WriteLine("Exiting the program.");
                        break;

                    default:
                        Console.WriteLine("Invalid choice. Please enter a number between 1 and 5.");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Invalid input. Please enter a number.");
            }

        } while (choice != 5);
    }
}
