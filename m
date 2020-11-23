Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5282C18EB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgKWWwi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbgKWWvw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:52 -0500
Date:   Mon, 23 Nov 2020 22:51:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PPHSCnJVnvJlVz3aoEklJjLL2DbcpBjoTxpAipI3SI=;
        b=BdTv1zT0RlLUxsuwWScOTRJr3JiZXYVlTHp6s/Klh8GFuy2uljYZxDmkxdAUpc6MgjWylL
        eksex5tO0LYA1cwANTo4DquoAy8pIzAyaPBGEgdQPh/gou5TSEYC525VBHncSLA/lIIoaT
        3DPWvcoTBaCBVx4PbhSGUwQzB0J3VLe21d0/qS3CakHgTgr4qKLCuHZC8SCwiXKyXnBo1R
        svEhOlwEtd+zoef+bsd2Yi+IUoQzmTvv7JM0STg2qzsYCYLo227bIF4IlUcWJwL4cEP2Wb
        0DegSOo+SEvDZuHaX2fJxbQ22dGRTeZ3JdHzzj/6xknIu0YctsS7012ZZXoZ6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PPHSCnJVnvJlVz3aoEklJjLL2DbcpBjoTxpAipI3SI=;
        b=Fx+iGdV3F4K80NWrmZNJG6zvBKMj7TZiwm7FXdn5slWeNGWLrhgR+95cEh5mSeBuQubrFW
        oJDgY/j4KwMMSkAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] sh: Get rid of nmi_count()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141732.844232404@linutronix.de>
References: <20201113141732.844232404@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190915.11115.15737801876796548430.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fe3f1d5d7cd3062c0cb8fe70dd77470019dedd19
Gitweb:        https://git.kernel.org/tip/fe3f1d5d7cd3062c0cb8fe70dd77470019dedd19
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:05 +01:00

sh: Get rid of nmi_count()

nmi_count() is a historical leftover and SH is the only user. Replace it
with regular per cpu accessors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141732.844232404@linutronix.de

---
 arch/sh/kernel/irq.c   | 2 +-
 arch/sh/kernel/traps.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 5717c7c..5addcb2 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", nmi_count(j));
+		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 9c3d32b..f5beecd 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -186,7 +186,7 @@ BUILD_TRAP_HANDLER(nmi)
 	arch_ftrace_nmi_enter();
 
 	nmi_enter();
-	nmi_count(cpu)++;
+	this_cpu_inc(irq_stat.__nmi_count);
 
 	switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
 	case NOTIFY_OK:
