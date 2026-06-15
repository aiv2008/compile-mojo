from std.memory import OwnedPointer
from std.utils import Variant

# === 叶子节点 ===

@fieldwise_init
struct Literal(Movable):
    """字面量匹配."""
    var text: String

@fieldwise_init
struct Regex(Movable):
    """正则表达式匹配."""
    var pattern: String

@fieldwise_init
struct RuleRef(Movable):
    """规则引用."""
    var name: String

# === 组合节点（递归引用 Rule）===

@fieldwise_init
struct Sequence(Movable):
    """序列: A ~ B (A 后跟 B)."""
    var left: OwnedPointer[Rule]
    var right: OwnedPointer[Rule]

@fieldwise_init
struct Choice(Movable):
    """选择: A | B (A 或 B, 有序)."""
    var left: OwnedPointer[Rule]
    var right: OwnedPointer[Rule]

@fieldwise_init
struct Repeat(Movable):
    """重复: A+ 或 A*."""
    var rule: OwnedPointer[Rule]
    var min: UInt
    var max: Optional[UInt]

@fieldwise_init
struct OptionalRule(Movable):
    """可选: A?."""
    var rule: OwnedPointer[Rule]

@fieldwise_init
struct NotPredicate(Movable):
    """否定前瞻: !A (不匹配 A)."""
    var rule: OwnedPointer[Rule]

@fieldwise_init
struct AndPredicate(Movable):
    """肯定前瞻: &A (匹配 A 但不消耗)."""
    var rule: OwnedPointer[Rule]

# === 顶层 Rule（类似 Zig 的 union(enum)）===

comptime RuleData = Variant[
    Literal,
    Regex,
    RuleRef,
    Sequence,
    Choice,
    OptionalRule,
    Repeat,
    NotPredicate,
    AndPredicate,
]

@fieldwise_init
struct Rule(Movable & ImplicitlyDestructible):
    var data: RuleData

        

fn _ptr(var rule: Rule) -> OwnedPointer[Rule]:
    return OwnedPointer[Rule](value=rule^)

fn literal(var text: String) -> Rule:
    return Rule(Literal(text^))

fn regex(var pattern: String) -> Rule:
    return Rule(Regex(pattern^))

fn rule_ref(var name: String) -> Rule:
    return Rule(RuleRef(name^))

fn sequence(var left: Rule, var right: Rule) -> Rule:
    return Rule(Sequence(_ptr(left^), _ptr(right^)))

fn choice(var left: Rule, var right: Rule) -> Rule:
    return Rule(Choice(_ptr(left^), _ptr(right^)))

fn optional(var inner: Rule) -> Rule:
    return Rule(OptionalRule(_ptr(inner^)))

fn one_or_more(var inner: Rule) -> Rule:
    return Rule(Repeat(_ptr(inner^), 1, Optional[UInt]()))

fn zero_or_more(var inner: Rule) -> Rule:
    return Rule(Repeat(_ptr(inner^), 0, Optional[UInt]()))

fn repeat_n(var inner: Rule, min: UInt, max: Optional[UInt]) -> Rule:
    return Rule(Repeat(_ptr(inner^), min, max))

fn not_predicate(var inner: Rule) -> Rule:
    return Rule(NotPredicate(_ptr(inner^)))

fn and_predicate(var inner: Rule) -> Rule:
    return Rule(AndPredicate(_ptr(inner^)))
