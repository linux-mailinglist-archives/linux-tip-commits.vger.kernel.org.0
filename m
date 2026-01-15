Return-Path: <linux-tip-commits+bounces-8019-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE52D28CEC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37197300D91E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755532D0DC;
	Thu, 15 Jan 2026 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fnp/b4Vp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NkcEYiTT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD632BF3A;
	Thu, 15 Jan 2026 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513448; cv=none; b=cKuDUkxP3C6Kdh2NeQvfbqsDqzkaeOovcXD1WSl+5qdY7M5kKr6iAN0da9U/7Wh9XKrqUIEEozZA8/lwiFaKphQarTlXgs/PlkK9J2tw0BRwmqnT6MD6HAFpiAlph4Lzm+blr1VDhgJfcVPdMGXWb0d3NwK0nwt8yeYcxVq/S4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513448; c=relaxed/simple;
	bh=0CaQYFd3rnMNRrmvNl3NxNRe1dyP9cTg6ZGnhuKqka8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XJILT7TaR64zyqy7ECYiLC5cycfyMI220Ofsx4CtD1sYWZ6n14HTIkvZDSaEkiW1ze4wHShBIJs6YQYk0CAkN282l9V42BPYrb1r1MBpdlioCO/pQk4YfcLXNbWiBtcHRVmyDGjbeP7creObtNJM2rvGSpbF1PvB32crjqzw6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fnp/b4Vp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NkcEYiTT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie8i1P3LTxrV29ACtECRpR49SJzbHczeknjBcviF+So=;
	b=Fnp/b4VpaP193RPpJW1YMCPkk4A/+Ogdya4GZaLg7NOWhmA+eIWJoSgGD6XZf4FYez5M7P
	MFWo+rn6nJEFqPxxTBnF0J9xW1wckD/nr5dPSv7yw3FHR3IGoitpQiynPfAjNuR8EW8KEI
	/HdNEKeznT9jj/8DcJ3BjNmd0z+fxenexie08jFkVtkQBiQsjtzguAR6aVaDfvcElxCjR/
	20paPOl5Lmmj7AUBD+967OX9zeonLjcASepEGh45xs8CePLhrpBV77cN6VLJcU06fLlkYR
	cv5rxwxqJvyLk4ILn0iKgDj3XGiC48m7kXoEBoFvCGlUjcA/un818TeJs/0+rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie8i1P3LTxrV29ACtECRpR49SJzbHczeknjBcviF+So=;
	b=NkcEYiTT+AZFHbyeU5cwnJfIEfVjTVWTep/2gnlm23SXDoPmyGFNbF3WuiJ4Kxk+SdGGPl
	XHACKC9YaKuWB9Bg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add support for PEBS memory
 auxiliary info field in NVL
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114011750.350569-5-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851344449.510.3631708515238775694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7cd264d1972d13177acc1ac9fb11ee0a7003e2e6
Gitweb:        https://git.kernel.org/tip/7cd264d1972d13177acc1ac9fb11ee0a700=
3e2e6
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 14 Jan 2026 09:17:47 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:27 +01:00

perf/x86/intel: Add support for PEBS memory auxiliary info field in NVL

Similar to DMR (Panther Cove uarch), both P-core (Coyote Cove uarch) and
E-core (Arctic Wolf uarch) of NVL adopt the new PEBS memory auxiliary
info layout.

Coyote Cove microarchitecture shares the same PMU capabilities, including
the memory auxiliary info layout, with Panther Cove. Arctic Wolf
microarchitecture has a similar layout to Panther Cove, with the only
difference being specific data source encoding for L2 hit cases (up to
the L2 cache level). The OMR encoding remains the same as in Panther Cove.

For detailed information on the memory auxiliary info encoding, please
refer to section 16.2 "PEBS LOAD LATENCY AND STORE LATENCY FACILITY" in
the latest ISE documentation.

This patch defines Arctic Wolf specific data source encoding and then
supports PEBS memory auxiliary info field for NVL.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260114011750.350569-5-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/ds.c   | 83 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 85 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 06e42ac..a47f173 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -96,6 +96,18 @@ union intel_x86_pebs_dse {
 		unsigned int pnc_fb_full:1;
 		unsigned int ld_reserved8:16;
 	};
