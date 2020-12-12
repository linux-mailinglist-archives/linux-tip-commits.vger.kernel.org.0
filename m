Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B382D2D86AC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436591AbgLLNH0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438934AbgLLNAK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84C1C061285;
        Sat, 12 Dec 2020 04:58:44 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hivkejmJ8hrdj1l0gV/S+9BbkQh93/D1HgRshhhoMC0=;
        b=H28QUNpvhg1aK9DshEWtoBTaLUth7e1A6EizKCaJTacsRtGTREC3G9g3ab7uywweJ9Dehx
        I6ZASvQrvXvzFWOsPHVbVi693vTm3JUixDRjQMm9N3+7xuPnNDTzyd9eJq8UTY2j3w7Kgf
        QMxpnBBIQCkuXXiCdLuyUbnKcwTtZJTis16ph/kDHreSV1YFD1BiDbNursyKk88kL9SH+C
        MISHc1l2qBen5ocK1PzhjW0SPUomMzVCp6ZzwS7oF5hF5K5hZCjqHtyYdrefslCZjBNuSG
        id9FQy1pD0my3Qfb8pRzPRXy+M1LtdC/5OLUDLasRtbhk77ZB28jNGH3EpcqQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hivkejmJ8hrdj1l0gV/S+9BbkQh93/D1HgRshhhoMC0=;
        b=VQ9gT5ZMO+Hugt1AWepmtpI9dTBQLMHFJfLHSxyfEr7+ivgZplc6+8Ic+gJjjvfUmQm1hb
        OzTIEc37xrQ6kyDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] s390/irq: Use irq_desc_kstat_cpu() in show_msi_interrupt()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194043.769108348@linutronix.de>
References: <20201210194043.769108348@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791905.3364.9957041212616902271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7a0a6b22431b36549151df8f30cec4f667a018fc
Gitweb:        https://git.kernel.org/tip/7a0a6b22431b36549151df8f30cec4f667a018fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:04 +01:00

s390/irq: Use irq_desc_kstat_cpu() in show_msi_interrupt()

The irq descriptor is already there, no need to look it up again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20201210194043.769108348@linutronix.de

---
 arch/s390/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 3514420..d9cd898 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -124,7 +124,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	seq_printf(p, "%3d: ", irq);
 	for_each_online_cpu(cpu)
-		seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
+		seq_printf(p, "%10u ", irq_desc_kstat_irq(desc, cpu));
 
 	if (desc->irq_data.chip)
 		seq_printf(p, " %8s", desc->irq_data.chip->name);
