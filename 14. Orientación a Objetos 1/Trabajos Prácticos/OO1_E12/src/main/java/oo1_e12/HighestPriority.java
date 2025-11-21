package oo1_e12;

import java.util.*;

public class HighestPriority implements Strategy {

    @Override
    public JobDescription next(List<JobDescription> jobs) {
        return jobs.stream().max((j1,j2)->Double.compare(j1.getPriority(),j2.getPriority())).orElse(null);
    }

}