Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C783A24F7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jun 2021 09:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFJHEs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Jun 2021 03:04:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59122 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJHEr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Jun 2021 03:04:47 -0400
Date:   Thu, 10 Jun 2021 07:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623308570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yHwII1Yt2O91s68AJ1Te4JRbWkXThgkkz9g7TkMkQc=;
        b=h2G0spDPUxcwvp9OEvB8qT11FQWu7uDxUNhWZDc88yvszGlyvMHai+x6m0HYjVsRoCY17Y
        MwKM2/IF3Z3ND9K67Q/NRTMsBjVnzBuUEEOVchcFS8JBOnLsuc3UHmtRbKoII24kczBCB6
        G6SGPqdsEwReJY7VpVNmkniO779Mm4oQ5wV/PniNlJlCnywBiVWEs3/nzSP8lpXjfxyXym
        3g/XDMbjCdvqf4yTYqUhpz6R1TTXDZZXSZiFET0G1u4RtGBAZ84vajnhfl+6T2sEd/laIY
        upjmYj4gqHh4GdtmS+c7QhKyzAjyBIvOY3D0MwnQNXhMFXvk/JjDI62yMPepDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623308570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yHwII1Yt2O91s68AJ1Te4JRbWkXThgkkz9g7TkMkQc=;
        b=cr9dGACQD1qV8vSh+VnJg/5Z/TMl/iEkBqtWlf4VEUuy1Zpqhp6JHDS8RlqcSTiXQtwYNQ
        Le0ESh3w4ZNsifBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] irq_work: Make irq_work_queue() NMI-safe again
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YL+uBq8LzXXZsYVf@hirez.programming.kicks-ass.net>
References: <YL+uBq8LzXXZsYVf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162330857005.29796.2967900864699325697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     dc6be79444d82d5b9d679c7d6bd77c672f1e28ca
Gitweb:        https://git.kernel.org/tip/dc6be79444d82d5b9d679c7d6bd77c672f1e28ca
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Jun 2021 19:54:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Jun 2021 20:03:59 +02:00

irq_work: Make irq_work_queue() NMI-safe again

Someone carelessly put NMI unsafe code in irq_work_queue(), breaking
just about every single user. Also, someone has a terrible comment
style.

Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YL+uBq8LzXXZsYVf@hirez.programming.kicks-ass.net
---
 kernel/irq_work.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 23a7a0b..db8c248 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -70,9 +70,6 @@ bool irq_work_queue(struct irq_work *work)
 	if (!irq_work_claim(work))
 		return false;
 
-	/*record irq_work call stack in order to print it in KASAN reports*/
-	kasan_record_aux_stack(work);
-
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
 	__irq_work_queue_local(work);