+	struct {
+		unsigned int arw_dse:8;
+		unsigned int arw_l2_miss:1;
+		unsigned int arw_xq_promotion:1;
+		unsigned int arw_reissue:1;
+		unsigned int arw_stlb_miss:1;
+		unsigned int arw_locked:1;
+		unsigned int arw_data_blk:1;
+		unsigned int arw_addr_blk:1;
+		unsigned int arw_fb_full:1;
+		unsigned int ld_reserved9:16;
+	};
 };
=20
=20
@@ -274,6 +286,29 @@ static u64 pnc_pebs_l2_hit_data_source[PNC_PEBS_DATA_SOU=
RCE_MAX] =3D {
 	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),	/* 0x0f: uncached */
 };
=20
+/* Version for Arctic Wolf and later */
+
+/* L2 hit */
+#define ARW_PEBS_DATA_SOURCE_MAX	16
+static u64 arw_pebs_l2_hit_data_source[ARW_PEBS_DATA_SOURCE_MAX] =3D {
+	P(OP, LOAD) | P(LVL, NA) | LEVEL(NA) | P(SNOOP, NA),	/* 0x00: non-cache acc=
ess */
+	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x01: L1 hit */
+	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),	/* 0x02: WCB Hit */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x03: L2 Hit Clean */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HIT),	/* 0x04: L2 Hit Snoop HIT =
*/
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, HITM),	/* 0x05: L2 Hit Snoop Hit=
 Modified */
+	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),	/* 0x06: uncached */
+	0,							/* 0x07: Reserved */
+	0,							/* 0x08: Reserved */
+	0,							/* 0x09: Reserved */
+	0,							/* 0x0a: Reserved */
+	0,							/* 0x0b: Reserved */
+	0,							/* 0x0c: Reserved */
+	0,							/* 0x0d: Reserved */
+	0,							/* 0x0e: Reserved */
+	0,							/* 0x0f: Reserved */
+};
+
 /* L2 miss */
 #define OMR_DATA_SOURCE_MAX		16
 static u64 omr_data_source[OMR_DATA_SOURCE_MAX] =3D {
@@ -458,6 +493,44 @@ u64 cmt_latency_data(struct perf_event *event, u64 statu=
s)
 				  dse.mtl_fwd_blk);
 }
=20
+static u64 arw_latency_data(struct perf_event *event, u64 status)
+{
+	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
+	u64 val;
+
+	dse.val =3D status;
+
+	if (!dse.arw_l2_miss)
+		val =3D arw_pebs_l2_hit_data_source[dse.arw_dse & 0xf];
+	else
+		val =3D parse_omr_data_source(dse.arw_dse);
+
+	if (!val)
+		val =3D P(OP, LOAD) | LEVEL(NA) | P(SNOOP, NA);
+
+	if (dse.arw_stlb_miss)
+		val |=3D P(TLB, MISS) | P(TLB, L2);
+	else
+		val |=3D P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	if (dse.arw_locked)
+		val |=3D P(LOCK, LOCKED);
+
+	if (dse.arw_data_blk)
+		val |=3D P(BLK, DATA);
+	if (dse.arw_addr_blk)
+		val |=3D P(BLK, ADDR);
+	if (!dse.arw_data_blk && !dse.arw_addr_blk)
+		val |=3D P(BLK, NA);
+
+	src.val =3D val;
+	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+		src.mem_op =3D P(OP, STORE);
+
+	return src.val;
+}
+
 static u64 lnc_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -551,6 +624,16 @@ u64 pnc_latency_data(struct perf_event *event, u64 statu=
s)
 	return src.val;
 }
=20
+u64 nvl_latency_data(struct perf_event *event, u64 status)
+{
+	struct x86_hybrid_pmu *pmu =3D hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type =3D=3D hybrid_small)
+		return arw_latency_data(event, status);
+
+	return pnc_latency_data(event, status);
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cbca188..aedc1a7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1666,6 +1666,8 @@ u64 arl_h_latency_data(struct perf_event *event, u64 st=
atus);
=20
 u64 pnc_latency_data(struct perf_event *event, u64 status);
=20
+u64 nvl_latency_data(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
=20
 extern struct event_constraint intel_atom_pebs_event_constraints[];

