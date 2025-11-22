package oo1_e12;

public class JS_FIFO extends JobScheduler {

    public JS_FIFO() {
        super();
    }

    @Override
    public JobDescription nextStrategy() {
        return !this.getJobs().isEmpty() ? this.getJobs().get(0) : null;
    }

}