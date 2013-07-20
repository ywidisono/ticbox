package ticbox

import java.util.concurrent.Callable
import java.util.concurrent.Executors

class EmailBlasterService {

    static int max_email_per_job = 10
    static int max_concurrent_job = 10

    def transaction = false

    def mailService

    def blastEmail(List<String> recipients, String templateName, String subjectStr, Map model){

        int poolSize = recipients.size() >= max_email_per_job * max_concurrent_job ? max_concurrent_job : ((recipients.size() % max_email_per_job) + 1)
        def threadPool = Executors.newFixedThreadPool(poolSize)

        def sendEmailClosure = { recipients_ ->
            recipients_?.each {recipient ->
                mailService.sendMail {
                    to recipient
                    subject subjectStr
                    body(
                            view: "/emailTemplates/${templateName}",
                            model: model
                    )
                }
            }
        }

        def futures = []

        recipients?.collate(max_email_per_job, max_email_per_job, true)?.each { recipients_split ->
            futures << threadPool.submit({-> sendEmailClosure recipients_split} as Callable)
        }

        futures.each {println it.get()}

        threadPool.shutdown()

    }
}
