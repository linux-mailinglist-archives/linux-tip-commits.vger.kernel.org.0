Return-Path: <linux-tip-commits+bounces-8021-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEECD28CF4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A81130146DE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEEA32ED43;
	Thu, 15 Jan 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4gZDz0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSeMzXai"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD0328621;
	Thu, 15 Jan 2026 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513451; cv=none; b=KqIO6bKxv1L2w6vy2byZ2pCDqlpKO/is52HDo3RYNFpNLbzpXaRx8h/bQkMv7G2NOi3Q4jKeVAbYakqJTEi8y4NfI989CUWB8JBpt9WVXKCpR9MADbRCvzdLSAr0RcfKOHXROMp9C7/96WCm3D1GcekQEYZ01PQvqtzYdIYGN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513451; c=relaxed/simple;
	bh=22/Zs/SNybkFyiMqiZw9jsWzWD7azS18VVaXfex0X9s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MTrta+TQpLmCEdzfrknkwcDYl+RTxVkOmuGkQqt+3a3GjKyLxoHM/z9LN7vUPSUPvC8oNJhUC1sSQd+BXzpfvjlcPkJuEG4+EkT+4Rl4wqN1eofoSOwgcmuim6YFe8HksHWGgg86T9PG0qCkILxNEnt8oYMPGSt8kIn/tTyp8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4gZDz0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSeMzXai; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93CyAeRlHbKC9uNHKOTdG1tTKdUvSHrKn5mexZPwO1I=;
	b=h4gZDz0XS6n5VvzS6Z2qYkbb2AOzhZi8nGSQl3uSR+uiFq1CSqvw4b5TGSxUqOzfpf85EY
	idAVLKiBUnby/Q8SoSUWUzZo1m6EZM0vI0IxLWtWQo5QykFiZavoHG2aoedPSJObWHUzg3
	Qo9ziC8GkN0hitXHyXtGDWeH0/dMUa20gducVby3ftCEb+Px51A+79V+C/tnLuNwHS45pa
	sjBvPY15rKkmtpQ3p98VyVubj9OfuRT+kLHIqH4CxDJGxZNk9RgfYq68R9MXxFjNfMfF6D
	ZfxTwvgd7HeLJI8H51sMv4J+IMKDncZ7fhAr1LSMgzylH+976MjmxNL6jTpV8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93CyAeRlHbKC9uNHKOTdG1tTKdUvSHrKn5mexZPwO1I=;
	b=MSeMzXaiaHAUtd9/oEJAZWLCoIzkFViPvFx8/w7GrvU/NO7AlFuCWRCe94IB6wdttMKKkt
	Zrk85QS6SaaEZEDQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add support for PEBS memory
 auxiliary info field in DMR
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114011750.350569-3-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851344701.510.17610555381486031917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d2bdcde9626cbea0c44a6aaa33b440c8adf81e09
Gitweb:        https://git.kernel.org/tip/d2bdcde9626cbea0c44a6aaa33b440c8adf=
81e09
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 14 Jan 2026 09:17:45 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:26 +01:00

perf/x86/intel: Add support for PEBS memory auxiliary info field in DMR

With the introduction of the OMR feature, the PEBS memory auxiliary info
field for load and store latency events has been restructured for DMR.

The memory auxiliary info field's bit[8] indicates whether a L2 cache
miss occurred for a memory load or store instruction. If bit[8] is 0,
it signifies no L2 cache miss, and bits[7:0] specify the exact cache data
source (up to the L2 cache level). If bit[8] is 1, bits[7:0] represent
the OMR encoding, indicating the specific L3 cache or memory region
involved in the memory access. A significant enhancement is OMR encoding
provides up to 8 fine-grained memory regions besides the cache region.

A significant enhancement for OMR encoding is the ability to provide
up to 8 fine-grained memory regions in addition to the cache region,
offering more detailed insights into memory access regions.

For detailed information on the memory auxiliary info encoding, please
refer to section 16.2 "PEBS LOAD LATENCY AND STORE LATENCY FACILITY" in
the ISE documentation.

