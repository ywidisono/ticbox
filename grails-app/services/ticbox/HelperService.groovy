package ticbox

import org.springframework.context.i18n.LocaleContextHolder

class HelperService {

    def messageSource

    static List<Long> getListOfLong(String[] ids) {
        def res = []
        for (String id : ids) {
            res << Long.parseLong(id)
        }
        return res
    }

    public String getProperty(String key, String defaultVal){
        return messageSource.getMessage(key, [], defaultVal, LocaleContextHolder.getLocale())
    }
}
