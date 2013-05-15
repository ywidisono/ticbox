environments {
    development {
        grails {
            mongo {
                host = "localhost"
                port = 27017
                username = "ticbox"
                password = "ticbox"
                databaseName = "ticbox"
            }
        }
    }
    test {
    }
    production {
        grails {
            mongo {
                host = "linus.mongohq.com"
                port = 10012
                username = "heroku"
                password = "ticbox"
                databaseName = "app15680173"
            }
        }
    }
}
