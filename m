Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45562D86C5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407428AbgLLNLB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:11:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41180 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438886AbgLLM70 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:26 -0500
Date:   Sat, 12 Dec 2020 12:58:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wt/xGtAx0yObD6IMDRCax7tOnAFss8QqCY6/3vXrBL4=;
        b=Lmh2X/BPsUfF4XkkwvmQxhyuSSNlYylkegGPAhMwSVq0pnf3RGJcPaY7QoCAGB6InDAsXx
        eLHvlORiyxqh1huuuCnMCtKIjrTxdQ6bU2mpa2YyGRLeeHiRnuHgapNNYNZh3OooSh+NHt
        ZUCEQcqiOh60SThXTJkXNenzxARvdNnIwGOTJU8uPRiqhPWcqqXr7pzrb6gjpUG0CPTP0j
        goU27x6RGH256WWzMB7mWzFLCdx4EDGDgtmC+K75g16UirMbTAqwp8wQsVuq+vCupRvEWI
        VHFVhO+3B9g70fBdzWc6N0jENPeuCrJ3Z+Airw+G/muYn+MleXc4mws/fe2NvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wt/xGtAx0yObD6IMDRCax7tOnAFss8QqCY6/3vXrBL4=;
        b=OB6P/dbToXznLqz8+EsG0NlBbgTP0jrdd0STY6G0RqDnQs/8rGx2HCopHrdGus4KphDHJp
        j2qB5FkTZ297mQCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove export of irq_to_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194045.551428291@linutronix.de>
References: <20201210194045.551428291@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791415.3364.306026672971489829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f07147b162a1cec348d8a9a7e7e73fdf7ce5f88b
Gitweb:        https://git.kernel.org/tip/f07147b162a1cec348d8a9a7e7e73fdf7ce5f88b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:26:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:07 +01:00

genirq: Remove export of irq_to_desc()

No more (ab)use in modules finally. Remove the export so there won't come
new ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194045.551428291@linutronix.de

---
 kernel/irq/irqdesc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 18dd779..5d766f4 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -352,7 +352,6 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 {
 	return radix_tree_lookup(&irq_desc_tree, irq);
 }
-EXPORT_SYMBOL(irq_to_desc);
 
 static void delete_irq_desc(unsigned int irq)
 {
