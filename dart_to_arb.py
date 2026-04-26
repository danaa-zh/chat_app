import re
import json
import os

LOCALES = ["en", "kk", "ru"]
DART_DIR = "lib/features/l10n/generated"
ARB_DIR  = "lib/features/l10n"

def parse_dart(dart_code):
    result = {}
    for key, val in re.findall(r"String get (\w+)\s*=>\s*'((?:[^'\\]|\\.)*)'\s*;", dart_code):
        result[key] = val.replace("\\'", "'")
    for key, val in re.findall(r'String get (\w+)\s*=>\s*"((?:[^"\\]|\\.)*)"\s*;', dart_code):
        result[key] = val.replace('\\"', '"')
    for key, val in re.findall(r"String get (\w+)\s*=>\s*\n\s*'((?:[^'\\]|\\.)*)'", dart_code):
        result[key] = val.replace("\\'", "'")
    for key, param, body in re.findall(r"String (\w+)\(String (\w+)\)\s*\{\s*return\s*'((?:[^'\\]|\\.)*)'\s*;\s*\}", dart_code):
        arb_val = re.sub(rf"\$\{{{param}\}}|\${param}", f"{{{param}}}", body)
        result[key] = arb_val.replace("\\'", "'")
    return result

def build_arb(locale, translations, reference=None):
    arb = {"@@locale": locale}
    for key, value in translations.items():
        arb[key] = value
        meta_key = f"@{key}"
        if reference and meta_key in reference:
            arb[meta_key] = reference[meta_key]
    return arb

def main():
    en_arb_path = os.path.join(ARB_DIR, "app_en.arb")
    reference_arb = {}
    if os.path.exists(en_arb_path):
        with open(en_arb_path, encoding="utf-8") as f:
            reference_arb = json.load(f)

    for locale in LOCALES:
        dart_path = os.path.join(DART_DIR, f"app_localizations_{locale}.dart")
        arb_path  = os.path.join(ARB_DIR,  f"app_{locale}.arb")
        if not os.path.exists(dart_path):
            print(f"Not found, skipping: {dart_path}")
            continue
        with open(dart_path, encoding="utf-8") as f:
            dart_code = f.read()
        translations = parse_dart(dart_code)
        arb = build_arb(locale, translations, reference_arb)
        os.makedirs(ARB_DIR, exist_ok=True)
        with open(arb_path, "w", encoding="utf-8") as f:
            json.dump(arb, f, ensure_ascii=False, indent=2)
            f.write("\n")
        print(f"Written {len(translations)} keys -> {arb_path}")

    print("Done! Run flutter gen-l10n to regenerate dart files.")

if __name__ == "__main__":
    main()
