Return-Path: <linux-tip-commits+bounces-1786-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725B593F28F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26931C21A88
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4880E1448F2;
	Mon, 29 Jul 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/Vtr6Ml";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2XTGoGVZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF12143C6D;
	Mon, 29 Jul 2024 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248692; cv=none; b=Nb1IZNCUbF/Dx+Ur0QlnVadHvkRxxDdkT4AoGpMgWPGFoRysWQENmbVNITpL+FfNLJw0HutUEx04r38ZMkXexYg8FtN9ZatKanKT+7BxKjXk3q8asCTBuAuWm69LLkqc8nAiDIlt0+4vQogFUWV57fWAOmeSHbK5oWV7b8XtTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248692; c=relaxed/simple;
	bh=3yBGbI39dGJqtMkE1b110tNM/pT6V+gM6oH3DLNRWoM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=B6dt2UVlt0SRYZVnBNN+EhEsiL53AuEKkJkHIZxCs2aidx+M8pFPYxv+49kIu4WDc46yIvOWY10Q0Cr7WAk0UmeRy+ny5mZt0oU3rOPonNva7kYKYuR1v/HonI11WoW5mo8qpws4ZLTxXFgwCVA0P7u4UqTpS3hCU5yVqUmxOQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/Vtr6Ml; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2XTGoGVZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:24:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722248689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Tbma9PtjqKRyGyTZeTnFjv/6rK/P/J6CHoK8+uXOeAc=;
	b=N/Vtr6MlMsAC4M7JpfV2DJrWg7/I7CPnxryVHb5jPzImvadfVq6awcS3HvaXaBT60qHhsI
	39HrFKB5T2sbG11uUktV9K1xiXSpXup7QvUDxKrZxF4fZD7uaM3wyAJxJRxCO+4blSiWl7
	w8rSy2YP76KQXhoaoYeNWq9KU7frzXvK0eNyQV35TZJqa7/PKJvtq3Pvpotd+nBV9FQJBD
	YqyzsO3rwWvXQfOGELHewJSMxolAtZMzTxhDEAHQMHs5pCH6CjXdSR2UE09eZnkKNVEco3
	o1f7oOolJjk8KuHY3/R8nSC92R1caNKSAdAF5I798ONPnFevgHr65rkOL5WHtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722248689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Tbma9PtjqKRyGyTZeTnFjv/6rK/P/J6CHoK8+uXOeAc=;
	b=2XTGoGVZp2pmxhrosLVHjTVMxSYQhvqUK5mC00FxdgHwsPxraqgbKsJ1L8aOI1mGAHmrnp
	ECdWyqDIJYxQbnBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add hw_perf_event::aux_config
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224868860.2215.15122628647277085403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     52c3fb1a0f822fd64529ca64f3792095524de450
Gitweb:        https://git.kernel.org/tip/52c3fb1a0f822fd64529ca64f3792095524de450
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Jul 2024 10:21:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:16:24 +02:00

perf/x86: Add hw_perf_event::aux_config

Start a new section for AUX PMUs in hw_perf_event.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/pt.c | 14 +++++++-------
 include/linux/perf_event.h |  3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 2959970..fd4670a 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -416,7 +416,7 @@ static bool pt_event_valid(struct perf_event *event)
 static void pt_config_start(struct perf_event *event)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
-	u64 ctl = event->hw.config;
+	u64 ctl = event->hw.aux_config;
 
 	ctl |= RTIT_CTL_TRACEEN;
 	if (READ_ONCE(pt->vmx_on))
@@ -424,7 +424,7 @@ static void pt_config_start(struct perf_event *event)
 	else
 		wrmsrl(MSR_IA32_RTIT_CTL, ctl);
 
-	WRITE_ONCE(event->hw.config, ctl);
+	WRITE_ONCE(event->hw.aux_config, ctl);
 }
 
 /* Address ranges and their corresponding msr configuration registers */
@@ -503,7 +503,7 @@ static void pt_config(struct perf_event *event)
 	u64 reg;
 
 	/* First round: clear STATUS, in particular the PSB byte counter. */
-	if (!event->hw.config) {
+	if (!event->hw.aux_config) {
 		perf_event_itrace_started(event);
 		wrmsrl(MSR_IA32_RTIT_STATUS, 0);
 	}
@@ -533,14 +533,14 @@ static void pt_config(struct perf_event *event)
 
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
-	event->hw.config = reg;
+	event->hw.aux_config = reg;
 	pt_config_start(event);
 }
 
 static void pt_config_stop(struct perf_event *event)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
-	u64 ctl = READ_ONCE(event->hw.config);
+	u64 ctl = READ_ONCE(event->hw.aux_config);
 
 	/* may be already stopped by a PMI */
 	if (!(ctl & RTIT_CTL_TRACEEN))
@@ -550,7 +550,7 @@ static void pt_config_stop(struct perf_event *event)
 	if (!READ_ONCE(pt->vmx_on))
 		wrmsrl(MSR_IA32_RTIT_CTL, ctl);
 
-	WRITE_ONCE(event->hw.config, ctl);
+	WRITE_ONCE(event->hw.aux_config, ctl);
 
 	/*
 	 * A wrmsr that disables trace generation serializes other PT
@@ -1557,7 +1557,7 @@ void intel_pt_handle_vmx(int on)
 
 	/* Turn PTs back on */
 	if (!on && event)
-		wrmsrl(MSR_IA32_RTIT_CTL, event->hw.config);
+		wrmsrl(MSR_IA32_RTIT_CTL, event->hw.aux_config);
 
 	local_irq_restore(flags);
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a89422..6bb0c21 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -168,6 +168,9 @@ struct hw_perf_event {
 			struct hw_perf_event_extra extra_reg;
 			struct hw_perf_event_extra branch_reg;
 		};
+		struct { /* aux / Intel-PT */
+			u64		aux_config;
+		};
 		struct { /* software */
 			struct hrtimer	hrtimer;
 		};

