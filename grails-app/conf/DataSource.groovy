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
                port = 10058
                username = "heroku"
                password = "927091a2861674b3a1438b3905499f68"
                databaseName = "app15680173"
            }
        }
    }
}
