Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE926C455
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgIPPfU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIPPa3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 11:30:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2EDC02C298;
        Wed, 16 Sep 2020 08:20:17 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26j5k12iEdLiGwGWYx2OW9S90xCL5f1QJ7jnCr96DbU=;
        b=tcQUmt77DpL3X+ZPqK7dU5dJzpWUY3JexcGEbwS+NpX9InPex3arqU98nxmURd2iLV24De
        KTvKLKVl5VuelQ0EDMTbGkFbaH7b9LEad+WaZZ77O7rCXEO36QvJ6POzafIp4mI/+BfOoi
        U7znYZn20QD3PuZC2j394xfGPlJMWH701YVlSiamYwk9lyoY1aXur4U0eq/KqEerhAEzwE
        aVCbQLRPlTI5a1/12lXg5AlHWn2yhEMTFAeMbClJK56Va43BweVjqVMhff5mizQQGUANJw
        8y37oWv50qfPKUXjcIeckqBY7cHR/YthiMucceXkSi76b8efg0HMmZKYSkIa3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26j5k12iEdLiGwGWYx2OW9S90xCL5f1QJ7jnCr96DbU=;
        b=eiUq0YHYBV1JLksCEvQUj8D4AYKbCMNHG8MkRBQI+hQ6/md/2h68dDblPfZui8FJo9ETb0
        PkF+WztmybMPEVAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Move apic_post_init() invocation to one place
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112332.658496557@linutronix.de>
References: <20200826112332.658496557@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913589.15536.1984671925148098137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     bb733e4336988e40072c759fb27057b5fe82c7d4
Gitweb:        https://git.kernel.org/tip/bb733e4336988e40072c759fb27057b5fe82c7d4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:35 +02:00

x86/irq: Move apic_post_init() invocation to one place

No point to call it from both 32bit and 64bit implementations of
default_setup_apic_routing(). Move it to the caller.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112332.658496557@linutronix.de

---
 arch/x86/kernel/apic/apic.c     | 3 +++
 arch/x86/kernel/apic/probe_32.c | 3 ---
 arch/x86/kernel/apic/probe_64.c | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 5f943b9..b3eef1d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1429,6 +1429,9 @@ void __init apic_intr_mode_init(void)
 		break;
 	}
 
+	if (x86_platform.apic_post_init)
+		x86_platform.apic_post_init();
+
 	apic_bsp_setup(upmode);
 }
 
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 99ee61c..67b6f7c 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -170,9 +170,6 @@ void __init default_setup_apic_routing(void)
 
 	if (apic->setup_apic_routing)
 		apic->setup_apic_routing();
-
-	if (x86_platform.apic_post_init)
-		x86_platform.apic_post_init();
 }
 
 void __init generic_apic_probe(void)
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index bd3835d..c46720f 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -32,9 +32,6 @@ void __init default_setup_apic_routing(void)
 			break;
 		}
 	}
-
-	if (x86_platform.apic_post_init)
-		x86_platform.apic_post_init();
 }
 
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
