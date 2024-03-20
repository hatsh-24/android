Scaffold-DbContext "Data Source=laptop-8tcmrkva;Initial Catalog=InterestFinder;Integrated Security=True;Trust Server Certificate=True" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models

"AllowedHosts": "*",
"ConnectioinStrings":{
  "DBConnection":"Data Source=Sanket\\SQLEXPRESS;Initial Catalog=test;Integrated Security=True;Encrypt=True;Trust Server Certificate=True"
}

builder.Services.AddDbContext<TestContext>(
    s => s.UseSqlServer(builder.Configuration.GetConnectionString("DBConnection")));


////////////////////////////Api//////////////////////////////////////////////////////////////////////////
nuggate packet 1.tools,2Sqlserver,3Frameworkcore

context:-
first comment 2 lines

CongfigurationBuilder confBuilder = new CongfigurationBuilder()
	optionBuilder.UseSqlserver(confBuilder.Build).GetConnectionString("DBConnectionString"));

 Program.cs:-
Add Coneection String 
-Rebuild

Create Api Controller

Api Will Created <=Copy Url


Crate a New MVC Project
nuggate packet =>newtonsoft.json

crate a mode class
Create Same Properties AS We Have In DB or In Api Url

Add Controller:-
regulare Read/Write Controller OF Author

public string baseUrlTeacher = "http://localhost:5074/api/Teachers";

HttpClient client = new HttpClient();

-----------------
 public async Task<Teacher> GetTeacherById(int id)
 {
     var ResponseValue = await client.GetAsync(baseUrlTeacher + "/" + id.ToString());
     var response = await ResponseValue.Content.ReadAsStringAsync();
     var teacher = JsonConvert.DeserializeObject<Teacher>(response);
     return teacher;
 }

 public async Task<IEnumerable<Teacher>> GetTeacherByName(string tname)
 {
     var ResponseValue = await client.GetAsync(baseUrlTeacher + "/designation/" + tname.ToString());
     var response = await ResponseValue.Content.ReadAsStringAsync();
     var teacher = JsonConvert.DeserializeObject<List<Teacher>>(response);
     return teacher;
 }

---------------------

 // GET: TeacherController
 public async Task<ActionResult> Index()
 {
     var ResponseValue = await client.GetAsync(baseUrlTeacher);
     var response = await ResponseValue.Content.ReadAsStringAsync();
     var listTeachers = JsonConvert.DeserializeObject<List<Teacher>>(response);
     return View(listTeachers);
 }

 // GET: TeacherController/Details/5
 public async Task<ActionResult> Details(int id)
 {
     var teacher = await GetTeacherById(id);
     return View(teacher);
 }
----------------------------------------
// GET: TeacherController/Search
public ActionResult Search()
{
    return View();
}

// POST: TeacherController/Search
[HttpPost]
[ValidateAntiForgeryToken]
public async Task<ActionResult> Search(string tname)
{
    try
    {
        var teacher = await GetTeacherByName(tname);
        return View(teacher);
    }
    catch
    {
        return View();
    }
}



//....................Android ...///////////

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MVC_API___Prc1.Models;
using Newtonsoft.Json;
using System.Drawing.Imaging;
using System.Text;
using System.Text.Json.Serialization;

namespace MVC_API___Prc1.Controllers
{
    public class TeacherController : Controller
    {
        public string baseUrlTeacher = "http://localhost:5074/api/Teachers";

        HttpClient client = new HttpClient();

        public async Task<Teacher> GetTeacherById(int id)
        {
            var ResponseValue = await client.GetAsync(baseUrlTeacher + "/" + id.ToString());
            var response = await ResponseValue.Content.ReadAsStringAsync();
            var teacher = JsonConvert.DeserializeObject<Teacher>(response);
            return teacher;
        }

        public async Task<IEnumerable<Teacher>> GetTeacherByName(string tname)
        {
            var ResponseValue = await client.GetAsync(baseUrlTeacher + "/designation/" + tname.ToString());
            var response = await ResponseValue.Content.ReadAsStringAsync();
            var teacher = JsonConvert.DeserializeObject<List<Teacher>>(response);
            return teacher;
        }

        // GET: TeacherController
        public async Task<ActionResult> Index()
        {
            var ResponseValue = await client.GetAsync(baseUrlTeacher);
            var response = await ResponseValue.Content.ReadAsStringAsync();
            var listTeachers = JsonConvert.DeserializeObject<List<Teacher>>(response);
            return View(listTeachers);
        }

        // GET: TeacherController/Details/5
        public async Task<ActionResult> Details(int id)
        {
            var teacher = await GetTeacherById(id);
            return View(teacher);
        }

