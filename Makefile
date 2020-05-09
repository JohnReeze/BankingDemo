## Installs all dependencies
init:
	# Install bundler if not installed
	if ! gem spec bundler > /dev/null 2>&1; then\
  		echo "bundler gem is not installed!";\
  		-sudo gem install bundler;\
	fi
	-bundle update
	-bundle install --path .bundle
	-bundle exec pod repo update
	-bundle exec pod install

## Run tests
test:
	xcodebuild -workspace BankingDemo.xcworkspace  -scheme BankingDemoDebug -sdk iphonesimulator  -destination 'name=iPhone 11' test

## Run SwiftLint check
lint:
	./Pods/SwiftLint/swiftlint lint --config .swiftlint.yml
	npx jscpd --config ./.jscpd.json ./BankingDemo

## Autocorrect with SwiftLint
format:
	./Pods/SwiftLint/swiftlint autocorrect --config .swiftlint.yml

## Execute pod install command
pod:
	-bundle exec pod install

