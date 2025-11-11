Return-Path: <linux-tip-commits+bounces-7289-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C86C4D6FA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FF2189A87D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3B357A31;
	Tue, 11 Nov 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGnB6PUX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pbANvyDp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBABA3587BD;
	Tue, 11 Nov 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861029; cv=none; b=eyGcbuQ0pwvQ/v1t2Hqn+ijhxoWXLYro0KugVKV4J/6/DGincY9+l1BX52IkrtwbYgZEa7UVJdn4b8ijqk9Cjom4soIpjH/o71tIzml5jOgKuRAQgf7JDrG5rW2vSIrhb6SsvCAJQJLAqvp2dmIAdnRqE/TRUhehRUpBw+b6MVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861029; c=relaxed/simple;
	bh=ukb9IyvrRlfId7U0UpVactkmadXLHVXYw6zfSIPF40U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hMT1o1yHLRrOtOJ5ZEx9z/Djk7KWaDNgWtxvFJCWIsGr/JvikHy49TTJ+PPs4JrxuITK+z7v1PjXQDx4L2XZfet2dEb4sJnabdtv7iItKkhmHMyANNXxFPmFdKwGCFMYd6Lmxg2k+Kv6md0LjACCrVGTFD2tDx0Ti/dYGpteQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eGnB6PUX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pbANvyDp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUsmOk3PKqYbe+lDTcSfTYt5MQ1HX/rJYM+XKEgHFCs=;
	b=eGnB6PUXUh1yoKZyjTT+clbgqX4vWIIjvJfiIqpVhUf1fcGgP8dmmOx2PJdm6w+erq9GSc
	xue56zqHyUL6Ia4INqAMLnGQAqTd/2E+4Lz2/ycmNVdYMsioEenPmHQlsvfD5PIvW3MfIJ
	Eq3PZwsToXGwklts0ni8xJkVWMTJfzfAoLfgvsmdZtwpV3fWS3xVUoWi9DlvQYLCGFnxrK
	AOcnWDe0iLpdKXYIjv4X+k8xf3QB37Tv3P1psN1jMLT1Gw7y3Jxn/nS3u856bQ9oVYz/Ry
	h+mZQeb8Mbtp77TwNkBPf8nRHeeoCENiHH47QEShTZxSNTjBpm9MZiGOAbHkZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUsmOk3PKqYbe+lDTcSfTYt5MQ1HX/rJYM+XKEgHFCs=;
	b=pbANvyDpbsC513FDRrfNqZ8hl07ApIkBiN/Iz4N4mxzweJK/h8wKUGkH9bUZUDqoFkEMj/
	1BLB6BbJsjfNyhDA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Factor out PEBS group processing
 code to functions
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-8-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102505.498.2096944487020422548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     167cde7dc9b36b7a88f3c29d836fabce13023327
Gitweb:        https://git.kernel.org/tip/167cde7dc9b36b7a88f3c29d836fabce130=
23327
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:31 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:21 +01:00

perf/x86/intel/ds: Factor out PEBS group processing code to functions