        // GET: TeacherController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: TeacherController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create(Teacher teacher)
        {
            try
            {
                var jsonData = JsonConvert.SerializeObject(teacher);
                var ResponseData = await client.PostAsync(baseUrlTeacher, new StringContent(jsonData, Encoding.UTF8, "application/json"));
                Console.WriteLine(ResponseData);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: TeacherController/Search
        public ActionResult Search()
        {
            return View();
        }

        // POST: TeacherController/Search
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Search(string tname)
        {
            try
            {
                var teacher = await GetTeacherByName(tname);
                return View(teacher);
            }
            catch
            {
                return View();
            }
        }

        // GET: TeacherController/Edit/5
        public async Task<ActionResult> Edit(int id)
        {
            var teacher = await GetTeacherById(id);
            return View(teacher);
        }

        // POST: TeacherController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit(int id, Teacher teacher)
        {
            try
            {
                var jsonData = JsonConvert.SerializeObject(teacher);
                var ResponseData = await client.PutAsync(baseUrlTeacher + "/" + id.ToString(), new StringContent(jsonData, Encoding.UTF8, "application/json"));
                Console.WriteLine(ResponseData);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: TeacherController/Delete/5
        public async Task<ActionResult> Delete(int id)
        {
            var teacher = await GetTeacherById(id);
            return View(teacher);
        }

        // POST: TeacherController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete(int id, Teacher teacher)
        {
            try
            {
                var jsonData = JsonConvert.SerializeObject(teacher);
                var ResponseData = await client.DeleteAsync(baseUrlTeacher + "/" + id.ToString());
                Console.WriteLine(ResponseData);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}






//



using Employeecrud.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Employeecrud.Controllers
{
    public class EmployeeController : Controller
    {
        private static List<Employee> employees = new List<Employee>();

        public EmployeeController() 
        {
            if(employees.Count <1)
            {
                employees.Add(new Employee { EmpId = 1, EmpName = "sanket", Designation = "Oprator", Age = 21 });

                employees.Add(new Employee { EmpId = 2, EmpName = "Hatsh", Designation = "Hr", Age = 24 });

                employees.Add(new Employee { EmpId = 3, EmpName = "Dev", Designation = "Manager", Age = 23 });

                employees.Add(new Employee { EmpId = 4, EmpName = "vishv", Designation = "Hr", Age = 22 });
            }
        }

        // GET: EmployeeController
        public ActionResult Index()
        {
            return View(employees.ToList());
        }

        // GET: EmployeeController/Details/5
        public ActionResult Details(int id)
        {
            Employee employee = (from e in employees
                                 where e.EmpId == id
                                 select e).First();

            return View(employee);
        }

        // GET: EmployeeController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: EmployeeController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: EmployeeController/Edit/5
        public ActionResult Edit(int id)
        {
            var empToEdit = employees.SingleOrDefault(e=>e.EmpId == id);
            return View(empToEdit);
        }

        // POST: EmployeeController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, Employee editEmpoyee)
        {
            try
            {
                var empToEdit = employees.SingleOrDefault(e=>e.EmpId == id);

                empToEdit.EmpName = editEmpoyee.EmpName;
                empToEdit.Designation = editEmpoyee.Designation;
                empToEdit.Age = editEmpoyee.Age;

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: EmployeeController/Delete/5
        public ActionResult Delete(int id)
        {
            var empTODelete = employees.SingleOrDefault(e=>e.EmpId == id);

            return View(empTODelete);
        }

        // POST: EmployeeController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                var EmpToDelete = employees.SingleOrDefault(e=>e.EmpId == id);

                employees.Remove(EmpToDelete);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Search() { return View(); }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Search(Employee emptosearch)
        {
            try
            {
                // return RedirectToAction(nameof(Index));
                return RedirectToAction(nameof(searchResult), new
                {
                    searchByAge = emptosearch.Age,
                    name = emptosearch.EmpName
                });
            }
            catch
            {
                return View();
            }
        }

        public ActionResult searchResult(int searchByAge, String name)
        {
            var searchResult = from e in employees
                               where e.Age > searchByAge
                               && e.EmpName.Contains(name)
                               select e;

            return View(searchResult.ToList());
        }

        public IActionResult Login()
        { return View(); }

        public IActionResult Login(string username, string password)
        {
            var existinguser = employees.FirstOrDefault(e => e.EmpName.Equals(username) && e.Designation.Equals(password) );
            if(existinguser != null)
            {
                return View(existinguser);
            }
            return RedirectToAction("Index");

        }
    }
}



