module Genome
  module Importers
    module Civic
    
      def self.source_info
        {
          base_url: 'https://www.civicdb.org',
          site_url: 'https://civic.genome.wustl.edu',
          citation: 'CIViC: Clinical Interpretations of Variants in Cancer',
          source_db_version: '24-Aug-2015',
          source_type_id: DataModel::SourceType.INTERACTION,
          source_db_name: 'CIViC',
          full_name: 'CIViC: Clinical Interpretations of Variants in Cancer'
        }
      end

      def self.run(tsv_path)
        blank_filter = ->(x) { x.blank? }
        TSVImporter.import tsv_path, CivicRow, source_info do
          interaction known_action_type: 'unknown' do
            drug :drug_name, nomenclature: 'CIViC Drug Name', primary_name: :drug_name do
            end
            gene :gene_symbol, nomenclature: 'CIViC Gene Name' do
              name :entrez_gene_id, nomenclature: 'Entrez Gene ID', unless: blank_filter
            end

            attribute :interaction_type, name: 'Interaction Type', unless: blank_filter
          end
        end.save!
      end
    end
  end
end
