package tp1.ejercicio8;

import java.util.*;

public class Queue<T> extends Sequence {

    protected List<T> data=new LinkedList<>();

    public Queue() {
        
    }

    public void enqueue(T dato) {
        this.data.add(dato);
    }

    public T dequeue() {
        return this.data.remove(0);
    }

    public T head() {
        return this.data.get(0);
    }

    @Override
    public int size() {
        return this.data.size();
    }

    @Override
    public boolean isEmpty() {
        return this.size()==0;
    }

    @Override
    public String toString() {
        String str="[";
	for (T i: this.data)
            str=str+i+", ";
	str=str.substring(0, str.length()-2)+"]";
	return str;
    }

}