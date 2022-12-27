require "test_helper"

class PuzzlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @puzzle = puzzles(:one)
  end

  test "should get index" do
    get puzzles_url
    assert_response :success
  end

  test "should get new" do
    get new_puzzle_url
    assert_response :success
  end

  test "should create puzzle" do
    assert_difference("Puzzle.count") do
      post puzzles_url, params: { puzzle: { r0c0: @puzzle.r0c0, r0c1: @puzzle.r0c1, r0c2: @puzzle.r0c2, r0c3: @puzzle.r0c3, r0c4: @puzzle.r0c4, r0c5: @puzzle.r0c5, r0c6: @puzzle.r0c6, r0c7: @puzzle.r0c7, r0c8: @puzzle.r0c8, r1c0: @puzzle.r1c0, r1c1: @puzzle.r1c1, r1c2: @puzzle.r1c2, r1c3: @puzzle.r1c3, r1c4: @puzzle.r1c4, r1c5: @puzzle.r1c5, r1c6: @puzzle.r1c6, r1c7: @puzzle.r1c7, r1c8: @puzzle.r1c8, r2c0: @puzzle.r2c0, r2c1: @puzzle.r2c1, r2c2: @puzzle.r2c2, r2c3: @puzzle.r2c3, r2c4: @puzzle.r2c4, r2c5: @puzzle.r2c5, r2c6: @puzzle.r2c6, r2c7: @puzzle.r2c7, r2c8: @puzzle.r2c8, r3c0: @puzzle.r3c0, r3c1: @puzzle.r3c1, r3c2: @puzzle.r3c2, r3c3: @puzzle.r3c3, r3c4: @puzzle.r3c4, r3c5: @puzzle.r3c5, r3c6: @puzzle.r3c6, r3c7: @puzzle.r3c7, r3c8: @puzzle.r3c8, r4c0: @puzzle.r4c0, r4c1: @puzzle.r4c1, r4c2: @puzzle.r4c2, r4c3: @puzzle.r4c3, r4c4: @puzzle.r4c4, r4c5: @puzzle.r4c5, r4c6: @puzzle.r4c6, r4c7: @puzzle.r4c7, r4c8: @puzzle.r4c8, r5c0: @puzzle.r5c0, r5c1: @puzzle.r5c1, r5c2: @puzzle.r5c2, r5c3: @puzzle.r5c3, r5c4: @puzzle.r5c4, r5c5: @puzzle.r5c5, r5c6: @puzzle.r5c6, r5c7: @puzzle.r5c7, r5c8: @puzzle.r5c8, r6c0: @puzzle.r6c0, r6c1: @puzzle.r6c1, r6c2: @puzzle.r6c2, r6c3: @puzzle.r6c3, r6c4: @puzzle.r6c4, r6c5: @puzzle.r6c5, r6c6: @puzzle.r6c6, r6c7: @puzzle.r6c7, r6c8: @puzzle.r6c8, r7c0: @puzzle.r7c0, r7c1: @puzzle.r7c1, r7c2: @puzzle.r7c2, r7c3: @puzzle.r7c3, r7c4: @puzzle.r7c4, r7c5: @puzzle.r7c5, r7c6: @puzzle.r7c6, r7c7: @puzzle.r7c7, r7c8: @puzzle.r7c8, r8c0: @puzzle.r8c0, r8c1: @puzzle.r8c1, r8c2: @puzzle.r8c2, r8c3: @puzzle.r8c3, r8c4: @puzzle.r8c4, r8c5: @puzzle.r8c5, r8c6: @puzzle.r8c6, r8c7: @puzzle.r8c7, r8c8: @puzzle.r8c8 } }
    end

    assert_redirected_to puzzle_url(Puzzle.last)
  end

  test "should show puzzle" do
    get puzzle_url(@puzzle)
    assert_response :success
  end

  test "should get edit" do
    get edit_puzzle_url(@puzzle)
    assert_response :success
  end

  test "should update puzzle" do
    patch puzzle_url(@puzzle), params: { puzzle: { r0c0: @puzzle.r0c0, r0c1: @puzzle.r0c1, r0c2: @puzzle.r0c2, r0c3: @puzzle.r0c3, r0c4: @puzzle.r0c4, r0c5: @puzzle.r0c5, r0c6: @puzzle.r0c6, r0c7: @puzzle.r0c7, r0c8: @puzzle.r0c8, r1c0: @puzzle.r1c0, r1c1: @puzzle.r1c1, r1c2: @puzzle.r1c2, r1c3: @puzzle.r1c3, r1c4: @puzzle.r1c4, r1c5: @puzzle.r1c5, r1c6: @puzzle.r1c6, r1c7: @puzzle.r1c7, r1c8: @puzzle.r1c8, r2c0: @puzzle.r2c0, r2c1: @puzzle.r2c1, r2c2: @puzzle.r2c2, r2c3: @puzzle.r2c3, r2c4: @puzzle.r2c4, r2c5: @puzzle.r2c5, r2c6: @puzzle.r2c6, r2c7: @puzzle.r2c7, r2c8: @puzzle.r2c8, r3c0: @puzzle.r3c0, r3c1: @puzzle.r3c1, r3c2: @puzzle.r3c2, r3c3: @puzzle.r3c3, r3c4: @puzzle.r3c4, r3c5: @puzzle.r3c5, r3c6: @puzzle.r3c6, r3c7: @puzzle.r3c7, r3c8: @puzzle.r3c8, r4c0: @puzzle.r4c0, r4c1: @puzzle.r4c1, r4c2: @puzzle.r4c2, r4c3: @puzzle.r4c3, r4c4: @puzzle.r4c4, r4c5: @puzzle.r4c5, r4c6: @puzzle.r4c6, r4c7: @puzzle.r4c7, r4c8: @puzzle.r4c8, r5c0: @puzzle.r5c0, r5c1: @puzzle.r5c1, r5c2: @puzzle.r5c2, r5c3: @puzzle.r5c3, r5c4: @puzzle.r5c4, r5c5: @puzzle.r5c5, r5c6: @puzzle.r5c6, r5c7: @puzzle.r5c7, r5c8: @puzzle.r5c8, r6c0: @puzzle.r6c0, r6c1: @puzzle.r6c1, r6c2: @puzzle.r6c2, r6c3: @puzzle.r6c3, r6c4: @puzzle.r6c4, r6c5: @puzzle.r6c5, r6c6: @puzzle.r6c6, r6c7: @puzzle.r6c7, r6c8: @puzzle.r6c8, r7c0: @puzzle.r7c0, r7c1: @puzzle.r7c1, r7c2: @puzzle.r7c2, r7c3: @puzzle.r7c3, r7c4: @puzzle.r7c4, r7c5: @puzzle.r7c5, r7c6: @puzzle.r7c6, r7c7: @puzzle.r7c7, r7c8: @puzzle.r7c8, r8c0: @puzzle.r8c0, r8c1: @puzzle.r8c1, r8c2: @puzzle.r8c2, r8c3: @puzzle.r8c3, r8c4: @puzzle.r8c4, r8c5: @puzzle.r8c5, r8c6: @puzzle.r8c6, r8c7: @puzzle.r8c7, r8c8: @puzzle.r8c8 } }
    assert_redirected_to puzzle_url(@puzzle)
  end

  test "should destroy puzzle" do
    assert_difference("Puzzle.count", -1) do
      delete puzzle_url(@puzzle)
    end

    assert_redirected_to puzzles_url
  end
end
