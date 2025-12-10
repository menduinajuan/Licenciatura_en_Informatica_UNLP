package oo1_e20;

import java.time.LocalDate;

public class DateLapse extends DateLapseAbstract {

    private LocalDate from;
    private LocalDate to;

    public DateLapse(LocalDate from, LocalDate to) {
        super(from);
        this.to=to;
    }

    @Override
    public LocalDate getTo() {
        return this.to;
    }

}