package well.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import well.model.Book;
import well.service.BookService;

import java.util.Objects;

import static java.util.Objects.isNull;


@Controller
public class MainController {
    private BookService bookService;

    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping(value = "books" , method = RequestMethod.GET)
    public String bookList(Model model) {
        model.addAttribute("bookList", bookService.getListBooks());
        model.addAttribute("newBook",new Book());
        return "books";
    }

    @RequestMapping(value = "bookInfo/{id}" , method = RequestMethod.GET)
    public String getBookById(@PathVariable("id") int id, Model model) {
        Book book = bookService.getBookById(id);
        model.addAttribute("book", book);
        if (!book.getReadAlready()) {
            book.setReadAlready(true);
        }
        bookService.updateBook(book);
        return "bookInfo";
    }

    @RequestMapping("/remove/{id}")
    public String removeBook(@PathVariable("id") int id){
        bookService.removeBook(id);
        return "redirect:/books";
    }

    @RequestMapping("edit/{id}")
    public String editBook(@PathVariable("id") int id, Model model){
        model.addAttribute("newBook", bookService.getBookById(id));
        model.addAttribute("bookList", bookService.getListBooks());

        return "books";
    }

    @RequestMapping(value = "/books/add", method = RequestMethod.POST)
    public String addBook(@ModelAttribute("newBook") Book book){
        if (Objects.equals(book.getAuthor(), "")) {
            return "redirect:/books";
        }
        book.setReadAlready(false);
        if (isNull(book.getId()) || book.getId() == 0) {
            bookService.addBook(book);
        }else {
            bookService.updateBook(book);
        }

        return "redirect:/books";
    }
}
