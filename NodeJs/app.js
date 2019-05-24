const path = require('path');
const express = require('express');
const bodyParser = require('body-parser')

const errorController = require('./controllers/error')
const mongoConnect = require('./util/database').mongoConnect;
const User = require('./models/user');

const app = express();

//global configurate values
app.set('view engine', 'ejs');
app.set('views', 'views')

//Routes
const adminRoutes = require('./routes/admin');
const shopRoutes = require('./routes/shop');

app.use(bodyParser.urlencoded({extends: false}));
app.use(express.static(path.join(__dirname, 'public')))

app.use((req, res , next) => {
    User.findById('5c334d9be0d4652199a2a70b')
        .then(user => {
            req.user = new User(user.name, user.email, user.cart, user._id);
            next()
    })
    .catch(err => console.log(err));
});

app.use('/admin', adminRoutes);
app.use(shopRoutes);

app.use(errorController.get404Page);

mongoConnect(() => {
    app.listen(3000);
});