// eslint.config.mjs
import js from '@eslint/js';
import globals from 'globals';

export default [
  js.configs.recommended,
  {
    languageOptions: {
      ecmaVersion: 2021,
      sourceType: 'module',
      globals: {
        ...globals.node,
        ...globals.jest,
      },
    },
    rules: {
      'no-console': 'off', // allow console.log
      'no-undef': 'off',   // avoid false positives on process, require, etc.
      'no-unused-vars': ['warn'],
      semi: ['error', 'always'],
      quotes: ['error', 'single'],
    },
  },
];
