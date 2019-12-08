Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0761162B4
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Dec 2019 16:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLHO7x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Dec 2019 09:59:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfLHO6q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:46 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy14-0000Vi-L1; Sun, 08 Dec 2019 15:58:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8BB951C2889;
        Sun,  8 Dec 2019 15:58:32 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:32 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, riscv: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-riscv@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-17-bigeasy@linutronix.de>
References: <20191015191821.11479-17-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711242.21853.7571841063567586614.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     29ff64929e6caf3a6df8e719aa5b9dc36e8e407a
Gitweb:        https://git.kernel.org/tip/29ff64929e6caf3a6df8e719aa5b9dc36e8e407a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:34 +01:00

sched/rt, riscv: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org
Link: https://lore.kernel.org/r/20191015191821.11479-17-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/riscv/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index a1349ca..dd61bb2 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -155,7 +155,7 @@ _save_context:
 	REG_L x2,  PT_SP(sp)
 	.endm
 
-#if !IS_ENABLED(CONFIG_PREEMPT)
+#if !IS_ENABLED(CONFIG_PREEMPTION)
 .set resume_kernel, restore_all
 #endif
 
@@ -304,7 +304,7 @@ restore_all:
 	sret
 #endif
 
-#if IS_ENABLED(CONFIG_PREEMPT)
+#if IS_ENABLED(CONFIG_PREEMPTION)
 resume_kernel:
 	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
 	bnez s0, restore_all
