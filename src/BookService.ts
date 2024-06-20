import { Pool } from 'pg';

interface Book {
  book_id?: number;
  title: string;
  author_id: number;
  publisher_id: number;
  genre: string;
  format: string;
  price: number;
  publication_date: string;
  rating: number;
}

class BookService {
  private pool: Pool;

  constructor() {
    this.pool = new Pool({
      user: process.env.DB_USER || 'postgres',
      host: process.env.DB_HOST || 'localhost',
      database: process.env.DB_NAME || 'online_bookstore_midterm_dbt',
      password: process.env.DB_PASSWORD || 'password',
      port: Number(process.env.DB_PORT) || 5432,
    });
  }

  async createBook(book: Book): Promise<Book> {
    const result = await this.pool.query(
      `INSERT INTO Books (title, author_id, publisher_id, genre, format, price, publication_date, rating)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
      [
        book.title,
        book.author_id,
        book.publisher_id,
        book.genre,
        book.format,
        book.price,
        book.publication_date,
        book.rating,
      ]
    );
    return result.rows[0];
  }

  async getBookById(book_id: number): Promise<Book | null> {
    const result = await this.pool.query(
      `SELECT * FROM Books WHERE book_id = $1`,
      [book_id]
    );
    return result.rows[0] || null;
  }

  async updateBook(book: Book): Promise<Book> {
    const result = await this.pool.query(
      `UPDATE Books SET title = $1, author_id = $2, publisher_id = $3, genre = $4, format = $5, price = $6, publication_date = $7, rating = $8
       WHERE book_id = $9 RETURNING *`,
      [
        book.title,
        book.author_id,
        book.publisher_id,
        book.genre,
        book.format,
        book.price,
        book.publication_date,
        book.rating,
        book.book_id,
      ]
    );
    return result.rows[0];
  }

  async deleteBook(book_id: number): Promise<void> {
    await this.pool.query(
      `DELETE FROM Books WHERE book_id = $1`,
      [book_id]
    );
  }
}

export default BookService;
