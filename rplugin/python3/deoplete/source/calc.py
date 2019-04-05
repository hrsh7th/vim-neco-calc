import re
from deoplete.source.base import Base

class Source(Base):
    def __init__(self, vim):
        Base.__init__(self, vim)

        self.name = 'calc'
        self.mark = '[calc]'
        self.rank = 10
        self.vars = {}
        self.input_pattern = self.regex()
        self.ignore_pattern = r'^(?:\d+(?:\.\d+)?|\s)+$'
        self.is_volatile = True
        self.min_pattern_length = 3

    def gather_candidates(self, context):
        candidates = []
        try:
            calculates = re.findall(self.input_pattern, context['input'])
            if re.match(self.ignore_pattern, calculates[0]):
                return []

            output = str(eval(calculates[0]))
            candidates += [{
                'word': ' = {}'.format(output),
                'abbr': '{} = {}'.format(calculates[0].strip(), output),
                'dup': 1
            }]
            candidates += [{
                'word': ' = {}'.format(output),
                'abbr': output,
                'dup': 1
            }]
        except:
            pass
        return candidates

    def regex(self):
        parts = []
        parts += [r'\d+(?:\.\d+)?']
        parts += [r'\s*']
        parts += [re.escape(x) for x in ['+', '*', '/', '-', '%']]
        parts += [re.escape(x) for x in ['(', ')']]
        regex = r'(?:' + r'|'.join(parts) + r')+$'
        return regex

