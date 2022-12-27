require "application_system_test_case"

class PuzzlesTest < ApplicationSystemTestCase
  setup do
    @puzzle = puzzles(:one)
  end

  test "visiting the index" do
    visit puzzles_url
    assert_selector "h1", text: "Puzzles"
  end

  test "should create puzzle" do
    visit puzzles_url
    click_on "New puzzle"

    fill_in "R0c0", with: @puzzle.r0c0
    fill_in "R0c1", with: @puzzle.r0c1
    fill_in "R0c2", with: @puzzle.r0c2
    fill_in "R0c3", with: @puzzle.r0c3
    fill_in "R0c4", with: @puzzle.r0c4
    fill_in "R0c5", with: @puzzle.r0c5
    fill_in "R0c6", with: @puzzle.r0c6
    fill_in "R0c7", with: @puzzle.r0c7
    fill_in "R0c8", with: @puzzle.r0c8
    fill_in "R1c0", with: @puzzle.r1c0
    fill_in "R1c1", with: @puzzle.r1c1
    fill_in "R1c2", with: @puzzle.r1c2
    fill_in "R1c3", with: @puzzle.r1c3
    fill_in "R1c4", with: @puzzle.r1c4
    fill_in "R1c5", with: @puzzle.r1c5
    fill_in "R1c6", with: @puzzle.r1c6
    fill_in "R1c7", with: @puzzle.r1c7
    fill_in "R1c8", with: @puzzle.r1c8
    fill_in "R2c0", with: @puzzle.r2c0
    fill_in "R2c1", with: @puzzle.r2c1
    fill_in "R2c2", with: @puzzle.r2c2
    fill_in "R2c3", with: @puzzle.r2c3
    fill_in "R2c4", with: @puzzle.r2c4
    fill_in "R2c5", with: @puzzle.r2c5
    fill_in "R2c6", with: @puzzle.r2c6
    fill_in "R2c7", with: @puzzle.r2c7
    fill_in "R2c8", with: @puzzle.r2c8
    fill_in "R3c0", with: @puzzle.r3c0
    fill_in "R3c1", with: @puzzle.r3c1
    fill_in "R3c2", with: @puzzle.r3c2
    fill_in "R3c3", with: @puzzle.r3c3
    fill_in "R3c4", with: @puzzle.r3c4
    fill_in "R3c5", with: @puzzle.r3c5
    fill_in "R3c6", with: @puzzle.r3c6
    fill_in "R3c7", with: @puzzle.r3c7
    fill_in "R3c8", with: @puzzle.r3c8
    fill_in "R4c0", with: @puzzle.r4c0
    fill_in "R4c1", with: @puzzle.r4c1
    fill_in "R4c2", with: @puzzle.r4c2
    fill_in "R4c3", with: @puzzle.r4c3
    fill_in "R4c4", with: @puzzle.r4c4
    fill_in "R4c5", with: @puzzle.r4c5
    fill_in "R4c6", with: @puzzle.r4c6
    fill_in "R4c7", with: @puzzle.r4c7
    fill_in "R4c8", with: @puzzle.r4c8
    fill_in "R5c0", with: @puzzle.r5c0
    fill_in "R5c1", with: @puzzle.r5c1
    fill_in "R5c2", with: @puzzle.r5c2
    fill_in "R5c3", with: @puzzle.r5c3
    fill_in "R5c4", with: @puzzle.r5c4
    fill_in "R5c5", with: @puzzle.r5c5
    fill_in "R5c6", with: @puzzle.r5c6
    fill_in "R5c7", with: @puzzle.r5c7
    fill_in "R5c8", with: @puzzle.r5c8
    fill_in "R6c0", with: @puzzle.r6c0
    fill_in "R6c1", with: @puzzle.r6c1
    fill_in "R6c2", with: @puzzle.r6c2
    fill_in "R6c3", with: @puzzle.r6c3
    fill_in "R6c4", with: @puzzle.r6c4
    fill_in "R6c5", with: @puzzle.r6c5
    fill_in "R6c6", with: @puzzle.r6c6
    fill_in "R6c7", with: @puzzle.r6c7
    fill_in "R6c8", with: @puzzle.r6c8
    fill_in "R7c0", with: @puzzle.r7c0
    fill_in "R7c1", with: @puzzle.r7c1
    fill_in "R7c2", with: @puzzle.r7c2
    fill_in "R7c3", with: @puzzle.r7c3
    fill_in "R7c4", with: @puzzle.r7c4
    fill_in "R7c5", with: @puzzle.r7c5
    fill_in "R7c6", with: @puzzle.r7c6
    fill_in "R7c7", with: @puzzle.r7c7
    fill_in "R7c8", with: @puzzle.r7c8
    fill_in "R8c0", with: @puzzle.r8c0
    fill_in "R8c1", with: @puzzle.r8c1
    fill_in "R8c2", with: @puzzle.r8c2
    fill_in "R8c3", with: @puzzle.r8c3
    fill_in "R8c4", with: @puzzle.r8c4
    fill_in "R8c5", with: @puzzle.r8c5
    fill_in "R8c6", with: @puzzle.r8c6
    fill_in "R8c7", with: @puzzle.r8c7
    fill_in "R8c8", with: @puzzle.r8c8
    click_on "Create Puzzle"

    assert_text "Puzzle was successfully created"
    click_on "Back"
  end

  test "should update Puzzle" do
    visit puzzle_url(@puzzle)
    click_on "Edit this puzzle", match: :first

    fill_in "R0c0", with: @puzzle.r0c0
    fill_in "R0c1", with: @puzzle.r0c1
    fill_in "R0c2", with: @puzzle.r0c2
    fill_in "R0c3", with: @puzzle.r0c3
    fill_in "R0c4", with: @puzzle.r0c4
    fill_in "R0c5", with: @puzzle.r0c5
    fill_in "R0c6", with: @puzzle.r0c6
    fill_in "R0c7", with: @puzzle.r0c7
    fill_in "R0c8", with: @puzzle.r0c8
    fill_in "R1c0", with: @puzzle.r1c0
    fill_in "R1c1", with: @puzzle.r1c1
    fill_in "R1c2", with: @puzzle.r1c2
    fill_in "R1c3", with: @puzzle.r1c3
    fill_in "R1c4", with: @puzzle.r1c4
    fill_in "R1c5", with: @puzzle.r1c5
    fill_in "R1c6", with: @puzzle.r1c6
    fill_in "R1c7", with: @puzzle.r1c7
    fill_in "R1c8", with: @puzzle.r1c8
    fill_in "R2c0", with: @puzzle.r2c0
    fill_in "R2c1", with: @puzzle.r2c1
    fill_in "R2c2", with: @puzzle.r2c2
    fill_in "R2c3", with: @puzzle.r2c3
    fill_in "R2c4", with: @puzzle.r2c4
    fill_in "R2c5", with: @puzzle.r2c5
    fill_in "R2c6", with: @puzzle.r2c6
    fill_in "R2c7", with: @puzzle.r2c7
    fill_in "R2c8", with: @puzzle.r2c8
    fill_in "R3c0", with: @puzzle.r3c0
    fill_in "R3c1", with: @puzzle.r3c1
    fill_in "R3c2", with: @puzzle.r3c2
    fill_in "R3c3", with: @puzzle.r3c3
    fill_in "R3c4", with: @puzzle.r3c4
    fill_in "R3c5", with: @puzzle.r3c5
    fill_in "R3c6", with: @puzzle.r3c6
    fill_in "R3c7", with: @puzzle.r3c7
    fill_in "R3c8", with: @puzzle.r3c8
    fill_in "R4c0", with: @puzzle.r4c0
    fill_in "R4c1", with: @puzzle.r4c1
    fill_in "R4c2", with: @puzzle.r4c2
    fill_in "R4c3", with: @puzzle.r4c3
    fill_in "R4c4", with: @puzzle.r4c4
    fill_in "R4c5", with: @puzzle.r4c5
    fill_in "R4c6", with: @puzzle.r4c6
    fill_in "R4c7", with: @puzzle.r4c7
    fill_in "R4c8", with: @puzzle.r4c8
    fill_in "R5c0", with: @puzzle.r5c0
    fill_in "R5c1", with: @puzzle.r5c1
    fill_in "R5c2", with: @puzzle.r5c2
    fill_in "R5c3", with: @puzzle.r5c3
    fill_in "R5c4", with: @puzzle.r5c4
    fill_in "R5c5", with: @puzzle.r5c5
    fill_in "R5c6", with: @puzzle.r5c6
    fill_in "R5c7", with: @puzzle.r5c7
    fill_in "R5c8", with: @puzzle.r5c8
    fill_in "R6c0", with: @puzzle.r6c0
    fill_in "R6c1", with: @puzzle.r6c1
    fill_in "R6c2", with: @puzzle.r6c2
    fill_in "R6c3", with: @puzzle.r6c3
    fill_in "R6c4", with: @puzzle.r6c4
    fill_in "R6c5", with: @puzzle.r6c5
    fill_in "R6c6", with: @puzzle.r6c6
    fill_in "R6c7", with: @puzzle.r6c7
    fill_in "R6c8", with: @puzzle.r6c8
    fill_in "R7c0", with: @puzzle.r7c0
    fill_in "R7c1", with: @puzzle.r7c1
    fill_in "R7c2", with: @puzzle.r7c2
    fill_in "R7c3", with: @puzzle.r7c3
    fill_in "R7c4", with: @puzzle.r7c4
    fill_in "R7c5", with: @puzzle.r7c5
    fill_in "R7c6", with: @puzzle.r7c6
    fill_in "R7c7", with: @puzzle.r7c7
    fill_in "R7c8", with: @puzzle.r7c8
    fill_in "R8c0", with: @puzzle.r8c0
    fill_in "R8c1", with: @puzzle.r8c1
    fill_in "R8c2", with: @puzzle.r8c2
    fill_in "R8c3", with: @puzzle.r8c3
    fill_in "R8c4", with: @puzzle.r8c4
    fill_in "R8c5", with: @puzzle.r8c5
    fill_in "R8c6", with: @puzzle.r8c6
    fill_in "R8c7", with: @puzzle.r8c7
    fill_in "R8c8", with: @puzzle.r8c8
    click_on "Update Puzzle"

    assert_text "Puzzle was successfully updated"
    click_on "Back"
  end

  test "should destroy Puzzle" do
    visit puzzle_url(@puzzle)
    click_on "Destroy this puzzle", match: :first

    assert_text "Puzzle was successfully destroyed"
  end
end
