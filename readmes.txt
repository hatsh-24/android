const mongoose = require ('mongoose');

const userchema = new mongoose.Schema(
    {
        name: String,
        email : String
    }
);

module.exports = mongoose.model('User',userchema);



const express = require('express');
const mongoose = require('mongoose');
const bodyparser = require('body-parser');
const User = require('./model/user');

const app = express();

app.set('viw egine','ejs');

app.use(bodyparser.urlencoded({extended:true}));
app.use(express.static('public'));

mongoose.connect('mongodb://127.0.0.1:27017/crud-app',{
    useNewUrlParser:true,
    useUnifiedTopology:true,
}).then(()=>{
    console.log('Connected to MongoDB');
}).catch((erroe)=>{
    console.log('Error connecting to MongoDB');
});

app.get('/',async(req,res)=>{
    const users = await User.find();
    res.render('index',{users});
});

app.get('/add',(req,res)=>{
    res.render('add-user');
});

app.post('/add',async(req,res)=>{
    const {name,email} = req.body;
    const newUser = new User({name,email});
    await newUser.save();
    res.redirect('/');
});

app.get('/delete/:id',async (req,res)=>{
    await User.findByIdAndDelete(req.params.id);
    res.redirect('/');
});

const PORT = 3000;
app.listen(PORT,()=>{
    console.log(`Server is running on port ${PORT}`);
});












<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/style.css">
    <title>Add User</title>
</head>
<body>
    <h1>Add New User</h1>
    <form action="/add" method="POST">
        <label>Name:</label>
        <input type="text" name="name" required><br>
        <label>Email:</label>
        <input type="email" name="email" required><br>
        <label>Age:</label>
        <input type="number" name="age" required><br>
        <button type="submit">Add User</button>
    </form>
    <a href="/">Back to User List</a>
</body>
</html>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/style.css">
    <title>User List</title>
</head>
<body>
    <h1>User List</h1>
    <a href="/add">Add New User</a>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Age</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% users.forEach(function(user){ %>
            <tr>
                <td><%= user.name %></td>
                <td><%= user.email %></td>
                <td><%= user.age %></td>
                <td>
                    <a href="/edit/<%= user._id %>">Edit</a>
                    <a href="/delete/<%= user._id %>">Delete</a>
                </td>
            </tr>
            <% }) %>
        </tbody>
    </table>
</body>
</html>
