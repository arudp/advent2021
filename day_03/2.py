from typing import List
from functools import reduce


SMALL_INPUT: str = "./day_03/small_input";
INPUT: str = "./day_03/input";

def get_most_common(filtered: List[str], pos: int) -> str:
  ones: int = reduce( lambda acc, item: acc + int(item[pos]), filtered, 0)
  return "1" if ones >= len(filtered) / 2 else "0"

with open(INPUT) as f:
  lines: List[str] = f.readlines()

  length: int = len(lines[0])
  filtered: List[str] = lines
  pos: int = 0

  while len(filtered) > 1 and pos < length:
    common: str = get_most_common(filtered, pos)
    filtered = [l for l in filtered if l[pos] == common]
    pos += 1

  oxygen = filtered[0].strip("\n")

  filtered: List[str] = lines
  pos: int = 0

  while len(filtered) > 1 and pos < length:
    common: str = get_most_common(filtered, pos)
    common = "1" if common == "0" else "0"

    filtered = [l for l in filtered if l[pos] == common]
    pos += 1

  co2 = filtered[0].strip("\n")

  print(f"Oxygen: {oxygen}")
  print(f"CO2: {co2}")
  print(f"things: {int(oxygen, 2) * int(co2, 2)}")

