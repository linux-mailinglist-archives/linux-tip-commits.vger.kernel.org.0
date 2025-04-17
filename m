Return-Path: <linux-tip-commits+bounces-5032-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253AAA91D22
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B44F44523F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFC2451E0;
	Thu, 17 Apr 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P4q1zsVL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u+yc/nyU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7115FA7B;
	Thu, 17 Apr 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894892; cv=none; b=BBWmZIE7DUNjfMxGxHhAQmb/6loM1LpAW7yOusaUigemKOYNJjQPeE49u8SMvrcJs69Q4Y5GvGG5kOikYBH2k74DFMUESEbIXrDl9wrhbwyuhRU8Qi9nwMghpRMv+C6iscsRKsh2/mh7B+8Cs4BTBYnyyTqaFECUPWegf55pzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894892; c=relaxed/simple;
	bh=fECKlvMu5BkYf9tc7tr//mqbSe3skE9YCWbjfZCnFGg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F/EV4Gg/IxTzA2SIPVXW10uKYfOR+FQNUFlJlVkFH0kUBV0A0HYU12FOhlUxG8qgN1d7CWBoZ3Ep3ZkZpd1FQQtRGZFJm5WJnIcf9orvWz7/SYJv5ywm3nY2LXDe8l6hFgkKUTLzPIH15rCA/7k/XE6rpllPjsjMrlkw/s4iqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P4q1zsVL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u+yc/nyU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PRA3usMlmUSSN8CTM4DQivW5POLKqtOif0m4vXOib4=;
	b=P4q1zsVLzmGcwJ+3jBk0wr/SNfPoS2u//r/1N+crRRQykQmAw39a82Pdyp4u/y37uzzTFU
	uTouth2Dn3dVurDYpG8IqQXb0HIJAVrXONYnpBiJqg8M3B7UgIPYtZO/6hOTecZExx+g2/
	PQQvcT6p+KQSmoRRbXtq/Sd6j0HUNCBwev0icXzrVF3xk02Gkc+lm3VokFRLPBr/9kYhIA
	cbT7fGjc9mqslS3C/nrw7qnZzptCCWyqKKihTTgJfDsgdIoO7o9Mg1Nx/l5LDdlI+BzekB
	v6+8z5zJ7x3WvmwGeEU1TmGu28a/CueFjjXi/HGFZ8vaqkDCF/PsA4mC6cfKug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PRA3usMlmUSSN8CTM4DQivW5POLKqtOif0m4vXOib4=;
	b=u+yc/nyUK1kEYyPK8lcn4SyEm+4AALKrGih2k3S0egN6rqPtIHfTvisl5ZtmaYa3abl+4q
	IE5x+b49h4yKJSBA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415114428.341182-6-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489488597.31282.541756394086494598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     acb727e0956a2424f22e5ab8c1ff9a39d1acb150
Gitweb:        https://git.kernel.org/tip/acb727e0956a2424f22e5ab8c1ff9a39d1acb150
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 15 Apr 2025 11:44:11 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:24 +02:00

perf/x86/intel: Rename x86_pmu.pebs to x86_pmu.ds_pebs

Since architectural PEBS would be introduced in subsequent patches,
rename x86_pmu.pebs to x86_pmu.ds_pebs for distinguishing with the
upcoming architectural PEBS.

Besides restrict reserve_ds_buffers() helper to work only for the
legacy DS based PEBS and avoid it to corrupt the pebs_active flag and
release PEBS buffer incorrectly for arch-PEBS since the later patch
would reuse these flags and alloc/release_pebs_buffer() helpers for
arch-PEBS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20250415114428.341182-6-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c |  6 +++---
 arch/x86/events/intel/ds.c   | 32 ++++++++++++++++++--------------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 16049ba..7bbc7a7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4584,7 +4584,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		.guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
 	};
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		return arr;
 
 	/*
@@ -5764,7 +5764,7 @@ static __init void intel_clovertown_quirk(void)
 	 * these chips.
 	 */
 	pr_warn("PEBS disabled due to CPU errata\n");
-	x86_pmu.pebs = 0;
+	x86_pmu.ds_pebs = 0;
 	x86_pmu.pebs_constraints = NULL;
 }
 
