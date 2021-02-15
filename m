Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393BE31BB99
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhBOO5L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhBOO5C (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD56C061224;
        Mon, 15 Feb 2021 06:55:56 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5Pv+HNBdZmEXhtET5Rz1cTnS+GLo01946ivogaxbag=;
        b=ob9vfAuo39HdQqa3iueDn9E73YR650rhnxv5/tP0TaENKy319W3wy2yV6lOyC1nn/WeDUG
        YC2GKi/CEJapcWFmEUA+H/UEDfJqnRtY+rg+LKpzfPNA7oNYf5+OrvPm/R2jMKhC+86dK6
        4PYHoo0o9CCxjWoOmksH5kpLeh0V+bLLMdgMm5tyCkNeggmzq3uhZNrxbzDovFbhmJ10IW
        VnLM02Vkz10A8cq00BlZtknwM9X8DxXOThsEz6L7uEA8dIpTf7lzg6O6Yh5vrZbCNRGsHI
        UgbI+7k/7M3m8FRfcMmKq2nayou0jGXH78OKsGXY/4z4B6XStdGHghxHabWpOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5Pv+HNBdZmEXhtET5Rz1cTnS+GLo01946ivogaxbag=;
        b=u6RCcKCgzjwE50uDZYsm24ne/rereGOBQQBTLI8YkofKTDjozO+2R8DxUS6p6H7E9RXnPX
        vFpkBwz4BmG4ziBA==
From:   "tip-bot2 for Emil Renner Berthing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Use new tasklet API for resend_tasklet
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210123182456.6521-1-esmil@mailme.dk>
References: <20210123182456.6521-1-esmil@mailme.dk>
MIME-Version: 1.0
Message-ID: <161340095421.20312.15029132758508383789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c260954177c4f1926b423823bca5728f19b40d67
Gitweb:        https://git.kernel.org/tip/c260954177c4f1926b423823bca5728f19b40d67
Author:        Emil Renner Berthing <kernel@esmil.dk>
AuthorDate:    Sat, 23 Jan 2021 19:24:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Jan 2021 11:18:04 +01:00

genirq: Use new tasklet API for resend_tasklet

This converts the resend_tasklet to use the new API in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

The new API changes the argument passed to the callback function, but
fortunately the argument isn't used so it is straight forward to use
DECLARE_TASKLET() rather than DECLARE_TASKLET_OLD().

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210123182456.6521-1-esmil@mailme.dk

---
 kernel/irq/resend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 8ccd32a..bd1d85c 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -27,7 +27,7 @@ static DECLARE_BITMAP(irqs_resend, IRQ_BITMAP_BITS);
 /*
  * Run software resends of IRQ's
  */
-static void resend_irqs(unsigned long arg)
+static void resend_irqs(struct tasklet_struct *unused)
 {
 	struct irq_desc *desc;
 	int irq;
@@ -45,7 +45,7 @@ static void resend_irqs(unsigned long arg)
 }
 
 /* Tasklet to handle resend: */
-static DECLARE_TASKLET_OLD(resend_tasklet, resend_irqs);
+static DECLARE_TASKLET(resend_tasklet, resend_irqs);
 
 static int irq_sw_resend(struct irq_desc *desc)
 {
