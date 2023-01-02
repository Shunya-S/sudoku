class Lump
  require './app/components/cell'
  
  # 初期化処理
  def initialize(kind, cells)
    # セル数が9以外の場合は入力値不正
    if cells.size != 9
      raise ArgumentError, "セル集合には9つのセルを設定してください"
    end

    # インスタンス変数に格納
    @kind = kind
    @cells = cells

    # 未使用値リスト、候補管理ハッシュを一旦全量で生成
    @rests = []
    @candidate_hash = Hash.new
    for value in 1..9 do
      @rests.push(value)
      @candidate_hash.store(value, @cells.clone)
    end

    # 未使用値リスト・候補管理ハッシュから不要な値・セルを除外
    updateAll()
  end

  # すべてのセルの状態をもとに、セル集合を更新する
  def updateAll()
    # すべてのセルに対し更新処理を実行
    @cells.each do |cell|
      update(cell)
    end
  end

  # 更新されたセルの状態をもとに、セル集合を更新する
  def update(cell)
    # セルの値をセル集合の残りリストから削除
    @rests.delete(cell.get_value())

    # 候補管理マップから該当セルを削除
    for value in 1..9 do
      # 各値（1-9）が該当セルの候補からなくなっていれば、候補管理マップからセルを除外
      if !cell.get_candidates().include?(value)
        @candidate_hash[value].delete(cell)
      end
    end

    # セルの値が確定したとき、管理候補ハッシュ（key=セルの確定値）をクリア
    if cell.is_fixed()
      @candidate_hash[cell.get_value()].clear()
    end
  end

  #以下、getter
  def get_kind()
    return @kind
  end

  def get_cells()
    return @cells
  end

  def get_rests()
    return @rests
  end

  def get_candidate_hash()
    return @candidate_hash
  end
end

# セル集合種別
module Kind
  # 行
  ROW = 0.freeze
  # 列
  COLUMN = 1.freeze
  # ブロック
  BLOCK = 2.freeze
end