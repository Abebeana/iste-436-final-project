from __future__ import annotations

import argparse
import re
from pathlib import Path

from pypdf import PdfReader


DEFAULT_KEY_TERMS = [
    "deliverable",
    "deliverables",
    "requirement",
    "requirements",
    "schema",
    "table",
    "transaction",
    "procedure",
    "package",
    "concurrency",
    "concurrent",
    "lost update",
    "dirty read",
    "isolation",
    "lock",
    "rubric",
    "grade",
    "report",
    "submission",
]


def extract_text(pdf_path: Path) -> str:
    reader = PdfReader(str(pdf_path))
    parts: list[str] = []
    for page in reader.pages:
        parts.append(page.extract_text() or "")
    return "\n".join(parts)


def compact(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def dump_text(out_dir: Path, pdf_name: str, text: str) -> Path:
    out_dir.mkdir(parents=True, exist_ok=True)
    out_path = out_dir / f"{pdf_name}.extracted.txt"
    out_path.write_text(text, encoding="utf-8")
    return out_path


def main() -> None:
    parser = argparse.ArgumentParser(description="Extract key rubric text from the project PDFs")
    parser.add_argument(
        "--dump",
        action="store_true",
        help="Write full extracted text files under tools/extracted/ for deeper review",
    )
    parser.add_argument(
        "--terms",
        nargs="*",
        default=DEFAULT_KEY_TERMS,
        help="Terms to search for (case-insensitive)",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parents[1]
    out_dir = repo_root / "tools" / "extracted"
    pdfs = [repo_root / "ProjectDescription.pdf", repo_root / "ISTE-436-FINAL.pdf"]

    for pdf in pdfs:
        print(f"\n=== {pdf.name} ===")
        if not pdf.exists():
            print("Missing file")
            continue

        reader = PdfReader(str(pdf))
        full = extract_text(pdf)
        print(f"pages: {len(reader.pages)}  chars: {len(full)}")

        if args.dump:
            out_path = dump_text(out_dir, pdf.stem, full)
            print(f"dumped: {out_path.relative_to(repo_root)}")

        for term in args.terms:
            m = re.search(re.escape(term), full, re.IGNORECASE)
            if not m:
                continue
            start = max(0, m.start() - 350)
            end = min(len(full), m.end() + 650)
            print(f"\n-- hit: {term} --")
            print(compact(full[start:end]))

        print("\n-- head --")
        print(compact(full[:1200]))


if __name__ == "__main__":
    main()
