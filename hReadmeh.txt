//helper

package database

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.util.Log
import android.widget.Toast


class sqlitehelper(context: Context):SQLiteOpenHelper(context, dbname,null, dbversion) {

    companion object{
        private  val dbname="dbschool"
        private  val dbversion =1
        private  val tblname="tblstudent"
        private val column1="id"
        private val column2="name"
    }

    override fun equals(other: Any?): Boolean {
        return super.equals(other)
    }

    override fun onCreate(db: SQLiteDatabase?) {
       var query = "CREATE TABLE $tblname ($column1 INTEGER PRIMARY KEY,$column2 TEXT)"
        db?.execSQL(query)
    }

    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {
        var query = "DROP TABLE $tblname"
        db?.execSQL(query)
        onCreate(db)
    }

    fun addstud(student: student):Boolean
    {
        val db = this.writableDatabase
        val values = ContentValues()
        values.put(column1,student.id)
        values.put(column2,student.name)

        var result = db.insert(tblname,null,values)

        if(result.toInt() ==-1)
        {
            return false
        }else
        {
            return true
        }
    }
    fun deletestud(id: Int):Boolean
    {
        val db = this.writableDatabase

        var result = db.delete(tblname,"id="+id, null)

        if (result == -1)
        {
            return false
        }else{
            return true
        }
    }

    fun editstud(student: student):Boolean
    {
        var db = this.writableDatabase
        val values = ContentValues()
        values.put(column1,student.id)
        values.put(column2,student.name)

        var result = db.update(tblname,values,"id="+student.id,null)
        if (result == -1)
        {
            return false
        }
        else
        {
            return true
        }
    }

    fun display():ArrayList<student>{
        val data = ArrayList<student>()
        val db = this.readableDatabase
        val query = "SELECT * FROM $tblname"
        val cursor = db.rawQuery(query,null)
        cursor.use {
            while (cursor.moveToNext())
            {
                val idIndex = cursor.getColumnIndex(column1)
                val nameIndex = cursor.getColumnIndex(column2)
                if (idIndex != -1 && nameIndex != -1) {
                    val id = cursor.getInt(idIndex)
                    val name = cursor.getString(nameIndex)
                    val student = student(id,name)
                    data.add(student)
                }else{
                    Log.e("tblname", "Column $column1 not found in cursor")
                }
            }
        }
        cursor.close()
        return data
    }

    fun checkuser(name: String):Boolean
    {
        val db = this.readableDatabase
        val query = "SELECT * FROM $tblname where  $column2 = ?"
        val cursor = db.rawQuery(query, arrayOf(name))
        val count = cursor.count
        cursor.close()
        return count > 0
    }
}



//dataaclass
package database

data class student(var id:Int, var name:String){




}



//main
package com.example.sqlitecrud

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.EditText
import android.widget.ListView
import android.widget.Toast
import database.sqlitehelper
import database.student

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        var txtid:EditText = findViewById(R.id.id)
        var txtname:EditText = findViewById(R.id.name)
        var add:Button = findViewById(R.id.add)
        val sqlitehelper = sqlitehelper(this)
        val dele:Button = findViewById(R.id.Delete)
        val edit:Button = findViewById(R.id.Edit)
        val display:Button = findViewById(R.id.Display)

        add.setOnClickListener(View.OnClickListener {
            var id = Integer.parseInt(txtid.text.toString())
            var name = txtname.text.toString()

            var result = sqlitehelper.addstud(student(id,name))

            if (result == true)
                Toast.makeText(this,"Inserted Succesfull",Toast.LENGTH_LONG).show()
        })
        dele.setOnClickListener(View.OnClickListener {
            var id = Integer.parseInt(txtid.text.toString())

            var result = sqlitehelper.deletestud(id)

            if(result == true)
                Toast.makeText(this,"Deleted Succesully",Toast.LENGTH_LONG).show()
        })
        edit.setOnClickListener(View.OnClickListener {
            var id = Integer.parseInt(txtid.text.toString())
            var name = txtname.text.toString()
            var result = sqlitehelper.editstud(student(id,name))
            if (result == true)
                Toast.makeText(this,"Edited",Toast.LENGTH_LONG).show()
        })
        display.setOnClickListener(View.OnClickListener {
            val listview = findViewById<ListView>(R.id.listview)
            val data = sqlitehelper.display()

            val adapter = ArrayAdapter(this,android.R.layout.simple_list_item_1,data)
            listview.adapter = adapter


        })

        val logout:Button = findViewById(R.id.Logout)

        logout.setOnClickListener(View.OnClickListener {
            val intent = Intent(this,Login::class.java)
            startActivity(intent)
        })
    }
}




/////

package com.example.sqlitecrud

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import database.sqlitehelper

class Login : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

       val username:EditText = findViewById(R.id.username)
       val login:Button = findViewById(R.id.login)

       val sqlitehelper = sqlitehelper(this)

        login.setOnClickListener(View.OnClickListener {
            var username = username.text.toString()
            val isvalidate = sqlitehelper.checkuser(username)
            if (isvalidate)
            {
                val intent = Intent(this,MainActivity::class.java)
                startActivity(intent)
            }else {
                Toast.makeText(this,"Invalid Crediantial ",Toast.LENGTH_LONG).show()
            }

        })
    }
}


 val option = resources.getStringArray(R.array.spinner_option)

        val data = listOf("Item 1", "Item 2", "Item 3")

        val arraydapter = ArrayAdapter(this,android.R.layout.simple_spinner_item,option)

        arraydapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)

        spinner.adapter = arraydapter


        spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener{
            override fun onItemSelected(
                parent: AdapterView<*>?,
                view: View?,
                position: Int,
                id: Long
            ) {
                var selectedOption = parent?.getItemAtPosition(position).toString()

                Toast.makeText(this@MainActivity,"Selected $selectedOption",Toast.LENGTH_LONG).show()
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
                /* TODO("Not yet implemented")*/
            }
        }
        val selctop = spinner.selectedItem.toString()

