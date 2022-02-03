const mongoose = require('mongoose')
const userSchema = new mongoose.Schema({
    uname:{
        type:String
    },
    email:{
        type:String
    },
    password:{
        type:String
    },
    encryptedID:{
        type:String
    }
})

const UserModel = new mongoose.model('User',userSchema);
module.exports = UserModel