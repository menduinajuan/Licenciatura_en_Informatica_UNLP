package tp1.ejercicio8;

import java.util.*;

public class Queue<T> extends Sequence {

    protected List<T> data;

    public Queue() {
        data=new LinkedList<T>();
    }

    public void enqueue(T dato) {
        data.add(dato);
    }

    public T dequeue() {
        return data.remove(0);
    }

    public T head() {
        return data.get(0);
    }

    @Override
    public int size() {
        return data.size();
    }

    @Override
    public boolean isEmpty() {
        return size()==0;
    }

    @Override
    public String toString() {
        String str="[";
	for (T i: data)
            str=str+i+", ";
	str=str.substring(0, str.length()-2)+"]";
	return str;
    }

}