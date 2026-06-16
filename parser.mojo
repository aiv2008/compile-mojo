from std.memory import ArcPointer
from std.collections.string import Codepoint
from ast import Rule


@fieldwise_init
struct Parser(Movable):
    var input: String
    var position: UInt
    var rules: Dict[String, ArcPointer[Rule]]

    def __init__(out self, var input: String):
        self.input = input^
        self.position = 0
        self.rules = Dict[String, ArcPointer[Rule]]()


    def add_rule(mut self, var name: String, var rule: Rule):
        self.rules[name^] = ArcPointer[Rule](value=rule^)

    def get_rule(self, name: String) raises -> ArcPointer[Rule]:
        return self.rules[name]

    # 主解析函数：解析整个 PEG 语法定义
    #  语法格式示例：
    #    rule1 = { "a" ~ "b" }
    #    rule2 = { "c" | "d" }
    def parse(self):
        pass
    
    


    #  第二步：实现辅助函数（跳过空白、读取字符等）
    #  1. 跳过空白字符（空格、\t、\n、\r）
    def skip_whitespace(mut self):
        while not self.is_at_end() and self.input[byte=Int(self.position)].isspace():
            self.position += 1

    # 2. 检查是否到达输入末尾
    def is_at_end(self)->Bool:
        return self.position >= UInt(self.input.byte_length())

    # 3. 获取当前字符（不移动位置）
    def peek(self) -> Optional[Byte]:
        if self.is_at_end():
            return Optional[Byte]()
        return Optional[Byte](self.input.as_bytes()[Int(self.position)])

    #  解析标识符（规则名）
    #  4. 读取当前字符并移动位置
    def advance(mut self) -> Optional[Byte]:
        if self.is_at_end():
            return None
        var b = self.input.as_bytes()[Int(self.position)]
        self.position += 1
        return Optional[Byte](b)

    #  第三步：解析标识符（规则名），例如 "expression", "term123"
    #  返回值：解析出的标识符字符串，或 null（如果没有找到）
    def parse_identifier(mut self) -> Optional[String]:
        self.skip_whitespace()

        if self.is_at_end():
            return None

        var first_char = self.input.as_bytes()[Int(self.position)]
        if not is_identifier_start(first_char):
            return None
        var start_pos = self.position
        while not self.is_at_end():
            var ch = self.input.as_bytes()[Int(self.position)]
            
        return ""

def is_letter(b: Byte) -> Bool:
    return (b >= Byte(ord('a')) and b <= Byte(ord('z'))) or (b >= Byte(ord('A')) and b <= Byte(ord('Z')))

def is_identifier_start(ch: Byte) -> Bool:
    return is_letter(ch) or ch == Byte(ord('_')) 

def is_ascii_digit(b: Byte) -> Bool:
    return Codepoint(UInt8(b)).is_ascii_digit()

def is_identifier_char(ch: Byte) -> Bool:
    return is_letter(ch) or is_ascii_digit(ch) or ch == Byte(ord('_')) 