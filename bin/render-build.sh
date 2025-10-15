set -o errexit

# Node.jsの依存関係をインストール
yarn install --frozen-lockfile

# Bundlerでgemをインストール
bundle install

# アセットをプリコンパイル（本番環境用）
RAILS_ENV=production bundle exec rails assets:precompile

# データベースのマイグレーション
bundle exec rails db:migrate