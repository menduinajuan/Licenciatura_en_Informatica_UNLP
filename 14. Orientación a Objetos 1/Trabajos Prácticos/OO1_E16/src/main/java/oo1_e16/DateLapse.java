package oo1_e16;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class DateLapse {

    private LocalDate from;
    private LocalDate to;

    public DateLapse(LocalDate from, LocalDate to) {
        this.from=from;
        this.to=to;
    }

    public LocalDate getFrom() {
        return this.from;
    }

    public LocalDate getTo() {
        return this.to;
    }

    public long sizeInDays() {
        return ChronoUnit.DAYS.between(this.getFrom(), this.getTo());
    }

    public boolean includesDate(LocalDate other) {
        return (other.equals(this.getFrom()) || other.isAfter(this.getFrom())) &&
               (other.equals(this.getTo()) || other.isBefore(this.getTo()));
        //return (!other.isBefore(this.getFrom()) && !other.isAfter(this.getTo()));
    }

}