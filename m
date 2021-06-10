Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444BF3A2658
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jun 2021 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhFJIPR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Jun 2021 04:15:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59536 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJIPQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Jun 2021 04:15:16 -0400
Date:   Thu, 10 Jun 2021 08:13:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623312799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3BpSyuyL7IyWEbFtTPhteVJPqZehbOZ+sfrPpq61P0=;
        b=GB9eROfPcSLG3TtlFeCPLt0hBXlVI6jx5uVUIaT/0OhCGTXwk7pV2irUbQqNQIgbJN1p2S
        DiXUZNFMH7oA4V+0bsuZ4bNuKuGDElBLSLUt0ruqqxs74Tgy6DcyjIB7KCtypMKaVgtKcS
        JQK7EQMDtEAaSZEftRDtMie+u/S7ZvvdaMyZyojWOv6aVsB7NRYcO4gO6QqlQzNkhhMtlG
        rRsaKmRoGtXUDPq8Imot8F8ja4VuK0HcKqIdeztUyTNiC2jHP0lR54DKqV8VsndHufLCxq
        B/UQjT2f6Lc7BZlaeP/ADMkxaLnQdCSu1H7VlJ2cog+znPOHOZRkXYJEyNGA7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623312799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3BpSyuyL7IyWEbFtTPhteVJPqZehbOZ+sfrPpq61P0=;
        b=Ghigu4lFKU0cX4r1oNa7V3xK6fr5WY2do6uId6tSo0wtBcN6CoEYhtKE73/ExkTK4NmLQi
        tUmphc/e4vjpYXBA==
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
Message-ID: <162331279887.29796.9510533590122950862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     156172a13ff0626d8e23276e741c7e2cb2f3b572
Gitweb:        https://git.kernel.org/tip/156172a13ff0626d8e23276e741c7e2cb2f3b572
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Jun 2021 19:54:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Jun 2021 10:00:08 +02:00

irq_work: Make irq_work_queue() NMI-safe again

Someone carelessly put NMI unsafe code in irq_work_queue(), breaking
just about every single user. Also, someone has a terrible comment
style.

Fixes: e2b5bcf9f5ba ("irq_work: record irq_work_queue() call stack")
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
