Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F8D424796
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Oct 2021 21:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhJFT6s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 15:58:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhJFT6r (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 15:58:47 -0400
Date:   Wed, 06 Oct 2021 19:56:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633550214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6pKq8pWda70kDQtpJbOun/vgQgSTagCBEQsGxDh5wg=;
        b=uk5Yrp6HUGm7sjP8OzDB8YgfDkD4dPnjdBqxUmVy8YpenyawVxxrTl/x0pKO+OHT94NILo
        5nOezpKWoMlbR1Vvio7vjuXn0hTv7mVfA9G9U5N1b7FegoEAzKFNtoU7rS/borjWV+qTJ0
        YxT/5IpzbUhGE4LDUv2eWmr1MkVuUwDNodpPmQZXCV3Nt3SIQS0ph5JrkKvxuhJ5lE8Jqd
        Etr/BJC1AQSqlqf18EPr1ien2UVBb3GQu5akdUrISlpBy6C3HkFBY3Hm+n3kN2e3HM6IVs
        X4JTGSZZZ4rWZcd1Ad2ZA0kNrEK/TUvK7IMW6BuNKMHij/0aYCwpGQb6oFxuZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633550214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6pKq8pWda70kDQtpJbOun/vgQgSTagCBEQsGxDh5wg=;
        b=IHiG+hdwC6N4LAIM9yci7b4z95aiQ2EiXf+hgxmIETqB0sjAhuLiLzgg+iP9OwOdyVS/Om
        1Ujf9RjvGKH5WACw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/sev: Make the #VC exception stacks part of the
 default stacks storage
Cc:     Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YVt1IMjIs7pIZTRR@zn.tnic>
References: <YVt1IMjIs7pIZTRR@zn.tnic>
MIME-Version: 1.0
Message-ID: <163355021284.25758.8427444047178389105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     541ac97186d9ea88491961a46284de3603c914fd
Gitweb:        https://git.kernel.org/tip/541ac97186d9ea88491961a46284de3603c914fd
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 01 Oct 2021 21:41:20 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Oct 2021 21:48:27 +02:00

x86/sev: Make the #VC exception stacks part of the default stacks storage

The size of the exception stacks was increased by the commit in Fixes,
resulting in stack sizes greater than a page in size. The #VC exception
handling was only mapping the first (bottom) page, resulting in an
SEV-ES guest failing to boot.

Make the #VC exception stacks part of the default exception stacks
storage and allocate them with a CONFIG_AMD_MEM_ENCRYPT=y .config. Map
them only when a SEV-ES guest has been detected.

Rip out the custom VC stacks mapping and storage code.

 [ bp: Steal and adapt Tom's commit message. ]

Fixes: 7fae4c24a2b8 ("x86: Increase exception stack sizes")
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Brijesh Singh <brijesh.singh@amd.com>
Link: https://lkml.kernel.org/r/YVt1IMjIs7pIZTRR@zn.tnic
---
 arch/x86/include/asm/cpu_entry_area.h |  8 ++++++-
 arch/x86/kernel/sev.c                 | 32 +--------------------------
 arch/x86/mm/cpu_entry_area.c          |  7 ++++++-
 3 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 3d52b09..dd5ea1b 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -10,6 +10,12 @@
 
 #ifdef CONFIG_X86_64
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#define VC_EXCEPTION_STKSZ	EXCEPTION_STKSZ
+#else
+#define VC_EXCEPTION_STKSZ	0
+#endif
+
 /* Macro to enforce the same ordering and stack sizes */
 #define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
 	char	DF_stack_guard[guardsize];			\
@@ -28,7 +34,7 @@
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0, 0)
+	ESTACKS_MEMBERS(0, VC_EXCEPTION_STKSZ)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 53a6837..4d0d1c2 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -46,16 +46,6 @@ static struct ghcb __initdata *boot_ghcb;
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
 
-	/* Physical storage for the per-CPU IST stack of the #VC handler */
-	char ist_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
-
-	/*
-	 * Physical storage for the per-CPU fall-back stack of the #VC handler.
-	 * The fall-back stack is used when it is not safe to switch back to the
-	 * interrupted stack in the #VC entry code.
-	 */
-	char fallback_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
-
 	/*
 	 * Reserve one page per CPU as backup storage for the unencrypted GHCB.
 	 * It is needed when an NMI happens while the #VC handler uses the real
@@ -99,27 +89,6 @@ DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
-static void __init setup_vc_stacks(int cpu)
-{
-	struct sev_es_runtime_data *data;
-	struct cpu_entry_area *cea;
-	unsigned long vaddr;
-	phys_addr_t pa;
-
-	data = per_cpu(runtime_data, cpu);
-	cea  = get_cpu_entry_area(cpu);
-
-	/* Map #VC IST stack */
-	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
-	pa    = __pa(data->ist_stack);
-	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
-
-	/* Map VC fall-back stack */
-	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC2);
-	pa    = __pa(data->fallback_stack);
-	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
-}
-
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -787,7 +756,6 @@ void __init sev_es_init_vc_handling(void)
 	for_each_possible_cpu(cpu) {
 		alloc_runtime_data(cpu);
 		init_ghcb(cpu);
-		setup_vc_stacks(cpu);
 	}
 
 	sev_es_setup_play_dead();
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index f5e1e60..6c2f1b7 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -110,6 +110,13 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	cea_map_stack(NMI);
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
+			cea_map_stack(VC);
+			cea_map_stack(VC2);
+		}
+	}
 }
 #else
 static inline void percpu_setup_exception_stacks(unsigned int cpu)
