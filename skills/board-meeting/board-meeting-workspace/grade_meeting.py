"""Grade board meeting outputs against assertions."""
import re
import sys
import json

def count_words(text):
    return len(text.split())

def extract_agent_turns(text):
    """Extract each agent's turn content (between ## headers)."""
    # Find all ## Agent Name sections
    pattern = r'## (\w+) \([^)]+\)\s*\n(.*?)(?=\n## |\n---|\n\*Approve|\Z)'
    matches = re.findall(pattern, text, re.DOTALL)
    turns = {}
    for name, content in matches:
        # Strip bold position lines and clean up
        clean = content.strip()
        turns[name] = {
            'content': clean,
            'word_count': count_words(clean)
        }
    return turns

def extract_recommendation(text):
    """Extract Board Recommendation section."""
    pattern = r'## Board Recommendation\s*\n(.*?)(?=\n---|\n>\s*\*|\n\*\*Supported|\n\*Approve|\Z)'
    match = re.search(pattern, text, re.DOTALL)
    if match:
        content = match.group(1).strip()
        return {'content': content, 'word_count': count_words(content)}
    return None

def grade_meeting(filepath):
    with open(filepath) as f:
        text = f.read()

    turns = extract_agent_turns(text)
    rec = extract_recommendation(text)

    # Calculate total discussion words (everything before Board Recommendation)
    rec_start = text.find('## Board Recommendation')
    if rec_start > 0:
        discussion = text[:rec_start]
        # Count only agent turn content
        total_discussion_words = sum(t['word_count'] for t in turns.values())
    else:
        total_discussion_words = 0

    results = {
        'agents_found': list(turns.keys()),
        'agent_word_counts': {name: t['word_count'] for name, t in turns.items()},
        'all_turns_under_60': all(t['word_count'] <= 60 for t in turns.values()),
        'max_turn_words': max((t['word_count'] for t in turns.values()), default=0),
        'total_discussion_words': total_discussion_words,
        'total_under_400': total_discussion_words <= 400,
        'recommendation_exists': rec is not None,
        'recommendation_words': rec['word_count'] if rec else 0,
        'recommendation_under_80': rec['word_count'] <= 80 if rec else False,
        'has_approval_prompt': bool(re.search(r'[Aa]pprove.*[Aa]mend.*[Rr]eject', text)),
        'has_save_prompt': bool(re.search(r'(save|document|keep.*chat)', text, re.IGNORECASE)),
        'has_risks': bool(re.search(r'[Rr]isk', text)),
    }
    return results

if __name__ == '__main__':
    filepath = sys.argv[1]
    results = grade_meeting(filepath)
    print(json.dumps(results, indent=2))
