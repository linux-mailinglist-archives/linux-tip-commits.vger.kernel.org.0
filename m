Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD142EDF8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbhJOJrN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbhJOJrE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:04 -0400
Date:   Fri, 15 Oct 2021 09:44:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A08zl4HXG8opBrz2YnJjyVkVQpEH0VoihlOcOW4rYUQ=;
        b=vUtrKwLGY4W1rdTXae6WB9NwXdFJp76gFH1inqPS7zBuQ1t3ve3iwNoLMJrrD92rCweA5c
        jZDz4NL8l+Mz9ZAV/+zaDPVPXauXChkbLWdlhKarVKzF3g0F7eSPycJ3Xl4RGU9F/9g8ek
        XEWIUy6AC83sQVxvEcwjEqFvr4aUEGVnzlaUZZcFm1q46y2K8lBQ/XDPmc4w3F2p7nDrz9
        fMty6BDoq8u44I3YG4DvZo2q9yCbz+/43eStO+sIp/AEp6AVR/hGeO6Qv/X0+jdfxH6aR3
        OwPCLvOB8pRcSmn+Mt9LYxJ7guHpI9KpiB2gg/3kx8Xal7KEQuwwUQvpDmeGeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A08zl4HXG8opBrz2YnJjyVkVQpEH0VoihlOcOW4rYUQ=;
        b=KdKe+YI0H56gNwIbK/pWS9h02XyyGTbQQCCcX+hfppwoDKlkiFWapg78ojoOKyTOQ52RQ9
        RsSCUGo6taaOi0BQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Annotate the RT balancing logic irqwork
 as IRQ_WORK_HARD_IRQ
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211006111852.1514359-2-bigeasy@linutronix.de>
References: <20211006111852.1514359-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163429109695.25758.9862374179452807395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     da6ff09943491819e077b94c284bf0a6b751c9b8
Gitweb:        https://git.kernel.org/tip/da6ff09943491819e077b94c284bf0a6b751c9b8
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 06 Oct 2021 13:18:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:16 +02:00

sched/rt: Annotate the RT balancing logic irqwork as IRQ_WORK_HARD_IRQ

The push-IPI logic for RT tasks expects to be invoked from hardirq
context. One reason is that a RT task on the remote CPU would block the
softirq processing on PREEMPT_RT and so avoid pulling / balancing the RT
tasks as intended.

Annotate root_domain::rto_push_work as IRQ_WORK_HARD_IRQ.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211006111852.1514359-2-bigeasy@linutronix.de
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c1729f9..e812467 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -526,7 +526,7 @@ static int init_rootdomain(struct root_domain *rd)
 #ifdef HAVE_RT_PUSH_IPI
 	rd->rto_cpu = -1;
 	raw_spin_lock_init(&rd->rto_lock);
-	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
+	rd->rto_push_work = IRQ_WORK_INIT_HARD(rto_push_irq_work_func);
 #endif
 
 	rd->visit_gen = 0;
