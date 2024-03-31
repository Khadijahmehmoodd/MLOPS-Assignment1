import subprocess

def test_app_script():
    try:
        subprocess.run(['python', 'app.py'], check=True)
    except subprocess.CalledProcessError as e:
        assert False, f"Running app.py script failed with error: {e}"
