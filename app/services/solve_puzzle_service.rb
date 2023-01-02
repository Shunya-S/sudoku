class SolvePuzzleService
  require './app/components/cell'
  require './app/components/lump'

  # 初期化処理
  def initialize(paramsHash)
    # インスタンス変数の宣言
    @rows = []
    @columns = []
    @blocks = []
    @cells = hash_to_cells(paramsHash)

    # セル集合の生成
    for num in 0..8 do
      @rows.push(Lump.new(Kind::ROW, @cells.select { |cell| cell.get_row() == num }))
      @columns.push(Lump.new(Kind::COLUMN, @cells.select { |cell| cell.get_column() == num }))
      @blocks.push(Lump.new(Kind::BLOCK, @cells.select { |cell| cell.get_block() == num }))
    end
  end

  # 自動解答メイン処理
  def solve(id)
    # 更新されなくなるまで解答ロジックを実行
    loop do
      if !execute_logic()
        break
      end
    end

    # 処理結果
    return cells_to_hash(id, @cells)
  end

  private

  # 解答ロジックをひと回りする
  def execute_logic()
    # 処理結果の初期化
    result = false

    # セル単位の更新
    loop do
      # 更新有無の管理
      is_updated = false
      # 全セル更新
      @rows.each do |row|
        if update_lump(row) != Result::NON
          # 更新あり
          is_updated = true
          result = true
        end
      end
      # 更新されなくなったら終わり
      if !is_updated
        break
      end
    end

    # 行単位の更新
    @rows.each do |row|
      if check_candidates_hash(row) != Result::NON
        result = true
      end
      if update_other_lump(row) != Result::NON
        result = true
      end
      if check_candidates_various(row) != Result::NON
        result = true
      end
    end

    # 列単位の更新
    @columns.each do |column|
      if check_candidates_hash(column) != Result::NON
        result = true
      end
      if update_other_lump(column) != Result::NON
        result = true
      end
      if check_candidates_various(column) != Result::NON
        result = true
      end
    end

    # ブロック単位の更新
    @blocks.each do |block|
      if check_candidates_hash(block) != Result::NON
        result = true
      end
      if update_other_lump(block) != Result::NON
        result = true
      end
      if check_candidates_various(block) != Result::NON
        result = true
      end
    end

    # 処理結果の返却
    return result
  end

  # セル集合内のすべてのセルを更新する（updateCellの一括呼び出し）
  def update_lump(lump)
    # 更新したセルの有無
    result = Result::NON

    # 指定されたセル集合内の全セルを更
    lump.get_cells().each do |cell|
      # セルの更新（updateCellの呼び出し）
      if !cell.is_fixed()
        result = set_result(result, update_cell(cell))
      end
    end

    # ステータスがプログレス以上なら再帰呼び出し
    if result != Result::NON
      update_lump(lump)
    end

    # 処理結果の返却
    return result
  end

  # 指定されたセルについて、設定可能な値を確認し更新する
  def update_cell(cell)
    # セルの候補値から除外したい値セット
    remove_set = []

    # セルの候補値リストについて
    cell.get_candidates.each do |tmp|
      # 同一行の未使用値リストにない（=他のセルの値として使われている）場合
      if !@rows[cell.get_row()].get_rests.include?(tmp)
        remove_set.push(tmp)
      end
      # 同一列の未使用値リストにない（=他のセルの値として使われている）場合
      if !@columns[cell.get_column()].get_rests.include?(tmp)
        remove_set.push(tmp)
      end
      # 同一ブロックの未使用値リストにない（=他のセルの値として使われている）場合
      if !@blocks[cell.get_block()].get_rests.include?(tmp)
        remove_set.push(tmp)
      end
    end
    # 重複の削除
    remove_set.uniq!

    # セルの候補値から除外
    return remove_candidates(cell, Result::NON, remove_set)
  end

  # セル集合の候補値マップを確認し、候補セルがひとつに定まっている候補値があれば、そのセルを候補値で確定する
  def check_candidates_hash(lump)
    # 処理結果の初期化
    result = Result::NON

    # 候補値ハッシュの各要素をループ処理
    lump.get_candidate_hash().each do |value, candidates|
      # 候補値マップが更新されているため、処理は再帰呼び出しに任せて終了する
      if result == Result::FIX
        return result
      end

      #候補セルがひとつの場合
      if (candidates.size() == 1)
        # 該当セルを取得
        cell = candidates[0]
        # 値の確定
        cell.set_value(value)

        # 該当セルに関連するセル集合
        row = @rows[cell.get_row()]
        column = @columns[cell.get_column()]
        block = @block[cell.get_column()]

        # 関連するセル集合（残りリストと候補値マップ）を更新
        row.update(cell)
        column.update(cell)
        block.update(cell)

        # 更新したセル集合内のすべてのセルを更新
        update_lump(row)
        update_lump(column)
        update_lump(block)

        # 処理結果の更新（確定セルあり）
        result = result::FIX

        # 再帰呼び出し
        check_candidates_hash(lump)
      end
    end
    # 処理結果の返却
    return result
  end

  # セル集合内で2~3セルにしか現れない候補値があり、
	# そのすべてが別種の同一セル集合に属する場合、その他のセルから該当候補値を取り除く
  def update_other_lump(lump)
    # 処理結果の初期化
    result = Result::NON

    # 候補値マップの各要素をループ処理
    lump.get_candidate_hash().each do |value, candidates|
      # 候補セルがない、または候補セルが４つ以上の場合、スキップ
      if candidates.size == 0 || candidates.size >= 4
        next
      end

      # 更新対象のセル集合（「別種の同一セル集合」）
      upd_lumps = []

      # 更新対象のセル集合を判定する用に、セルをひとつ取得
      sample_cell = candidates[0]

      # ある候補値を持つセルが同一のセル集合内にあるか
      is_same = Cell.in_same_lump(candidates)

      # 渡されたセル集合が行or列の場合
      if lump.get_kind == Kinnd.ROW || lump.get_kind == Kinnd.COLUMN
        # 対象セルが同一ブロック内であれば、該当ブロックを更新
        if is_same[Kind::BLOCK]
          upd_lumps.push(@blocks.get[sample_cell.get_block])
        end
      end

      # 渡されたセル集合がブロックの場合
      if lump.get_kind == Kind::BLOCK
        # 対象セルが同一行内であれば、該当行を更新
        if is_same[Kind::ROW]
          upd_lumps.push(@rows.get[sample_cell.get_row])
        end
        # 対象セルが同一列内であれば、該当列を更新
        if is_same[Kind::COLUMN]
          upd_lumps.push(@columns.get[sample_cell.get_column])
        end
      end

      # 更新対象セル集合内のすべてのセルを更新
      upd_lumps.each do |lump|
        lump.get_cells().each do |cell|
          # ただし、もともとの検査対象のセルは除く
          if !candidates.include?(cell)
            result = remove_candidates(cell, result, value)
          end
        end
      end
    end

    # 処理結果の返却
    return result
  end

  # セル集合内で、複数のセルが持つ候補値の種類数がそれらのセル数と同値の場合、
	# そのセル集合の他のセルから該当の候補値すべてを取り除く
  def check_candidates_various(lump)
    # 処理結果の初期化
    result = Result::NON

    # セル集合内の、値未確定のセルリスト
    sub_list = lump.get_cells().select { |cell| !cell.is_fixed() }

    # 組み合わせハッシュの生成
    comb_hash = Hash.new()
    create_comb_hash(sub_list, 2, comb_hash)

    # ハッシュのすべての組み合わせを網羅
    for i in 2..sub_list.size()-1 do
      comb_hash[i].each do |comb_list|
        # (2週目以降向け）組み合わせたセルに確定セルが混ざっていれば、スキップ
        if comb_list.select{ |cell| cell.is_fixed() }.size() > 0
          next
        end

        # combList内の全セル（セル数はi個）が持つ候補値
        candidates = Cell.cells_candidates(comb_list)
        # 候補値の種類数がセル数と一致する場合
        if candidates.size == i
          # 未確定のセルリストから組み合わせリスト内のセルを除いた一時リストを生成
          tmp_list = sub_list.clone
          comb_list.each do |cell|
            tmp_list.delete(cell)
          end

          # 一時リストの各セルの候補値から、候補値セットの値を除外
          tmp_list.each do |cell|
            result = remove_candidates(cell, result, candidates)
          end
        end
      end
    end
    # 処理結果の返却
    return result
  end

  # 指定されたセル群に対し、2-n個の組み合わせを網羅して返却する
  def create_comb_hash(cells, num, comb_hash)
    # 未確定セルの個数が、組み合わせ個数以下の場合、処理終了
    if cells.size <= num
      return
    end

    # 処理続行の場合、組み合わせマップに追加
    comb_hash[num] = []

    # 組み合わせ個数が2のときの処理
    if num == 2
      for i in 0..cells.size()-2 do
        for j in i+1..cells.size()-1 do
          comb_list = [cells[i], cells[j]]
          comb_hash[num].push(comb_list)
        end
      end
    # 組み合わせ個数が3以上のときの処理
    else
      # 組み合わせ個数-1個の組み合わせのすべてに1個足して実現する
      comb_hash[num-1].each do |tmp_list|
        start = cells.reverse.index(tmp_list.reverse[0])
        for i in start..cells.size()-1
          # tmp_listにないセルなら、tmp_list+cellのリストをマップに追加
          if !tmp_list.include?(cells[i])
            comb_list = tmp_list.clone
            comb_list.push(cells[i])
            comb_hash[num].push(comb_list)
          end
        end
      end
    end
    # 組み合わせ個数に+1して再帰呼び出し
    create_comb_hash(cells, num+1, comb_hash)
  end

  # セルから候補値を削除し、そのセルを含むセル集合を更新する
  def remove_candidates(cell, prev_result, values)
    # 候補値の削除
    curr_result = cell.remove(values)

    # セル状態が変動した場合
    if curr_result != Result::NON
      # 該当セルに関連するセル集合
      row = @rows[cell.get_row()]
      column = @columns[cell.get_column()]
      block = @blocks[cell.get_block]

      # 関連するセル集合（残りリストと候補値マップ）を更新
      row.update(cell)
      column.update(cell)
      block.update(cell)

      # 更新したセル集合内のすべてのセルを更新
      update_lump(row)
      update_lump(column)
      update_lump(block)
    end

    # 処理結果の返却
    return set_result(prev_result, curr_result)
  end

  # これまでの処理結果と今回の処理結果から、優先度を考慮した今回の処理結果を返却する
  def set_result(prev_result, curr_result)
    # 優先度の高いほうを返却
    if curr_result > prev_result
      return curr_result
    end
    return prev_result
  end

  # 渡されたハッシュをセル配列に変換
  def hash_to_cells(hash)
    cells = [Cell.new(0, 0, hash[:r0c0].to_i),\
             Cell.new(0, 1, hash[:r0c1].to_i),\
             Cell.new(0, 2, hash[:r0c2].to_i),\
             Cell.new(0, 3, hash[:r0c3].to_i),\
             Cell.new(0, 4, hash[:r0c4].to_i),\
             Cell.new(0, 5, hash[:r0c5].to_i),\
             Cell.new(0, 6, hash[:r0c6].to_i),\
             Cell.new(0, 7, hash[:r0c7].to_i),\
             Cell.new(0, 8, hash[:r0c8].to_i),\
             Cell.new(1, 0, hash[:r1c0].to_i),\
             Cell.new(1, 1, hash[:r1c1].to_i),\
             Cell.new(1, 2, hash[:r1c2].to_i),\
             Cell.new(1, 3, hash[:r1c3].to_i),\
             Cell.new(1, 4, hash[:r1c4].to_i),\
             Cell.new(1, 5, hash[:r1c5].to_i),\
             Cell.new(1, 6, hash[:r1c6].to_i),\
             Cell.new(1, 7, hash[:r1c7].to_i),\
             Cell.new(1, 8, hash[:r1c8].to_i),\
             Cell.new(2, 0, hash[:r2c0].to_i),\
             Cell.new(2, 1, hash[:r2c1].to_i),\
             Cell.new(2, 2, hash[:r2c2].to_i),\
             Cell.new(2, 3, hash[:r2c3].to_i),\
             Cell.new(2, 4, hash[:r2c4].to_i),\
             Cell.new(2, 5, hash[:r2c5].to_i),\
             Cell.new(2, 6, hash[:r2c6].to_i),\
             Cell.new(2, 7, hash[:r2c7].to_i),\
             Cell.new(2, 8, hash[:r2c8].to_i),\
             Cell.new(3, 0, hash[:r3c0].to_i),\
             Cell.new(3, 1, hash[:r3c1].to_i),\
             Cell.new(3, 2, hash[:r3c2].to_i),\
             Cell.new(3, 3, hash[:r3c3].to_i),\
             Cell.new(3, 4, hash[:r3c4].to_i),\
             Cell.new(3, 5, hash[:r3c5].to_i),\
             Cell.new(3, 6, hash[:r3c6].to_i),\
             Cell.new(3, 7, hash[:r3c7].to_i),\
             Cell.new(3, 8, hash[:r3c8].to_i),\
             Cell.new(4, 0, hash[:r4c0].to_i),\
             Cell.new(4, 1, hash[:r4c1].to_i),\
             Cell.new(4, 2, hash[:r4c2].to_i),\
             Cell.new(4, 3, hash[:r4c3].to_i),\
             Cell.new(4, 4, hash[:r4c4].to_i),\
             Cell.new(4, 5, hash[:r4c5].to_i),\
             Cell.new(4, 6, hash[:r4c6].to_i),\
             Cell.new(4, 7, hash[:r4c7].to_i),\
             Cell.new(4, 8, hash[:r4c8].to_i),\
             Cell.new(5, 0, hash[:r5c0].to_i),\
             Cell.new(5, 1, hash[:r5c1].to_i),\
             Cell.new(5, 2, hash[:r5c2].to_i),\
             Cell.new(5, 3, hash[:r5c3].to_i),\
             Cell.new(5, 4, hash[:r5c4].to_i),\
             Cell.new(5, 5, hash[:r5c5].to_i),\
             Cell.new(5, 6, hash[:r5c6].to_i),\
             Cell.new(5, 7, hash[:r5c7].to_i),\
             Cell.new(5, 8, hash[:r5c8].to_i),\
             Cell.new(6, 0, hash[:r6c0].to_i),\
             Cell.new(6, 1, hash[:r6c1].to_i),\
             Cell.new(6, 2, hash[:r6c2].to_i),\
             Cell.new(6, 3, hash[:r6c3].to_i),\
             Cell.new(6, 4, hash[:r6c4].to_i),\
             Cell.new(6, 5, hash[:r6c5].to_i),\
             Cell.new(6, 6, hash[:r6c6].to_i),\
             Cell.new(6, 7, hash[:r6c7].to_i),\
             Cell.new(6, 8, hash[:r6c8].to_i),\
             Cell.new(7, 0, hash[:r7c0].to_i),\
             Cell.new(7, 1, hash[:r7c1].to_i),\
             Cell.new(7, 2, hash[:r7c2].to_i),\
             Cell.new(7, 3, hash[:r7c3].to_i),\
             Cell.new(7, 4, hash[:r7c4].to_i),\
             Cell.new(7, 5, hash[:r7c5].to_i),\
             Cell.new(7, 6, hash[:r7c6].to_i),\
             Cell.new(7, 7, hash[:r7c7].to_i),\
             Cell.new(7, 8, hash[:r7c8].to_i),\
             Cell.new(8, 0, hash[:r8c0].to_i),\
             Cell.new(8, 1, hash[:r8c1].to_i),\
             Cell.new(8, 2, hash[:r8c2].to_i),\
             Cell.new(8, 3, hash[:r8c3].to_i),\
             Cell.new(8, 4, hash[:r8c4].to_i),\
             Cell.new(8, 5, hash[:r8c5].to_i),\
             Cell.new(8, 6, hash[:r8c6].to_i),\
             Cell.new(8, 7, hash[:r8c7].to_i),\
             Cell.new(8, 8, hash[:r8c8].to_i)\
            ]
    return cells
  end

  # セル配列をPuzzleモデルのハッシュに変換
  def cells_to_hash(id, cells)
    hash = {id:id, \
      r0c0:cells[0].get_value(), r0c1:cells[1].get_value(), r0c2:cells[2].get_value(), r0c3:cells[3].get_value(), r0c4:cells[4].get_value(), r0c5:cells[5].get_value(), r0c6:cells[6].get_value(), r0c7:cells[7].get_value(), r0c8:cells[8].get_value(),\
      r1c0:cells[9].get_value(), r1c1:cells[10].get_value(), r1c2:cells[11].get_value(), r1c3:cells[12].get_value(), r1c4:cells[13].get_value(), r1c5:cells[14].get_value(), r1c6:cells[15].get_value(), r1c7:cells[16].get_value(), r1c8:cells[17].get_value(),\
      r2c0:cells[18].get_value(), r2c1:cells[19].get_value(), r2c2:cells[20].get_value(), r2c3:cells[21].get_value(), r2c4:cells[22].get_value(), r2c5:cells[23].get_value(), r2c6:cells[24].get_value(), r2c7:cells[25].get_value(), r2c8:cells[26].get_value(),\
      r3c0:cells[27].get_value(), r3c1:cells[28].get_value(), r3c2:cells[29].get_value(), r3c3:cells[30].get_value(), r3c4:cells[31].get_value(), r3c5:cells[32].get_value(), r3c6:cells[33].get_value(), r3c7:cells[34].get_value(), r3c8:cells[35].get_value(),\
      r4c0:cells[36].get_value(), r4c1:cells[37].get_value(), r4c2:cells[38].get_value(), r4c3:cells[39].get_value(), r4c4:cells[40].get_value(), r4c5:cells[41].get_value(), r4c6:cells[42].get_value(), r4c7:cells[43].get_value(), r4c8:cells[44].get_value(),\
      r5c0:cells[45].get_value(), r5c1:cells[46].get_value(), r5c2:cells[47].get_value(), r5c3:cells[48].get_value(), r5c4:cells[49].get_value(), r5c5:cells[50].get_value(), r5c6:cells[51].get_value(), r5c7:cells[52].get_value(), r5c8:cells[53].get_value(),\
      r6c0:cells[54].get_value(), r6c1:cells[55].get_value(), r6c2:cells[56].get_value(), r6c3:cells[57].get_value(), r6c4:cells[58].get_value(), r6c5:cells[59].get_value(), r6c6:cells[60].get_value(), r6c7:cells[61].get_value(), r6c8:cells[62].get_value(),\
      r7c0:cells[63].get_value(), r7c1:cells[64].get_value(), r7c2:cells[65].get_value(), r7c3:cells[66].get_value(), r7c4:cells[67].get_value(), r7c5:cells[68].get_value(), r7c6:cells[69].get_value(), r7c7:cells[70].get_value(), r7c8:cells[71].get_value(),\
      r8c0:cells[72].get_value(), r8c1:cells[73].get_value(), r8c2:cells[74].get_value(), r8c3:cells[75].get_value(), r8c4:cells[76].get_value(), r8c5:cells[77].get_value(), r8c6:cells[78].get_value(), r8c7:cells[79].get_value(), r8c8:cells[80].get_value()\
    }
    return hash
  end
end