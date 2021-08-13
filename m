Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6741A3EB446
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Aug 2021 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbhHMKtl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 13 Aug 2021 06:49:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhHMKtl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 13 Aug 2021 06:49:41 -0400
Date:   Fri, 13 Aug 2021 10:49:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628851753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AMLllHMycNcC4hKfM/vOPH/POFQGseaOT5hx0towTLU=;
        b=xLNxxVfTr0107P72SKWE0BCXpQiC0TPqAgtX+Y+HKl7lVbUpOWYbX/MXQSHnlSgmZBTUtW
        zVaAt7Bv5aQLHGRPVz2kEsHUMW/0ZrTvoUOor6ed0V9WPLOi+KjRRIm+CnFCZOVTvg/wyW
        rYtoGhKwjON315pgOdWjcCtv7JpFPPnqjBV1dlU8+A2+8X5tAk3GF/2o3k/qBiH7bn87vY
        YleYCvpVOE6sZzwRCtmvF9fFvygqeZyTZ/EM2EvKSaIdR9SeFjj+GeVrccfYtSNcxpn7uL
        MlYwLhYCykoJvPdTZW77KwD5PG3K+6X2psm2DDGHCHT5Azo7WuvnhsZiyfKW1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628851753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AMLllHMycNcC4hKfM/vOPH/POFQGseaOT5hx0towTLU=;
        b=TGKpTh2OMo5rB2eGEhh1PXZ4vy6V6YFR2+eOrh7hEL8u4E4Rl4UH/dbATNMIs0jZISIz8m
        gGj551PO1Rsv03Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix kernel doc indentation
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
MIME-Version: 1.0
Message-ID: <162885175277.395.17743129255104361597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     04c2721d3530f0723b4c922a8fa9f26b202a20de
Gitweb:        https://git.kernel.org/tip/04c2721d3530f0723b4c922a8fa9f26b202a20de
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Aug 2021 12:40:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Aug 2021 12:45:13 +02:00

genirq: Fix kernel doc indentation

Fixes: 61377ec14457 ("genirq: Clarify documentation for request_threaded_irq()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 34a66c4..27667e8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2107,9 +2107,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *
  *	IRQF_SHARED		Interrupt is shared
  *	IRQF_TRIGGER_*		Specify active edge(s) or level
- *	IRQF_ONESHOT		Do not unmask interrupt line until
- *				thread_fn returns
- *
+ *	IRQF_ONESHOT		Run thread_fn with interrupt line masked
  */
 int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 			 irq_handler_t thread_fn, unsigned long irqflags,
