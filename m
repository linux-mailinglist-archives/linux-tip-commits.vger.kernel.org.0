Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C726C6C3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgIPSDJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgIPSCx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 14:02:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0021C014B22;
        Wed, 16 Sep 2020 06:25:41 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:21:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600262520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37tQsIlHlxymyLmHuJB2eTPFlu9JP4zQdFpzOyYo/a8=;
        b=I3D/3x35JTn8zDdTcFIj7l4ERf0/Yp5tBsMDsyycacottKhxxern1WXWzF293HQ+RLMJ20
        c4gLO8ZA7ahxu3PDHlcl1D4x6vvWY0A+ROIkQQgRAzItHGV7RUE42xIsd9uLkcgXDW//AH
        pXlmbfhk+0RPLZtsDL2oBF5pLaMtvHy/64Me3iLxgpSVrt9fqZYGDwG/KWqynSjM2vxKBn
        Iifwy8WD392QuuHN+F30A8FZIFfoJqLVwtzva1QWLdxFrFaZ92luuVeLC90VonrLaJNsJB
        ReqtTjpQ3h1AXsamjLdpCSs4+9f3e+GAyzyHI3zovioo336SfIFIZxsCQv5tuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600262520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37tQsIlHlxymyLmHuJB2eTPFlu9JP4zQdFpzOyYo/a8=;
        b=D1uRzI2IGQ7yd+/CylkXXmzYy9NKximKCz1Ya5Qvf9racmZYhqbVpchF9szgLL13t4/h6X
        KPw0Mf3el/jjAoDw==
From:   "tip-bot2 for Jiafei Pan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Add debug check to __raise_softirq_irqoff()
Cc:     Jiafei Pan <Jiafei.Pan@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200814045522.45719-1-Jiafei.Pan@nxp.com>
References: <20200814045522.45719-1-Jiafei.Pan@nxp.com>
MIME-Version: 1.0
Message-ID: <160026251907.15536.10650431255857233346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     cdabce2e3dff7e4bcef73473987618569d178af3
Gitweb:        https://git.kernel.org/tip/cdabce2e3dff7e4bcef73473987618569d178af3
Author:        Jiafei Pan <Jiafei.Pan@nxp.com>
AuthorDate:    Fri, 14 Aug 2020 12:55:22 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 15:18:56 +02:00

softirq: Add debug check to __raise_softirq_irqoff()

__raise_softirq_irqoff() must be called with interrupts disabled to protect
the per CPU softirq pending state update against an interrupt and soft
interrupt handling on return from interrupt.

Add a lockdep assertion to validate the calling convention.

[ tglx: Massaged changelog ]

Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200814045522.45719-1-Jiafei.Pan@nxp.com

---
 kernel/softirq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index bf88d7f..09229ad 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -481,6 +481,7 @@ void raise_softirq(unsigned int nr)
 
 void __raise_softirq_irqoff(unsigned int nr)
 {
+	lockdep_assert_irqs_disabled();
 	trace_softirq_raise(nr);
 	or_softirq_pending(1UL << nr);
 }
