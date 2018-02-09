.PHONY: all docs

all:
	mix test
	mix property
	mix dialyzer
	mix credo --strict

docs:
	mix docs

shell:
	iex -S mix