@@ -6252,7 +6252,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.pebs ? attr->mode : 0;
+	return x86_pmu.ds_pebs ? attr->mode : 0;
 }
 
 static umode_t
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d894cf3..1d6b3fa 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -624,7 +624,7 @@ static int alloc_pebs_buffer(int cpu)
 	int max, node = cpu_to_node(cpu);
 	void *buffer, *insn_buff, *cea;
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		return 0;
 
 	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
@@ -659,7 +659,7 @@ static void release_pebs_buffer(int cpu)
 	struct cpu_hw_events *hwev = per_cpu_ptr(&cpu_hw_events, cpu);
 	void *cea;
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		return;
 
 	kfree(per_cpu(insn_buffer, cpu));
@@ -734,7 +734,7 @@ void release_ds_buffers(void)
 {
 	int cpu;
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	for_each_possible_cpu(cpu)
@@ -750,7 +750,8 @@ void release_ds_buffers(void)
 	}
 
 	for_each_possible_cpu(cpu) {
-		release_pebs_buffer(cpu);
+		if (x86_pmu.ds_pebs)
+			release_pebs_buffer(cpu);
 		release_bts_buffer(cpu);
 	}
 }
@@ -761,15 +762,17 @@ void reserve_ds_buffers(void)
 	int cpu;
 
 	x86_pmu.bts_active = 0;
-	x86_pmu.pebs_active = 0;
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (x86_pmu.ds_pebs)
+		x86_pmu.pebs_active = 0;
+
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	if (!x86_pmu.bts)
 		bts_err = 1;
 
-	if (!x86_pmu.pebs)
+	if (!x86_pmu.ds_pebs)
 		pebs_err = 1;
 
 	for_each_possible_cpu(cpu) {
@@ -781,7 +784,8 @@ void reserve_ds_buffers(void)
 		if (!bts_err && alloc_bts_buffer(cpu))
 			bts_err = 1;
 
-		if (!pebs_err && alloc_pebs_buffer(cpu))
+		if (x86_pmu.ds_pebs && !pebs_err &&
+		    alloc_pebs_buffer(cpu))
 			pebs_err = 1;
 
 		if (bts_err && pebs_err)
@@ -793,7 +797,7 @@ void reserve_ds_buffers(void)
 			release_bts_buffer(cpu);
 	}
 
-	if (pebs_err) {
+	if (x86_pmu.ds_pebs && pebs_err) {
 		for_each_possible_cpu(cpu)
 			release_pebs_buffer(cpu);
 	}
@@ -805,7 +809,7 @@ void reserve_ds_buffers(void)
 		if (x86_pmu.bts && !bts_err)
 			x86_pmu.bts_active = 1;
 
-		if (x86_pmu.pebs && !pebs_err)
+		if (x86_pmu.ds_pebs && !pebs_err)
 			x86_pmu.pebs_active = 1;
 
 		for_each_possible_cpu(cpu) {
@@ -2662,12 +2666,12 @@ void __init intel_pebs_init(void)
 	if (!boot_cpu_has(X86_FEATURE_DTES64))
 		return;
 
-	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
+	x86_pmu.ds_pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	if (x86_pmu.version <= 4)
 		x86_pmu.pebs_no_isolation = 1;
 
-	if (x86_pmu.pebs) {
+	if (x86_pmu.ds_pebs) {
 		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
 		char *pebs_qual = "";
 		int format = x86_pmu.intel_cap.pebs_format;
@@ -2759,7 +2763,7 @@ void __init intel_pebs_init(void)
 
 		default:
 			pr_cont("no PEBS fmt%d%c, ", format, pebs_type);
-			x86_pmu.pebs = 0;
+			x86_pmu.ds_pebs = 0;
 		}
 	}
 }
@@ -2768,7 +2772,7 @@ void perf_restore_debug_store(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
 
-	if (!x86_pmu.bts && !x86_pmu.pebs)
+	if (!x86_pmu.bts && !x86_pmu.ds_pebs)
 		return;
 
 	wrmsrl(MSR_IA32_DS_AREA, (unsigned long)ds);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ac6743e..2ef407d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -898,7 +898,7 @@ struct x86_pmu {
 	 */
 	unsigned int	bts			:1,
 			bts_active		:1,
-			pebs			:1,
+			ds_pebs			:1,
 			pebs_active		:1,
 			pebs_broken		:1,
 			pebs_prec_dist		:1,

