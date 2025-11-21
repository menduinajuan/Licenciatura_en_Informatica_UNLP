package oo1_e12;

public class JS_LIFO extends JobScheduler {

    public JS_LIFO() {
        super();
    }

    @Override
    public JobDescription nextStrategy() {
        return this.getJobs().get(this.getJobs().size()-1);
    }

}