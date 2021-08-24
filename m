Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADEC3F58D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Aug 2021 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhHXHVQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Aug 2021 03:21:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhHXHVP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Aug 2021 03:21:15 -0400
Date:   Tue, 24 Aug 2021 07:20:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629789630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWkuQfvBFrQmu7lvbFbCrfOPgLtNKPOCEXflAo8T5Jw=;
        b=drLgETfhJj4UTFMR0g63noDeYWW4Tt4pkmXC7E6N/6Q19e3IVACvAQkwyFAVOJbBzgnWvy
        yz2lg60tborjiJUpUSbV91yFiV4O7dX0VjYswCp0HYGJXokicOn8ZMqbOE53WnysPzY96c
        bmG5GdixNX8oAUalx2/E6ca1A9buwBDX85mNXqwm7eB+dg5/HHPpk78v/sScYY1Cqn6sxq
        K575R9livQOzxTjSo1PFw9sHjCMuDtmaZIK41hpNq+sE1ovTkRa+yXZd/Tp3tA0Zs8ue6f
        Men8PgvERKMgaWLLkut71p8+XGdcsBRayMtw/tB+Bhz7IQC8SYD2Qp1bieL3Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629789630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWkuQfvBFrQmu7lvbFbCrfOPgLtNKPOCEXflAo8T5Jw=;
        b=m7CeCUQkIOT0f8mipTdz+yunBSN3rPUFqxLCEZrcimCpyZXrJFGtxlrZo0+CVuTVQjK+Vu
        Y+u4w1pMbeUHEgBw==
From:   "tip-bot2 for Lee Jones" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/cpuhotplug: Demote debug printk to KERN_DEBUG
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210816134817.1503661-1-lee.jones@linaro.org>
References: <20210816134817.1503661-1-lee.jones@linaro.org>
MIME-Version: 1.0
Message-ID: <162978962944.25758.8716579313615137898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     88ffe2d0a55a165e55cedad1693f239d47e3e17e
Gitweb:        https://git.kernel.org/tip/88ffe2d0a55a165e55cedad1693f239d47e3e17e
Author:        Lee Jones <lee.jones@linaro.org>
AuthorDate:    Mon, 16 Aug 2021 14:48:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Aug 2021 09:16:20 +02:00

genirq/cpuhotplug: Demote debug printk to KERN_DEBUG

This sort of information is only generally useful when debugging.
No need to have these sprinkled through the kernel log otherwise.

Real world problem:

  During pre-release testing these have an affect on performance on
  real products.  To the point where so much logging builds up, that
  it sets off the watchdog(s) on some high profile consumer devices.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210816134817.1503661-1-lee.jones@linaro.org
---
 kernel/irq/cpuhotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 02236b1..39a41c5 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
 		raw_spin_unlock(&desc->lock);
 
 		if (affinity_broken) {
-			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
+			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
 					    irq, smp_processor_id());
 		}
 	}
