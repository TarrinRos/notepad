require 'sqlite3'

class Post

  @@SQLITE_DB_FILE = 'notepad.sqlite'

  def self.post_types
    {'Memo': Memo, 'Task': Task, 'Link': Link}
  end

  def self.create(type)
    post_types[type].new
  end

  def initialize
    @created_at = Time.now
    @text = nil
  end

  def read_from_console
  #   todo
  end

  def to_strings
  #   todo
  end

  def save(file_path)
    file = File.new(file_path(file_path), 'w')

    to_strings.each do |item|
      file.puts(item)
    end

    file.close
  end

  def file_path(current_path)
    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")

    "#{current_path}/data/#{file_name}"
  end

  def save_to_db
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)
    db.results_as_hash = true

    # запрос к базе на вставку новой записи в соответствии с хэшом, сформированным дочерним классом to_db_hash
    db.execute(
      "INSERT INTO posts (" +
        to_db_hash.keys.join(', ') + # все поля, перечисленные через запятую
        ") " +
        " VALUES ( " +
        ('?,'*to_db_hash.keys.size).chomp(',') + # строка из заданного числа _плейсхолдеров_ ?,?,?...
        ")",
      to_db_hash.values # массив значений хэша, которые будут вставлены в запрос вместо _плейсхолдеров_
    )

    insert_row_id = db.last_insert_row_id

    # закрываем соединение
    db.close

    # возвращаем идентификатор записи в базе
    return insert_row_id
  end

  def to_db_hash
    {
      # self — ключевое слово, указывает на 'этот объект',
      # то есть конкретный экземпляр класса, где выполняется в данный момент этот код
      'type': self.class.name,
      'created_at': @created_at.to_s
    }
  end
end