Adaptive PEBS and arch-PEBS share lots of same code to process these
PEBS groups, like basic, GPR and meminfo groups. Extract these shared
code to generic functions to avoid duplicated code.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-8-dapeng1.mi@linux.intel.=
com
---
 arch/x86/events/intel/ds.c | 170 ++++++++++++++++++++++--------------
 1 file changed, 104 insertions(+), 66 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c8aa72d..6866452 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2072,6 +2072,90 @@ static inline void __setup_pebs_counter_group(struct c=
pu_hw_events *cpuc,
=20
 #define PEBS_LATENCY_MASK			0xffff
=20
+static inline void __setup_perf_sample_data(struct perf_event *event,
+					    struct pt_regs *iregs,
+					    struct perf_sample_data *data)
+{
+	perf_sample_data_init(data, 0, event->hw.last_period);
+
+	/*
+	 * We must however always use iregs for the unwinder to stay sane; the
+	 * record BP,SP,IP can point into thin air when the record is from a
+	 * previous PMI context or an (I)RET happened between the record and
+	 * PMI.
+	 */
+	perf_sample_save_callchain(data, event, iregs);
+}
+
+static inline void __setup_pebs_basic_group(struct perf_event *event,
+					    struct pt_regs *regs,
+					    struct perf_sample_data *data,
+					    u64 sample_type, u64 ip,
+					    u64 tsc, u16 retire)
+{
+	/* The ip in basic is EventingIP */
+	set_linear_ip(regs, ip);
+	regs->flags =3D PERF_EFLAGS_EXACT;
+	setup_pebs_time(event, data, tsc);
+
+	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
+		data->weight.var3_w =3D retire;
+}
+
+static inline void __setup_pebs_gpr_group(struct perf_event *event,
+					  struct pt_regs *regs,
+					  struct pebs_gprs *gprs,
+					  u64 sample_type)
+{
+	if (event->attr.precise_ip < 2) {
+		set_linear_ip(regs, gprs->ip);
+		regs->flags &=3D ~PERF_EFLAGS_EXACT;
+	}
+
+	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
+		adaptive_pebs_save_regs(regs, gprs);
+}
+
+static inline void __setup_pebs_meminfo_group(struct perf_event *event,
+					      struct perf_sample_data *data,
+					      u64 sample_type, u64 latency,
+					      u16 instr_latency, u64 address,
+					      u64 aux, u64 tsx_tuning, u64 ax)
+{
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
+		u64 tsx_latency =3D intel_get_tsx_weight(tsx_tuning);
+
+		data->weight.var2_w =3D instr_latency;
+
+		/*
+		 * Although meminfo::latency is defined as a u64,
+		 * only the lower 32 bits include the valid data
+		 * in practice on Ice Lake and earlier platforms.
+		 */
+		if (sample_type & PERF_SAMPLE_WEIGHT)
+			data->weight.full =3D latency ?: tsx_latency;
+		else
+			data->weight.var1_dw =3D (u32)latency ?: tsx_latency;
+
+		data->sample_flags |=3D PERF_SAMPLE_WEIGHT_TYPE;
+	}
+
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
+		data->data_src.val =3D get_data_src(event, aux);
+		data->sample_flags |=3D PERF_SAMPLE_DATA_SRC;
+	}
+
+	if (sample_type & PERF_SAMPLE_ADDR_TYPE) {
+		data->addr =3D address;
+		data->sample_flags |=3D PERF_SAMPLE_ADDR;
+	}
+
+	if (sample_type & PERF_SAMPLE_TRANSACTION) {
+		data->txn =3D intel_get_tsx_transaction(tsx_tuning, ax);
+		data->sample_flags |=3D PERF_SAMPLE_TRANSACTION;
+	}
+}
+
 /*
  * With adaptive PEBS the layout depends on what fields are configured.
  */
