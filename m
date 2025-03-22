Return-Path: <linux-tip-commits+bounces-4419-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53D1A6C810
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Mar 2025 08:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A9217CAD5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Mar 2025 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47424155326;
	Sat, 22 Mar 2025 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GGPlXjv5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHLjIfwl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D122612;
	Sat, 22 Mar 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742628661; cv=none; b=RrQg4F0JhbLmCNO5jZY295GX8Bx9wBaTkCUezx4j05xPjMjZU5jhvF8/rsyZ8AzOVTMcOz8rOF2UMMIHGBvR7v4lCu46B0HVsf0ij2nqJ5IYGngBie4OzNbYA/ZwjrOaoFH3lCZJ5kNyS/SFWKl95d09GPZXg0p6w2Fu7SIV1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742628661; c=relaxed/simple;
	bh=MaJZC2yara0sCKeZWwyBqH4ZWak9labAABqVHTMUd88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gMZIHRVvYXZ0m9HbzyCm/aZZwlyLaBvPKjKVr2wy3EQZBOc5o1GtBW77ycB34tKfkBT+uOJFkos1noAdM46xBarPemjABaJLHLYPaCjJmam+RB21sfK6qEeR/9I1sY6+B9MQUqi6iqF9m3Rx0Vz75HAC/QVEMyGuFJTcBXrTsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GGPlXjv5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHLjIfwl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Mar 2025 07:30:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742628657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MduWMwHSYC5ybm3DUm6GJPv0P1176l7Z8NUijNxW8M8=;
	b=GGPlXjv50KBlE6mR8n7OVThEgS8mESQNoQPBIGlG+rpyaWH/YSPdUfi2C33aN26CEAz2JR
	SwK74SBJPb094gxA//1aj7XE8S4vBK/aDWc0kbDi4/LQSUK7mh1hKT3ZhUZpqXL1Jm4Gkg
	Xr+asWqc5nFJO4DyUv65drnmLY5j0quA/zBmEUad1ZicaI17vZKyfTee7NUDCUnWpbZ0ML
	EIyisW1LDnc5TTUp6922JDQa5dxrAP+oiJomfTl49G7DJUkqwZ5yC3DStzClpPD0nmMQCH
	bHhSikdGqV9q7uTiToK++fWnJG5YCKrtgsPw9Ydh73h19U896KeukZyt6o0TXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742628657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MduWMwHSYC5ybm3DUm6GJPv0P1176l7Z8NUijNxW8M8=;
	b=YHLjIfwlH/QlL8Afg46sOJzAjdz4Ml3qbeVj+v6RJQbrzKdRbOdsNhdopDceG5GBEe3p8p
	k13EnPO0dYQi/FDQ==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/amd/ibs: Prevent leaking sensitive data to userspace
Cc: Matteo Rizzo <matteorizzo@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321161251.1033-1-ravi.bangoria@amd.com>
References: <20250321161251.1033-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174262865140.14745.9326438938807692123.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     50a53b60e141d7e31368a87e222e4dd5597bd4ae
Gitweb:        https://git.kernel.org/tip/50a53b60e141d7e31368a87e222e4dd5597bd4ae
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Sat, 22 Mar 2025 08:13:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:18:24 +01:00

perf/amd/ibs: Prevent leaking sensitive data to userspace

Although IBS "swfilt" can prevent leaking samples with kernel RIP to the
userspace, there are few subtle cases where a 'data' address and/or a
'branch target' address can fall under kernel address range although RIP
is from userspace. Prevent leaking kernel 'data' addresses by discarding
such samples when {exclude_kernel=1,swfilt=1}.

IBS can now be invoked by unprivileged user with the introduction of
"swfilt". However, this creates a loophole in the interface where an
unprivileged user can get physical address of the userspace virtual
addresses through IBS register raw dump (PERF_SAMPLE_RAW). Prevent this
as well.

This upstream commit fixed the most obvious leak:

  65a99264f5e5 perf/x86: Check data address for IBS software filter

