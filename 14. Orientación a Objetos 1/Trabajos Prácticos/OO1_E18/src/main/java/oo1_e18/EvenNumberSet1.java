package oo1_e18;

import java.util.*;

public class EvenNumberSet1 extends HashSet<Integer> {

    @Override
    public boolean add(Integer num) {
        return (int) num%2==0 ? super.add(num) : false;
    }

    @Override
    public boolean addAll(Collection<? extends Integer> c) {
        boolean inserted=false;
        for (Integer e: c)
            inserted|=this.add(e);
        return inserted;
    }

}