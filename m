Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD0CFAE0F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2019 11:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKMKGn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Nov 2019 05:06:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37168 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKMKGn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Nov 2019 05:06:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUpXe-0000HF-Ld; Wed, 13 Nov 2019 11:06:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 449CD1C0357;
        Wed, 13 Nov 2019 11:06:26 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:06:25 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Consistently fail fork on allocation failures
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191105075702.60319-1-alexander.shishkin@linux.intel.com>
References: <20191105075702.60319-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157363958587.29376.2994304953046746827.tip-bot2@tip-bot2>
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

Commit-ID:     697d877849d4b34ab58d7078d6930bad0ef6fc66
Gitweb:        https://git.kernel.org/tip/697d877849d4b34ab58d7078d6930bad0ef6fc66
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Tue, 05 Nov 2019 09:57:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 08:16:43 +01:00

perf/core: Consistently fail fork on allocation failures

Commit:

  313ccb9615948 ("perf: Allocate context task_ctx_data for child event")

makes the inherit path skip over the current event in case of task_ctx_data
allocation failure. This, however, is inconsistent with allocation failures
in perf_event_alloc(), which would abort the fork.

Correct this by returning an error code on task_ctx_data allocation
failure and failing the fork in that case.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20191105075702.60319-1-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7655441..466e333 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11802,7 +11802,7 @@ inherit_event(struct perf_event *parent_event,
 						   GFP_KERNEL);
 		if (!child_ctx->task_ctx_data) {
 			free_event(child_event);
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 		}
 	}
 
