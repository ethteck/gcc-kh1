#include <stdlib.h>

size_t
_DEFUN (_wcstombs_r, (reent, s, pwcs, n, state),
        struct _reent *r    _AND         
        char          *s    _AND
        const wchar_t *pwcs _AND
        size_t         n    _AND
        int           *state)
{
  char *ptr = s;
  size_t max = n;
  char buff[8];
  int i, num_to_copy;

  while (n > 0)
    {
      int bytes = _wctomb_r (r, buff, *pwcs, state);
      if (bytes == -1)
        return -1;
      num_to_copy = (n > bytes ? bytes : (int)n);
      for (i = 0; i < num_to_copy; ++i)
        *ptr++ = buff[i];
          
      if (*pwcs == 0x00)
        return ptr - s - (n >= bytes);
      ++pwcs;
      n -= num_to_copy;
    }

  return max;
} 
