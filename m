Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052082D86A2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438939AbgLLNAV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438936AbgLLNAK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD9C061257;
        Sat, 12 Dec 2020 04:58:44 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Et3NKmrzxPKNKfeOUEkhsBPlOe8ZxpYmM2+MHsmM+w=;
        b=HVgb+L9fpSLq/IScsoINSy4SjlzSTbcish4LAfx3ENrXuA3ScN0FEYfGtetHHDnXC5+0cm
        Oqj5cSTIYI+2juvkpGWxzddg6R+8oUWXVu84znrByNYHMqWTkWtq89iQqJBQmhESBa35el
        q+wofI/RFjUEBINpSU1yMjkFv9K26fURdYgqXOHmgkZ+G/3MqrYHc+6L5O9+8CFhRRltyI
        3Y+3i3Gc0kt3+wq2i0mHwYOAyF+4uPtDrve1j26rwuawIwckoGmm/PdpUGl2AXC8pk1W+E
        lJ2yU1jwfqT8EZirt4a2lohl2UwXMLCCdHCWTpERAQTW509BSjb/CS4TAi/1Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Et3NKmrzxPKNKfeOUEkhsBPlOe8ZxpYmM2+MHsmM+w=;
        b=ccLGfIp7v4DUK1hx/DM3WHoGrmr/XCWwRbcyep3yAIYzQAxekRN5an7myYC/Azit7GiXEN
        Vidp4QqnSgIfyGAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] parisc/irq: Use irq_desc_kstat_cpu() in show_interrupts()
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-parisc@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194043.659522455@linutronix.de>
References: <20201210194043.659522455@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791931.3364.17864432721014360849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     27fb43cb32d016366d1d87986970d5be7d6607e1
Gitweb:        https://git.kernel.org/tip/27fb43cb32d016366d1d87986970d5be7d6607e1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:04 +01:00

parisc/irq: Use irq_desc_kstat_cpu() in show_interrupts()

The irq descriptor is already there, no need to look it up again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-parisc@vger.kernel.org
Link: https://lore.kernel.org/r/20201210194043.659522455@linutronix.de

---
 arch/parisc/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 15c6207..49cd6d2 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -218,7 +218,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_printf(p, "%3d: ", i);
 
 		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(desc, j));
 
 		seq_printf(p, " %14s", irq_desc_get_chip(desc)->name);
 #ifndef PARISC_IRQ_CR16_COUNTS
