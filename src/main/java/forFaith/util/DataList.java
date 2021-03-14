package forFaith.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import forFaith.domain.Paging;

/**
 * @Class Name : DataList.java
 * @Description : 데이터 저장 리스트
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

@SuppressWarnings("serial")
public class DataList<E> extends Paging implements IDataList<E> {

	private List<E> list;

	public DataList() {
		super();
		this.list = new ArrayList<E>();
	}

	public DataList(List<E> list) {
		super();
		this.list = list;
	}

	public DataList(int pageNo) {
		super(pageNo);
		this.list = new ArrayList<E>();
	}

	public DataList(String pagingYn) {
		super(pagingYn);
		this.list = new ArrayList<E>();
	}

	public DataList(int pageNo, int numOfRows) {
		super(pageNo, numOfRows);
		this.list = new ArrayList<E>();
	}

	public DataList(int pageNo, String pagingYn) {
		super(pageNo, pagingYn);
		this.list = new ArrayList<E>();
	}

	public DataList(int pageNo, int numOfRows, int numOfNums, String pagingYn) {
		super(pageNo, numOfRows, numOfNums, pagingYn);
		this.list = new ArrayList<E>();
	}

	@Override
	public List<E> getList() {
		return list;
	}

	@Override
	public void setList(List<E> list) {
		this.list = list;
	}

	@Override
	public int size() {
		return this.list.size();
	}

	@Override
	public boolean isEmpty() {
		return this.list.isEmpty();
	}

	@Override
	public boolean contains(Object o) {
		return this.list.contains(o);
	}

	@Override
	public Iterator<E> iterator() {
		return this.list.iterator();
	}

	@Override
	public Object[] toArray() {
		return this.list.toArray();
	}

	@Override
	public <T>T[] toArray(T[] a) {
		return this.list.toArray(a);
	}

	@Override
	public boolean containsAll(Collection<?> c) {
		return this.list.containsAll(c);
	}

	@Override
	public boolean addAll(Collection<? extends E> c) {
		return this.list.addAll(c);
	}

	@Override
	public boolean addAll(int index, Collection<? extends E> c) {
		return this.list.addAll(index, c);
	}

	@Override
	public boolean removeAll(Collection<?> c) {
		return this.list.removeAll(c);
	}

	@Override
	public boolean retainAll(Collection<?> c) {
		return this.list.retainAll(c);
	}

	@Override
	public void clear() {
		this.list.clear();
	}

	@Override
	public boolean equals(Object o) {
		return this.list.equals(o);
	}

	@Override
	public int hashCode() {
		return this.list.hashCode();
	}

	@Override
	public E get(int index) {
		return this.list.get(index);
	}

	@Override
	public E set(int index, E element) {
		return this.list.set(index, element);
	}

	@Override
	public boolean add(List<E> list) {
		if(list != null && list.size() > 0) {
			for(int i=0; i<list.size(); ++i) {
				this.list.add(list.get(i));
			}
		}

		return (list != null && list.size() > 0);
	}

	@Override
	public boolean add(E e) {
		return this.list.add(e);
	}

	@Override
	public void add(int index, E element) {
		this.list.add(index, element);
	}

	@Override
	public E remove(int index) {
		return this.list.remove(index);
	}

	@Override
	public boolean remove(Object o) {
		return this.list.remove(o);
	}

	@Override
	public int indexOf(Object o) {
		return this.list.indexOf(o);
	}

	@Override
	public int lastIndexOf(Object o) {
		return this.list.lastIndexOf(o);
	}

	@Override
	public ListIterator<E> listIterator() {
		return this.list.listIterator();
	}

	@Override
	public ListIterator<E> listIterator(int index) {
		return this.list.listIterator(index);
	}

	@Override
	public List<E> subList(int fromIndex, int toIndex) {
		return this.list.subList(fromIndex, toIndex);
	}

	@Override
	public String toString() {
		return "DataList [list=" + list + "]\n" + super.toString() ;
	}
	
	
	
}
