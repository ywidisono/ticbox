package ticbox

import org.apache.shiro.SecurityUtils

class TicboxUtilsService {

    def serviceMethod() {

    }

    def getPrincipal(){
        SecurityUtils.subject.principal
    }
}
