package com.vicky.dto;

public class CompanyDTO {
    private int id;
    private String country;
    private String name;
    private String englishName;
    private String appliedBuildings;
    private String industrialBuildings;
    private String luxuryProduct;
    private String prosperityEffect;

    public CompanyDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEnglishName() { return englishName; }
    public void setEnglishName(String englishName) { this.englishName = englishName; }
    public String getAppliedBuildings() { return appliedBuildings; }
    public void setAppliedBuildings(String appliedBuildings) { this.appliedBuildings = appliedBuildings; }
    public String getIndustrialBuildings() { return industrialBuildings; }
    public void setIndustrialBuildings(String industrialBuildings) { this.industrialBuildings = industrialBuildings; }
    public String getLuxuryProduct() { return luxuryProduct; }
    public void setLuxuryProduct(String luxuryProduct) { this.luxuryProduct = luxuryProduct; }
    public String getProsperityEffect() { return prosperityEffect; }
    public void setProsperityEffect(String prosperityEffect) { this.prosperityEffect = prosperityEffect; }
}
