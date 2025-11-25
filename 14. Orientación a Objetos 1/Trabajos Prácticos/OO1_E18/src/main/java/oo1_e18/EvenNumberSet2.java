package oo1_e18;

import java.util.*;

public class EvenNumberSet2 implements Set<Integer> {

    private final Set<Integer> internal=new HashSet<>();

    @Override
    public boolean add(Integer num) {
        return (int) num%2==0 ? this.internal.add(num) : false;
    }

    @Override
    public boolean addAll(Collection<? extends Integer> c) {
        boolean inserted=false;
        for (Integer e: c)
            inserted|=this.add(e);
        return inserted;
    }

    @Override
    public int size() {
        return this.internal.size();
    }

    @Override
    public boolean isEmpty() {
        return this.internal.isEmpty();
    }

    @Override
    public boolean contains(Object o) {
        return this.internal.contains(o);
    }

    @Override
    public Iterator<Integer> iterator() {
        return this.internal.iterator();
    }

    @Override
    public Object[] toArray() {
        return this.internal.toArray();
    }

    @Override
    public <T> T[] toArray(T[] a) {
        return this.internal.toArray(a);
    }

    @Override
    public boolean remove(Object o) {
        return this.internal.remove(o);
    }

    @Override
    public boolean containsAll(Collection<?> c) {
        return this.internal.containsAll(c);
    }

    @Override
    public boolean retainAll(Collection<?> c) {
        return this.internal.retainAll(c);
    }

    @Override
    public boolean removeAll(Collection<?> c) {
        return this.internal.removeAll(c);
    }

    @Override
    public void clear() {
        this.internal.clear();
    }

}