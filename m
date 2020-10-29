Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0466629EB74
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgJ2MPt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJ2MPs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:48 -0400
Date:   Thu, 29 Oct 2020 12:15:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9CpPRqbLbj0IFyO1aX3R8mkK/Ohk3QosR04O+2i6Ts=;
        b=iUSs3mi+e2HyvjHVNeNzj0+97yjx0Mbw65RVbfFkXL+VpvzpmnN7h8mIiGGYfDf2vBJDeA
        3LXCK23j98UubzWUO/b06I8VQRCRD9r7l76K7hbIF1FaHSpwoewPxyBf7D0bvW8rwJzfaP
        n0tnd72g6hEQzIu/77C096huei3TuHLR+DtmlIEGbAXc+3TfPgbWn+hFklJZnchFyPySY6
        d5HqEDPruL5DwZu7lXXCqQNmuw27YE5ZersXsniDMo5eGOwLCXA8PX8WvkGU8nhbpV2Shx
        K38ped605yL6wDNtfsM1HlXySOMot8sBB2gQDbBx7mnPfOW4FKMNiOWLw8a5uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9CpPRqbLbj0IFyO1aX3R8mkK/Ohk3QosR04O+2i6Ts=;
        b=b4poF4cjXohtV25rerOUjZryaXVsE4Jfz5Oasf2g4vdbefw0iHJBNDFnCgcAoM+bPhubz4
        0e+czxHPp25h5tDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Replace pointless apic:: Dest_logical usage
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-7-dwmw2@infradead.org>
References: <20201024213535.443185-7-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374638.397.9931172941421302751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     22e0db42097b30a49771744e514350b7e9dd26f2
Gitweb:        https://git.kernel.org/tip/22e0db42097b30a49771744e514350b7e9dd26f2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:24 +01:00

x86/apic: Replace pointless apic:: Dest_logical usage

All these functions are only used for logical destination mode. So reading
the destination mode mask from the apic structure is a pointless
exercise. Just hand in the proper constant: APIC_DEST_LOGICAL.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-7-dwmw2@infradead.org

---
 arch/x86/kernel/apic/apic_flat_64.c   | 2 +-
 arch/x86/kernel/apic/ipi.c            | 6 +++---
 arch/x86/kernel/apic/x2apic_cluster.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index fdd38a1..6df837f 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -53,7 +53,7 @@ static void _flat_send_IPI_mask(unsigned long mask, int vector)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__default_send_IPI_dest_field(mask, vector, apic->dest_logical);
+	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 387154e..d1fb874 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -260,7 +260,7 @@ void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
 	for_each_cpu(query_cpu, mask)
 		__default_send_IPI_dest_field(
 			early_per_cpu(x86_cpu_to_logical_apicid, query_cpu),
-			vector, apic->dest_logical);
+			vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
 
@@ -279,7 +279,7 @@ void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask,
 			continue;
 		__default_send_IPI_dest_field(
 			early_per_cpu(x86_cpu_to_logical_apicid, query_cpu),
-			vector, apic->dest_logical);
+			vector, APIC_DEST_LOGICAL);
 		}
 	local_irq_restore(flags);
 }
@@ -297,7 +297,7 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 
 	local_irq_save(flags);
 	WARN_ON(mask & ~cpumask_bits(cpu_online_mask)[0]);
-	__default_send_IPI_dest_field(mask, vector, apic->dest_logical);
+	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 82fb43d..f77e9fb 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -61,7 +61,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 		if (!dest)
 			continue;
 
-		__x2apic_send_IPI_dest(dest, vector, apic->dest_logical);
+		__x2apic_send_IPI_dest(dest, vector, APIC_DEST_LOGICAL);
 		/* Remove cluster CPUs from tmpmask */
 		cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
 	}
