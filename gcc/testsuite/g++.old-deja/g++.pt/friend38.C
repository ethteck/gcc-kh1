// Build don't link:

// Overly simplified from testcase by "B. K. Oxley" <binkley@bigfoot.com>

// crash test - XFAIL *-*-*

template<class P> struct foo {
  typedef P parent_type;
  friend parent_type; // ERROR - template parameters cannot be friends
};
