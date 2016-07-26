#=============================================================================
# FILE: calc.py
# AUTHOR: hrsh7th
#=============================================================================

from .base import Base
import deoplete.util
import re

class Source(Base):
    def __init__(self, vim):
        Base.__init__(self, vim)

        self.name = 'calc'
        self.mark = '[calc]'
        self.is_bytepos = True
        self.rank = 500

    def get_complete_position(self, context):
        return self.vim.call('necocalc#get_complete_position', context['input'])

    def gather_candidates(self, context):
        return self.vim.call('necocalc#gather_candidates', context['complete_str'])

