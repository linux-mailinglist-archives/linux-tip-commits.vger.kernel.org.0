Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE18362674
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbhDPROK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 13:14:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbhDPROK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 13:14:10 -0400
Date:   Fri, 16 Apr 2021 17:13:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618593224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLrpAR+/vQ+E1RsQXCYLRzyCUBzP8KouI1zW3reGLIA=;
        b=b9woOJychMWtfbW2WX+8M5xvAdgUD+iFQ6AGXTU2UVwXxfDcyvX1liCrNNLzqMj8kj5ScB
        6TYsGdfsyBkkl7+yP0Y7yLps0cC3XFw3RTQvNMDxRNvTAzBpbARU3a+O6ONRnvPh02++oK
        RYiSYnprr79nGkUm1ZsYbsusEg+TnDf1UqCJnGyPl8v2Be+ohV61/cprwQ9nHVIh0NdpH+
        CV6hygTsVxxCPERsqVz3AHtVTqCaab1Kbj3eE/AeZTGKp3AVpCOVLE1BJzCd6q3qIOHPf2
        83YIe93ZVSTLjKU+9qF9C4/fHBTTdVpWvwwvI+YXNP2t8uMJcB/LAWCo611fhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618593224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLrpAR+/vQ+E1RsQXCYLRzyCUBzP8KouI1zW3reGLIA=;
        b=PoHUeXhEkqZFQHkr43HQqDWILrobLnSRdMnQpFrD53BbxGe0T5pRBjdsZTWaJTcV7tmT3m
        UHktWII019pTNsDQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210083327.22726-2-namhyung@kernel.org>
References: <20210210083327.22726-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <161859322373.29796.13679463241653165502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d0d1dd628527c77db2391ce0293c1ed344b2365f
Gitweb:        https://git.kernel.org/tip/d0d1dd628527c77db2391ce0293c1ed344b2365f
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 10 Feb 2021 17:33:26 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 18:58:52 +02:00

perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event

This patch adds a new software event to count context switches
involving cgroup switches.  So it's counted only if cgroups of
previous and next tasks are different.  Note that it only checks the
cgroups in the perf_event subsystem.  For cgroup v2, it shouldn't
matter anyway.

One can argue that we can do this by using existing sched_switch event
with eBPF.  But some systems might not have eBPF for some reason so
I'd like to add this as a simple way.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210210083327.22726-2-namhyung@kernel.org
---
 include/linux/perf_event.h      | 7 +++++++
 include/uapi/linux/perf_event.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 92d51a7..8989b2b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1218,6 +1218,13 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 	if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
 		__perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
 
+#ifdef CONFIG_CGROUP_PERF
+	if (__perf_sw_enabled(PERF_COUNT_SW_CGROUP_SWITCHES) &&
+	    perf_cgroup_from_task(prev, NULL) !=
+	    perf_cgroup_from_task(next, NULL))
+		__perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
+#endif
+
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_out(prev, next);
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 31b00e3..0b58970 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -112,6 +112,7 @@ enum perf_sw_ids {
 	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
 	PERF_COUNT_SW_DUMMY			= 9,
 	PERF_COUNT_SW_BPF_OUTPUT		= 10,
+	PERF_COUNT_SW_CGROUP_SWITCHES		= 11,
 
 	PERF_COUNT_SW_MAX,			/* non-ABI */
 };
