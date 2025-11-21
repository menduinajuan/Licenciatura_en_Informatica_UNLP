package oo1_e12;

public class JS_HighestPriority extends JobScheduler {

    public JS_HighestPriority() {
        super();
    }

    @Override
    public JobDescription nextStrategy() {
        return this.getJobs().stream().max((j1,j2)->Double.compare(j1.getPriority(),j2.getPriority())).orElse(null);
    }

}