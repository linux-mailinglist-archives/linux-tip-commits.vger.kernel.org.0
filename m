Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6F2A1FB4
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgKARAN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgKARAM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056DC0617A6;
        Sun,  1 Nov 2020 09:00:12 -0800 (PST)
Date:   Sun, 01 Nov 2020 17:00:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQ6lvHJD+OePwiwlrUcBRMbj79KkOxpLdVmqdVRuFgw=;
        b=0YgMeVczDA60g9SFpklnLMW15oNjh+oeb0cGkrhbSze3LfLX5s9+WktRB3/0bjxHfzrbGH
        EZuxgi/XKvGIpZqCKye8iz95HdEDvLCZCUrA5TJU/ISgLGqqn3x0cU/X4pHVUBmqdU5FhM
        BVBS/BDw++pwK70qB1dsLgMocd65D+7tJExiaDmEJPlOCXNl6oMenOcTeyjL8zo9FO/opu
        4EDc3sAhD5/sm03BlHHGj2l2Dmvm/YrZeMLk6q0FI1T5hpSsl2y/O8T0EaUKf5kxwWGdY9
        WbbEuGlRPwOsyix7BRoUm7SsdIm4slXGaVBzbSZmxANYE8sc6v3Bs0QgwnRugg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQ6lvHJD+OePwiwlrUcBRMbj79KkOxpLdVmqdVRuFgw=;
        b=8pDvh9/B1LwhsWGp5m/WD5uRVjwPJT+vftIJRcNbzZLz8biODWHIzWqdEVUdpOFUEg1eYK
        7iCUjcrieE46f8Dw==
From:   "tip-bot2 for Greentime Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sifive-plic: Fix broken irq_set_affinity() callback
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201020081532.2377-1-greentime.hu@sifive.com>
References: <20201020081532.2377-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Message-ID: <160425000981.397.18063893287457447572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a7480c5d725c4ecfc627e70960f249c34f5d13e8
Gitweb:        https://git.kernel.org/tip/a7480c5d725c4ecfc627e70960f249c34f5d13e8
Author:        Greentime Hu <greentime.hu@sifive.com>
AuthorDate:    Tue, 20 Oct 2020 16:15:32 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 25 Oct 2020 12:33:07 

irqchip/sifive-plic: Fix broken irq_set_affinity() callback

An interrupt submitted to an affinity change will always be left enabled
after plic_set_affinity() has been called, while the expectation is that
it should stay in whatever state it was before the call.

Preserving the configuration fixes a PWM hang issue on the Unleashed
board.

[  919.015783] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  919.020922] rcu:     0-...0: (0 ticks this GP)
idle=7d2/1/0x4000000000000002 softirq=1424/1424 fqs=105807
[  919.030295]  (detected by 1, t=225825 jiffies, g=1561, q=3496)
[  919.036109] Task dump for CPU 0:
[  919.039321] kworker/0:1     R  running task        0    30      2 0x00000008
[  919.046359] Workqueue: events set_brightness_delayed
[  919.051302] Call Trace:
[  919.053738] [<ffffffe000930d92>] __schedule+0x194/0x4de
[  982.035783] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  982.040923] rcu:     0-...0: (0 ticks this GP)
idle=7d2/1/0x4000000000000002 softirq=1424/1424 fqs=113325
[  982.050294]  (detected by 1, t=241580 jiffies, g=1561, q=3509)
[  982.056108] Task dump for CPU 0:
[  982.059321] kworker/0:1     R  running task        0    30      2 0x00000008
[  982.066359] Workqueue: events set_brightness_delayed
[  982.071302] Call Trace:
[  982.073739] [<ffffffe000930d92>] __schedule+0x194/0x4de
[..]

Fixes: bb0fed1c60cc ("irqchip/sifive-plic: Switch to fasteoi flow")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
[maz: tidy-up commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20201020081532.2377-1-greentime.hu@sifive.com
---
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index eaa3e9f..4048657 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -151,7 +151,7 @@ static int plic_set_affinity(struct irq_data *d,
 		return -EINVAL;
 
 	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
