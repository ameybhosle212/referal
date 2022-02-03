const route = require('express').Router()
const User = require('../model/user')
const jwt = require('jsonwebtoken')
var bcrypt = require('bcryptjs');
var CryptoJS = require("crypto-js");
var salt = bcrypt.genSaltSync(10);
require('dotenv').config()

route.post("/profile",async(req,res)=>{
    const token = req.body.token;
    var decoded = jwt.verify(token, process.env.secret);
    const data = await User.find({uname:decoded.uname});
    if(data){
        const profileData={
            "referals":[
                {
                    "name":"amey",
                    "reward":"100",
                    "investment":"Myntra"
                },
                {
                    "name":"Nitn",
                    "reward":"870",
                    "investment":"Flipkart"
                },
                {
                    "name":"Satendra",
                    "reward":"0",
                    "investment":"Amazon"
                },
                {
                    "name":"Star",
                    "reward":"100",
                    "investment":"WEHUNT"
                },
            ]
        };
        return res.json({'data':profileData,'error':null})
    }else{
        return res.json({'data':'error occured','status':'error','error':'error'})
    }
})

route.post("/register",async(req,res)=>{
    const {uname, email , password} = req.body;
    const data = await User.findOne({email:email})
    if(!data){
        var hash = bcrypt.hashSync(password, salt);
        const newUser = new User({
            uname:uname,
            email:email,
            password:hash
        })
        newUser.encryptedID = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(newUser._id.toString()));
        newUser.save();
        return res.json({'data':newUser,'status':'ok','error':null})
    }else{
        return res.json({'data':'Email Id exists','status':'error','error':'error'})
    }
})

route.post("/login",async(req,res)=>{
    const {email , password} = req.body;
    const data = await User.findOne({email:email});
    if(!data){
        return res.json({'data':'Redirect to register','status':'error','error':'error','redirect':'register'})
    }else{
        var dd = bcrypt.compareSync(password,data.password);
        if(dd){
            var ob = {
                'uname':data.uname
            }
            var token = jwt.sign(ob,process.env.secret)
            return res.json({'token':token,'status':'ok','error':null})
        }else{
            return res.json({'data':'incorrect Password','status':'null'})
        }
    }
})


module.exports = route;