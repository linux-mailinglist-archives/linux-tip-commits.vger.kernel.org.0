Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1929EB83
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgJ2MQ0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:16:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgJ2MPt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:49 -0400
Date:   Thu, 29 Oct 2020 12:15:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GECynj6B1tFP3jOTYTEPs+OLEHJGqBhnl2/IZ65y/4=;
        b=EOqcAdsPq98tGnvSOlMYldxVVHSfsAbQiaJo/V5swsny63swCYCK10HdKj54eeaFWF+7HK
        mCZFu8BMdbh5OSv68zPl65XU4B0swYq4fjPAuxA/Yq3EpYfohToa42x9nAlMg3iw6ud6tI
        alqEi5s5gjS+UYcLfkj4607oeo8SaT60IsrTMf95uQpP9xiME3O/pj3tnCrKAqKe7jsmqu
        MbQJYIACoYkqdgv2ov77IdTUAcwM3S5xKWHIsTfWG8nd3HIoMvkb6xoULwP2tjc+A613Zy
        zF/LfDQiktTWCsZlTC23lD2A5TveUCbF6LljfsvwirNPxcvbkVsdO1g8DIlzRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GECynj6B1tFP3jOTYTEPs+OLEHJGqBhnl2/IZ65y/4=;
        b=y8tFeEOsI7DXGwC1jM9w0arxfHteUjO59OtveAS8dpaSmXwxODWGIDgAINGc3WXH0sC57e
        oMlkigzPWgBXlyDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Get rid of apic:: Dest_logical
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-8-dwmw2@infradead.org>
References: <20201024213535.443185-8-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374582.397.3225892306137178066.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e57d04e5fa00f7649d4c00796f8d12054799be4a
Gitweb:        https://git.kernel.org/tip/e57d04e5fa00f7649d4c00796f8d12054799be4a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:24 +01:00

x86/apic: Get rid of apic:: Dest_logical

struct apic has two members which store information about the destination
mode: dest_logical and irq_dest_mode.

dest_logical contains a mask which was historically used to set the
destination mode in IPI messages. Over time the usage was reduced and the
logical/physical functions were seperated.

There are only a few places which still use 'dest_logical' but they can
use 'irq_dest_mode' instead.

irq_dest_mode is actually a boolean where 0 means physical destination mode
and 1 means logical destination mode. Of course the name does not reflect
the functionality. This will be cleaned up in a subsequent change.

Remove apic::dest_logical and fixup the remaining users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-8-dwmw2@infradead.org

---
 arch/x86/include/asm/apic.h           | 2 --
 arch/x86/kernel/apic/apic.c           | 2 +-
 arch/x86/kernel/apic/apic_flat_64.c   | 8 ++------
 arch/x86/kernel/apic/apic_noop.c      | 4 +---
 arch/x86/kernel/apic/apic_numachip.c  | 8 ++------
 arch/x86/kernel/apic/bigsmp_32.c      | 4 +---
 arch/x86/kernel/apic/probe_32.c       | 4 +---
 arch/x86/kernel/apic/x2apic_cluster.c | 4 +---
 arch/x86/kernel/apic/x2apic_phys.c    | 4 +---
 arch/x86/kernel/apic/x2apic_uv_x.c    | 4 +---
 arch/x86/kernel/smpboot.c             | 5 +++--
 arch/x86/xen/apic.c                   | 4 +---
 12 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 37a08f3..e230ed2 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -306,8 +306,6 @@ struct apic {
 	void	(*send_IPI_all)(int vector);
 	void	(*send_IPI_self)(int vector);
 
-	/* dest_logical is used by the IPI functions */
-	u32	dest_logical;
 	u32	disable_esr;
 
 	enum apic_delivery_modes delivery_mode;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 113f6ca..29d28b3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1591,7 +1591,7 @@ static void setup_local_APIC(void)
 	apic->init_apic_ldr();
 
 #ifdef CONFIG_X86_32
-	if (apic->dest_logical) {
+	if (apic->irq_dest_mode == 1) {
 		int logical_apicid, ldr_apicid;
 
 		/*
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 6df837f..bbb1b89 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -117,11 +117,9 @@ static struct apic apic_flat __ro_after_init = {
 	.irq_dest_mode			= 1, /* logical */
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= flat_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
@@ -210,11 +208,9 @@ static struct apic apic_physflat __ro_after_init = {
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
-	.dest_logical			= 0,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= physflat_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 4fc934b..38f167c 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -100,11 +100,9 @@ struct apic apic_noop __ro_after_init = {
 	.irq_dest_mode			= 1,
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= default_check_apicid_used,
 
+	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= noop_init_apic_ldr,
-
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= NULL,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index db715d0..4ebf9fe 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -250,11 +250,9 @@ static const struct apic apic_numachip1 __refconst = {
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
-	.dest_logical			= 0,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= flat_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
@@ -299,11 +297,9 @@ static const struct apic apic_numachip2 __refconst = {
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
-	.dest_logical			= 0,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= flat_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 7f6461f..64c375b 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -132,11 +132,9 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.irq_dest_mode			= 0,
 
 	.disable_esr			= 1,
-	.dest_logical			= 0,
-	.check_apicid_used		= bigsmp_check_apicid_used,
 
+	.check_apicid_used		= bigsmp_check_apicid_used,
 	.init_apic_ldr			= bigsmp_init_apic_ldr,
-
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= bigsmp_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 77c6e2e..97652aa 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -74,11 +74,9 @@ static struct apic apic_default __ro_after_init = {
 	.irq_dest_mode			= 1,
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= default_check_apicid_used,
 
+	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= default_init_apic_ldr,
-
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= setup_apic_flat_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index f77e9fb..53390fc 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -188,11 +188,9 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.irq_dest_mode			= 1, /* logical */
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 437e843..ee0c4d0 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -161,11 +161,9 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.irq_dest_mode			= 0, /* physical */
 
 	.disable_esr			= 0,
-	.dest_logical			= 0,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 49deefd..d21a685 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -811,11 +811,9 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.irq_dest_mode			= 0, /* Physical */
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_PHYSICAL,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= uv_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2..6c14f10 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -747,13 +747,14 @@ static void __init smp_quirk_init_udelay(void)
 int
 wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
 {
+	u32 dm = apic->irq_dest_mode ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 	unsigned long send_status, accept_status = 0;
 	int maxlvt;
 
 	/* Target chip */
 	/* Boot on the stack */
 	/* Kick the second */
-	apic_icr_write(APIC_DM_NMI | apic->dest_logical, apicid);
+	apic_icr_write(APIC_DM_NMI | dm, apicid);
 
 	pr_debug("Waiting for send to finish...\n");
 	send_status = safe_apic_wait_icr_idle();
@@ -980,7 +981,7 @@ wakeup_cpu_via_init_nmi(int cpu, unsigned long start_ip, int apicid,
 	if (!boot_error) {
 		enable_start_cpu0 = 1;
 		*cpu0_nmi_registered = 1;
-		if (apic->dest_logical == APIC_DEST_LOGICAL)
+		if (apic->irq_dest_mode)
 			id = cpu0_logical_apicid;
 		else
 			id = apicid;
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index e82fd19..c35c24b 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -152,11 +152,9 @@ static struct apic xen_pv_apic = {
 	/* .irq_dest_mode     - used in native_compose_msi_msg only */
 
 	.disable_esr			= 0,
-	/* .dest_logical      -  default_send_IPI_ use it but we use our own. */
-	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
 
+	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
 	.init_apic_ldr			= xen_noop, /* setup_local_APIC calls it */
-
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map, /* Used on 32-bit */
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
