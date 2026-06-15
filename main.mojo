from ast import (
    Choice,
    RuleRef,
    Rule,
    and_predicate,
    choice,
    literal,
    one_or_more,
    optional,
    regex,
    rule_ref,
    sequence,
)

fn main():
    # expr = rule_ref("term") ~ ("+" | "-") ~ rule_ref("term") | rule_ref("term")
    var expr = choice(
        sequence(
            sequence(rule_ref("term"), choice(literal("+"), literal("-"))),
            rule_ref("term"),
        ),
        rule_ref("term"),
    )

    # digit+ = &digit ~ digit*
    _ = sequence(
        and_predicate(literal("0")),
        one_or_more(literal("0")),
    )

    _ = optional(literal("?"))
    _ = regex("[0-9]+")

    if expr.data.isa[RuleRef]():
        pass
    elif expr.data.isa[Choice]():
        pass

    print("AST built successfully")
