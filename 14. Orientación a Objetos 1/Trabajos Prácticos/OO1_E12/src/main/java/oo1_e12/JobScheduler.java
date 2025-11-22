package oo1_e12;

import java.util.*;

public abstract class JobScheduler {

    private List<JobDescription> jobs;

    public JobScheduler () {
        this.jobs=new ArrayList<>();
    }

    public void schedule(JobDescription job) {
        this.jobs.add(job);
    }

    public void unschedule(JobDescription job) {
        if (job!=null)
            this.jobs.remove(job);
    }

    public List<JobDescription> getJobs(){
        return this.jobs;
    }

    public JobDescription next() {
        JobDescription nextJob=this.nextStrategy();
        this.unschedule(nextJob);
        return nextJob;
    }

    public abstract JobDescription nextStrategy();

}