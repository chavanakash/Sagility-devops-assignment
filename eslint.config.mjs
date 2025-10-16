import js from "@eslint/js";
import globals from "globals";

export default [
  {
    files: ["**/*.{js,mjs,cjs}"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        ...globals.node,  
        ...globals.jest,   
      },
    },
    rules: {
      ...js.configs.recommended.rules,
    },
  },
];
