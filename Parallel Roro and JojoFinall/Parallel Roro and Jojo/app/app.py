from flask import Flask, render_template, request
import subprocess
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = "C:\\Users\\Startklar\\OneDrive\\Desktop\\Parallel Roro and Jojo\\uploads"
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)  # Ensure upload folder exists

@app.route('/', methods=['GET', 'POST'])
def index():
    output = ""

    if request.method == 'POST':
        task = request.form.get('task')
        processes = request.form.get('processes')

        if not task or not processes:
            output = "Please select a task and specify the number of processes."
            return render_template('index.html', output=output)

        # Command setup
        cmd = [
            "mpirun", "-n", processes,
            "python", "C:\\Users\\Startklar\\OneDrive\\Desktop\\Parallel Roro and Jojo\\alltasks.py",
            "--task", task
        ]

        # Handle task-specific parameters
        if task == "1":
            nums = request.form.get("numbers")
            if nums:
                cmd += ["--nums", nums]

        if task == "3":
            filter_type = request.form.get("filter")
            if filter_type:
                cmd += ["--filter", filter_type]

        if task == "5":
            keyword = request.form.get("keyword")
            if keyword:
                cmd += ["--keyword", keyword]

        if task == "7":
            a_rows = request.form.get("a_rows")
            a_cols = request.form.get("a_cols")
            b_rows = request.form.get("b_rows")
            b_cols = request.form.get("b_cols")
            a_values = request.form.get("a_values")
            b_values = request.form.get("b_values")

            if not (a_rows and a_cols and b_rows and b_cols and a_values and b_values):
                output = "Please provide all matrix dimensions and values."
                return render_template('index.html', output=output)

            cmd += [
                "--a_rows", a_rows,
                "--a_cols", a_cols,
                "--b_rows", b_rows,
                "--b_cols", b_cols,
                "--a_values", a_values,
                "--b_values", b_values
            ]

        # Handle file upload
        uploaded_file = request.files.get('file')
        if uploaded_file and uploaded_file.filename != '':
            filename = secure_filename(uploaded_file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            uploaded_file.save(filepath)
            cmd += ["--file", filepath]

        try:
            # Execute the command
            process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            stdout, stderr = process.communicate(timeout=60)
            output = stdout if stdout else "No output received."
            if stderr:
                output += f"\nErrors:\n{stderr}"
        except subprocess.TimeoutExpired:
            output = "Task execution timed out."
        except Exception as e:
            output = f"Execution error: {e}"

    return render_template('index.html', output=output)

if __name__ == '__main__':
    app.run(debug=True)
