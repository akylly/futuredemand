# Run 'python3 test_anagram.py' to run tests
import unittest

from anagram import is_anagram


class AnagramTest(unittest.TestCase):

    def test_empty_strings_should_return_true(self):
        self.assertTrue(is_anagram('', ''))

    def test_small_strings_should_return_true(self):
        self.assertTrue(is_anagram('baa','aba'))

    def test_sentences_should_return_true(self):
        self.assertTrue(is_anagram('baa xz','zba ax'))

    def test_small_strings_should_return_false(self):
        self.assertFalse(is_anagram('baa','abb'))

    def test_different_lengths_should_return_false(self):
        self.assertFalse(is_anagram('ab','aab'))

    def test_sentences_should_return_false(self):
        self.assertFalse(is_anagram('abb ff','aab ab'))


if __name__ == '__main__':
    unittest.main()
