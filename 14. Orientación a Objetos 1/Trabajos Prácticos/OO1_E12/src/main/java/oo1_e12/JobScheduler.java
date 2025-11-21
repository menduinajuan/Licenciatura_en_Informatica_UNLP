package oo1_e12;

import java.util.*;

public class JobScheduler {

    private List<JobDescription> jobs;
    private Strategy strategy;

    public JobScheduler () {
        this.jobs=new ArrayList<>();
    }

    public void setStrategy(Strategy strategy) {
        this.strategy=strategy;
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

    public Strategy getStrategy() {
        return this.strategy; 
    }

    public JobDescription next() {
        JobDescription nextJob=null;
        if (this.getJobs()!=null) {
            nextJob=this.getStrategy().next(this.getJobs());
            this.unschedule(nextJob);
        }
        return nextJob;
    }

}