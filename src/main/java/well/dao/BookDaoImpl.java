package well.dao;

import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import well.model.Book;

import java.util.List;

import static java.util.Objects.nonNull;


@Repository
public class BookDaoImpl implements BookDao {

    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private static final Logger logger = LoggerFactory.getLogger(BookDaoImpl.class);

    @Transactional(propagation = Propagation.REQUIRED)
    public void addBook(Book book) {
        sessionFactory.getCurrentSession().save(book);
        logger.info("Книга: " + book + " успешно добавлена.");
    }


    @Transactional(propagation = Propagation.REQUIRED)
    public void updateBook(Book book) {
        sessionFactory.getCurrentSession().update(book);
        logger.info("Книга: " + book + " успешно обновлена.");

    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void removeBook(int id) {
        Book book = getBookById(id);
        logger.info("Книга: " + book);
        if (nonNull(book)) {
            sessionFactory.getCurrentSession().delete(book);
            logger.info("Книга: " + book + " успешно удалена.");
        }
    }

    @Transactional(readOnly = true, propagation = Propagation.REQUIRED)
    public Book getBookById(int id) {
        Book book = sessionFactory.getCurrentSession().load(Book.class, id);
        if (nonNull(book)) {
            logger.info("Книга: " + book + " найдена.");
        } else {
            logger.info("Книга c id: " + id + " не существует.");
        }

        return book;
    }

    @SuppressWarnings("unchecked")
    @Transactional(readOnly = true, propagation = Propagation.REQUIRED)
    public List<Book> getListBooks() {
        List<Book> bookList = sessionFactory.getCurrentSession().createQuery("from Book").list();
        logger.info("Получен список книг:");
        bookList.forEach(b ->logger.info(b.toString()));

        return bookList;
    }
}