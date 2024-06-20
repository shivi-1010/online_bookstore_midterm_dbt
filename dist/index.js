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
const express_1 = __importDefault(require("express"));
const BookService_1 = __importDefault(require("./BookService"));
const app = (0, express_1.default)();
const port = 3000; // Ensure the port is set to 3000
const bookService = new BookService_1.default();
app.use(express_1.default.json());
app.get("/", (req, res) => {
    res.send("Welcome to the Online Bookstore API");
});
app.post("/books", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const newBook = yield bookService.createBook(req.body);
        res.status(201).json(newBook);
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}));
app.get("/books/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const book = yield bookService.getBookById(parseInt(req.params.id, 10));
        if (book) {
            res.json(book);
        }
        else {
            res.status(404).json({ message: "Book not found" });
        }
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}));
app.put("/books/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const book = Object.assign(Object.assign({}, req.body), { book_id: parseInt(req.params.id, 10) });
        const updatedBook = yield bookService.updateBook(book);
        res.json(updatedBook);
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}));
app.delete("/books/:id", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield bookService.deleteBook(parseInt(req.params.id, 10));
        res.status(204).send();
    }
    catch (error) {
        res.status(500).json({ error: error.message });
    }
}));
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
