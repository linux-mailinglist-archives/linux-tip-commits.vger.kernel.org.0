Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24084285908
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgJGHMP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgJGHMJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:09 -0400
Date:   Wed, 07 Oct 2020 07:12:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLcJVShCE/bVReTC/c2dp7iAQ6Y9QJGRYrex2JO0/KA=;
        b=VM56vToFuZpoEmPRGXYO7rfuyTwHZ1TVbQVP2tVLpC9y55ktV+Rnlg7eivXAribK3PAKO1
        y52dB5JoH9xZXtlhcqbhGnZ0RF5A6uzt3g60G/SIRmVNAnaC+IWraqFHosJNh/klLgwtJq
        Xaohs0yaUorbVXSHA32KeWWe1CzTRzO20YNL2Usp0EnJkiPZ2ofap3g9cS/zyHFR9WBqxJ
        xZ1ff+wEWXn2Ro0r3VysmWvcEw+/A89moYYNW3EMLPAfe0kw7ZzYf9FLMw6L4heoVhTuv3
        7ZtUOWg9UEQNYKkZDvHqWuKZAMMVTYwBbFakHCkqyni2Sl6ihFzakpy6MLOZgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLcJVShCE/bVReTC/c2dp7iAQ6Y9QJGRYrex2JO0/KA=;
        b=Yjs7OB4Crpt8FkVQnu7+nIFj+EaF9ry5dm0TnfgyfG8eamP1rGokQEQ73fRe5KFyLh6bre
        eiaGPe6A9yAbFJCQ==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove SCIR MMR references for
 UV systems
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-3-mike.travis@hpe.com>
References: <20201005203929.148656-3-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205472550.7002.12214063722259144150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     c4d98077443adf61268ffb8b2c5d63c6176d845f
Gitweb:        https://git.kernel.org/tip/c4d98077443adf61268ffb8b2c5d63c6176d845f
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Mon, 05 Oct 2020 15:39:18 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 08:53:51 +02:00

x86/platform/uv: Remove SCIR MMR references for UV systems

UV class systems no longer use System Controller for monitoring of CPU
activity provided by this driver. Other methods have been developed for
BIOS and the management controller (BMC). Remove that supporting code.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-3-mike.travis@hpe.com
---
 arch/x86/include/asm/uv/uv_hub.h   | 43 +--------------
 arch/x86/kernel/apic/x2apic_uv_x.c | 82 +-----------------------------
 2 files changed, 3 insertions(+), 122 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 100d668..b21228d 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -129,17 +129,6 @@
  */
 #define UV_MAX_NASID_VALUE	(UV_MAX_NUMALINK_BLADES * 2)
 
