require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include ::Asciidoctor

Extensions.register do
  # A treeprocessor that increments each level-1 section number by the value of
  # the `sectnumoffset` attribute. The numbers of all subsections will be
  # incremented automatically since those values are calculated dynamically.
  #
  # Run using:
  #
  # asciidoctor -r ./lib/sectnumoffset-treeprocessor.rb -a sectnums -a sectnumoffset=1 lib/sectnumoffset-treeprocessor/sample.adoc
  treeprocessor do
    process do |document|
      if (document.attr? 'sectnums') && (sectnumoffset = (document.attr 'sectnumoffset', 0).to_i) > 0
        ((document.find_by context: :section) || []).each do |sect|
          # FIXME use filter block once Asciidoctor >= 1.5.3 is available
          next unless sect.level == 1
          # Distinguish between normal chapters and appendices
          # by type of sect.number
          if (sect.number.is_a?(Integer))
            sect.number += sectnumoffset
          else
            # Hack to increment appendices
            for i in 1..sectnumoffset do
              # Eg "Appendix A" --> "Appendix B"
              sect.caption = sect.caption.next
              # Eg "B" --> "C"
              sect.number = sect.number.next
            end
          end
        end
      end
      nil
    end
  end
end
