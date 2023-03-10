class PuzzlesController < ApplicationController
  before_action :set_puzzle, only: %i[ show edit update destroy ]
  require './app/services/solve_puzzle_service'

  # GET /puzzles or /puzzles.json
  def index
    @puzzles = Puzzle.all
  end

  # GET /puzzles/1
  def show
  end

  # GET /puzzles/new
  def new
    @puzzle = Puzzle.new
  end

  # GET /puzzles/1/edit
  def edit
  end

  # POST /puzzles
  def create
    @puzzle = Puzzle.new(puzzle_params)

    respond_to do |format|
      if @puzzle.save
        redirect_to puzzles_url, notice: "問題#{@puzzle.id}を登録しました。" and return
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /puzzles/1
  def update
    respond_to do |format|
      if @puzzle.update(puzzle_params)
        redirect_to puzzle_url(@puzzle), notice: "問題#{@puzzle.id}を更新しました。" and return
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  # DELETE /puzzles/1
  def destroy
    @puzzle.destroy

    respond_to do |format|
      redirect_to puzzles_url, notice: "問題#{@puzzle.id}を削除しました。" and return
    end
  end

  # PATCH /puzzles/1/solve
  def solve
    solvePuzzleService = SolvePuzzleService.new(puzzle_params)
    paramsHash = solvePuzzleService.solve(puzzle_params[:id])
    @puzzle = Puzzle.new(paramsHash)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puzzle
      @puzzle = Puzzle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def puzzle_params
      params.require(:puzzle).permit(:id, :r0c0, :r0c1, :r0c2, :r0c3, :r0c4, :r0c5, :r0c6, :r0c7, :r0c8, :r1c0, :r1c1, :r1c2, :r1c3, :r1c4, :r1c5, :r1c6, :r1c7, :r1c8, :r2c0, :r2c1, :r2c2, :r2c3, :r2c4, :r2c5, :r2c6, :r2c7, :r2c8, :r3c0, :r3c1, :r3c2, :r3c3, :r3c4, :r3c5, :r3c6, :r3c7, :r3c8, :r4c0, :r4c1, :r4c2, :r4c3, :r4c4, :r4c5, :r4c6, :r4c7, :r4c8, :r5c0, :r5c1, :r5c2, :r5c3, :r5c4, :r5c5, :r5c6, :r5c7, :r5c8, :r6c0, :r6c1, :r6c2, :r6c3, :r6c4, :r6c5, :r6c6, :r6c7, :r6c8, :r7c0, :r7c1, :r7c2, :r7c3, :r7c4, :r7c5, :r7c6, :r7c7, :r7c8, :r8c0, :r8c1, :r8c2, :r8c3, :r8c4, :r8c5, :r8c6, :r8c7, :r8c8)
    end
end