@@ -2081,12 +2165,14 @@ static void setup_pebs_adaptive_sample_data(struct pe=
rf_event *event,
 					    struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	u64 sample_type =3D event->attr.sample_type;
 	struct pebs_basic *basic =3D __pebs;
 	void *next_record =3D basic + 1;
-	u64 sample_type, format_group;
 	struct pebs_meminfo *meminfo =3D NULL;
 	struct pebs_gprs *gprs =3D NULL;
 	struct x86_perf_regs *perf_regs;
+	u64 format_group;
+	u16 retire;
=20
 	if (basic =3D=3D NULL)
 		return;
@@ -2094,31 +2180,17 @@ static void setup_pebs_adaptive_sample_data(struct pe=
rf_event *event,
 	perf_regs =3D container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs =3D NULL;
=20
-	sample_type =3D event->attr.sample_type;
 	format_group =3D basic->format_group;
-	perf_sample_data_init(data, 0, event->hw.last_period);
=20
-	setup_pebs_time(event, data, basic->tsc);
-
-	/*
-	 * We must however always use iregs for the unwinder to stay sane; the
-	 * record BP,SP,IP can point into thin air when the record is from a
-	 * previous PMI context or an (I)RET happened between the record and
-	 * PMI.
-	 */
-	perf_sample_save_callchain(data, event, iregs);
+	__setup_perf_sample_data(event, iregs, data);
=20
 	*regs =3D *iregs;
-	/* The ip in basic is EventingIP */
-	set_linear_ip(regs, basic->ip);
-	regs->flags =3D PERF_EFLAGS_EXACT;
=20
-	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
-		if (x86_pmu.flags & PMU_FL_RETIRE_LATENCY)
-			data->weight.var3_w =3D basic->retire_latency;
-		else
-			data->weight.var3_w =3D 0;
-	}
+	/* basic group */
+	retire =3D x86_pmu.flags & PMU_FL_RETIRE_LATENCY ?
+			basic->retire_latency : 0;
+	__setup_pebs_basic_group(event, regs, data, sample_type,
+				 basic->ip, basic->tsc, retire);
=20
 	/*
 	 * The record for MEMINFO is in front of GP
@@ -2134,54 +2206,20 @@ static void setup_pebs_adaptive_sample_data(struct pe=
rf_event *event,
 		gprs =3D next_record;
 		next_record =3D gprs + 1;
=20
-		if (event->attr.precise_ip < 2) {
-			set_linear_ip(regs, gprs->ip);
-			regs->flags &=3D ~PERF_EFLAGS_EXACT;
-		}
-
-		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
-			adaptive_pebs_save_regs(regs, gprs);
+		__setup_pebs_gpr_group(event, regs, gprs, sample_type);
 	}
=20
 	if (format_group & PEBS_DATACFG_MEMINFO) {
-		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
-			u64 latency =3D x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
-					meminfo->cache_latency : meminfo->mem_latency;
-
-			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
-				data->weight.var2_w =3D meminfo->instr_latency;
-
-			/*
-			 * Although meminfo::latency is defined as a u64,
-			 * only the lower 32 bits include the valid data
-			 * in practice on Ice Lake and earlier platforms.
-			 */
-			if (sample_type & PERF_SAMPLE_WEIGHT) {
-				data->weight.full =3D latency ?:
-					intel_get_tsx_weight(meminfo->tsx_tuning);
-			} else {
-				data->weight.var1_dw =3D (u32)latency ?:
-					intel_get_tsx_weight(meminfo->tsx_tuning);
-			}
-
-			data->sample_flags |=3D PERF_SAMPLE_WEIGHT_TYPE;
-		}
-
-		if (sample_type & PERF_SAMPLE_DATA_SRC) {
-			data->data_src.val =3D get_data_src(event, meminfo->aux);
-			data->sample_flags |=3D PERF_SAMPLE_DATA_SRC;
-		}
-
-		if (sample_type & PERF_SAMPLE_ADDR_TYPE) {
-			data->addr =3D meminfo->address;
-			data->sample_flags |=3D PERF_SAMPLE_ADDR;
-		}
-
-		if (sample_type & PERF_SAMPLE_TRANSACTION) {
-			data->txn =3D intel_get_tsx_transaction(meminfo->tsx_tuning,
-							  gprs ? gprs->ax : 0);
-			data->sample_flags |=3D PERF_SAMPLE_TRANSACTION;
-		}
+		u64 latency =3D x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
+				meminfo->cache_latency : meminfo->mem_latency;
+		u64 instr_latency =3D x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
+				meminfo->instr_latency : 0;
+		u64 ax =3D gprs ? gprs->ax : 0;
+
+		__setup_pebs_meminfo_group(event, data, sample_type, latency,
+					   instr_latency, meminfo->address,
+					   meminfo->aux, meminfo->tsx_tuning,
+					   ax);
 	}
=20
 	if (format_group & PEBS_DATACFG_XMMS) {

