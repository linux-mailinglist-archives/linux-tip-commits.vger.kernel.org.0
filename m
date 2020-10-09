Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3876328826B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgJIGg5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbgJIGfk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:40 -0400
Date:   Fri, 09 Oct 2020 06:35:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k3ALobk26IktQmLEjcoWYznLMuxrKGvN7DRS2e08KBU=;
        b=NSj9fhhuFgPIzvDi7UvxSioWyFkyvUMX7SHKEXJ8gAw1jxclsomSy4J7vFXeFcRgO2tIwN
        O/FF5iIa6UEnKF7zahLdC5msZ/T9zv4ODL0KAKuoh7PrwGzS/8ckVqIaOZcorHpMrspDep
        qg6k3oQ6cqvJdP9PyLLFkNQ+Ou4LVnZpRr7JoD2tTaX+A5eI+NHErtuqGEZJ59DBVojO14
        jEQ1yj3Xyk+wdacKMcjIKae/9WRaihOWQ0mouP3/ZKGY3XLoCjbmkUGEi8fovD6ocG+tfU
        qkqUB6bInDUeGblqnJ3BOfMDc8yVTyv/nVt7OTjl/fUCd3Mi+UQ5GKzc7vqvEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k3ALobk26IktQmLEjcoWYznLMuxrKGvN7DRS2e08KBU=;
        b=CMX1bGrDUOEDjUHRBu+F1gIwCzbedNHN276r7V9jBwoZUSBF7t101ohlRO8N7g1O4kaCeO
        ybWAwv3ALYGzy7Aw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add READ_ONCE() to rcu_do_batch() access to
 rcu_cpu_stall_ftrace_dump
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533821.7002.17438847331239262870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1ef5a442a113d140580b3b8bbd6f50c9f7746397
Gitweb:        https://git.kernel.org/tip/1ef5a442a113d140580b3b8bbd6f50c9f7746397
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 23 Jun 2020 20:57:59 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:08 -07:00

rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_cpu_stall_ftrace_dump

Given that sysfs can change the value of rcu_cpu_stall_ftrace_dump at any
time, this commit adds a READ_ONCE() to the accesses to that variable.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a1780a6..0fde39b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -623,7 +623,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(gps);
-		if (rcu_cpu_stall_ftrace_dump)
+		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
 
 	} else if (rcu_gp_in_progress() &&
@@ -632,7 +632,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2, gps);
-		if (rcu_cpu_stall_ftrace_dump)
+		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
 	}
 }
