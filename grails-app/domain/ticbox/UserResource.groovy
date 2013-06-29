package ticbox

import org.bson.types.ObjectId

class UserResource {

    ObjectId id
    String kind

    static belongsTo = [user: User]

    static constraints = {
    }
}
