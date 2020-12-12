Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66722D86A8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394931AbgLLNDi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438959AbgLLNAa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B9C0611C5;
        Sat, 12 Dec 2020 04:58:45 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ar8fQR8tzt3kmR0zT9eYGLu2Q+C7Rd2UxtUaUNbrmD8=;
        b=bB0vgFZuePzpN6YBsGeHMciro/XCsVeEF2QpW/86Il33AZtiXOX7gnqSvOohT6tzC5uIXO
        /XBG8Ky+vtLsydF0Ae0fR3SijWaHFmYFaLZ4aPJUbnpOJYCEARLelg1F+2dFcTl0TP9I1z
        zSO19CbtcyqqAGqBXlwJxA7JJ19K5P4uUaVUH+NmV2YMe0/sYF29mUPLSfrnSMa+A3Pi4o
        RnQE/9HFORjY5/sNiJC1P43EoLu+Bqi2R0BszLtCd554WvaTkymR6zSdSoNcHUFQ2M50Pq
        i7s/6L4WtyAlLq45MCvZlGLcZxcYlRW0Zd+o1z3hXCF619c1zJbwki0UYWenOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ar8fQR8tzt3kmR0zT9eYGLu2Q+C7Rd2UxtUaUNbrmD8=;
        b=M6LgdEy6+3G0+8E1PvfvJuwVUaIY6E7IgKSr4qXt20JBVbOpGNpDPvZl+1mQKw6vQmmF/l
        zNPbL7R/DLsRaHDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ARM: smp: Use irq_desc_kstat_cpu() in show_ipi_list()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201210194043.454288890@linutronix.de>
References: <20201210194043.454288890@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791988.3364.2156312134993010963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fe80f1d579dfd4edf78a66c3bd3befa985b4b02b
Gitweb:        https://git.kernel.org/tip/fe80f1d579dfd4edf78a66c3bd3befa985b4b02b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:03 +01:00

ARM: smp: Use irq_desc_kstat_cpu() in show_ipi_list()

The irq descriptor is already there, no need to look it up again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201210194043.454288890@linutronix.de

---
 arch/arm/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48099c6..e66c46a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -550,7 +550,7 @@ void show_ipi_list(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
 
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
 
 		seq_printf(p, " %s\n", ipi_types[i]);
 	}
