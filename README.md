# tests-io
A simple test framework, written in bash, for testing console applications.
It works by accepting a set of `input` tests and comparing the program output to a set of `expected result` files.

## Usage
### File System Structure
```
./                        --> your project directory
 /tests/**tests-io.sh**   --> the test script
       /input/            --> folder for **input** and **expected** test files
```

### Writing input and expected files
Test input files stay in the `input` directory and have to match the following template - `test-{number}`.
For every corresponding input file, there should be an `expected` file. 
It should be created in the same directory and match the template - `test-{number}.exp`.
The `number` in the `expected file` name determines which is the corresponding `input file`.

### Running the script
In order to run the testing script, execute the command
```
bash tests-io.sh {program-name}
```

The `program-name` should be a valid executable. You should also specify `the path` to the executable unless it is present in the `PATH` environment variable.

### Output files
After running the tests, there is an `output` folder created, where you can inspect the actual program outputs for every test being ran.

There is currently not an option for automatically deleting the folder after running the tests. But I am accepting pull requests. :) 

Usage: 
1. Put test files in the script's folder with name 'test-X', where X is some number
2. Put expected output files in the script's folder with name 'test-X-expected'
3. Run the script by typing 'bash test-framework.sh \<path-to-program\>'
