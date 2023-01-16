package com.smhrd.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Getter
@AllArgsConstructor
@RequiredArgsConstructor
public class Mate {

	private BigDecimal mate_seq;
	private String mate_id;
	private Timestamp mate_date;
	@NonNull
	private String m_id;
	@NonNull
	private String mate_memo;
	@NonNull
	private String mate_name;
	
	public Mate(BigDecimal mate_seq, String mate_id) {
		super();
		this.mate_seq = mate_seq;
		this.mate_id = mate_id;
	}
	
	
	
}
