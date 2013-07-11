package ticbox

class HelperService {

    static List<Long> getListOfLong(String[] ids) {
        def res = []
        for (String id : ids) {
            res << Long.parseLong(id)
        }
        return res
    }
}
