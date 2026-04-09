package me.spring.entity;

public class HouseImgInfo {
	
	private String code;
	private String photocode;
	private String title;
	private String location;
	private String description;
	private String savingfilename;
	private String originalfilename;
	private String contenttype;
	private String dataBase64;
	
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getDataBase64() {
		return dataBase64;
	}
	public void setDataBase64(String dataBase64) {
		this.dataBase64 = dataBase64;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getPhotocode() {
		return photocode;
	}
	public void setPhotocode(String photocode) {
		this.photocode = photocode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSavingfilename() {
		return savingfilename;
	}
	public void setSavingfilename(String savingfilename) {
		this.savingfilename = savingfilename;
	}
	public String getOriginalfilename() {
		return originalfilename;
	}
	public void setOriginalfilename(String originalfilename) {
		this.originalfilename = originalfilename;
	}
	public String getContenttype() {
		return contenttype;
	}
	public void setContenttype(String contenttype) {
		this.contenttype = contenttype;
	}
	public HouseImgInfo() {
		super();
	}
	public HouseImgInfo(String code, String photocode, String title, String location, String description,
			String savingfilename, String originalfilename, String contenttype, String dataBase64) {
		super();
		this.code = code;
		this.photocode = photocode;
		this.title = title;
		this.location = location;
		this.description = description;
		this.savingfilename = savingfilename;
		this.originalfilename = originalfilename;
		this.contenttype = contenttype;
		this.dataBase64 = dataBase64;
	}
	@Override
	public String toString() {
		// 禁止输出 dataBase64 / 大段文本，避免日志与调试打印时阻塞控制台
		return "HouseImgInfo [code=" + code + ", photocode=" + photocode + ", originalfilename=" + originalfilename
				+ ", contenttype=" + contenttype + "]";
	}
	
}