This patch ensures that the PEBS memory auxiliary info field is correctly
interpreted and utilized in DMR.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260114011750.350569-3-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c            | 140 +++++++++++++++++++++++++-
 arch/x86/events/perf_event.h          |   2 +-
 include/uapi/linux/perf_event.h       |  27 ++++-
 tools/include/uapi/linux/perf_event.h |  27 ++++-
 4 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index feb1c3c..272e652 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -34,6 +34,17 @@ struct pebs_record_32 {
=20
  */
=20
+union omr_encoding {
+	struct {
+		u8 omr_source : 4;
+		u8 omr_remote : 1;
+		u8 omr_hitm : 1;
+		u8 omr_snoop : 1;
+		u8 omr_promoted : 1;
+	};
+	u8 omr_full;
+};
+
 union intel_x86_pebs_dse {
 	u64 val;
 	struct {
@@ -73,6 +84,18 @@ union intel_x86_pebs_dse {
 		unsigned int lnc_addr_blk:1;
 		unsigned int ld_reserved6:18;
 	};
+	struct {
+		unsigned int pnc_dse: 8;
+		unsigned int pnc_l2_miss:1;
+		unsigned int pnc_stlb_clean_hit:1;
+		unsigned int pnc_stlb_any_hit:1;
+		unsigned int pnc_stlb_miss:1;
+		unsigned int pnc_locked:1;
+		unsigned int pnc_data_blk:1;
+		unsigned int pnc_addr_blk:1;
+		unsigned int pnc_fb_full:1;
+		unsigned int ld_reserved8:16;
+	};
 };
=20
=20
@@ -228,6 +251,85 @@ void __init intel_pmu_pebs_data_source_lnl(void)
 	__intel_pmu_pebs_data_source_cmt(data_source);
 }
=20
+/* Version for Panthercove and later */
+
+/* L2 hit */
+#define PNC_PEBS_DATA_SOURCE_MAX	16
+static u64 pnc_pebs_l2_hit_data_source[PNC_PEBS_DATA_SOURCE_MAX] =3D {
+	P(OP, LOAD) | P(LVL, NA) | LEVEL(NA) | P(SNOOP, NA),	/* 0x00: non-cache acc=
ess */
+	OP_LH               | LEVEL(L0) | P(SNOOP, NONE),	/* 0x01: L0 hit */
+	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x02: L1 hit */
+	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),	/* 0x03: L1 Miss Handlin=
g Buffer hit */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x04: L2 Hit Clean */
+	0,							/* 0x05: Reserved */
+	0,							/* 0x06: Reserved */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HIT),	/* 0x07: L2 Hit Snoop HIT =
*/
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HITM),	/* 0x08: L2 Hit Snoop Hit=
 Modified */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, MISS),	/* 0x09: Prefetch Promoti=
on */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, MISS),	/* 0x0a: Cross Core Prefe=
tch Promotion */
+	0,							/* 0x0b: Reserved */
+	0,							/* 0x0c: Reserved */
+	0,							/* 0x0d: Reserved */
+	0,							/* 0x0e: Reserved */
+	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),	/* 0x0f: uncached */
+};
+
+/* L2 miss */
+#define OMR_DATA_SOURCE_MAX		16
+static u64 omr_data_source[OMR_DATA_SOURCE_MAX] =3D {
+	P(OP, LOAD) | P(LVL, NA) | LEVEL(NA) | P(SNOOP, NA),	/* 0x00: invalid */
+	0,							/* 0x01: Reserved */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, L_SHARE),	/* 0x02: local CA shar=
ed cache */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, L_NON_SHARE),/* 0x03: local CA n=
on-shared cache */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, O_IO),	/* 0x04: other CA IO agen=
t */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, O_SHARE),	/* 0x05: other CA shar=
ed cache */
+	OP_LH | P(LVL, L3) | LEVEL(L3) | P(REGION, O_NON_SHARE),/* 0x06: other CA n=
on-shared cache */
+	OP_LH | LEVEL(RAM) | P(REGION, MMIO),			/* 0x07: MMIO */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM0),			/* 0x08: Memory region 0 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM1),			/* 0x09: Memory region 1 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM2),			/* 0x0a: Memory region 2 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM3),			/* 0x0b: Memory region 3 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM4),			/* 0x0c: Memory region 4 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM5),			/* 0x0d: Memory region 5 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM6),			/* 0x0e: Memory region 6 */
+	OP_LH | LEVEL(RAM) | P(REGION, MEM7),			/* 0x0f: Memory region 7 */
+};
+
+static u64 parse_omr_data_source(u8 dse)
+{
+	union omr_encoding omr;
+	u64 val =3D 0;
+
+	omr.omr_full =3D dse;
+	val =3D omr_data_source[omr.omr_source];
+	if (omr.omr_source > 0x1 && omr.omr_source < 0x7)
+		val |=3D omr.omr_remote ? P(LVL, REM_CCE1) : 0;
+	else if (omr.omr_source > 0x7)
+		val |=3D omr.omr_remote ? P(LVL, REM_RAM1) : P(LVL, LOC_RAM);
+
+	if (omr.omr_remote)
+		val |=3D REM;
+
+	val |=3D omr.omr_hitm ? P(SNOOP, HITM) : P(SNOOP, HIT);
+
+	if (omr.omr_source =3D=3D 0x2) {
+		u8 snoop =3D omr.omr_snoop | omr.omr_promoted;
+
+		if (snoop =3D=3D 0x0)
+			val |=3D P(SNOOP, NA);
+		else if (snoop =3D=3D 0x1)
+			val |=3D P(SNOOP, MISS);
+		else if (snoop =3D=3D 0x2)
+			val |=3D P(SNOOP, HIT);
+		else if (snoop =3D=3D 0x3)
+			val |=3D P(SNOOP, NONE);
+	} else if (omr.omr_source > 0x2 && omr.omr_source < 0x7) {
+		val |=3D omr.omr_snoop ? P(SNOOPX, FWD) : 0;
+	}
+
+	return val;
+}
+
 static u64 precise_store_data(u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -411,6 +513,44 @@ u64 arl_h_latency_data(struct perf_event *event, u64 sta=
tus)
 	return lnl_latency_data(event, status);
 }
