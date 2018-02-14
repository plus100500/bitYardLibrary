package well.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import well.dao.BookDao;
import well.model.Book;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    private BookDao bookDao;

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Transactional
    public void addBook(Book book) {
        bookDao.addBook(book);
    }
    @Transactional
    public void updateBook(Book book) {
        bookDao.updateBook(book);
    }
    @Transactional
    public void removeBook(int id) {
        System.out.println("remove " + id);
        bookDao.removeBook(id);
    }
    @Transactional
    public Book getBookById(int id) {
        return bookDao.getBookById(id);
    }
    @Transactional
    public List<Book> getListBooks() {
        return bookDao.getListBooks();
    }
}
