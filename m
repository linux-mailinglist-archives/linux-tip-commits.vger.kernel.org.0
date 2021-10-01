Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFB041F063
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354863AbhJAPH2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354810AbhJAPHV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:21 -0400
Date:   Fri, 01 Oct 2021 15:05:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZfHdPCUHWELCZN6zPVO5rsAd7ZonOwe3nRN5tyRfGY=;
        b=vBBGwN2kufSiv4ZiLULulmJn8ze280vxudM+SapR1PP50u4iBxax1wDn3NXYmorP1+GVG+
        6AcJcvSwiOHk5+TqPxq8ssb9akTXcsaHHH5ujObPM1DkC/wkqZ8HA9D51k6JU8X2IpBVar
        XZv9fLMrT7c00tSjC0SQNOwVnYp4tBXRcLIGS0wc00KLAe4fQnZzHY97ep0dGl+yk2DcyN
        nnFMQNYM340lv6I+/hHFBiOMzrPBzUIPYFYRWH1p7O7r7x/VNu9C+/r4xqag9QBPgayRW7
        NhDGpFtSiqq9RIz4B5XzxUcDk3HcFuPpIQPJQlhSHyjZ6S1ct/OVQJ6+3R1M2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZfHdPCUHWELCZN6zPVO5rsAd7ZonOwe3nRN5tyRfGY=;
        b=AFTPfUvY9UAJn/SpFqJimVtUVc4Rsobk/yB3LLE1Tr7mEOu98LV9rMG1YF01adOeTvdR38
        9IyiocBh0JJcCiDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Cleanup might_sleep() printks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923165358.117496067@linutronix.de>
References: <20210923165358.117496067@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310073106.25758.4598750412209394394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a45ed302b6e6fe5b03166321c08b4f2ad4a92a35
Gitweb:        https://git.kernel.org/tip/a45ed302b6e6fe5b03166321c08b4f2ad4a92a35
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Sep 2021 18:54:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:50 +02:00

sched: Cleanup might_sleep() printks

Convert them to pr_*(). No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210923165358.117496067@linutronix.de
---
 kernel/sched/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d790df..a7c6069 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9516,16 +9516,14 @@ void __might_resched(const char *file, int line, int preempt_offset)
 	/* Save this before calling printk(), since that will clobber it: */
 	preempt_disable_ip = get_preempt_disable_ip(current);
 
-	printk(KERN_ERR
-		"BUG: sleeping function called from invalid context at %s:%d\n",
-			file, line);
-	printk(KERN_ERR
-		"in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
-			in_atomic(), irqs_disabled(), current->non_block_count,
-			current->pid, current->comm);
+	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
+	       file, line);
+	pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
+	       in_atomic(), irqs_disabled(), current->non_block_count,
+	       current->pid, current->comm);
 
 	if (task_stack_end_corrupted(current))
-		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
+		pr_emerg("Thread overran stack, or stack corrupted\n");
 
 	debug_show_held_locks(current);
 	if (irqs_disabled())
