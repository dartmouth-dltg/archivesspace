# frozen_string_literal: true

require_relative '../spec_helper'

describe 'Collection Management' do
  before(:all) do
    @repo = create(:repo, repo_code: "notes_test_#{Time.now.to_i}")
    set_repo @repo

    @archivist = create_user(@repo => ['repository-archivists'])

    @driver = Driver.get.login_to_repo(@archivist, @repo)
  end

  after(:all) do
    @driver ? @driver.quit : next
  end

  it 'should be fine with no records' do
    @driver.find_element(:link, 'Browse').click
    @driver.click_and_wait_until_gone(:link, 'Collection Management')
    expect(@driver.find_element(css: '.alert.alert-info').text).to eq('No records found')
  end

  it 'is browseable even when its linked accession has no title' do
    # first create the title-less accession
    @driver.find_element(:link, 'Create').click
    @driver.click_and_wait_until_gone(:link, 'Accession')
    fourid = @driver.generate_4part_id
    @driver.complete_4part_id('accession_id_%d_', fourid)
    # @driver.click_and_wait_until_gone(:css => "form#accession_form button[type='submit']")

    # add a collection management sub record
    @driver.find_element(css: '#accession_collection_management_ .subrecord-form-heading .btn:not(.show-all)').click
    @driver.find_element(id: 'accession_collection_management__processing_priority_').select_option('high')
    @driver.find_element(id: 'accession_collection_management__processing_status_').select_option('completed')

    # save changes (twice to trigger an update also)
    2.times do
      @driver.click_and_wait_until_gone(css: "form#accession_form button[type='submit']")
      sleep(1)
    end

    run_all_indexers
    # check the CM page
    @driver.find_element(:link, 'Browse').click
    @driver.click_and_wait_until_gone(:link, 'Collection Management')

    expect do
      @driver.find_element(xpath: "//td[contains(text(), '#{fourid[0]}')]")
    end.not_to raise_error

    @driver.click_and_wait_until_gone(:link, 'View')
    @driver.click_and_wait_until_gone(:link, 'Edit')

    # now delete it
    @driver.find_element(css: '#accession_collection_management_ .subrecord-form-remove').click
    @driver.find_element(css: '#accession_collection_management_ .confirm-removal').click
    @driver.click_and_wait_until_gone(css: "form#accession_form button[type='submit']")

    run_index_round

    expect do
      10.times do
        @driver.find_element(:link, 'Browse').click
        @driver.click_and_wait_until_gone(:link, 'Collection Management')
        @driver.find_element_orig(xpath: "//td[contains(text(), '#{fourid[0]}')]")
        run_index_round # keep indexing and refreshing till it disappears
        @driver.navigate.refresh
        sleep(1)
      end
    end.to raise_error Selenium::WebDriver::Error::NoSuchElementError
  end

  it 'it should only allow numbers for some values' do
    @driver.navigate.to($frontend.to_s)

    @accession_title = 'Collection Management Test'
    # first create the title-less accession
    @driver.find_element(:link, 'Create').click
    @driver.click_and_wait_until_gone(:link, 'Accession')
    fourid = @driver.generate_4part_id
    @driver.complete_4part_id('accession_id_%d_', fourid)
    @driver.find_hidden_element(:css, '#accession_title_').wait_for_class('initialised')
    @driver.execute_script("$('#accession_title_').data('CodeMirror').setValue('#{@accession_title}')")

    # add a collection management sub record
    @driver.find_element(css: '#accession_collection_management_ .subrecord-form-heading .btn:not(.show-all)').click

    @driver.clear_and_send_keys([:id, 'accession_collection_management__processing_hours_per_foot_estimate_'], 'a lot')
    @driver.clear_and_send_keys([:id, 'accession_collection_management__processing_total_extent_'], 'even more')
    @driver.find_element(id: 'accession_collection_management__processing_total_extent_type_').select_option('cassettes')

    @driver.find_element(id: 'accession_collection_management__processing_status_').select_option('completed')

    # save changes
    @driver.click_and_wait_until_gone(css: "form#accession_form button[type='submit']")
    @driver.wait_for_ajax
    expect do
      @driver.find_element_with_text('//div[contains(@class, "error")]', %r{Processing hrs/unit Estimate - Must be a number with no more than nine digits and five decimal places\.})
      @driver.find_element_with_text('//div[contains(@class, "error")]', /Processing Total Extent - Must be a number with no more than nine digits and five decimal places\./)
    end.not_to raise_error

    @driver.clear_and_send_keys([:id, 'accession_collection_management__processing_hours_per_foot_estimate_'], '10')
    @driver.clear_and_send_keys([:id, 'accession_collection_management__processing_total_extent_'], '40')

    @driver.click_and_wait_until_gone(css: "form#accession_form button[type='submit']")

    expect(@driver.find_element(css: '.record-pane h2').text).to eq("#{@accession_title} Accession")
    expect do
      @driver.find_element_with_text('//div[contains(@class, "error")]', %r{Processing hrs/unit Estimate - Must be a number with no more than nine digits and five decimal places\.}, false, true)
      @driver.find_element_with_text('//div[contains(@class, "error")]', /Processing Total Extent - Must be a number with no more than nine digits and five decimal places\./, false, true)
    end.to raise_error(Selenium::WebDriver::Error::NoSuchElementError)
  end

  it 'can export a list of jobs to CSV' do
    @driver.navigate.to("#{$frontend}/collection_management")

    el = @driver.find_element(link: 'Download CSV')
    @driver.download_file(el)

    sleep(1)
    assert(5) { expect(Dir.glob(File.join(Dir.tmpdir, '*.csv')).length).to eq(1) }
  end
end
