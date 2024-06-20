"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const BookService_1 = __importDefault(require("./BookService"));
// Initialize BookService
const bookService = new BookService_1.default();
function testCRUDOperations() {
    return __awaiter(this, void 0, void 0, function* () {
        // Create a new book
        const newBook = {
            title: 'New Book',
            author_id: 1,
            publisher_id: 1,
            genre: 'Fiction',
            format: 'physical',
            price: 19.99,
            publication_date: '2023-06-01',
            rating: 4.5
        };
        const createdBook = yield bookService.createBook(newBook);
        console.log('Created Book:', createdBook);
        // Read the book by ID
        const bookId = createdBook.book_id;
        if (bookId !== undefined) {
            const readBook = yield bookService.getBookById(bookId);
            console.log('Read Book:', readBook);
            if (readBook) {
                // Update the book
                readBook.price = 21.99;
                const updatedBook = yield bookService.updateBook(readBook);
                console.log('Updated Book:', updatedBook);
                // Delete the book
                yield bookService.deleteBook(bookId);
                console.log('Deleted Book:', bookId);
            }
        }
    });
}
testCRUDOperations().catch(console.error);
