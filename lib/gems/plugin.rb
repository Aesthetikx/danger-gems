# frozen_string_literal: true

module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  #
  # @example Ensure people are well warned about merging on Mondays
  #
  #          my_plugin.warn_on_mondays
  #
  # @see  Aesthetikx/danger-gems
  # @tags monday, weekends, time, rattata
  #
  class DangerGems < Plugin
    def summarize_changes
      markdown Gems::SummaryTable.new(changes: changes).markdown
    end

    def changes
      Gems::Gemfile.changes(git: git)
    end

    def additions
      changes.select(&:addition?)
    end

    def removals
      changes.select(&:removal?)
    end

    def upgrades
      changes.select(&:upgrade?)
    end

    def downgrades
      changes.select(&:downgrade?)
    end
  end
end