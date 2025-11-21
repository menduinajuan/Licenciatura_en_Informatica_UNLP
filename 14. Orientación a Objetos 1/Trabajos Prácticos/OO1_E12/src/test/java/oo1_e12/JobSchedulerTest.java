package oo1_e12;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class JobSchedulerTest {

    private JobDescription firstJob;
    private JobDescription highestPriorityJob;
    private JobDescription mostEffortJob;
    private JobDescription lastJob;

    @BeforeEach
    public void setUp() throws Exception {
        firstJob=new JobDescription(1, 1, "Éste es el primero");
        highestPriorityJob=new JobDescription(1, 100, "Éste es el de más prioridad");
        mostEffortJob=new JobDescription(100, 1, "Éste es el de más esfuerzo");
        lastJob=new JobDescription(1, 1, "Éste es el último");
    }

    private JobScheduler newFifoScheduler() {
        JobScheduler fifoScheduler=new JobScheduler();
        fifoScheduler.setStrategy(new FIFO());
        return fifoScheduler;
    }

    private JobScheduler newLifoScheduler() {
        JobScheduler lifoScheduler=new JobScheduler();
        lifoScheduler.setStrategy(new LIFO());
        return lifoScheduler;
    }

    private JobScheduler newPriorityScheduler() {
        JobScheduler priorityScheduler=new JobScheduler();
        priorityScheduler.setStrategy(new HighestPriority());
        return priorityScheduler;
    }

    private JobScheduler newEffortScheduler() {
        JobScheduler effortScheduler=new JobScheduler();
        effortScheduler.setStrategy(new MostEffort());
        return effortScheduler;
    }

    private void scheduleJobsIn(JobScheduler aJobScheduler) {
        aJobScheduler.schedule(firstJob);
        aJobScheduler.schedule(highestPriorityJob);
        aJobScheduler.schedule(mostEffortJob);
        aJobScheduler.schedule(lastJob);
    }

    @Test
    public void testSchedule() {
        JobScheduler aScheduler=new JobScheduler();
        aScheduler.schedule(highestPriorityJob);
        assertTrue(aScheduler.getJobs().contains(highestPriorityJob));
    }

    @Test
    public void testUnschedule() {
        JobScheduler aScheduler = new JobScheduler();
        this.scheduleJobsIn(aScheduler);
        aScheduler.unschedule(highestPriorityJob);
        assertFalse(aScheduler.getJobs().contains(highestPriorityJob));
    }

    @Test
    public void testNext() {
        JobScheduler scheduler;
        scheduler=this.newFifoScheduler();
        this.scheduleJobsIn(scheduler);
        assertEquals(scheduler.next(), firstJob);
        assertEquals(scheduler.getJobs().size(), 3);
        scheduler=this.newLifoScheduler();
        this.scheduleJobsIn(scheduler);
        assertEquals(scheduler.next(), lastJob);
        assertEquals(scheduler.getJobs().size(), 3);
        scheduler=this.newPriorityScheduler();
        this.scheduleJobsIn(scheduler);
        assertEquals(scheduler.next(), highestPriorityJob);
        assertEquals(scheduler.getJobs().size(), 3);
        scheduler=this.newEffortScheduler();
        this.scheduleJobsIn(scheduler);
        assertEquals(scheduler.next(), mostEffortJob);
        assertEquals(scheduler.getJobs().size(), 3);
    }

}