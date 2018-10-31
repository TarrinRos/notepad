class Memo < Post
  def read_from_console
    puts 'Новая заметка (все, что пишется до слова \"end\")'
    @text = []

    line = nil

    while line != 'end' do
    line = STDIN.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"

    @text.unshift(time_string)
  end

  def to_db_hash
    #  Получение доступа к аналогичному методу родителя
    super
  end
end