package oo1_e18;

import java.util.*;

public class EvenNumberSet2 implements Set<Integer> {

    private final Set<Integer> internal=new HashSet<>();

    @Override
    public boolean add(Integer e) {
        if (e % 2 == 0)
            return internal.add(e);
        return false;
    }

    @Override
    public boolean addAll(Collection<? extends Integer> c) {
        boolean inserted = false;
        for (Integer e : c) {
            inserted |= this.add(e);
        }
        return inserted;
    }

    // Delegación de *todos* los demás métodos
    @Override
    public int size() {
        return internal.size();
    }

    @Override
    public boolean isEmpty() {
        return internal.isEmpty();
    }

    @Override
    public boolean contains(Object o) {
        return internal.contains(o);
    }

    @Override
    public Iterator<Integer> iterator() {
        return internal.iterator();
    }

    @Override
    public Object[] toArray() {
        return internal.toArray();
    }

    @Override
    public <T> T[] toArray(T[] a) {
        return internal.toArray(a);
    }

    @Override
    public boolean remove(Object o) {
        return internal.remove(o);
    }

    @Override
    public boolean containsAll(Collection<?> c) {
        return internal.containsAll(c);
    }

    @Override
    public boolean retainAll(Collection<?> c) {
        return internal.retainAll(c);
    }

    @Override
    public boolean removeAll(Collection<?> c) {
        return internal.removeAll(c);
    }

    @Override
    public void clear() {
        internal.clear();
    }

}