package forFaith.util;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

/**
 * @Class Name : IDataList.java
 * @Description : 데이터 저장 리스트 원형
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

public interface IDataList<E> {

	List<E> getList();

	void setList(List<E> list);

	int size();

	boolean isEmpty();

	boolean contains(Object o);

	Iterator<E> iterator();

	Object[] toArray();

	<T>T[] toArray(T[] a);

	boolean containsAll(Collection<?> c);

	boolean addAll(Collection<? extends E> c);

	boolean addAll(int index, Collection<? extends E> c);

	boolean removeAll(Collection<?> c);

	boolean retainAll(Collection<?> c);

	void clear();

	boolean equals(Object o);

	int hashCode();

	E get(int index);

	E set(int index, E element);

	boolean add(List<E> list);

	boolean add(E e);

	void add(int index, E element);

	E remove(int index);

	boolean remove(Object o);

	int indexOf(Object o);

	int lastIndexOf(Object o);

	ListIterator<E> listIterator();

	ListIterator<E> listIterator(int index);

	List<E> subList(int fromIndex, int toIndex);
}
