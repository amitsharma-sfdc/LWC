public class JSON2Apex {

	public class Administrative {
		public String name;
		public String description;
		public String isoName;
		public Integer order;
		public Integer adminLevel;
		public String isoCode;
		public String wikidataId;
		public Integer geonameId;
	}

	public Double latitude;
	public String lookupSource;
	public Double longitude;
	public String localityLanguageRequested;
	public String continent;
	public String continentCode;
	public String countryName;
	public String countryCode;
	public String principalSubdivision;
	public String principalSubdivisionCode;
	public String city;
	public String locality;
	public String postcode;
	public String plusCode;
	public LocalityInfo localityInfo;

	public class LocalityInfo {
		public List<Administrative> administrative;
		public List<Informative> informative;
	}

	public class Informative {
		public String name;
		public String description;
		public String isoName;
		public Integer order;
		public String isoCode;
		public String wikidataId;
		public Integer geonameId;
	}

	
	public static JSON2Apex parse(String json) {
		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
	}
}