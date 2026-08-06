# global agent instructions

## Writing
- Write plain dash "-" wherever you would reach for an em dash "—": prose, commits, new code. Leave existing code as it is.
- A comment must earn its place: write one only when it is faster to read than the code it describes,
  or carries context unavailable from the neighbouring code and from clicking through to references
  and implementations. Keep earned comments to the fewest words that work; leave self-explanatory code bare.

## Commits
- Write commit messages as a concise title only: no body, no `Co-Authored-By` trailer.

## Engineering standard
- YAGNI, absolutely. Build the bare minimum that meets the stated requirements. Quality, robustness
  and scalability apply to the requirements you have, never to ones you imagine.
- When a solution seems to warrant more - an extra layer, a hook for later, a case nobody asked for -
  that is a question about whether the requirements should expand. Put the question to the user;
  building it is not an answer.
- Weigh technical decisions on quality, simplicity, robustness, scalability, and long-term
  maintainability. Development cost is a minor factor.
- Change auto-generated files only through their generator: edit the source or template, then regenerate.
