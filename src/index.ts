import express from 'express';
import BookService from './BookService';

const app = express();
const port = 3000;  
const bookService = new BookService();

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Welcome to the Online Bookstore API");
});

app.post("/books", async (req, res) => {
  try {
    const newBook = await bookService.createBook(req.body);
    res.status(201).json(newBook);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

app.get("/books/:id", async (req, res) => {
  try {
    const book = await bookService.getBookById(parseInt(req.params.id, 10));
    if (book) {
      res.json(book);
    } else {
      res.status(404).json({ message: "Book not found" });
    }
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

app.put("/books/:id", async (req, res) => {
  try {
    const book = { ...req.body, book_id: parseInt(req.params.id, 10) };
    const updatedBook = await bookService.updateBook(book);
    res.json(updatedBook);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

app.delete("/books/:id", async (req, res) => {
  try {
    await bookService.deleteBook(parseInt(req.params.id, 10));
    res.status(204).send();
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
