Return-Path: <linux-tip-commits+bounces-2634-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFEC9B47C8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99BC1C23FDD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213071E0DDF;
	Tue, 29 Oct 2024 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mDqMGimV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eiAubZFL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562A1DED7D;
	Tue, 29 Oct 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199656; cv=none; b=HFoi2MQpMXHCkH1ra2SvWdxn40m6JX5c1S6DMZMeu6pCeKlQE8clUjctpKph3aBV5oPHbCgK5h13o76UWwtCLLsNSYRTNSMi9eMX4mu0w3W7diVgtbqxh3JMLbjrNGKKSOG61h27PpFgAdRg0z8SZWf+wGnYFOJBLJGiGG08f88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199656; c=relaxed/simple;
	bh=t4/pn5+JPxJU14B+Uq9O2FlGpAK9N/+7QK06w+hxL/k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uKemV4FMdGLeBO8MZ4FB3gZ9Xv7o5olqZo6RfvpbAS72A8SdWVsb6jGct/rZro+18nUwlX+kTT4ZAL5N2yP6RbIyakugCTYlkOaQuhtzVD5oSW5CpLX5rkq3ceQlD/AU6VoGGL/E/ZwNaF5iwlvQIJ2pFhOX9aHFt6t0qkJHcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mDqMGimV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eiAubZFL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:00:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730199651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6T2Z+mhvp/5hSrU6/4Yq+m8sE0Hl+75fZ6U32ZRoGnI=;
	b=mDqMGimVfltvG7vbB9tX5E3hIZn93sAsdUcVqrMZAxoV1zpU+IBvGOj8oVJpE+5R/tTmPz
	QEQTuJYcuv1wonu1zRSYMheJPVn4UMUwAfpQH7bOytz9aOwbCdviBisesHFkFw2Cd5Rl99
	WDOFJkZLknQ7Ck1INtFha/Q081gBox3PIfQ+zyGd8We2cK2gHMdxBT+0XOFe4qG29LE7ax
	4Vw0EfsKefPuL8bRp72Z8QeeI9RTqeNPqanwaUN1+u5nZsZiFlCKrZjIkV56zMPS6+Hy7r
	PEfSr1eEeYDYHlgCW+AGKG2xhD87JlQU6ZI2PTu13lQv0lbZ5tWlwjXpOSkyHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730199651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6T2Z+mhvp/5hSrU6/4Yq+m8sE0Hl+75fZ6U32ZRoGnI=;
	b=eiAubZFLioeNhKcCw4NVey7EawAJ1TN8yuqKl3ULcYEllEuNE3VJEhvuN0P3Ww8f0+P+Qo
	u+OxpM0577gH3IBg==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Convert shared memory back to private on kexec
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C05a8c15fb665dbb062b04a8cb3d592a63f235937=2E17225?=
 =?utf-8?q?20012=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C05a8c15fb665dbb062b04a8cb3d592a63f235937=2E172252?=
 =?utf-8?q?0012=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173019965022.1442.14782678274090419631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     3074152e56c9b0f9b9c67edfbc08b371db050b6d
Gitweb:        https://git.kernel.org/tip/3074152e56c9b0f9b9c67edfbc08b371db050b6d
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 01 Aug 2024 19:14:50 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Oct 2024 18:06:54 +01:00

x86/sev: Convert shared memory back to private on kexec

SNP guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second, kexec-ed, kernel has no idea what memory is converted this
way. It only sees E820_TYPE_RAM.

Accessing shared memory via private mapping will cause unrecoverable RMP
page-faults.

On kexec, walk direct mapping and convert all shared memory back to
private. It makes all RAM private again and second kernel may use it
normally. Additionally, for SNP guests, convert all bss decrypted
section pages back to private.

