class Cell
  require './app/components/lump'

  # 初期化処理
  def initialize(row, column, value)
    @row = row
    @column = column
    @block = ((row/3).to_s + (column/3).to_s).to_i(3)
    if value == 0
      @value = nil
      @candidates = [1,2,3,4,5,6,7,8,9]
      @default_flg = false
    else
      @value = value
      @candidates = []
      @default_flg = true
    end
  end
  
  # セル候補値から値を削除
  def remove(values)
    # 確定しているセルなら何もしない
    if is_fixed()
      return Result::NON
    end

    # 渡された候補値を削除
    result = Result::NON
    values.each do |value|
      tmp = @candidates.delete(value)
      # 削除された場合は変化あり
      if tmp != nil
        result = Result::PROGRESS
      end
    end

    if @candidates.size == 1
      # 候補値がひとつに定まっていれば、確定
      return set_value(@candidates[0])
    else
      # 未確定であれば更新したかどうかを返す
      return result
    end
  end

# セル値の確定
  def set_value(value)
    # nilが渡されt場合、エラー
    if value.nil?
      raise ArgumentError, "nilの設定は許可されていません"
    end

    # 値を確定させ、候補から削除する
    @value = value
    @candidates = []

    # 更新結果：確定
    return Result::FIX
  end

  # 渡された複数のセルが同一セル集合に含まれるかを判定する
  def self.in_same_lump(cells)
    # 処理結果の初期化
    result = {Kind::ROW => true, Kind::COLUMN => true, Kind::BLOCK => true}

    # ループ間での値保持用変数
    row = nil
    column = nil
    block = nil

    # ループ処理で判定
    cells.each do |cell|
      # 行についての処理
      if row.nil?
        # 1週目は各セル集合の番号を設定するだけ
        row = cell.get_row()
      elsif row != cell.get_row()
        # 2週目以降は先頭セルとセル集合の番号が一致するかを検査する
        result[Kind::ROW] = false
      end

      # 列についての処理
      if column.nil?
        # 1週目は各セル集合の番号を設定するだけ
        column = cell.get_column()
      elsif column != cell.get_column()
        # 2週目以降は先頭セルとセル集合の番号が一致するかを検査する
        result[Kind::COLUMN] = false
      end

      # ブロックについての処理
      if block.nil?
        # 1週目は各セル集合の番号を設定するだけ
        block = cell.get_block()
      elsif block != cell.get_block()
        # 2週目以降は先頭セルとセル集合の番号が一致するかを検査する
        result[Kind::BLOCK] = false
      end
    end

    # 結果の返却
    return result
  end

  # 複数セルの候補値をまとめたセットの取得
  def self.cells_candidates(cells)
    result = []
    # 全セルの候補値を結合
    cells.each do |cell|
      result.concat(cell.get_candidates)
    end

    # 重複を削除して返却
    result.uniq!
    return result.sort!
  end

  # セル値が確定しているかどうかの判定
  def is_fixed()
    return !@value.nil?
  end

  # 以下、getter
  def get_row()
    return @row
  end

  def get_column()
    return @column
  end

  def get_block()
    return @block
  end

  def get_value()
    return @value
  end

  def get_candidates()
    return @candidates
  end

  def get_default_flg()
    return @default_flg
  end

  def to_s()
    return "行：#{@row}／列：#{@column}／値：#{@value}"
  end
end

# 更新結果
module Result
  # 変化なし
  NON = 0.freeze
  # 変化あり（未確定）
  PROGRESS = 1.freeze
  # 確定
  FIX = 2.freeze
end