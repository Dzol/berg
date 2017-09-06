REBAR = ./rebar3

.PHONY: doc type init clean

doc:
	$(REBAR) edoc

type:
	$(REBAR) dialyzer

init:
	chmod u+x $(REBAR)

clean:
	$(REBAR) clean
	rm -rf _build