The conversion occurs in two steps: stopping new conversions and
unsharing all memory. In the case of normal kexec, the stopping of
conversions takes place while scheduling is still functioning. This
allows for waiting until any ongoing conversions are finished. The
second step is carried out when all CPUs except one are inactive and
interrupts are disabled. This prevents any conflicts with code that may
access shared memory.

Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/05a8c15fb665dbb062b04a8cb3d592a63f235937.1722520012.git.ashish.kalra@amd.com
---
 arch/x86/coco/sev/core.c      | 131 +++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/sev.h    |   4 +-
 arch/x86/mm/mem_encrypt_amd.c |   2 +-
 3 files changed, 137 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index c7b4270..97f445f 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -954,6 +954,137 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static void set_pte_enc(pte_t *kpte, int level, void *va)
+{
+	struct pte_enc_desc d = {
+		.kpte	   = kpte,
+		.pte_level = level,
+		.va	   = va,
+		.encrypt   = true
+	};
+
+	prepare_pte_enc(&d);
+	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
+}
+
+static void unshare_all_memory(void)
+{
+	unsigned long addr, end, size, ghcb;
+	struct sev_es_runtime_data *data;
+	unsigned int npages, level;
+	bool skipped_addr;
+	pte_t *pte;
+	int cpu;
+
+	/* Unshare the direct mapping. */
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+		npages = size / PAGE_SIZE;
+		skipped_addr = false;
+
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte)) {
+			addr += size;
+			continue;
+		}
+
+		/*
+		 * Ensure that all the per-CPU GHCBs are made private at the
+		 * end of the unsharing loop so that the switch to the slower
+		 * MSR protocol happens last.
+		 */
+		for_each_possible_cpu(cpu) {
+			data = per_cpu(runtime_data, cpu);
+			ghcb = (unsigned long)&data->ghcb_page;
+
+			if (addr <= ghcb && ghcb <= addr + size) {
+				skipped_addr = true;
+				break;
+			}
+		}
+
+		if (!skipped_addr) {
+			set_pte_enc(pte, level, (void *)addr);
+			snp_set_memory_private(addr, npages);
+		}
+		addr += size;
+	}
+
+	/* Unshare all bss decrypted memory. */
+	addr = (unsigned long)__start_bss_decrypted;
+	end  = (unsigned long)__start_bss_decrypted_unused;
+	npages = (end - addr) >> PAGE_SHIFT;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		pte = lookup_address(addr, &level);
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
+			continue;
+
+		set_pte_enc(pte, level, (void *)addr);
+	}
+	addr = (unsigned long)__start_bss_decrypted;
+	snp_set_memory_private(addr, npages);
+
+	__flush_tlb_all();
+}
+
+/* Stop new private<->shared conversions */
+void snp_kexec_begin(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	/*
+	 * Crash kernel ends up here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion())
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+void snp_kexec_finish(void)
+{
+	struct sev_es_runtime_data *data;
+	unsigned int level, cpu;
+	unsigned long size;
+	struct ghcb *ghcb;
+	pte_t *pte;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	unshare_all_memory();
+
+	/*
+	 * Switch to using the MSR protocol to change per-CPU GHCBs to
+	 * private. All the per-CPU GHCBs have been switched back to private,
+	 * so can't do any more GHCB calls to the hypervisor beyond this point
+	 * until the kexec'ed kernel starts running.
+	 */
+	boot_ghcb = NULL;
+	sev_cfg.ghcbs_initialized = false;
+
+	for_each_possible_cpu(cpu) {
+		data = per_cpu(runtime_data, cpu);
+		ghcb = &data->ghcb_page;
+		pte = lookup_address((unsigned long)ghcb, &level);
+		size = page_level_size(level);
+		set_pte_enc(pte, level, (void *)ghcb);
+		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
+	}
+}
+
 static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
 {
 	int ret;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5f59893..91f08af 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -455,6 +455,8 @@ void sev_show_status(void);
 void snp_update_svsm_ca(void);
 int prepare_pte_enc(struct pte_enc_desc *d);
 void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
+void snp_kexec_finish(void);
+void snp_kexec_begin(void);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -494,6 +496,8 @@ static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
 static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
 static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
+static inline void snp_kexec_finish(void) { }
+static inline void snp_kexec_begin(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index f4be81d..774f967 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -490,6 +490,8 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
+	x86_platform.guest.enc_kexec_begin	     = snp_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = snp_kexec_finish;
 
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the

