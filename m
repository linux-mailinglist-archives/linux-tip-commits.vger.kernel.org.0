Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618D031DA18
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhBQNSX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhBQNSP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:15 -0500
Date:   Wed, 17 Feb 2021 13:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viclKIS/wEh2C5cZN05Bn36phjwqC1yjEjIXMF4ZcH0=;
        b=nvicFERDgIkMfVb9mbRWEoLEpOaYl6rZfOnBVmubcH7GCFc9MVvURheTiK6LNlqBobwcWg
        iVRbzBZGUqoB8F9MEDfZKcPvMA7rz8y1GYjJGgYBEGmBKwruzF1qNCVBxJZh8UaxNBBG1b
        xivbA9w0jJlVjd4F75RqwFYAEhERFsHpNHwcLvwNM1KUG5ekXZi1zYfgtwYfxOYIGIOpgG
        fsBHIcre5G9bCKRscG8K4w8sbF8wAvliXoWfcIu/anDpIa33+jNC47H4QSHQKDz/lD6KQf
        YOs5irym5vMckcY/vg+xDFtvPmD4Rq4n42XycMDCT8gDxPEQOJOeAw/vaFEzSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viclKIS/wEh2C5cZN05Bn36phjwqC1yjEjIXMF4ZcH0=;
        b=xa3SKRYSO9mCzZVc9W0ohyy/Uz+w9GjhZKvSULTHXV9o4GTGS5KcjKiOtESAUFd3cmCu1N
        waZ7l7JAf5ZYZIBg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smp: Process pending softirqs in
 flush_smp_call_function_from_idle()
Cc:     Jens Axboe <axboe@kernel.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210123201027.3262800-2-bigeasy@linutronix.de>
References: <20210123201027.3262800-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <161356785301.20312.17140312346684582449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f9d34595ae4feed38856b88769e2ba5af22d2548
Gitweb:        https://git.kernel.org/tip/f9d34595ae4feed38856b88769e2ba5af22d2548
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 23 Jan 2021 21:10:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:42 +01:00

smp: Process pending softirqs in flush_smp_call_function_from_idle()

send_call_function_single_ipi() may wake an idle CPU without sending an
IPI. The woken up CPU will process the SMP-functions in
flush_smp_call_function_from_idle(). Any raised softirq from within the
SMP-function call will not be processed.
Should the CPU have no tasks assigned, then it will go back to idle with
pending softirqs and the NOHZ will rightfully complain.

Process pending softirqs on return from flush_smp_call_function_queue().

Fixes: b2a02fc43a1f4 ("smp: Optimize send_call_function_single_ipi()")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210123201027.3262800-2-bigeasy@linutronix.de
---
 kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 1b6070b..aeb0adf 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/gfp.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
@@ -449,6 +450,9 @@ void flush_smp_call_function_from_idle(void)
 
 	local_irq_save(flags);
 	flush_smp_call_function_queue(true);
+	if (local_softirq_pending())
+		do_softirq();
+
 	local_irq_restore(flags);
 }
 
