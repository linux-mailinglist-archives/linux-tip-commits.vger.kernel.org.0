Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91112C18E9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbgKWWwi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbgKWWvw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107BAC0613CF;
        Mon, 23 Nov 2020 14:51:52 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:51:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8rgZjFVGbZTiySQP0d1p5lzAg0pPMaZFpFfq78h8Rg=;
        b=xNMBYCDl5kO2Ge6w8diK/WWd4PF2iwuTdWeXCJKPkvSlKt4MvD8mVV/Q9hD/65sGu7P9kX
        61eYm1IewpmFUIMPrzRbcZ5WHq8xCdaYveWwobTEZ+9gYpVv9SPoVplZZaTaObZJ3xMESg
        6uaNL4Tf5CuHbkKRHMy0q5VW7DMXx59TBl6cQeKQxQgkvgVptlmF43i/+Jn+gHxsDQQM+s
        gN+L2woZ07fH0agT1Hmx0UOlECsXSU4G9SkIpGpJyptvArlGU+ZM4zNaQeqaYB2PFTuHgb
        A1rpsyPK01+FG79ycYbeVzjLIULp2VHUwcCkzM1qRCcya7/c8frJWPNgACbkEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8rgZjFVGbZTiySQP0d1p5lzAg0pPMaZFpFfq78h8Rg=;
        b=ukztMMG9yyh1wKcRZlDKTTB3LTuFIkudQzHe2F343NupfxXOrYC/qC5BO1McxjotvBa2po
        d13/ytZbrFR8wFDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] parisc: Remove bogus __IRQ_STAT macro
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141732.680780121@linutronix.de>
References: <20201113141732.680780121@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190975.11115.3653204687525543664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9f112156f8da016df2dcbe77108e5b070aa58992
Gitweb:        https://git.kernel.org/tip/9f112156f8da016df2dcbe77108e5b070aa58992
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:05 +01:00

parisc: Remove bogus __IRQ_STAT macro

This is a leftover from a historical array based implementation and unused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141732.680780121@linutronix.de

---
 arch/parisc/include/asm/hardirq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 7f70395..fad29aa 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -32,7 +32,6 @@ typedef struct {
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define __ARCH_IRQ_STAT
-#define __IRQ_STAT(cpu, member) (irq_stat[cpu].member)
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
 #define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
