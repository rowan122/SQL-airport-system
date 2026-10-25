# alltasks.py
import subprocess
from flask import render_template
from mpi4py import MPI
import argparse
import os
import numpy as np
from PIL import Image, ImageFilter
import sys
sys.stdout.flush()
from mpi4py import MPI
comm = MPI.COMM_WORLD
rank = comm.Get_rank()

if rank == 0:
    print("MPI is running on", comm.Get_size(), "processes!")
    import sys; sys.stdout.flush()

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()
cmd = [
    "mpirun", "-n", "4",  # or how many processes you want
    "python", "alltasks.py",
    "--task", "1",  # example
    "--nums", "3,2,1"
]

# Run with cwd set to the folder containing alltasks.py
process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, cwd=r"C:\\Users\\Startklar\\OneDrive\\Desktop\\Parallel Roro and Jojo")
stdout, stderr = process.communicate()
print(stdout)
print(stderr)




def sorting_task(nums):
    numbers = list(map(int, nums.split(',')))
    chunk_size = len(numbers) // size
    local_nums = numbers[rank*chunk_size:(rank+1)*chunk_size] if rank != size - 1 else numbers[rank*chunk_size:]
    local_sorted = sorted(local_nums)
    gathered = comm.gather(local_sorted, root=0)
    if rank == 0:
        merged = sorted([num for sublist in gathered for num in sublist])
        print("Sorted Result:", merged)


def file_processing_task(filepath):
    with open(filepath, 'r') as file:
        lines = file.readlines()
    chunk_size = len(lines) // size
    local_lines = lines[rank*chunk_size:(rank+1)*chunk_size] if rank != size - 1 else lines[rank*chunk_size:]
    local_word_count = sum(len(line.split()) for line in local_lines)
    total = comm.reduce(local_word_count, op=MPI.SUM, root=0)
    if rank == 0:
        print("Total Word Count:", total)
    if not os.path.exists(filepath):
        output = f"[X] Uploaded file not found: {filepath}"
    return render_template('index.html', output=output)



def image_processing_task(filepath, filter_type):
    if rank == 0:
        img = Image.open(filepath)
        if filter_type == "BLUR":
            img = img.filter(ImageFilter.BLUR)
        elif filter_type == "CONTOUR":
            img = img.filter(ImageFilter.CONTOUR)
        elif filter_type == "DETAIL":
            img = img.filter(ImageFilter.DETAIL)
        if filter_type.upper() == "SHARPEN":
          img = img.filter(ImageFilter.SHARPEN)
        elif filter_type.upper() == "EDGE":
          img = img.filter(ImageFilter.FIND_EDGES)

        img.save("processed_image.png")
        print("[✓] Image processed and saved as processed_image.png")


def ml_training_task():
    samples_per_proc = 1000
    X = np.random.rand(samples_per_proc, 3)
    y = 3 * X[:, 0] + 2 * X[:, 1] + 1 * X[:, 2] + np.random.randn(samples_per_proc) * 0.1
    XTX_local = X.T @ X
    XTy_local = X.T @ y
    XTX = comm.reduce(XTX_local, op=MPI.SUM, root=0)
    XTy = comm.reduce(XTy_local, op=MPI.SUM, root=0)
    if rank == 0:
        coef = np.linalg.inv(XTX) @ XTy
        print("Model Coefficients:", coef)


def parallel_search_task(filepath, keyword):
    with open(filepath, 'r') as file:
        lines = file.readlines()
    chunk_size = len(lines) // size
    local_lines = lines[rank*chunk_size:(rank+1)*chunk_size] if rank != size - 1 else lines[rank*chunk_size:]
    local_matches = [line.strip() for line in local_lines if keyword in line]
    all_matches = comm.gather(local_matches, root=0)
    if rank == 0:
        matches = [item for sublist in all_matches for item in sublist]
        print(f"Found {len(matches)} matches:")
        for m in matches:
            print(m)
    if not os.path.exists(filepath):
        output = f"[X] Uploaded file not found: {filepath}"
    return render_template('index.html', output=output)


def stats_analyzer_task(filepath):
    data = np.loadtxt(filepath)
    chunk_size = len(data) // size
    local_data = data[rank*chunk_size:(rank+1)*chunk_size] if rank != size - 1 else data[rank*chunk_size:]
    local_sum = np.sum(local_data)
    local_sq_sum = np.sum(local_data**2)
    total_sum = comm.reduce(local_sum, op=MPI.SUM, root=0)
    total_sq_sum = comm.reduce(local_sq_sum, op=MPI.SUM, root=0)
    total_count = comm.reduce(len(local_data), op=MPI.SUM, root=0)
    if rank == 0:
        mean = total_sum / total_count
        variance = (total_sq_sum / total_count) - (mean**2)
        print(f"Mean: {mean}, Variance: {variance}")


def matrix_multiplication_task(args):
    A = np.fromstring(args.a_values, sep=",").reshape((int(args.a_rows), int(args.a_cols)))
    B = np.fromstring(args.b_values, sep=",").reshape((int(args.b_rows), int(args.b_cols)))
    rows_per_proc = A.shape[0] // size
    local_A = A[rank*rows_per_proc:(rank+1)*rows_per_proc] if rank != size - 1 else A[rank*rows_per_proc:]
    local_result = np.dot(local_A, B)
    gathered = comm.gather(local_result, root=0)
    if rank == 0:
        result = np.vstack(gathered)
        print("Matrix A:")
        print(A)
        print("Matrix B:")
        print(B)
        print("Result of A * B:")
        print(result)
        if int(args.a_cols) != int(args.b_rows):
    
          print("[X] A's columns must equal B's rows for multiplication.")
    return



def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--task', required=True)
    parser.add_argument('--nums')
    parser.add_argument('--file')
    parser.add_argument('--filter')
    parser.add_argument('--keyword')
    parser.add_argument('--a_rows')
    parser.add_argument('--a_cols')
    parser.add_argument('--b_rows')
    parser.add_argument('--b_cols')
    parser.add_argument('--a_values')
    parser.add_argument('--b_values')
    args = parser.parse_args()

    if args.task == '1':
        sorting_task(args.nums)
    elif args.task == '2':
        file_processing_task(args.file)
    elif args.task == '3':
        image_processing_task(args.file, args.filter)
    elif args.task == '4':
        ml_training_task()
    elif args.task == '5':
        parallel_search_task(args.file, args.keyword)
    elif args.task == '6':
        stats_analyzer_task(args.file)
    elif args.task == '7':
        matrix_multiplication_task(args)
    else:
        if rank == 0:
            print("[X] Invalid task number.")

if __name__ == '__main__':
    main()
