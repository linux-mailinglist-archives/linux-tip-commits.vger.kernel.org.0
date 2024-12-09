Return-Path: <linux-tip-commits+bounces-3041-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B2E9E9994
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 15:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF44A167659
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6911BEF90;
	Mon,  9 Dec 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nrbEeGVF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faztBdtU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19321BEF63;
	Mon,  9 Dec 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756121; cv=none; b=IOeFIs8HFS42krBfbbE9TbRm4R/uZF0uEaJZKGSZ/6+dFD/XJD3bTeXb7F32ViW0AGsENvpd86yL4+tElx5OFnywkLDNzT4ytqEgm3uY3QILA2MPyI9In7kDKv5slg768u8qD6vh4J/YrL99AbXV9K1uG5+VvCGW3T+72A9CrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756121; c=relaxed/simple;
	bh=5W6lIuuQABzsqi/dYQBz9XW24NXUcItmuXQLPYzMeIg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FiQ05yqbbgcD2AoA3tj5RwVDFfdAAX6lTri4zx0HlnZerpQbOc8Ylbzfy2McxjcnFNaLNYwJrz7WihXHIkTtFel/7UcgM10OzSGiKLbFruuGIHuQgQxsSBJz9gPAeYkJ48GjWIfKp5cmeEcYfIz40Hlje1eNkuS4DsXSV7y8T4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nrbEeGVF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=faztBdtU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 14:55:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733756117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQLBQ418kBMwVrI/r3yVio4MBWBi9aKCZ6uy2ecsvBU=;
	b=nrbEeGVF7lIk7n+elOMyy8tOxKe6TnOHkVbKGpSQGDlB95qp3lrmXSKWzLtbrum3s2RJ9V
	mbOEJjiyjkF3OualdeR8ZZNMQxG+dfifJZflam3sZ923b0pwUx9uoxKltHd1qxTOmdn/06
	vxBx+cMx3f8MZikNP/ix6dEW63wn0xOtm8we1FDnI2heUNjbFvEEHuon/Q5NP7dmTX/pkr
	0mk9lF5luZPmxx/dZZ4AvhLXhQD0NUcVvfjIh29YusuCZLaZbPCPdu4TyGbjs63JrUkkVX
	zba73JcjTjChXZSzuH6JgSNA6RSIOtiwxIJ/VLOnahw0Di0O4ftJewm+DGEN2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733756117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQLBQ418kBMwVrI/r3yVio4MBWBi9aKCZ6uy2ecsvBU=;
	b=faztBdtUwxL1PuI1s4tKdAeBmlUDDHZwq2YiUdFjWRQsQsDmdbnCp3+FPg/9w7Vl56gsyt
	+BL42VmH+28DDJAg==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Export perf_exclude_event()
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Thomas Richter <tmricht@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241203180441.1634709-2-namhyung@kernel.org>
References: <20241203180441.1634709-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173375611696.412.4973606717817130064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6057b90ecc84f232dd32a047a086a4c4c271765f
Gitweb:        https://git.kernel.org/tip/6057b90ecc84f232dd32a047a086a4c4c271765f
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 03 Dec 2024 10:04:40 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Dec 2024 15:50:31 +01:00

perf/core: Export perf_exclude_event()

While at it, rename the same function in s390 cpum_sf PMU.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lore.kernel.org/r/20241203180441.1634709-2-namhyung@kernel.org
---
 arch/s390/kernel/perf_cpum_sf.c | 6 +++---
 include/linux/perf_event.h      | 6 ++++++
 kernel/events/core.c            | 3 +--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 1e99514..5f60248 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -981,7 +981,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
 	cpuhw->flags &= ~PMU_F_ENABLED;
 }
 
-/* perf_exclude_event() - Filter event
+/* perf_event_exclude() - Filter event
  * @event:	The perf event
  * @regs:	pt_regs structure
  * @sde_regs:	Sample-data-entry (sde) regs structure
@@ -990,7 +990,7 @@ static void cpumsf_pmu_disable(struct pmu *pmu)
  *
  * Return non-zero if the event shall be excluded.
  */
-static int perf_exclude_event(struct perf_event *event, struct pt_regs *regs,
+static int perf_event_exclude(struct perf_event *event, struct pt_regs *regs,
 			      struct perf_sf_sde_regs *sde_regs)
 {
 	if (event->attr.exclude_user && user_mode(regs))
@@ -1073,7 +1073,7 @@ static int perf_push_sample(struct perf_event *event,
 	data.tid_entry.pid = basic->hpp & LPP_PID_MASK;
 
 	overflow = 0;
-	if (perf_exclude_event(event, &regs, sde_regs))
+	if (perf_event_exclude(event, &regs, sde_regs))
 		goto out;
 	if (perf_event_overflow(event, &data, &regs)) {
 		overflow = 1;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bf831b1..8333f13 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1690,6 +1690,8 @@ static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
+extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
+
 extern void perf_event_init(void);
 extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  int entry_size, struct pt_regs *regs,
@@ -1895,6 +1897,10 @@ static inline u64 perf_event_pause(struct perf_event *event, bool reset)
 {
 	return 0;
 }
+static inline int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
+{
+	return 0;
+}
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e9f698c..b2bc677 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10039,8 +10039,7 @@ static void perf_swevent_event(struct perf_event *event, u64 nr,
 	perf_swevent_overflow(event, 0, data, regs);
 }
 
-static int perf_exclude_event(struct perf_event *event,
-			      struct pt_regs *regs)
+int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
 		return 1;

