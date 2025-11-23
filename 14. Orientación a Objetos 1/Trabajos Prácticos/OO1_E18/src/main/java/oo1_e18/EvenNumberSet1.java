package oo1_e18;

import java.util.HashSet;

public class EvenNumberSet1 extends HashSet<Integer> {

    @Override
    public boolean add(Integer num) {
        if ((int) num%2==0)
            return super.add(num);
        else
            return false;
    }

}