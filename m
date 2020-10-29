Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74C829E9A8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgJ2Kwa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgJ2Kvu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:50 -0400
Date:   Thu, 29 Oct 2020 10:51:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Z5SejojEcxaW3DEy/Oi7n0gFcnZbOoAuhMAMFANUr28=;
        b=Sg7FMWvpp10hy4r5Cq7ubukSRyvmlRVLhab5ou2oh7lP4B/ZzJdzfD7lTbefQZdbg1mUyh
        6vUUwWqmnOG8pD9Q2aLa4c/GdOmuHzKDAz61i38P07EWVKIBfyHdBKapgRvhOK8PUHT46R
        p8l5TmyDLivY+9et30Qy5ye1PN72u8wvWF4NArXAqKyGp1E/ZPCsr16APsjFlnpWIswnUw
        4w/VscFKSwu+JwIRoqN94Z9n5tTw2yKv4++ntD8WBgvKdc72rOFRsUaLZ5AdiGBhVLEUnM
        V1pzXgekGC2lyeEbS3x/BNhDL7LrnWlN11RJdBvDY8hI8JyIle1spHDAjBpnEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Z5SejojEcxaW3DEy/Oi7n0gFcnZbOoAuhMAMFANUr28=;
        b=UhTLVYt4bxK/hfa3fpZs/i5VKjznfLgT6hVsoJaaBCd2FXlEGrnqfixyw6ZVzlhUl8d+sh
        4hKYOMHRitvlYhCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Exclude the current CPU from find_new_ilb()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160396870806.397.17543198051603219100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     45da7a2b0af8fa29dff2e6ba8926322068350fce
Gitweb:        https://git.kernel.org/tip/45da7a2b0af8fa29dff2e6ba8926322068350fce
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 10:48:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:30 +01:00

sched/fair: Exclude the current CPU from find_new_ilb()

It is possible for find_new_ilb() to select the current CPU, however,
this only happens from newidle balancing, in which case need_resched()
will be true, and consequently nohz_csd_func() will not trigger the
softirq.

Exclude the current CPU from becoming an ILB target.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9368d1..cd9a37c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10056,6 +10056,10 @@ static inline int find_new_ilb(void)
 
 	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
 			      housekeeping_cpumask(HK_FLAG_MISC)) {
+
+		if (ilb == smp_processor_id())
+			continue;
+
 		if (idle_cpu(ilb))
 			return ilb;
 	}
