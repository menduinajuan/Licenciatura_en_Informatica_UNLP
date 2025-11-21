package oo1_e12;

public class JS_MostEffort extends JobScheduler {

    public JS_MostEffort() {
        super();
    }

    @Override
    public JobDescription nextStrategy() {
        return this.getJobs().stream().max((j1,j2)->Double.compare(j1.getEffort(),j2.getEffort())).orElse(null);
    }

}