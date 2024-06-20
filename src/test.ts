import BookService from "./BookService";

// Initialize BookService
const bookService = new BookService();

async function testCRUDOperations() {
  // Create a new book
  const newBook = {
    title: 'New Book',
    author_id: 1,
    publisher_id: 1,
    genre: 'Fiction',
    format: 'physical' as 'physical' | 'ebook' | 'audiobook',
    price: 19.99,
    publication_date: '2023-06-01',
    rating: 4.5
  };
  const createdBook = await bookService.createBook(newBook);
  console.log('Created Book:', createdBook);

  // Read the book by ID
  const bookId = createdBook.book_id;
  if (bookId !== undefined) {
    const readBook = await bookService.getBookById(bookId);
    console.log('Read Book:', readBook);

    if (readBook) {
      // Update the book
      readBook.price = 21.99;
      const updatedBook = await bookService.updateBook(readBook);
      console.log('Updated Book:', updatedBook);

      // Delete the book
      await bookService.deleteBook(bookId);
      console.log('Deleted Book:', bookId);
    }
  }
}

testCRUDOperations().catch(console.error);
