Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA272DE724
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Dec 2020 17:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgLRQDP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Dec 2020 11:03:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgLRQDP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Dec 2020 11:03:15 -0500
Date:   Fri, 18 Dec 2020 16:02:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608307353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMA1NUzrroNV7wtgygwVjEnPBuryv0pd4k2lZpO2Ol4=;
        b=D7/27Uy/t0uz4hoOOmX6b/1GvDuBIIe1YvuuNq+xcOye7+cSsGNaDqqJJalCbxddKc3Vi2
        yPa4KezZUT58sb23Lsq5QwxmeLR35ljgSCpyVD9KuxfhJvebjRFWX8klpJw70SqbZfZz/o
        LDG3liK3Br5MvwtAlfOp2rIk4ilANtU2znmHq2zA7ouWWPmST4Mdaj47aToGdHFdVJ+hxv
        UB+YX4cyzppISzJM8C9Vk5QgTIdUTz2i1e4D6xWHQ76Zqub4vYOHV2xy75D+5R7rEz82iI
        VhrkPjvL1E+IbJCXN8Y4anfAdgs72CZsHk0/dklJdk8Bj4lzRjTdbBSpHARgMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608307353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMA1NUzrroNV7wtgygwVjEnPBuryv0pd4k2lZpO2Ol4=;
        b=tLD5MfopoD0pwqv/fjz78dF7Pega/lD9G8S/0JYwUxrOsJG1dyMFjfP+FDCvx7pLD65RRa
        0tWqOFegRNqXAPBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] softirq: Avoid bad tracing / lockdep interaction
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201218154519.GW3092@hirez.programming.kicks-ass.net>
References: <20201218154519.GW3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160830735281.22759.13387853459689261658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     91ea62d58bd661827c328a2c6c02a87fa4aae88b
Gitweb:        https://git.kernel.org/tip/91ea62d58bd661827c328a2c6c02a87fa4aae88b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 18 Dec 2020 16:39:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Dec 2020 16:53:13 +01:00

softirq: Avoid bad tracing / lockdep interaction

Similar to commit:

  1a63dcd8765b ("softirq: Reorder trace_softirqs_on to prevent lockdep splat")

__local_bh_enable_ip() can also call into tracing with inconsistent
state. Unlike that commit we don't need to bother about the tracepoint
because 'cnt-1' never matches preempt_count() (by construction).

Reported-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lkml.kernel.org/r/20201218154519.GW3092@hirez.programming.kicks-ass.net
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 09229ad..0f1d3a3 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -185,7 +185,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
 	 */
-	preempt_count_sub(cnt - 1);
+	__preempt_count_sub(cnt - 1);
 
 	if (unlikely(!in_interrupt() && local_softirq_pending())) {
 		/*
