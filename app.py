from flask import Flask, render_template, request, redirect, session, url_for
import mysql.connector

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# Connect to MySQL database
db = mysql.connector.connect(
    host='localhost',
    user='root',
    password='12345678',
    database='library_db'
)

@app.route('/')
def home():
    return render_template('login.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        role = request.form['role']
        cur = db.cursor()
        cur.execute("SELECT * FROM users WHERE username = %s AND password = %s AND role = %s", (username, password, role))
        user = cur.fetchone()
        if user:
            session['user_id'] = user[0]
            session['username'] = username
            session['role'] = role
            return redirect('/dashboard')
    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        role = request.form['role']
        cur = db.cursor()
        cur.execute("INSERT INTO users (username, password, role) VALUES (%s, %s, %s)", (username, password, role))
        db.commit()
        return redirect('/login')
    return render_template('register.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    session.pop('username', None)
    session.pop('role', None)
    return redirect('/')

@app.route('/dashboard')
def dashboard():
    search_query = request.args.get('search', '')
    cur = db.cursor()
    if search_query:
        cur.execute("SELECT * FROM books WHERE title LIKE %s OR author LIKE %s", 
                    ('%' + search_query + '%', '%' + search_query + '%'))
    else:
        cur.execute("SELECT * FROM books")
    books = cur.fetchall()
    return render_template('dashboard.html', books=books)

@app.route('/book/<int:book_id>')
def book_details(book_id):
    cur = db.cursor()
    cur.execute("SELECT * FROM books WHERE id = %s", (book_id,))
    book = cur.fetchone()
    return render_template('book_details.html', book=book)

@app.route('/book/<int:book_id>/review', methods=['POST'])
def review_book(book_id):
    if 'user_id' not in session:
        return redirect('/login')

    user_id = session['user_id']
    rating = request.form['rating']
    comment = request.form['comment']

    cur = db.cursor()
    cur.execute("INSERT INTO reviews (user_id, book_id, rating, comment) VALUES (%s, %s, %s, %s)", 
                (user_id, book_id, rating, comment))
    db.commit()
    return redirect(f'/book/{book_id}')

@app.route('/book/<int:book_id>/favorite', methods=['POST'])
def favorite_book(book_id):
    if 'user_id' not in session:
        return redirect('/login')

    user_id = session['user_id']

    cur = db.cursor()
    cur.execute("INSERT INTO favorites (user_id, book_id) VALUES (%s, %s)", (user_id, book_id))
    db.commit()
    return redirect('/dashboard')

@app.route('/profile')
def profile():
    if 'user_id' not in session:
        return redirect('/login')

    user_id = session['user_id']
    cur = db.cursor()
    cur.execute("SELECT * FROM favorites JOIN books ON favorites.book_id = books.id WHERE favorites.user_id = %s", (user_id,))
    favorite_books = cur.fetchall()
    
    cur.execute("SELECT * FROM borrows JOIN books ON borrows.book_id = books.id WHERE borrows.user_id = %s", (user_id,))
    borrowed_books = cur.fetchall()
    
    return render_template('profile.html', favorite_books=favorite_books, borrowed_books=borrowed_books)

if __name__ == '__main__':
    app.run(debug=True)
