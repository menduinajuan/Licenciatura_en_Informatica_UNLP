package oo1_e12;

import java.util.*;

public class FIFO implements Strategy {

    @Override
    public JobDescription next(List<JobDescription> jobs) {
        return jobs.get(0);
    }

}