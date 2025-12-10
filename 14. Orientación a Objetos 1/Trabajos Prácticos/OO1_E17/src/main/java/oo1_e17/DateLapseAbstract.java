package oo1_e17;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public abstract class DateLapseAbstract implements DateLapseInterface {
    
    private LocalDate from;

    public DateLapseAbstract(LocalDate from) {
        this.from=from;
    }

    @Override
    public LocalDate getFrom() {
        return this.from;
    }

    @Override
    public long sizeInDays() {
        return ChronoUnit.DAYS.between(this.getFrom(), this.getTo());
    }

    @Override
    public boolean includesDate(LocalDate other) {
        return (other.equals(this.getFrom()) || other.isAfter(this.getFrom())) &&
               (other.equals(this.getTo()) || other.isBefore(this.getTo()));
        //return (!other.isBefore(this.getFrom()) && !other.isAfter(this.getTo()));
    }

}