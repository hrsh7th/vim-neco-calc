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

    def gather_candidates(self, context):
        candidates = []
        try:
            if re.match(r'^\s*\d+(\.\d+)?\s*$', context['input']):
                return []
            output = str(eval(context['input']))
            candidates += [{
                'word': ' = {}'.format(output),
                'abbr': '{} = {}'.format(context['input'].strip(), output),
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
        parts += [re.escape(x) for x in ['+', '*', '/', '-', '%']]
        parts += ['\d+(\.\d+)?']
        parts += [re.escape(x) for x in ['(', ')']]
        return '(' + '|'.join(parts) + ')'

