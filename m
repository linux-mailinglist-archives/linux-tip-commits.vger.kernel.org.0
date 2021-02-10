Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F6D31686F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhBJNyq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 08:54:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhBJNyT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 08:54:19 -0500
Date:   Wed, 10 Feb 2021 13:53:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZCZ1/yQVQmt38ryAvajWjtGHU5inusBmrOS4qU0prM=;
        b=jyb2reRCEBvrT7vwvqKtVJgoKwoEWpYS7p/VzO3N7irvqcmoQU1GTNndg61Z9LXKcVgxv7
        Y6DLAzVPxXc6DQ8eGxq1jRnZUw8CCWj2kVWq2dF9JBJbrPDHGx85w0np7ma/QSBXAImc8d
        eehSXkKDIHQb9q3/SWXL9ckho1ZGDl88JyOzzghAEF0gfNoa29xFBCyHVpWbostCtq7ctg
        dwVv41wjPu07jTmlH3qPXDeUHqll6hDFmbn6NlAOK69EQySzhdIucbP/KHzA2rSjCVuuxv
        E6SIE73Z4A+IRB0tATeJhXVpHhDUsqy4HrxfQT4jP/eR2yZIui/0PAg6372tNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZCZ1/yQVQmt38ryAvajWjtGHU5inusBmrOS4qU0prM=;
        b=tkALj72UXshc2C3gsQzhdQsIsPXw+MNRYL23913kWitzju54xIaloWj+EZlbNweLu4Fq+6
        Nd9zPK67N8aeBqAQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smp: Process pending softirqs in
 flush_smp_call_function_from_idle()
Cc:     Jens Axboe <axboe@kernel.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210123201027.3262800-2-bigeasy@linutronix.de>
References: <20210123201027.3262800-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <161296521428.23325.4658153498345457080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     66040b2d5d41f85cb1a752a75260595344c5ec3b
Gitweb:        https://git.kernel.org/tip/66040b2d5d41f85cb1a752a75260595344c5ec3b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 23 Jan 2021 21:10:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:42 +01:00

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
 
