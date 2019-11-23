import nltk
import os


nltk.download('stopwords', download_dir=os.environ.get('NLTK_DATA', default='/app/data/nltk'))
nltk.download('wordnet', download_dir=os.environ.get('NLTK_DATA', default='/app/data/nltk'))