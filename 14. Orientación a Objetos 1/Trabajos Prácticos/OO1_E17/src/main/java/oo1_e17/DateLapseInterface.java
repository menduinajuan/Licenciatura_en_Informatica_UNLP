package oo1_e17;

import java.time.LocalDate;

public interface DateLapseInterface {

    public LocalDate getFrom();
    public LocalDate getTo();
    public long sizeInDays();
    public boolean includesDate(LocalDate other);

}