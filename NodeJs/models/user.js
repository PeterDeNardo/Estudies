const mongodb = require('mongodb');
const getDb = require('../util/database').getDb;

const ObjectId = mongodb.ObjectID;

class User {
    constructor(userName, email, cart, id) {
        this.name = userName;
        this.email = email;
        this.cart = cart;
        this._id = id
    }

    save() {
        if (self.newNoteTitle().length > 0 && self.newNoteContent().length > 0) {
            self.saveButtonEnabled(false);
            
            //Pega os valores do HTML e salva dentro de um Jeason 
            var record = {
                recordType: "CloudNote",
                fields: {
                    title: {
                        value: self.newNoteTitle()
                    },
                    text: {
                        value: self.newNoteContent()
                    }
                }
            };
            
            // Envia o Jeason criado para o servidor e salva;
            publicDB.saveRecord(record).then(
                function(response) {
                    if (response.hasErrors) {
                        console.error(response.errors[0]);
                        self.saveButtonEnabled(true);
                        return;
                    }
                    var createdRecord = response.records[0];
                    self.notes.push(createdRecord);

                    self.newNoteTitle("");
                    self.newNoteContent("");
                    self.saveButtonEnabled(true);
                }
            );

        }
        else {
            alert('Note must have a title and some content');
        }
        
    }

    save() {
        const db = getDb();
        return db
            .collection('users')
            .insertOne(this);
    }

    
}

module.exports = User;