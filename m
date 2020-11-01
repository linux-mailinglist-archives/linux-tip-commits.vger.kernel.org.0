Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46B82A1FBF
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKARA0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgKARAO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D200C061A04;
        Sun,  1 Nov 2020 09:00:14 -0800 (PST)
Date:   Sun, 01 Nov 2020 17:00:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vVc6aI9b/++9qrb3I5qS6nBqM6575aUd+PIYwEhiUGQ=;
        b=Gw3JV8tZGckfkd7M+bqCbvarcqw22QTqE8tEyVa0CM5hRJmHanFDre7/X3F2BMTNafAwl3
        lDym3MEr+o2n3jQbqiYhN0+nw1xGeSqSHS/B0cLg5Vj9/HIJ3NSlNKoTSCYaRhnDxbVrSL
        883MiwbSfULtww3qyQgZ2MXT4A83/++hmdb8YA6El6Zyxa0ma7mruq2hifVg6ljBeAbr5G
        I4NBJ6VL3uEx51okID67v3owLdfoE6h6yDJq+GQL6MfHnDzCIwDx4Q1xoTxq+coQ41AfDJ
        RqEfnMfj900PLzzUC7xoq1DnlO57/2/8lJdA4BS2ljFXwph9KGHsbosgmGlXbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vVc6aI9b/++9qrb3I5qS6nBqM6575aUd+PIYwEhiUGQ=;
        b=GYy9B9Ln7puRkzhW6J2jyMWsbebaClvV8Z3lna7CVA+WcFynoPE2/tLJxfig6V+iHJBmrv
        oQWaIGoeb7g0VsCg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/mips: Drop selection of IRQ_DOMAIN_HIERARCHY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160425001157.397.2762632010762962787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     d26dd4131d0d6ad7aa294a7f8d18782b47c27c93
Gitweb:        https://git.kernel.org/tip/d26dd4131d0d6ad7aa294a7f8d18782b47c27c93
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 16 Oct 2020 09:28:23 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Oct 2020 10:51:12 +01:00

irqchip/mips: Drop selection of IRQ_DOMAIN_HIERARCHY

Now that GENERIC_IRQ_IPI selects IRQ_DOMAIN_HIERARCHY, there is no
need to have this conditional select for IRQ_MIPS_CPU. Similarily,
MIPS_GIC only needs selecting GENERIC_IRQ_IPI.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index cd734df..38785a0 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -180,7 +180,6 @@ config IRQ_MIPS_CPU
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
-	select IRQ_DOMAIN_HIERARCHY if GENERIC_IRQ_IPI
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config CLPS711X_IRQCHIP
@@ -307,7 +306,6 @@ config KEYSTONE_IRQ
 config MIPS_GIC
 	bool
 	select GENERIC_IRQ_IPI
-	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
 config INGENIC_IRQ
