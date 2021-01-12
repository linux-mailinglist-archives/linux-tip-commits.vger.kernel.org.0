Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574B92F32C3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Jan 2021 15:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbhALOPd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 09:15:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbhALOPd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 09:15:33 -0500
Date:   Tue, 12 Jan 2021 14:14:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610460890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/jFzWa0BcooDpIR8auJzgjzenvo/u0Q391Wtg/QO3Y=;
        b=MJE6PAhw9TP/gvD50FfB2xwkYT+QyBUgvUNcu+g/bgLU8IJXzetEWhNAHxHi4aeeYFB0qn
        SoBLoJctnLpee1VysLTK2fELFGVvdzy14nF4YuWkeZINTpovtqLmwi3ckrC3b2zCqEZ4+z
        xGWNDy5+y47BnSTFOMKjt7ypHbZZOl2AX1Tc1xealn3gAYkHnTlnTD8lJATgka5zUjf0SE
        YHMczVfmDU81h3pTwvH4iOana4XEsfRP40Q2uL/I9sy8FvEHTTeSQcMHm31jBKUkOeaTIJ
        7ez57DqpusK8jyLaNG5vGlOjLpxGhKmYgYcMuFMrwcDJuxALQniTLCnjOnQcJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610460890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/jFzWa0BcooDpIR8auJzgjzenvo/u0Q391Wtg/QO3Y=;
        b=OqTMpI1yKj9u1SknJLeLja53sarl/H0K4mUBNIiwx+oxQJeOA7+p4G47hAyNG5cJ9jjiLf
        xVi3YUIfmoisnTDA==
From:   "tip-bot2 for Hao Lee" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/entry: Remove now unused do_IRQ() declaration
Cc:     Hao Lee <haolee.swjtu@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210103030834.GA15432@haolee.github.io>
References: <20210103030834.GA15432@haolee.github.io>
MIME-Version: 1.0
Message-ID: <161046088982.414.245132272230243029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     11aa1415d8bd2920ce884356479eabbd64b1df2a
Gitweb:        https://git.kernel.org/tip/11aa1415d8bd2920ce884356479eabbd64b1df2a
Author:        Hao Lee <haolee.swjtu@gmail.com>
AuthorDate:    Sun, 03 Jan 2021 03:08:34 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 Jan 2021 14:37:37 +01:00

x86/entry: Remove now unused do_IRQ() declaration

do_IRQ() has been replaced by common_interrupt() in

  fa5e5c409213 ("x86/entry: Use idtentry for interrupts")

Remove its now unused declaration.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210103030834.GA15432@haolee.github.io
---
 arch/x86/include/asm/irq.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 528c8a7..76d3896 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -40,8 +40,6 @@ extern void native_init_IRQ(void);
 
 extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
-extern __visible void do_IRQ(struct pt_regs *regs, unsigned long vector);
-
 extern void init_ISA_irqs(void);
 
 extern void __init init_IRQ(void);
