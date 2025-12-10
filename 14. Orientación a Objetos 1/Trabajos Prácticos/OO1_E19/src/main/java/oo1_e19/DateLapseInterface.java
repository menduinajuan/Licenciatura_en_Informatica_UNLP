package oo1_e19;

import java.time.LocalDate;

public interface DateLapseInterface {

    public LocalDate getFrom();
    public LocalDate getTo();
    public long sizeInDays();
    public boolean includesDate(LocalDate other);
    public boolean overlaps(DateLapse anotherDateLapse);

}