-/* System Controller Interface Reg info */
-struct uv_scir_s {
-	struct timer_list timer;
-	unsigned long	offset;
-	unsigned long	last;
-	unsigned long	idle_on;
-	unsigned long	idle_off;
-	unsigned char	state;
-	unsigned char	enabled;
-};
-
 /* GAM (globally addressed memory) range table */
 struct uv_gam_range_s {
 	u32	limit;		/* PA bits 56:26 (GAM_RANGE_SHFT) */
@@ -191,16 +180,13 @@ struct uv_hub_info_s {
 struct uv_cpu_info_s {
 	void			*p_uv_hub_info;
 	unsigned char		blade_cpu_id;
-	struct uv_scir_s	scir;
+	void			*reserved;
 };
 DECLARE_PER_CPU(struct uv_cpu_info_s, __uv_cpu_info);
 
 #define uv_cpu_info		this_cpu_ptr(&__uv_cpu_info)
 #define uv_cpu_info_per(cpu)	(&per_cpu(__uv_cpu_info, cpu))
 
-#define	uv_scir_info		(&uv_cpu_info->scir)
-#define	uv_cpu_scir_info(cpu)	(&uv_cpu_info_per(cpu)->scir)
-
 /* Node specific hub common info struct */
 extern void **__uv_hub_info_list;
 static inline struct uv_hub_info_s *uv_hub_info_list(int node)
@@ -297,9 +283,9 @@ union uvh_apicid {
 #define UV3_GLOBAL_MMR32_SIZE		(32UL * 1024 * 1024)
 
 #define UV4_LOCAL_MMR_BASE		0xfa000000UL
-#define UV4_GLOBAL_MMR32_BASE		0xfc000000UL
+#define UV4_GLOBAL_MMR32_BASE		0
 #define UV4_LOCAL_MMR_SIZE		(32UL * 1024 * 1024)
-#define UV4_GLOBAL_MMR32_SIZE		(16UL * 1024 * 1024)
+#define UV4_GLOBAL_MMR32_SIZE		0
 
 #define UV_LOCAL_MMR_BASE		(				\
 					is_uv2_hub() ? UV2_LOCAL_MMR_BASE : \
@@ -772,29 +758,6 @@ DECLARE_PER_CPU(struct uv_cpu_nmi_s, uv_cpu_nmi);
 #define	UV_NMI_STATE_DUMP		2
 #define	UV_NMI_STATE_DUMP_DONE		3
 
-/* Update SCIR state */
-static inline void uv_set_scir_bits(unsigned char value)
-{
-	if (uv_scir_info->state != value) {
-		uv_scir_info->state = value;
-		uv_write_local_mmr8(uv_scir_info->offset, value);
-	}
-}
-
-static inline unsigned long uv_scir_offset(int apicid)
-{
-	return SCIR_LOCAL_MMR_BASE | (apicid & 0x3f);
-}
-
-static inline void uv_set_cpu_scir_bits(int cpu, unsigned char value)
-{
-	if (uv_cpu_scir_info(cpu)->state != value) {
-		uv_write_global_mmr8(uv_cpu_to_pnode(cpu),
-				uv_cpu_scir_info(cpu)->offset, value);
-		uv_cpu_scir_info(cpu)->state = value;
-	}
-}
-
 /*
  * Get the minimum revision number of the hub chips within the partition.
  * (See UVx_HUB_REVISION_BASE above for specific values.)
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 0b6eea3..f51fabf 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -909,85 +909,6 @@ static __init void uv_rtc_init(void)
 	}
 }
 
-/*
- * percpu heartbeat timer
- */
-static void uv_heartbeat(struct timer_list *timer)
-{
-	unsigned char bits = uv_scir_info->state;
-
-	/* Flip heartbeat bit: */
-	bits ^= SCIR_CPU_HEARTBEAT;
-
-	/* Is this CPU idle? */
-	if (idle_cpu(raw_smp_processor_id()))
-		bits &= ~SCIR_CPU_ACTIVITY;
-	else
-		bits |= SCIR_CPU_ACTIVITY;
-
-	/* Update system controller interface reg: */
-	uv_set_scir_bits(bits);
-
-	/* Enable next timer period: */
-	mod_timer(timer, jiffies + SCIR_CPU_HB_INTERVAL);
-}
-
-static int uv_heartbeat_enable(unsigned int cpu)
-{
-	while (!uv_cpu_scir_info(cpu)->enabled) {
-		struct timer_list *timer = &uv_cpu_scir_info(cpu)->timer;
-
-		uv_set_cpu_scir_bits(cpu, SCIR_CPU_HEARTBEAT|SCIR_CPU_ACTIVITY);
-		timer_setup(timer, uv_heartbeat, TIMER_PINNED);
-		timer->expires = jiffies + SCIR_CPU_HB_INTERVAL;
-		add_timer_on(timer, cpu);
-		uv_cpu_scir_info(cpu)->enabled = 1;
-
-		/* Also ensure that boot CPU is enabled: */
-		cpu = 0;
-	}
-	return 0;
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-static int uv_heartbeat_disable(unsigned int cpu)
-{
-	if (uv_cpu_scir_info(cpu)->enabled) {
-		uv_cpu_scir_info(cpu)->enabled = 0;
-		del_timer(&uv_cpu_scir_info(cpu)->timer);
-	}
-	uv_set_cpu_scir_bits(cpu, 0xff);
-	return 0;
-}
-
-static __init void uv_scir_register_cpu_notifier(void)
-{
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/x2apic-uvx:online",
-				  uv_heartbeat_enable, uv_heartbeat_disable);
-}
-
-#else /* !CONFIG_HOTPLUG_CPU */
-
-static __init void uv_scir_register_cpu_notifier(void)
-{
-}
-
-static __init int uv_init_heartbeat(void)
-{
-	int cpu;
-
-	if (is_uv_system()) {
-		for_each_online_cpu(cpu)
-			uv_heartbeat_enable(cpu);
-	}
-
-	return 0;
-}
-
-late_initcall(uv_init_heartbeat);
-
-#endif /* !CONFIG_HOTPLUG_CPU */
-
 /* Direct Legacy VGA I/O traffic to designated IOH */
 static int uv_set_vga_state(struct pci_dev *pdev, bool decode, unsigned int command_bits, u32 flags)
 {
@@ -1517,8 +1438,6 @@ static void __init uv_system_init_hub(void)
 			uv_hub_info_list(numa_node_id)->pnode = pnode;
 		else if (uv_cpu_hub_info(cpu)->pnode == 0xffff)
 			uv_cpu_hub_info(cpu)->pnode = pnode;
-
-		uv_cpu_scir_info(cpu)->offset = uv_scir_offset(apicid);
 	}
 
 	for_each_node(nodeid) {
@@ -1547,7 +1466,6 @@ static void __init uv_system_init_hub(void)
 
 	uv_nmi_setup();
 	uv_cpu_init();
-	uv_scir_register_cpu_notifier();
 	uv_setup_proc_files(0);
 
 	/* Register Legacy VGA I/O redirection handler: */
