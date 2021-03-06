require 'test_helper'
require 'lib/generators/haml/testing_helper'

class Haml::Generators::MailerGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Rails::Generators::MailerGenerator
  arguments %w(notifier foo bar --template-engine haml)

  setup :prepare_destination
  setup :copy_routes

  test "should invoke template engine" do
    run_generator

    if ::Rails.version.to_s >= '4.2'
      assert_file "app/views/layouts/mailer.text.haml" do |view|
        assert_match /\= yield/, view
      end

      assert_file "app/views/layouts/mailer.html.haml" do |view|
        assert_match /\= yield/, view
      end

      assert_file "app/views/notifier_mailer/foo.html.haml" do |view|
        assert_match %r(app/views/notifier_mailer/foo\.html\.haml), view
        assert_match /\= @greeting/, view
      end

      assert_file "app/views/notifier_mailer/bar.html.haml" do |view|
        assert_match %r(app/views/notifier_mailer/bar\.html\.haml), view
        assert_match /\= @greeting/, view
      end

      assert_file "app/views/notifier_mailer/foo.text.haml" do |view|
        assert_match %r(app/views/notifier_mailer/foo\.text\.haml), view
        assert_match /\= @greeting/, view
      end

      assert_file "app/views/notifier_mailer/bar.text.haml" do |view|
        assert_match %r(app/views/notifier_mailer/bar\.text\.haml), view
        assert_match /\= @greeting/, view
      end
    else
      if ::Rails.version.to_s >= '4.1'
        assert_file "app/views/notifier/foo.html.haml" do |view|
          assert_match %r(app/views/notifier/foo\.html\.haml), view
          assert_match /\= @greeting/, view
        end

        assert_file "app/views/notifier/bar.html.haml" do |view|
          assert_match %r(app/views/notifier/bar\.html\.haml), view
          assert_match /\= @greeting/, view
        end
      end

      assert_file "app/views/notifier/foo.text.haml" do |view|
        assert_match %r(app/views/notifier/foo\.text\.haml), view
        assert_match /\= @greeting/, view
      end

      assert_file "app/views/notifier/bar.text.haml" do |view|
        assert_match %r(app/views/notifier/bar\.text\.haml), view
        assert_match /\= @greeting/, view
      end
    end
  end
end
