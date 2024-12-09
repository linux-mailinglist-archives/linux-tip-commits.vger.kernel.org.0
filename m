Return-Path: <linux-tip-commits+bounces-3020-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6B9E9032
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C9A281E6F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B727217658;
	Mon,  9 Dec 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5/0TG1T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oJKfI49R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982D217656;
	Mon,  9 Dec 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740339; cv=none; b=mT8AbxtsDzMCJlY8PHhgUhmqb9pDU8H2REi0/HN/OnpFfVIeY7Bj7NzWkKA7TnFLcxarJYVfnwsVV0wdKI4uzK2uAsBGVkP0er5xhEhhBPswE01AvUt+LXWCLnzHWSRcYsFY3RBrPex/SsT7BYYxc483vrNoCVc/PKsTN5aPPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740339; c=relaxed/simple;
	bh=JZKR0zXlrpuA1+YBqezQgPeLkk6IZpp2MplgJYEBVhQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=chRUsHTSUGhlkin1KwdOsf3k7qe5+9l9Pk3Rjvu1YBgMkLjUcVgLRLfB9Qjc9hichm0r2Clt/uVIOkQDTl4qMm5wMtxD0HsPLyJAX180l6pVi7qC2cX/wHrd5ragvXBB5woKYlsTN/u4VhOc/yzY8ALeO+qZBMqq+VrrVcomUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z5/0TG1T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oJKfI49R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 10:32:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733740330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oMUpUpD9yMgFv7jSZ92VLruRlshaHcWk+gT+U7QnyQ=;
	b=z5/0TG1TSgQvy+3SfKT5GTuf8L08RyIV0JZTjYotTowJOl23cZQnrIKV2dYcTxWR5lHUSY
	SK3vKJNtju8FSfuRQiCKoeWy9GdWgjGwr6a/+XMpMJheH11cEZgR1tokplzGybGQui1sqW
	TsX/zUetg1CnRzWlviSd1KuiicrWnpXz24dWCrAcaJfAViCmtYyiEDVixCy4S2zSRorh60
	d+fM1aTG5orq9DbHwWbNLjdw/W9QH6aneghO2FVsS2khvbLI4S7M4kuIq6Ypg+yQRCScVf
	zfwdrmfZtXB8Cc8F9UrF41evKEHplktNUatHClqKlS7yN/ByOy/9GSeNK5TM+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733740330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oMUpUpD9yMgFv7jSZ92VLruRlshaHcWk+gT+U7QnyQ=;
	b=oJKfI49Rhf79JbMaVoHYNqdL82AP8ciiLuPE0vrd8o4jd5n46DKUU827+WokZdKAp2T+5N
	C7XPn5el5wwcRdCg==
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
Message-ID: <173374032957.412.5301921865630626412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3807d5c928f46b27de80b67de4aae15699d19bec
Gitweb:        https://git.kernel.org/tip/3807d5c928f46b27de80b67de4aae15699d19bec
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 03 Dec 2024 10:04:40 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:18:08 +01:00

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

