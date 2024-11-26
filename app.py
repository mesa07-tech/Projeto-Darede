from flask import Flask, render_template, g
import sqlite3

app = Flask(__name__)

DATABASE = 'library.db'

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/books')
def books():
    db = get_db()
    cursor = db.execute('SELECT * FROM books')
    books = cursor.fetchall()
    return render_template('books.html', books=books)

@app.route('/authors')
def authors():
    db = get_db()
    cursor = db.execute('SELECT * FROM authors')
    authors = cursor.fetchall()
    return render_template('authors.html', authors=authors)

if __name__ == "__main__":
    app.run(debug=True)