=20
+u64 pnc_latency_data(struct perf_event *event, u64 status)
+{
+	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
+	u64 val;
+
+	dse.val =3D status;
+
+	if (!dse.pnc_l2_miss)
+		val =3D pnc_pebs_l2_hit_data_source[dse.pnc_dse & 0xf];
+	else
+		val =3D parse_omr_data_source(dse.pnc_dse);
+
+	if (!val)
+		val =3D P(OP, LOAD) | LEVEL(NA) | P(SNOOP, NA);
+
+	if (dse.pnc_stlb_miss)
+		val |=3D P(TLB, MISS) | P(TLB, L2);
+	else
+		val |=3D P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	if (dse.pnc_locked)
+		val |=3D P(LOCK, LOCKED);
+
+	if (dse.pnc_data_blk)
+		val |=3D P(BLK, DATA);
+	if (dse.pnc_addr_blk)
+		val |=3D P(BLK, ADDR);
+	if (!dse.pnc_data_blk && !dse.pnc_addr_blk)
+		val |=3D P(BLK, NA);
+
+	src.val =3D val;
+	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+		src.mem_op =3D P(OP, STORE);
+
+	return src.val;
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 586e3fd..bd501c2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1664,6 +1664,8 @@ u64 lnl_latency_data(struct perf_event *event, u64 stat=
us);
=20
 u64 arl_h_latency_data(struct perf_event *event, u64 status);
=20
+u64 pnc_latency_data(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
=20
 extern struct event_constraint intel_atom_pebs_event_constraints[];
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c44a8fb..533393e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1330,14 +1330,16 @@ union perf_mem_data_src {
 			mem_snoopx  :  2, /* Snoop mode, ext */
 			mem_blk     :  3, /* Access blocked */
 			mem_hops    :  3, /* Hop level */
-			mem_rsvd    : 18;
+			mem_region  :  5, /* cache/memory regions */
+			mem_rsvd    : 13;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd    : 18,
+		__u64	mem_rsvd    : 13,
+			mem_region  :  5, /* cache/memory regions */
 			mem_hops    :  3, /* Hop level */
 			mem_blk     :  3, /* Access blocked */
 			mem_snoopx  :  2, /* Snoop mode, ext */
@@ -1394,7 +1396,7 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L4			0x0004 /* L4 */
 #define PERF_MEM_LVLNUM_L2_MHB			0x0005 /* L2 Miss Handling Buffer */
 #define PERF_MEM_LVLNUM_MSC			0x0006 /* Memory-side Cache */
-/* 0x007 available */
+#define PERF_MEM_LVLNUM_L0			0x0007 /* L0 */
 #define PERF_MEM_LVLNUM_UNC			0x0008 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL			0x0009 /* CXL */
 #define PERF_MEM_LVLNUM_IO			0x000a /* I/O */
@@ -1447,6 +1449,25 @@ union perf_mem_data_src {
 /* 5-7 available */
 #define PERF_MEM_HOPS_SHIFT			43
=20
+/* Cache/Memory region */
+#define PERF_MEM_REGION_NA		0x0  /* Invalid */
+#define PERF_MEM_REGION_RSVD		0x01 /* Reserved */
+#define PERF_MEM_REGION_L_SHARE		0x02 /* Local CA shared cache */
+#define PERF_MEM_REGION_L_NON_SHARE	0x03 /* Local CA non-shared cache */
+#define PERF_MEM_REGION_O_IO		0x04 /* Other CA IO agent */
+#define PERF_MEM_REGION_O_SHARE		0x05 /* Other CA shared cache */
+#define PERF_MEM_REGION_O_NON_SHARE	0x06 /* Other CA non-shared cache */
+#define PERF_MEM_REGION_MMIO		0x07 /* MMIO */
+#define PERF_MEM_REGION_MEM0		0x08 /* Memory region 0 */
+#define PERF_MEM_REGION_MEM1		0x09 /* Memory region 1 */
+#define PERF_MEM_REGION_MEM2		0x0a /* Memory region 2 */
+#define PERF_MEM_REGION_MEM3		0x0b /* Memory region 3 */
+#define PERF_MEM_REGION_MEM4		0x0c /* Memory region 4 */
+#define PERF_MEM_REGION_MEM5		0x0d /* Memory region 5 */
+#define PERF_MEM_REGION_MEM6		0x0e /* Memory region 6 */
+#define PERF_MEM_REGION_MEM7		0x0f /* Memory region 7 */
+#define PERF_MEM_REGION_SHIFT		46
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
=20
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux=
/perf_event.h
index c44a8fb..d4b9961 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1330,14 +1330,16 @@ union perf_mem_data_src {
 			mem_snoopx  :  2, /* Snoop mode, ext */
 			mem_blk     :  3, /* Access blocked */
 			mem_hops    :  3, /* Hop level */
-			mem_rsvd    : 18;
+			mem_region  :  5, /* cache/memory regions */
+			mem_rsvd    : 13;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd    : 18,
+		__u64	mem_rsvd    : 13,
+			mem_region  :  5, /* cache/memory regions */
 			mem_hops    :  3, /* Hop level */
 			mem_blk     :  3, /* Access blocked */
 			mem_snoopx  :  2, /* Snoop mode, ext */
@@ -1394,7 +1396,7 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L4			0x0004 /* L4 */
 #define PERF_MEM_LVLNUM_L2_MHB			0x0005 /* L2 Miss Handling Buffer */
 #define PERF_MEM_LVLNUM_MSC			0x0006 /* Memory-side Cache */
-/* 0x007 available */
+#define PERF_MEM_LVLNUM_L0			0x0007   /* L0 */
 #define PERF_MEM_LVLNUM_UNC			0x0008 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL			0x0009 /* CXL */
 #define PERF_MEM_LVLNUM_IO			0x000a /* I/O */
@@ -1447,6 +1449,25 @@ union perf_mem_data_src {
 /* 5-7 available */
 #define PERF_MEM_HOPS_SHIFT			43
=20
+/* Cache/Memory region */
+#define PERF_MEM_REGION_NA		0x0  /* Invalid */
+#define PERF_MEM_REGION_RSVD		0x01 /* Reserved */
+#define PERF_MEM_REGION_L_SHARE		0x02 /* Local CA shared cache */
+#define PERF_MEM_REGION_L_NON_SHARE	0x03 /* Local CA non-shared cache */
+#define PERF_MEM_REGION_O_IO		0x04 /* Other CA IO agent */
+#define PERF_MEM_REGION_O_SHARE		0x05 /* Other CA shared cache */
+#define PERF_MEM_REGION_O_NON_SHARE	0x06 /* Other CA non-shared cache */
+#define PERF_MEM_REGION_MMIO		0x07 /* MMIO */
+#define PERF_MEM_REGION_MEM0		0x08 /* Memory region 0 */
+#define PERF_MEM_REGION_MEM1		0x09 /* Memory region 1 */
+#define PERF_MEM_REGION_MEM2		0x0a /* Memory region 2 */
+#define PERF_MEM_REGION_MEM3		0x0b /* Memory region 3 */
+#define PERF_MEM_REGION_MEM4		0x0c /* Memory region 4 */
+#define PERF_MEM_REGION_MEM5		0x0d /* Memory region 5 */
+#define PERF_MEM_REGION_MEM6		0x0e /* Memory region 6 */
+#define PERF_MEM_REGION_MEM7		0x0f /* Memory region 7 */
+#define PERF_MEM_REGION_SHIFT		46
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
=20

