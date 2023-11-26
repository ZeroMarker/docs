# 交换排序
"交换排序" (Swap Sort) 通常是指排序算法中一类基于交换元素位置的排序方法。其中最著名的就是冒泡排序（Bubble Sort）和快速排序（Quick Sort）。以下是它们的简要描述：

冒泡排序（Bubble Sort）：

这是一种简单的排序算法，它多次遍历待排序的元素，比较相邻两个元素的大小，并交换它们，直到整个序列有序。
每一轮都会使一个最大的元素浮到序列的最后。
时间复杂度：平均 O(n^2)，最好情况 O(n)（如果初始状态已经有序），最坏情况 O(n^2)。
python
Copy code
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
快速排序（Quick Sort）：

快速排序是一种分治策略的排序算法，通过选择一个基准元素，将数组分为左右两部分，然后递归地对左右子数组进行排序。
由于采用了分治的思想，快速排序通常比冒泡排序更快。
时间复杂度：平均 O(n log n)，最好情况 O(n log n)，最坏情况 O(n^2)。
python
Copy code
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quick_sort(left) + middle + quick_sort(right)
这两种算法都是基于元素之间的比较和交换来实现排序的。在实际应用中，通常会选择更高效的排序算法，例如合并排序（Merge Sort）或堆排序（Heap Sort），特别是对于大型数据集。

# 非交换排序
非交换排序是指排序算法中不涉及元素位置交换的一类排序方法。其中最典型的就是插入排序（Insertion Sort）和选择排序（Selection Sort）。以下是它们的简要描述：

插入排序（Insertion Sort）：

插入排序的思想是将数组分为已排序和未排序两部分，每次从未排序部分取一个元素插入到已排序部分的适当位置。
时间复杂度：平均 O(n^2)，最好情况 O(n)（如果初始状态已经有序），最坏情况 O(n^2)。
python
Copy code
def insertion_sort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i - 1
        while j >= 0 and key < arr[j]:
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key
选择排序（Selection Sort）：

选择排序的思想是每次从未排序部分选择最小（或最大）的元素，与未排序部分的第一个元素交换位置。
时间复杂度：平均 O(n^2)，最好情况 O(n^2)，最坏情况 O(n^2)。
python
Copy code
def selection_sort(arr):
    for i in range(len(arr)):
        min_idx = i
        for j in range(i + 1, len(arr)):
            if arr[j] < arr[min_idx]:
                min_idx = j
        arr[i], arr[min_idx] = arr[min_idx], arr[i]
这两种算法都不涉及元素的交换，而是通过元素的比较和移动来达到排序的目的。在实际应用中，对于小型数据集，插入排序的性能通常较好，而选择排序的性能相对较差。然而，对于大型数据集，通常会选择更高效的排序算法，例如归并排序（Merge Sort）或快速排序（Quick Sort）。