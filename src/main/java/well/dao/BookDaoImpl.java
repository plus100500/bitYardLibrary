package well.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import well.model.Book;

import java.util.List;

@Repository
public class BookDaoImpl implements BookDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private static final Logger logger = LoggerFactory.getLogger(BookDaoImpl.class);
    private static Session session = BookSessionFactory.getSession();

    public void addBook(Book book) {
        Transaction tx = session.beginTransaction();
        session.persist(book);
        tx.commit();
        logger.info("Книга: " + book + " успешно добавлена.");
    }


    public void updateBook(Book book) {
        Transaction tx = session.beginTransaction();
        session.merge(book);
        tx.commit();
        logger.info("Книга: " + book + " успешно обновлена.");

    }


    public void removeBook(int id) {
        Book book = getBookById(id);
        logger.info("Книга: " + book);
        if (book != null) {
            Transaction tx = session.beginTransaction();
            session.delete(book);
            tx.commit();

            logger.info("Книга: " + book + " успешно удалена.");
        }
    }


    public Book getBookById(int id) {
        Transaction tx = session.beginTransaction();
        Book book = (Book) session.load(Book.class,id);
        tx.commit();
        if (book != null) {
            logger.info("Книга: " + book + " найдена.");
        } else {
            logger.info("Книга c id: " + id + " не существует.");
        }

        return book;
    }

    @SuppressWarnings("unchecked")
    public List<Book> getListBooks() {
        Transaction tx = session.beginTransaction();
        List<Book> bookList = session.createQuery("from Book").list();
        tx.commit();
        logger.info("Получен список книг:");
        for(Book book : bookList) {
            logger.info(book.toString());
        }

        return bookList;
    }
}
