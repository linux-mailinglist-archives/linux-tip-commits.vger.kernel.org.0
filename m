Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C32D8DB2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgLMOF7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 09:05:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgLMOF7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 09:05:59 -0500
Date:   Sun, 13 Dec 2020 14:05:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607868317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8qeVt2rx1xomEFfNQBZEl0wuqlJ2B0W9cuSSPb9aJOg=;
        b=yVHD9S5jqeZB4g9T1mCbI7B26GvVLk5U7QwkbTi/HwuTb57hg1srE1lER4x/l7ZuAHnT6R
        DToqa2F7ZkKXujGwvNdblKnlhr3sYwb3mdKhN5j6Cf37MR3QKscEy+1lPBpPE1l9C4etBK
        8apLA0ohBXQn+EjUqyqoWmkau3nB/MUovOs2tHU0EJLNGKk4YymWok6C9dEP+TvRrrRi0m
        DKDn9csskSSPE3B6lAwKJ1PnLVCBA6RRE4o/QgyBV2Wc3ei8bG3S0TI7lFT1kuQqmVBAfY
        qfH0UfcHnR+QHIJvXBt9Tae4bx8FXGWgx9MujgMtGNWxmHj5fbwbIANQ9AmQeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607868317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8qeVt2rx1xomEFfNQBZEl0wuqlJ2B0W9cuSSPb9aJOg=;
        b=py018k6dfvZ2c5JQi4h6+d8z99dWm9afZ8JlkpXNrm5kivbja8I33ZuswExvCmmNLsM4Nb
        5vT1tITAJh8YWiDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] s390/irq: Use the correct irq stats accessor
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
MIME-Version: 1.0
Message-ID: <160786831611.3364.16380497402097854439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5684f2a950727020ebaece04fe89e00d04e3b479
Gitweb:        https://git.kernel.org/tip/5684f2a950727020ebaece04fe89e00d04e3b479
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Dec 2020 14:08:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 13 Dec 2020 14:58:44 +01:00

s390/irq: Use the correct irq stats accessor

It's irq_desc_kstat_cpu() and not irq_desc_kstat_irq().

Fixes: 7a0a6b22431b ("s390/irq: Use irq_desc_kstat_cpu() in show_msi_interrupt()")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/s390/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index d9cd898..f8a8b94 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -124,7 +124,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	seq_printf(p, "%3d: ", irq);
 	for_each_online_cpu(cpu)
-		seq_printf(p, "%10u ", irq_desc_kstat_irq(desc, cpu));
+		seq_printf(p, "%10u ", irq_desc_kstat_cpu(desc, cpu));
 
 	if (desc->irq_data.chip)
 		seq_printf(p, " %8s", desc->irq_data.chip->name);
