Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAE922F0D7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jul 2020 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgG0OZP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Jul 2020 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732389AbgG0OZN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Jul 2020 10:25:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500DCC0619D2;
        Mon, 27 Jul 2020 07:25:13 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:25:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595859911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMD+An+yRJFnhJevzCpA9ASEr2Q20FpshnheoKFP3lk=;
        b=vLbPGjbDu2xic82PJEQ82vZLPeFAmFqYivgCm3yc34Cj16gmBHbwTTTHFiqTA1WMuXH/QX
        gXkpT0pMoEUlUucqKl1a/NiojyhBygGLmFH6kQoRvjPiK89gCtrztGXI7sXsaTZQqOKd3m
        Lofu5ZC0RjLd/7/vn4d/bQwvuMd1gQrRHsVagm55eQbUW0yR0E3y5lATi0gCJf/yPRvNGm
        GT/Jt9wfAUlz1WBEnZMD247e/B0Mow2VjDM3efkG527VkUUOig648RuYH68STzFOWUAmB2
        9RWMkmd4R30aCPVBgMf1gjMdhHeQQU8+bxWy2vybPWhCocfM1hCNgsegsnHKhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595859911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMD+An+yRJFnhJevzCpA9ASEr2Q20FpshnheoKFP3lk=;
        b=IOBF3Bohu/1/UggaMobfJVuRHvPh1liRAcuGVDP/hHcgLq3VqJMpBOdUPgworZ3sud2/a5
        JngDew5W/0T70ECA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/debugfs: Add missing irqchip flags
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <874kpvydxc.wl-maz@kernel.org>
References: <874kpvydxc.wl-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <159585991070.4006.15343271710137526648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     aa251fc5b936d3ddb4b4c4b36427eb9aa3347c82
Gitweb:        https://git.kernel.org/tip/aa251fc5b936d3ddb4b4c4b36427eb9aa3347c82
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 25 Jul 2020 13:30:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Jul 2020 16:20:40 +02:00

genirq/debugfs: Add missing irqchip flags

Recently introduced irqchip flags lack the corresponding printouts in
debugfs. Add them.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/874kpvydxc.wl-maz@kernel.org


---
 kernel/irq/debugfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 4f9f844..b95ff5d 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -112,6 +112,7 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_AFFINITY_SET),
 	BIT_MASK_DESCR(IRQD_SETAFFINITY_PENDING),
 	BIT_MASK_DESCR(IRQD_AFFINITY_MANAGED),
+	BIT_MASK_DESCR(IRQD_AFFINITY_ON_ACTIVATE),
 	BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
 	BIT_MASK_DESCR(IRQD_CAN_RESERVE),
 	BIT_MASK_DESCR(IRQD_MSI_NOMASK_QUIRK),
@@ -120,6 +121,10 @@ static const struct irq_bit_descr irqdata_states[] = {
 
 	BIT_MASK_DESCR(IRQD_WAKEUP_STATE),
 	BIT_MASK_DESCR(IRQD_WAKEUP_ARMED),
+
+	BIT_MASK_DESCR(IRQD_DEFAULT_TRIGGER_SET),
+
+	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
 };
 
 static const struct irq_bit_descr irqdesc_states[] = {
