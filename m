Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7FC2D86AA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbgLLNHU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438935AbgLLNAK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E47C061248;
        Sat, 12 Dec 2020 04:58:44 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h76AYyVsfHrTAasUn8EqxBNoappjyH5G6kqQojSw/CQ=;
        b=s/hiXrz5kH8yH8vM8Nt9/FQWR+yKMiSktc5+sifAFqqkF+KeQ72LEsFK1cq7mMAC3e6UDs
        qmkVKTSJy52i85MvTehvGR/Nno1J0iV4hIsSTJb2JLbUMnuhCu2oX1p28DXSI89KFYoFxt
        ajcA7Ik3ePFtzEC7CMbUcIYY3FzfKjWdEQUR8vDI5iVTZgO0RNbKwtp06A6Qptf55pOIbr
        fmc/kQ92+8AdcmRWONUzE0m4fIjEVHmuRlTjJQ3LiIwZGM4sI5AUEzSx77ESQQZmv1Tngj
        ehMhMPg0txsP/BiLA1mmDLcUtyUEXpDE81dHvct4sXS9qQ7QJR3MEbdA5Yu8dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h76AYyVsfHrTAasUn8EqxBNoappjyH5G6kqQojSw/CQ=;
        b=H526TrxfuLWauij9/CNJEZ26vhjeIlLGPXJSNl0/Xt1iiOKDkeHbKrhRHjMQgCuP5OS5x7
        pB7rmLwJj3csC3BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201210194043.546326568@linutronix.de>
References: <20201210194043.546326568@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791958.3364.3792398745015019197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2f516e34383d0e97ced094d18424838181ce51b7
Gitweb:        https://git.kernel.org/tip/2f516e34383d0e97ced094d18424838181ce51b7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:04 +01:00

arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()

The irq descriptor is already there, no need to look it up again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201210194043.546326568@linutronix.de

---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 09c96f5..95c93e6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -809,7 +809,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
 		seq_printf(p, "      %s\n", ipi_types[i]);
 	}
 