Follow that up with a more complete fix.

Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
Suggested-by: Matteo Rizzo <matteorizzo@google.com>
Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250321161251.1033-1-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 84 +++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c465005..e36c9c6 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -941,6 +941,8 @@ static void perf_ibs_get_mem_lock(union ibs_op_data3 *op_data3,
 		data_src->mem_lock = PERF_MEM_LOCK_LOCKED;
 }
 
+/* Be careful. Works only for contiguous MSRs. */
+#define ibs_fetch_msr_idx(msr)	(msr - MSR_AMD64_IBSFETCHCTL)
 #define ibs_op_msr_idx(msr)	(msr - MSR_AMD64_IBSOPCTL)
 
 static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
@@ -1036,6 +1038,67 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 	return 1;
 }
 
+static bool perf_ibs_is_kernel_data_addr(struct perf_event *event,
+					 struct perf_ibs_data *ibs_data)
+{
+	u64 sample_type_mask = PERF_SAMPLE_ADDR | PERF_SAMPLE_RAW;
+	union ibs_op_data3 op_data3;
+	u64 dc_lin_addr;
+
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+	dc_lin_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
+
+	return unlikely((event->attr.sample_type & sample_type_mask) &&
+			op_data3.dc_lin_addr_valid && kernel_ip(dc_lin_addr));
+}
+
+static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
+					 struct perf_ibs_data *ibs_data,
+					 int br_target_idx)
+{
+	union ibs_op_data op_data;
+	u64 br_target;
+
+	op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
+	br_target = ibs_data->regs[br_target_idx];
+
+	return unlikely((event->attr.sample_type & PERF_SAMPLE_RAW) &&
+			op_data.op_brn_ret && kernel_ip(br_target));
+}
+
+static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
+				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
+				    int br_target_idx)
+{
+	if (perf_exclude_event(event, regs))
+		return true;
+
+	if (perf_ibs != &perf_ibs_op || !event->attr.exclude_kernel)
+		return false;
+
+	if (perf_ibs_is_kernel_data_addr(event, ibs_data))
+		return true;
+
+	if (br_target_idx != -1 &&
+	    perf_ibs_is_kernel_br_target(event, ibs_data, br_target_idx))
+		return true;
+
+	return false;
+}
+
+static void perf_ibs_phyaddr_clear(struct perf_ibs *perf_ibs,
+				   struct perf_ibs_data *ibs_data)
+{
+	if (perf_ibs == &perf_ibs_op) {
+		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)] &= ~(1ULL << 18);
+		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)] = 0;
+		return;
+	}
+
+	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)] &= ~(1ULL << 52);
+	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)] = 0;
+}
+
 static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
@@ -1048,6 +1111,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	int offset, size, check_rip, offset_max, throttle = 0;
 	unsigned int msr;
 	u64 *buf, *config, period, new_config = 0;
+	int br_target_idx = -1;
 
 	if (!test_bit(IBS_STARTED, pcpu->state)) {
 fail:
@@ -1102,6 +1166,7 @@ fail:
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_BRNTRGT) {
 				rdmsrl(MSR_AMD64_IBSBRTARGET, *buf++);
+				br_target_idx = size;
 				size++;
 			}
 			if (ibs_caps & IBS_CAPS_OPDATA4) {
@@ -1128,16 +1193,20 @@ fail:
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
-	if (perf_ibs == &perf_ibs_op)
-		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
-
 	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    (perf_exclude_event(event, &regs) ||
-	     ((data.sample_flags & PERF_SAMPLE_ADDR) &&
-	      event->attr.exclude_kernel && kernel_ip(data.addr)))) {
+	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
+	/*
+	 * Prevent leaking physical addresses to unprivileged users. Skip
+	 * PERF_SAMPLE_PHYS_ADDR check since generic code prevents it for
+	 * unprivileged users.
+	 */
+	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
+	    perf_allow_kernel(&event->attr)) {
+		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
+	}
 
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw = (struct perf_raw_record){
@@ -1149,6 +1218,9 @@ fail:
 		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
+	if (perf_ibs == &perf_ibs_op)
+		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from

