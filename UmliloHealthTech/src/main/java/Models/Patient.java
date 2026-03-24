package Models;

public class Patient {
	private Long id;
	private String firstName;
	private String surname;
	private String idNumber;
	private String cell;
	private String gender;
	private String address;
	private String email;
	private String employmentStatus;
	private String jobTitle;
	private String nextOfKinName;
	private String nextOfKinRelation;
	private String emergencyContact;
	private boolean southAfrican;
	private String nationality;
	private String foreignId;
	private String illnesses;
	private String illnessNotes;
	private boolean consent;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getCell() {
		return cell;
	}

	public void setCell(String cell) {
		this.cell = cell;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmploymentStatus() {
		return employmentStatus;
	}

	public void setEmploymentStatus(String employmentStatus) {
		this.employmentStatus = employmentStatus;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getNextOfKinName() {
		return nextOfKinName;
	}

	public void setNextOfKinName(String nextOfKinName) {
		this.nextOfKinName = nextOfKinName;
	}

	public String getNextOfKinRelation() {
		return nextOfKinRelation;
	}

	public void setNextOfKinRelation(String nextOfKinRelation) {
		this.nextOfKinRelation = nextOfKinRelation;
	}

	public String getEmergencyContact() {
		return emergencyContact;
	}

	public void setEmergencyContact(String emergencyContact) {
		this.emergencyContact = emergencyContact;
	}

	public boolean isSouthAfrican() {
		return southAfrican;
	}

	public void setSouthAfrican(boolean southAfrican) {
		this.southAfrican = southAfrican;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getForeignId() {
		return foreignId;
	}

	public void setForeignId(String foreignId) {
		this.foreignId = foreignId;
	}

	public String getIllnesses() {
		return illnesses;
	}

	public void setIllnesses(String illnesses) {
		this.illnesses = illnesses;
	}

	public String getIllnessNotes() {
		return illnessNotes;
	}

	public void setIllnessNotes(String illnessNotes) {
		this.illnessNotes = illnessNotes;
	}

	public boolean isConsent() {
		return consent;
	}

	public void setConsent(boolean consent) {
		this.consent = consent;
	}
}
