require_relative 'test_helper'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Test Queue Implementation" do
  it "creates a Queue" do
    q = Queue.new
    expect(q.class).must_equal Queue
  end

  it "adds something to an empty Queue" do
    q = Queue.new
    q.enqueue(10)
    expect(q.to_s).must_equal "[10]"
  end

  it "adds multiple somethings to a Queue" do
    q = Queue.new
    q.enqueue(10)
    q.enqueue(20)
    q.enqueue(30)
    expect(q.to_s).must_equal "[10, 20, 30]"
  end

  it "starts the Queue empty" do
    q = Queue.new
    expect(q.empty?).must_equal true
  end

  it "a Queue is empty after removing all the elements" do
    q = Queue.new
    q.enqueue(5)
    q.enqueue(6)
    expect(q.dequeue).must_equal 5
    expect(q.dequeue).must_equal 6
    expect(q.empty?).must_equal true
  end

  it "can remove something from the Queue" do
    q = Queue.new
    q.enqueue(5)
    removed = q.dequeue
    expect(removed).must_equal 5
    expect(q.empty?).must_equal true
  end

  it "removes the right something (LIFO)" do
    q = Queue.new
    q.enqueue(5)
    q.enqueue(3)
    q.enqueue(7)
    removed = q.dequeue
    expect(removed).must_equal 5
    expect(q.to_s).must_equal "[3, 7]"
  end

  it "properly adjusts the size with enqueueing and dequeueing" do
    q = Queue.new
    expect(q.empty?).must_equal true
    q.enqueue(-1)
    q.enqueue(-60)
    expect(q.empty?).must_equal false
    q.dequeue
    q.dequeue
    expect(q.empty?).must_equal true
  end

  it "returns the front element in the Queue" do
    q = Queue.new
    q.enqueue(40)
    q.enqueue(22)
    q.enqueue(3)
    q.dequeue
    expect(q.dequeue).must_equal 22
  end

  it "works with a large Queue" do
    q = Queue.new
    q.enqueue(10)
    q.enqueue(20)
    q.enqueue(30)
    expect(q.dequeue).must_equal 10
    expect(q.dequeue).must_equal 20
    q.enqueue(40)
    q.enqueue(50)
    q.enqueue(60)
    q.enqueue(70)
    q.enqueue(80)
    q.enqueue(90)
    q.enqueue(100)
    q.enqueue(110)
    q.enqueue(120)
    q.enqueue(130)
    q.enqueue(140)
    q.enqueue(150)
    q.enqueue(160)
    q.enqueue(170)
    q.enqueue(180)
    q.enqueue(190)
    q.enqueue(200)
    q.enqueue(210)
    q.dequeue

    expect(q.to_s).must_equal('[40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210]')
  end

  describe 'enqueue' do
    it 'raises ArgumentError if try to enqueue while queue is full: head is at 0 and tail is at 19' do
      q = Queue.new
      q.enqueue(10)
      q.enqueue(20)
      q.enqueue(30)
      q.enqueue(40)
      q.enqueue(50)
      q.enqueue(60)
      q.enqueue(70)
      q.enqueue(80)
      q.enqueue(90)
      q.enqueue(100)
      q.enqueue(110)
      q.enqueue(120)
      q.enqueue(130)
      q.enqueue(140)
      q.enqueue(150)
      q.enqueue(160)
      q.enqueue(170)
      q.enqueue(180)
      q.enqueue(190)
      q.enqueue(200)
      expect(q.head_ind).must_equal 0
      expect(q.tail_ind).must_equal 19
      expect { q.enqueue(210) }.must_raise ArgumentError
    end

    it 'raises ArgumentError if try to enqueue while queue is full: queue is wrapped around' do
      q = Queue.new
      q.enqueue(10)
      q.enqueue(20)
      q.enqueue(30)
      q.enqueue(40)
      q.enqueue(50)
      q.enqueue(60)
      q.enqueue(70)
      q.enqueue(80)
      q.enqueue(90)
      q.enqueue(100)
      q.enqueue(110)
      q.enqueue(120)
      q.enqueue(130)
      q.enqueue(140)
      q.enqueue(150)
      q.enqueue(160)
      q.enqueue(170)
      q.enqueue(180)
      q.enqueue(190)
      q.enqueue(200)
      q.dequeue
      q.enqueue(200)
      expect(q.head_ind).must_equal 1
      expect(q.tail_ind).must_equal 0
      expect { q.enqueue(210) }.must_raise ArgumentError
    end
  end

  describe 'front method' do
    it 'raises ArgumentError if try to access front for empty queue' do
      q = Queue.new
      expect{ q.front }.must_raise ArgumentError
    end

    it 'returns the first item in the queue without changing the queue' do
      q = Queue.new
      q.enqueue(5)
      q.enqueue(4)
      q.enqueue(3)
      expect(q.front).must_equal 5
      expect(q.to_s).must_equal('[5, 4, 3]')
    end
  end

  describe 'size method' do
    it 'returns 0 for an empty queue' do
      q = Queue.new
      expect(q.size).must_equal 0
    end

    it 'returns the size of a non-empty queue' do
      q = Queue.new
      q.enqueue(5)
      q.enqueue(4)
      q.enqueue(3)
      expect(q.size).must_equal 3
    end
  end
end
