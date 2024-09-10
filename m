Return-Path: <linux-tip-commits+bounces-2289-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D47973051
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 12:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14121F22640
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7ED18EFF8;
	Tue, 10 Sep 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9CtWr5n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ezyGARzM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCE18CC17;
	Tue, 10 Sep 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962349; cv=none; b=mXUUWo8Eaecw7DyHijUIGw2a/Xqu7Elg4rm77HrEAKa7lEk910H+ch+Qj+DDGBS8Bct2Yewqv84+Gz/G9WP0ybvnMExnrnOZoHkgNM22ap19W/W6Zk5JCEFFnsPQ5VR9wOmYcGFxEQrzXyAxV77PPzH3UcorjJrjrqKWDAeR+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962349; c=relaxed/simple;
	bh=pB/cLWxi+6Gds+Dvtmxtsb0p8gWhvQS3pJJezxS8H04=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nMjWOr1iRond4toL/a9w2+kgYIvtC0IT9saV/ArjXH8LTrV9MwmYYcq5jNyDiZBlOHIjkEUXAEX+QPCFYHMPSIquRuvnbUQOGCIMmFFYEkf8YyJys3ontVyxrlKns8eZLLlVVTzlRtqDTgGrFgEo+zsmn3FCyeCupB97woLyvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9CtWr5n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ezyGARzM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 09:59:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725962345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzaZ09MGUUW3Yycc9CIQ+jfqbRFP1aVpOVGX7paOQ5U=;
	b=C9CtWr5n4V7RyaafKyo0d13U+MmEARRze/CNMAghiM4lvqFL7oPfKRhEboufRdvVTVGPDE
	26DC3ey0XIjPEgXicxmtQP8lBv0YBhUL7x2qIsHw5l/gmulqnvqVoXiBusSrji9tDwtRhw
	8rxa81+P9GnnxUm1fR0Yoqq3/HZ18HSjD21abs8mTHkSv0fJEAUhfFux6+iaBjSp2Z2vaz
	1hyhgYJCHa1T8pWmZq1+qxP3OpeCFHipdBbd82YBR5nsoTSfAlbsj9HEXEdWpcLQVayvIn
	9SaiqPac1NBfkWu3feNPxVTlFdcc4YS+o3xloiKuZhFwU5n6jVePxb4zNXSW7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725962345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzaZ09MGUUW3Yycc9CIQ+jfqbRFP1aVpOVGX7paOQ5U=;
	b=ezyGARzM/orfb7HvJnf6FWKuxdL1nMJ8vcMc5ktBA5hT4t231Dxzmk6sjUdLV80yLRX/E5
	ZRfsc+bURv9vJRBg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add PERF_EV_CAP_READ_SCOPE
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802151643.1691631-3-kan.liang@linux.intel.com>
References: <20240802151643.1691631-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172596234459.2215.4948538664512700721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a48a36b316ae5d3ab83f9b545dba15998e96d59c
Gitweb:        https://git.kernel.org/tip/a48a36b316ae5d3ab83f9b545dba15998e96d59c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 02 Aug 2024 08:16:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 11:44:13 +02:00

perf: Add PERF_EV_CAP_READ_SCOPE

Usually, an event can be read from any CPU of the scope. It doesn't need
to be read from the advertised CPU.

Add a new event cap, PERF_EV_CAP_READ_SCOPE. An event of a PMU with
scope can be read from any active CPU in the scope.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240802151643.1691631-3-kan.liang@linux.intel.com
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 14 +++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a3cbcd7..794f660 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -636,10 +636,13 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
  * PERF_EV_CAP_SIBLING: An event with this flag must be a group sibling and
  * cannot be a group leader. If an event with this flag is detached from the
  * group it is scheduled out and moved into an unrecoverable ERROR state.
+ * PERF_EV_CAP_READ_SCOPE: A CPU event that can be read from any CPU of the
+ * PMU scope where it is active.
  */
 #define PERF_EV_CAP_SOFTWARE		BIT(0)
 #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
 #define PERF_EV_CAP_SIBLING		BIT(2)
+#define PERF_EV_CAP_READ_SCOPE		BIT(3)
 
 #define SWEVENT_HLIST_BITS		8
 #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5ff9735..2766090 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4556,16 +4556,24 @@ struct perf_read_data {
 	int ret;
 };
 
+static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int scope, int cpu);
+
 static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 {
+	int local_cpu = smp_processor_id();
 	u16 local_pkg, event_pkg;
 
 	if ((unsigned)event_cpu >= nr_cpu_ids)
 		return event_cpu;
 
-	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
-		int local_cpu = smp_processor_id();
+	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
+		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
+
+		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
+			return local_cpu;
+	}
 
+	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
 		event_pkg = topology_physical_package_id(event_cpu);
 		local_pkg = topology_physical_package_id(local_cpu);
 
@@ -11905,7 +11913,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 				if (cpu >= nr_cpu_ids)
 					ret = -ENODEV;
 				else
-					event->cpu = cpu;
+					event->event_caps |= PERF_EV_CAP_READ_SCOPE;
 			} else {
 				ret = -ENODEV;
 			}

