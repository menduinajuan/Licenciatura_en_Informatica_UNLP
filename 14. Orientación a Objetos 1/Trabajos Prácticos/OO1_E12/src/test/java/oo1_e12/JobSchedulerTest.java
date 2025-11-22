package oo1_e12;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

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
        return new JS_FIFO();
    }

    private JobScheduler newLifoScheduler() {
        return new JS_LIFO();
    }

    private JobScheduler newPriorityScheduler() {
        return new JS_HighestPriority();
    }

    private JobScheduler newEffortScheduler() {
        return new JS_MostEffort();
    }

    private void scheduleJobsIn(JobScheduler aJobScheduler) {
        aJobScheduler.schedule(this.firstJob);
        aJobScheduler.schedule(this.highestPriorityJob);
        aJobScheduler.schedule(this.mostEffortJob);
        aJobScheduler.schedule(this.lastJob);
    }

    @Test
    public void testSchedule() {
        JobScheduler aScheduler=new JS_FIFO();
        this.scheduleJobsIn(aScheduler);
        assertTrue(aScheduler.getJobs().contains(this.firstJob));
    }

    @Test
    public void testUnschedule() {
        JobScheduler aScheduler=new JS_FIFO();
        this.scheduleJobsIn(aScheduler);
        aScheduler.unschedule(this.firstJob);
        assertFalse(aScheduler.getJobs().contains(this.firstJob));
    }

    @Test
    public void testNext() {

        JobScheduler scheduler;

        scheduler=this.newFifoScheduler();
        assertNotEquals(scheduler.next(), this.firstJob);
        assertEquals(scheduler.getJobs().size(), 0);
        this.scheduleJobsIn(scheduler);
        assertEquals(scheduler.next(), this.firstJob);
        assertEquals(scheduler.getJobs().size(), 3);

        scheduler=this.newLifoScheduler();
        assertNotEquals(scheduler.next(), this.lastJob);
        assertEquals(scheduler.getJobs().size(), 0);
        this.scheduleJobsIn(scheduler);
        assertEquals(scheduler.next(), this.lastJob);
        assertEquals(scheduler.getJobs().size(), 3);

        scheduler=this.newPriorityScheduler();
        assertNotEquals(scheduler.next(), this.highestPriorityJob);
        assertEquals(scheduler.getJobs().size(), 0);
        this.scheduleJobsIn(scheduler);
        assertEquals(scheduler.next(), this.highestPriorityJob);
        assertEquals(scheduler.getJobs().size(), 3);

        scheduler=this.newEffortScheduler();
        assertNotEquals(scheduler.next(), this.mostEffortJob);
        assertEquals(scheduler.getJobs().size(), 0);
        this.scheduleJobsIn(scheduler);
        assertEquals(scheduler.next(), this.mostEffortJob);
        assertEquals(scheduler.getJobs().size(), 3);

    }

}