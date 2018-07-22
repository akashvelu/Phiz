var mysql = require('mysql');
var config = require('./config.json');
var pool = mysql.createPool ({
    host      :       config.dbhost,
    user      :       config.dbuser,
    password  :       config.dbpassword,
    database  :       config.dbname

})

function insertUser (callback, connection, fields) {
    var firstName = fields.firstName; 
    var lastName = fields.lastName; 
    var email = fields.email; 
    var username = fields.username; 

    var queryString = "INSERT INTO fizzAppSchema.Users (firstNameUsers, lastNameUsers, emailUsers, usernameUsers) VALUES ( " +  firstName + ", " + lastName + ", " + email + ", " + username + ")";
    connection.query(queryString, function(error, results, fields) {
        connection.release();
        if (error) {
            callback(error, "ERROR");
            return false; 
        } else { 
            callback(null, "Successfully inserted user " + username + " into database");
            return true; 
        }
    }); 
        
}

function insertRestaurant (callback, connection, fields) {
    var name = fields.name; 
    var address = fields.address; 
    var city = fields.city; 
    var state = fields.state; 
    var zip = fields.zip; 

    var queryString = "INSERT INTO fizzAppSchema.Restaurants (nameRestaurants, addressRestaurants, cityRestaurants, stateRestaurants, zipCodeRestaurants) VALUES (" +  name + ", " + address + ", " + city + ", " + state + ", " + zip + ")";
    connection.query(queryString, function(error, results, fields) {
        connection.release();
        if (error) {
            callback(error, "ERROR")
            return false; 
        } else {
            console.log("Successfully inserted " + name + " into database");
            return true; 
        }
    }); 
}

function insertPost (callback, connection, fields) {
    var caption = fields.caption; 
    var user = fields.user; 
    var restaurant = fields.restaurant; 
    var dish = fields.dish; 
    var pictureLink = fields.pictureLink; 

    var queryString = "INSERT INTO fizzAppSchema.Posts (captionPosts, userPosts, retaurantPosts, dishPosts, picturelinkPosts) VALUES (" +  caption + ", " + user + ", " + restaurant + ", " + dish + ", " + pictureLink + ")";
    connection.query(queryString, function(error, results, fields) {
        connection.release();
        if (error) console.log(error); 
        else console.log('Successful post entry');

    }); 
}





exports.handler = (event, context, callback) => {
    context.callbackWaitsForEmptyEventLoop = false; 
    pool.getConnection(function(err, connection) {
        if (err) callback(err); 
        var action = event.action; 
        var fields = event.fields; 

        var success = false; 
        if (action == "insertRestaurant") {
            success = insertRestaurant(callback, connection, fields);
        } else if (action == "insertUser") {
            success = insertUser(callback, connection, fields);
        } else if (action == "insertPost") {
            success = insertPost(callback, connection, fields); 
        } else {
            success = callback("Invalid action", null); 
        }
        
        if (success) {
            callback(null, "success"); 
        } else {
            callback("ERROR", null);
        }

    });
}



