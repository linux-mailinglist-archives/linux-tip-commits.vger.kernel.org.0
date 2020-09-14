Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8F2692F3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgINRUM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgINRQY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAABEC061788;
        Mon, 14 Sep 2020 10:16:16 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:16:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQVrCZ4mcp7SJ0BjmotzJ2aqXd6Tqdnv8aQgvLzbuvs=;
        b=gwcvtriqYr8xPQbrZU+6o2uVP6AK10LlT8B61idwDDF6DD4hJTPnv6UtXQdX/4hlJqK6kZ
        WOtLcfZPASN/tg5glZ84q0S8mucSL4E4C9kdD4EOISsYpuuCsjomAnKtZvTelmW3YdL5O0
        /5HPG+8aPXhtjaAwPLCbJjN4kQtyQY5MeFPeeVbvAauPVMzwQGOvMIg+ACNenJ+ArOHTLO
        L1/0PbUNZLpRxcY9Y6tOUuYJM8+FCJbOMxAmxmqVcjMNuBrk9FKg+xAVLm1b309E0bM0vE
        TwjQQtFoLaZa7B+YE6onvaYnZBJ3/NfHvX/WqZuydYyIXJUVm516TKJV5Yq3GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQVrCZ4mcp7SJ0BjmotzJ2aqXd6Tqdnv8aQgvLzbuvs=;
        b=K/1mLFYlku21Q/jxzcYffAvZTnQ5NMYQVeGhPkmk14NfccNPc+KH9FPPzqZ8hx63ZP1UhA
        6AyTdp6VFLTGVFBA==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] kprobes: Remove NMI context check
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870615628.1229682.6087311596892125907.stgit@devnote2>
References: <159870615628.1229682.6087311596892125907.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160010377449.15536.10398989560902081648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     e03b4a084ea6b0a18b0e874baec439e69090c168
Gitweb:        https://git.kernel.org/tip/e03b4a084ea6b0a18b0e874baec439e69090c168
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Sat, 29 Aug 2020 22:02:36 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Sep 2020 11:52:35 +02:00

kprobes: Remove NMI context check

The in_nmi() check in pre_handler_kretprobe() is meant to avoid
recursion, and blindly assumes that anything NMI is recursive.

However, since commit:

  9b38cc704e84 ("kretprobe: Prevent triggering kretprobe from within kprobe_flush_task")

there is a better way to detect and avoid actual recursion.

By setting a dummy kprobe, any actual exceptions will terminate early
(by trying to handle the dummy kprobe), and recursion will not happen.

Employ this to avoid the kretprobe_table_lock() recursion, replacing
the over-eager in_nmi() check.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/159870615628.1229682.6087311596892125907.stgit@devnote2
---
 kernel/kprobes.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a0afaa7..2111382 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1359,7 +1359,8 @@ static void cleanup_rp_inst(struct kretprobe *rp)
 	struct hlist_node *next;
 	struct hlist_head *head;
 
-	/* No race here */
+	/* To avoid recursive kretprobe by NMI, set kprobe busy here */
+	kprobe_busy_begin();
 	for (hash = 0; hash < KPROBE_TABLE_SIZE; hash++) {
 		kretprobe_table_lock(hash, &flags);
 		head = &kretprobe_inst_table[hash];
@@ -1369,6 +1370,8 @@ static void cleanup_rp_inst(struct kretprobe *rp)
 		}
 		kretprobe_table_unlock(hash, &flags);
 	}
+	kprobe_busy_end();
+
 	free_rp_inst(rp);
 }
 NOKPROBE_SYMBOL(cleanup_rp_inst);
@@ -2035,17 +2038,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 	unsigned long hash, flags = 0;
 	struct kretprobe_instance *ri;
 
-	/*
-	 * To avoid deadlocks, prohibit return probing in NMI contexts,
-	 * just skip the probe and increase the (inexact) 'nmissed'
-	 * statistical counter, so that the user is informed that
-	 * something happened:
-	 */
-	if (unlikely(in_nmi())) {
-		rp->nmissed++;
-		return 0;
-	}
-
 	/* TODO: consider to only swap the RA after the last pre_handler fired */
 	hash = hash_ptr(current, KPROBE_HASH_BITS);
 	raw_spin_lock_irqsave(&rp->lock, flags);
