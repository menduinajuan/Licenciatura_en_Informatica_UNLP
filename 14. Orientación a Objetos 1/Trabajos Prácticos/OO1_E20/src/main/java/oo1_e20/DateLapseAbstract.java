package oo1_e20;

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

    @Override
    public boolean overlaps(DateLapse anotherDateLapse) {
        return !this.getTo().isBefore(anotherDateLapse.getFrom()) && !this.getFrom().isAfter(anotherDateLapse.getTo());
    }

    public boolean nowIsBeforeThis() {
        return LocalDate.now().isBefore(this.getFrom());
    }

    public boolean isWithinXDaysBeforeStart(int dias) {
        return !LocalDate.now().isBefore(this.getFrom().minusDays(dias)) && this.nowIsBeforeThis();
    }

}