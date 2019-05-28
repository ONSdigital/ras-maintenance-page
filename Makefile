build:
	pipenv install --dev

test:
	pipenv run pytest tests  --cov-report term-missing --cov app --capture no

start:
	pipenv run python run.py

