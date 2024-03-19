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





