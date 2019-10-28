Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B7AE7096
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2019 12:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbfJ1LmE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Oct 2019 07:42:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44334 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfJ1LmE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Oct 2019 07:42:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iP3PA-0001G6-KO; Mon, 28 Oct 2019 12:41:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E2311C0482;
        Mon, 28 Oct 2019 12:41:48 +0100 (CET)
Date:   Mon, 28 Oct 2019 11:41:47 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/ibs: Handle erratum #420 only on the
 affected CPU family (10h)
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191023150955.30292-2-kim.phillips@amd.com>
References: <20191023150955.30292-2-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <157226290796.29376.14857339901992201975.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e431e79b60603079d269e0c2a5177943b95fa4b6
Gitweb:        https://git.kernel.org/tip/e431e79b60603079d269e0c2a5177943b95fa4b6
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Wed, 23 Oct 2019 10:09:55 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Oct 2019 11:02:00 +01:00

perf/x86/amd/ibs: Handle erratum #420 only on the affected CPU family (10h)

This saves us writing the IBS control MSR twice when disabling the
event.

I searched revision guides for all families since 10h, and did not
find occurrence of erratum #420, nor anything remotely similar:
so we isolate the secondary MSR write to family 10h only.

Also unconditionally update the count mask for IBS Op implementations
that have read & writeable current count (CurCnt) fields in addition
to the MaxCnt field.  These bits were reserved on prior
implementations, and therefore shouldn't have negative impact.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: c9574fe0bdb9 ("perf/x86-ibs: Implement workaround for IBS erratum #420")
Link: https://lkml.kernel.org/r/20191023150955.30292-2-kim.phillips@amd.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/amd/ibs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 98ba21a..26c3635 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -377,7 +377,8 @@ static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
 					  struct hw_perf_event *hwc, u64 config)
 {
 	config &= ~perf_ibs->cnt_mask;
-	wrmsrl(hwc->config_base, config);
+	if (boot_cpu_data.x86 == 0x10)
+		wrmsrl(hwc->config_base, config);
 	config &= ~perf_ibs->enable_mask;
 	wrmsrl(hwc->config_base, config);
 }
@@ -553,7 +554,8 @@ static struct perf_ibs perf_ibs_op = {
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_CONFIG_MASK,
-	.cnt_mask		= IBS_OP_MAX_CNT,
+	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
+				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
 	.valid_mask		= IBS_OP_VAL,
 	.max_period		= IBS_OP_MAX_CNT << 4,
