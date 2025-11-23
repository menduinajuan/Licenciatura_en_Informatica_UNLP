package oo1_e17;

import java.time.LocalDate;

public class DateLapse2 extends DateLapseAbstract {

    private LocalDate from;
    private long sizeInDays;

    public DateLapse2(LocalDate from, long sizeInDays) {
        super(from);
        this.sizeInDays=sizeInDays;
    }

    @Override
    public LocalDate getTo() {
        return this.getFrom().plusDays(this.sizeInDays);
    }

}