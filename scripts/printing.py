import dLux
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("index", help="index of the job", type=int)
args = parser.parse_args()
index = args.index

square_numbers = [x**2 for x in range(10)]
print(f"dLux version: {dLux.__version__}.")
print(f"The {index}th square number is {square_numbers[index]}.")