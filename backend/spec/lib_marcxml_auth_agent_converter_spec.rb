require 'spec_helper'
require 'converter_spec_helper'

require_relative '../app/converters/marcxml_auth_agent_converter'

describe 'MARCXML Auth Agent converter' do

  def my_converter
    MarcXMLAuthAgentConverter
  end

  let(:person_agent_1) {
    File.expand_path("../app/exporters/examples/marc/authority_john_davis.xml",
                     File.dirname(__FILE__))
  }

  let(:person_agent_2) {
    File.expand_path("../app/exporters/examples/marc/authority_john_davis_2.xml",
                     File.dirname(__FILE__))
  }

  let(:corporate_agent_1) {
    File.expand_path("../app/exporters/examples/marc/IAS.xml",
                     File.dirname(__FILE__))
  }

  let(:corporate_agent_2) {
    File.expand_path("../app/exporters/examples/marc/IAS_2.xml",
                     File.dirname(__FILE__))
  }

  let(:family_agent_1) {
    File.expand_path("../app/exporters/examples/marc/Wood.xml",
                     File.dirname(__FILE__))
  }


  describe "agent person" do
    before(:all) do
    end

    it "converts agent name from marc auth (indirect)" do
      record = convert(person_agent_1).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['names'][0]['primary_name']).to eq("Davis")
      expect(record['names'][0]['number']).to eq("IV")
      expect(record['names'][0]['title']).to eq("Dr.")
      expect(record['names'][0]['qualifier']).to eq("qualifier")
      expect(record['names'][0]['fuller_form']).to eq("fuller_form")
      expect(record['names'][0]['dates']).to eq("1873-1955")
      expect(record['names'][0]['authorized']).to eq(true)
    end

    it "converts agent name from marc auth (direct)" do
      record = convert(person_agent_2).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['names'][0]['primary_name']).to eq("Davis")
      expect(record['names'][0]['number']).to eq("IV")
      expect(record['names'][0]['title']).to eq("Dr.")
      expect(record['names'][0]['qualifier']).to eq("qualifier")
      expect(record['names'][0]['fuller_form']).to eq("378 fuller")
      expect(record['names'][0]['dates']).to eq("1873-1955")
      expect(record['names'][0]['authorized']).to eq(true)
    end

    it "imports parallel names" do
      record = convert(person_agent_1).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['names'][0]['parallel_names'].length).to eq(1)
      expect(record['names'][0]['parallel_names'][0]['primary_name']).to eq("Davis")
    end

    it "imports dates of existence" do
      record = convert(person_agent_1).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['dates_of_existence'][0]['structured_date_range']['begin_date_expression']).to eq("18990101")
      expect(record['dates_of_existence'][0]['structured_date_range']['end_date_expression']).to eq("19611201")
    end

    it "imports agent gender" do

      record = convert(person_agent_1).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['agent_genders'][0]['gender_enum']).to eq("Male")
    end

    it "imports topics" do
      record = convert(person_agent_1).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['agent_topics'].length).to eq(1)
    end
  end

  describe "agent family" do
    it "imports name" do
      record = convert(family_agent_1).select {|r| r['jsonmodel_type'] == "agent_family"}.first

      expect(record['names'][0]['family_name']).to eq("Wood, Natalie")
      expect(record['names'][0]['qualifier']).to eq("qualifier")
      expect(record['names'][0]['dates']).to eq("1873-1955")
      expect(record['names'][0]['authorized']).to eq(true)
    end

    it "imports parallel names" do
      record = convert(family_agent_1).select {|r| r['jsonmodel_type'] == "agent_family"}.first

      expect(record['names'][0]['parallel_names'].length).to eq(8)
      expect(record['names'][0]['parallel_names'][0]['family_name']).to eq("Gurdin, Natasha,")
      expect(record['names'][0]['parallel_names'][0]['authorized']).to eq(false)
    end

    it "imports dates of existence" do
      record = convert(family_agent_1).select {|r| r['jsonmodel_type'] == "agent_family"}.first

      expect(record['dates_of_existence'][0]['structured_date_range']['begin_date_expression']).to eq("1938-07-20")
      expect(record['dates_of_existence'][0]['structured_date_range']['end_date_expression']).to eq("1981-11-29")
    end

    it "imports functions" do
      record = convert(family_agent_1).select {|r| r['jsonmodel_type'] == "agent_family"}.first

      expect(record['agent_functions'].length).to eq(1)
    end
  end

  describe "agent_corporate_entity" do
    it "imports name" do
      record = convert(corporate_agent_1).select {|r| r['jsonmodel_type'] == "agent_corporate_entity"}.first

      expect(record['names'][0]['primary_name']).to eq("Institute for Advanced Study (Princeton, N.J.)")
      expect(record['names'][0]['authorized']).to eq(true)
      expect(record['names'][0]['conference_meeting']).to eq(false)
      expect(record['names'][0]['subordinate_name_1']).to eq("sub name 1")
      expect(record['names'][0]['location']).to eq("Miami")
      expect(record['names'][0]['dates']).to eq("1999")
      expect(record['names'][0]['number']).to eq("3")
      expect(record['names'][0]['qualifier']).to eq("qualifier")
    end

    it "imports name (conference)" do
      record = convert(corporate_agent_2).select {|r| r['jsonmodel_type'] == "agent_corporate_entity"}.first

      expect(record['names'][0]['primary_name']).to eq("Institute for Advanced Study (Princeton, N.J.)")
      expect(record['names'][0]['authorized']).to eq(true)
      expect(record['names'][0]['conference_meeting']).to eq(true)
      expect(record['names'][0]['subordinate_name_1']).to eq("sub name 1")
      expect(record['names'][0]['location']).to eq("Miami")
      expect(record['names'][0]['dates']).to eq("1999")
      expect(record['names'][0]['number']).to eq("3")
      expect(record['names'][0]['subordinate_name_2']).to eq("sub name 2")
    end

    it "imports parallel names" do
      record = convert(corporate_agent_1).select {|r| r['jsonmodel_type'] == "agent_corporate_entity"}.first

      expect(record['names'][0]['parallel_names'].length).to eq(3)
      expect(record['names'][0]['parallel_names'][0]['primary_name']).to eq("Louis Bamberger and Mrs. Felix Fuld Foundation")
      expect(record['names'][0]['parallel_names'][0]['authorized']).to eq(false)
    end    

    it "imports dates of existence" do
      record = convert(corporate_agent_1).select {|r| r['jsonmodel_type'] == "agent_corporate_entity"}.first

      expect(record['dates_of_existence'][0]['structured_date_range']['begin_date_expression']).to eq("1930-05-20")
    end

    it "imports functions" do
      record = convert(corporate_agent_1).select {|r| r['jsonmodel_type'] == "agent_corporate_entity"}.first

      expect(record['agent_functions'].length).to eq(1)
    end
  end

  describe "common subrecords" do
    it "imports agent_record_control" do
      record = convert(person_agent_1).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['agent_record_controls'][0]['maintenance_status_enum']).to eq("revised_corrected")
      expect(record['agent_record_controls'][0]['maintenance_agency']).to eq("DLC")
      expect(record['agent_record_controls'][0]['romanization_enum']).to eq("not_applicable")
      expect(record['agent_record_controls'][0]['language']).to eq("eng")
      expect(record['agent_record_controls'][0]['government_agency_type_enum']).to eq("unknown")
      expect(record['agent_record_controls'][0]['reference_evaluation_enum']).to eq("tr_consistent")
      expect(record['agent_record_controls'][0]['name_type_enum']).to eq("differentiated")
      expect(record['agent_record_controls'][0]['level_of_detail_enum']).to eq("fully_established")
      expect(record['agent_record_controls'][0]['modified_record_enum']).to eq("not_modified")
      expect(record['agent_record_controls'][0]['cataloging_source_enum']).to eq("nat_bib_agency")
    end

    it "imports agent_record_identifier" do
      record = convert(person_agent_1).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['agent_record_identifiers'][0]['record_identifier']).to eq("n  88218900")
      expect(record['agent_record_identifiers'][0]['identifier_type_enum']).to eq("local")
      expect(record['agent_record_identifiers'][0]['source_enum']).to eq("DLC")
      expect(record['agent_record_identifiers'][0]['primary_identifier']).to eq(true)
    end

    it "imports agent_maintenance_histories" do
      record = convert(person_agent_1, true).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['agent_maintenance_histories'][0]['event_date']).to eq("19890119")
      expect(record['agent_maintenance_histories'][0]['maintenance_event_type_enum']).to eq("created")
      expect(record['agent_maintenance_histories'][0]['maintenance_agent_type_enum']).to eq("machine")
      expect(record['agent_maintenance_histories'][0]['agent']).to eq("DLC")
    end

    it "does not import agent_maintenance_histories if option not set" do
      record = convert(person_agent_1, false).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['agent_maintenance_histories'].count == 0).to eq(true)
    end

    it "imports agent_conventions_declarations" do
      record = convert(person_agent_1).select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['agent_conventions_declarations'][0]['name_rule']).to eq("AACR2")
    end

    it "imports places of birth" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first
      subjects = raw.select {|r| r['jsonmodel_type'] == "subject"}

      place = record['agent_places'].select{|ap| ap['place_role_enum'] == "place_of_birth"}

      expect(place.length).to eq(1)
    end

    it "imports places of death" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first
      subjects = raw.select {|r| r['jsonmodel_type'] == "subject"}

      place = record['agent_places'].select{|ap| ap['place_role_enum'] == "place_of_death"}

      expect(place.length).to eq(1)
    end

    it "imports places of associated country" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first
      subjects = raw.select {|r| r['jsonmodel_type'] == "subject"}

      place = record['agent_places'].select{|ap| ap['place_role_enum'] == "assoc_country"}

      expect(place.length).to eq(1)
    end

    it "imports places of residence" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first
      subjects = raw.select {|r| r['jsonmodel_type'] == "subject"}

      place = record['agent_places'].select{|ap| ap['place_role_enum'] == "residence"}

      expect(place.length).to eq(1)
    end

    it "imports places of other associated" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first
      subjects = raw.select {|r| r['jsonmodel_type'] == "subject"}

      place = record['agent_places'].select{|ap| ap['place_role_enum'] == "other_assoc"}

      expect(place.length).to eq(1)
    end

    it "imports occupation" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first
      subjects = raw.select {|r| r['jsonmodel_type'] == "subject"}

      expect(record['agent_occupations'].length).to eq(1)
    end

    it "imports used language from $a" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['used_languages'][0]['language']).to eq('eng')
    end

    it "imports used language from value in $l if $a is not defined" do
      raw = convert(person_agent_2)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['used_languages'][0]['language']).to eq('fre')
    end

    it "imports agent_sources subrecords" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['agent_sources'][0]['source_entry']).to eq('NUCMC data from Washington and Lee University Lib. for Gaines, F. Papers, 1903-1982')
      expect(record['agent_sources'][0]['descriptive_note']).to eq('(Davis, John W.)')
      expect(record['agent_sources'][0]['file_uri']).to eq('http://www.google.com')
    end

    it "imports bioghist notes" do
      raw = convert(person_agent_1)

      record = raw.select {|r| r['jsonmodel_type'] == "agent_person"}.first

      expect(record['notes'][0]['label']).to eq('Biographical note')
      expect(record['notes'][1]['label']).to eq('Administrative history')

      expect(record['notes'][0]['subnotes'][0]['jsonmodel_type']).to eq('note_text')
      expect(record['notes'][0]['subnotes'][0]['content']).to eq('Biographical or historical data.')
      expect(record['notes'][0]['subnotes'][1]['jsonmodel_type']).to eq('note_abstract')
      expect(record['notes'][0]['subnotes'][1]['content']).to eq(['Expansion ...'])

      expect(record['notes'][1]['label']).to eq('Administrative history')
    end
  end
end
