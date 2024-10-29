Return-Path: <linux-tip-commits+bounces-2635-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13C9B47CA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEE81C23E59
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Oct 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F415205E1B;
	Tue, 29 Oct 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFb+3fa0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Afv/nyOk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D702038A0;
	Tue, 29 Oct 2024 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199657; cv=none; b=F0DKdU1vb/MVlsoQl57BVzpXG2GvVZAabCHNirL4Y2SiPasnQwhR7ZzdpVSaKuAcEUqlkT9d7vhiCSheh/E/UlYg15bScd5BqKESIXpMLjt/l9L0C7TaW1USCZm7i6C0mDRGuS288bhHRuJ4pqtHMpf7uCoa406mIFytY/Anap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199657; c=relaxed/simple;
	bh=yiXVkzgGvHpZcbfuXO0B50vt3UCEcEU9DV35tCB4iXw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZIVvMRv7THg07rEJOw3UBue5hmrmNcNhU/JmMIaCV5r18LTcA52j2BN29FG8wtXEMvCBkw7GBU0tSY94cG94pyg3B9kfB5rVpcbd8Q7D1yvfZzzYPD//uEKYovnuuI8vNvl3yYSR3Bf9KCGcIYkZRi4rzJpN/2lrN2oazISeW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LFb+3fa0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Afv/nyOk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 11:00:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730199652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIP79YsvOmZCrt8TcljKaNjOBkknFdB5zqH1jpCwC48=;
	b=LFb+3fa06XSY5hVqs0tyKFEl5eOynk4DU2Xa24hEIzhz6GsaF/vAWyUeyQSbHlUoGAogqk
	leCwV8CckasOrOYQH1TUcglElFZxqbtVFayifCiXEICs4zJcT9ofhjtctAse60cweDm8ZI
	erZUH1yuKYeecBOVAk88d5v14iTZ8PTYabtnVYhz4WIM75akhxLTteug9CA7rO0rxYGDhn
	y4VsYSRdCedTtH5dHyPAarbiiKVYwH5DaeqIq4FhCYOtHfKJVjMLB/hsjgX04QU4n4OEg0
	Z0b5rGTMdDkREHF13ODkQejjTxuwnhlA4sn4VlXj4tbwHlBbJXmbpZPRg1kW5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730199652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIP79YsvOmZCrt8TcljKaNjOBkknFdB5zqH1jpCwC48=;
	b=Afv/nyOk+9dYk2oCxeOdu+LNJGoYpm9QjvZRTUrwOid7Wpjcb6NqoJy/lzOaaPCBUuMmu2
	F41tgTBeehFu+YDg==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/mm: Refactor __set_clr_pte_enc()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5df4aa450447f28294d1c5a890e27b63ed4ded36=2E17225?=
 =?utf-8?q?20012=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C5df4aa450447f28294d1c5a890e27b63ed4ded36=2E172252?=
 =?utf-8?q?0012=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173019965105.1442.3190406723686336711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     2a783066b6f5f5250b838d2acfc716561d2a66e0
Gitweb:        https://git.kernel.org/tip/2a783066b6f5f5250b838d2acfc716561d2a66e0
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 01 Aug 2024 19:14:34 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Oct 2024 17:55:43 +01:00

x86/mm: Refactor __set_clr_pte_enc()

Refactor __set_clr_pte_enc() and add two new helper functions to
set/clear PTE C-bit from early SEV/SNP initialization code and later
during shutdown/kexec especially when all CPUs are stopped and
interrupts are disabled and set_memory_xx() interfaces can't be used.

Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/5df4aa450447f28294d1c5a890e27b63ed4ded36.1722520012.git.ashish.kalra@amd.com
---
 arch/x86/include/asm/sev.h    | 20 +++++++++-
 arch/x86/mm/mem_encrypt_amd.c | 75 ++++++++++++++++++++++------------
 2 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2e49c4a..5f59893 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -322,6 +322,22 @@ struct svsm_attest_call {
 	u8 rsvd[4];
 };
 
+/* PTE descriptor used for the prepare_pte_enc() operations. */
+struct pte_enc_desc {
+	pte_t *kpte;
+	int pte_level;
+	bool encrypt;
+	/* pfn of the kpte above */
+	unsigned long pfn;
+	/* physical address of @pfn */
+	unsigned long pa;
+	/* virtual address of @pfn */
+	void *va;
+	/* memory covered by the pte */
+	unsigned long size;
+	pgprot_t new_pgprot;
+};
+
 /*
  * SVSM protocol structure
  */
@@ -437,6 +453,8 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_update_svsm_ca(void);
+int prepare_pte_enc(struct pte_enc_desc *d);
+void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot);
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -474,6 +492,8 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
+static inline int prepare_pte_enc(struct pte_enc_desc *d) { return 0; }
+static inline void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 86a476a..f4be81d 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -311,59 +311,82 @@ static int amd_enc_status_change_finish(unsigned long vaddr, int npages, bool en
 	return 0;
 }
 
-static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+int prepare_pte_enc(struct pte_enc_desc *d)
 {
-	pgprot_t old_prot, new_prot;
-	unsigned long pfn, pa, size;
-	pte_t new_pte;
+	pgprot_t old_prot;
 
-	pfn = pg_level_to_pfn(level, kpte, &old_prot);
-	if (!pfn)
-		return;
+	d->pfn = pg_level_to_pfn(d->pte_level, d->kpte, &old_prot);
+	if (!d->pfn)
+		return 1;
 
-	new_prot = old_prot;
-	if (enc)
-		pgprot_val(new_prot) |= _PAGE_ENC;
+	d->new_pgprot = old_prot;
+	if (d->encrypt)
+		pgprot_val(d->new_pgprot) |= _PAGE_ENC;
 	else
-		pgprot_val(new_prot) &= ~_PAGE_ENC;
+		pgprot_val(d->new_pgprot) &= ~_PAGE_ENC;
 
 	/* If prot is same then do nothing. */
-	if (pgprot_val(old_prot) == pgprot_val(new_prot))
-		return;
+	if (pgprot_val(old_prot) == pgprot_val(d->new_pgprot))
+		return 1;
 
-	pa = pfn << PAGE_SHIFT;
-	size = page_level_size(level);
+	d->pa = d->pfn << PAGE_SHIFT;
+	d->size = page_level_size(d->pte_level);
 
 	/*
-	 * We are going to perform in-place en-/decryption and change the
-	 * physical page attribute from C=1 to C=0 or vice versa. Flush the
-	 * caches to ensure that data gets accessed with the correct C-bit.
+	 * In-place en-/decryption and physical page attribute change
+	 * from C=1 to C=0 or vice versa will be performed. Flush the
+	 * caches to ensure that data gets accessed with the correct
+	 * C-bit.
 	 */
-	clflush_cache_range(__va(pa), size);
+	if (d->va)
+		clflush_cache_range(d->va, d->size);
+	else
+		clflush_cache_range(__va(d->pa), d->size);
+
+	return 0;
+}
+
+void set_pte_enc_mask(pte_t *kpte, unsigned long pfn, pgprot_t new_prot)
+{
+	pte_t new_pte;
+
+	/* Change the page encryption mask. */
+	new_pte = pfn_pte(pfn, new_prot);
+	set_pte_atomic(kpte, new_pte);
+}
+
+static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+{
+	struct pte_enc_desc d = {
+		.kpte	     = kpte,
+		.pte_level   = level,
+		.encrypt     = enc
+	};
+
+	if (prepare_pte_enc(&d))
+		return;
 
 	/* Encrypt/decrypt the contents in-place */
 	if (enc) {
-		sme_early_encrypt(pa, size);
+		sme_early_encrypt(d.pa, d.size);
 	} else {
-		sme_early_decrypt(pa, size);
+		sme_early_decrypt(d.pa, d.size);
 
 		/*
 		 * ON SNP, the page state in the RMP table must happen
 		 * before the page table updates.
 		 */
-		early_snp_set_memory_shared((unsigned long)__va(pa), pa, 1);
+		early_snp_set_memory_shared((unsigned long)__va(d.pa), d.pa, 1);
 	}
 
-	/* Change the page encryption mask. */
-	new_pte = pfn_pte(pfn, new_prot);
-	set_pte_atomic(kpte, new_pte);
+	set_pte_enc_mask(kpte, d.pfn, d.new_pgprot);
 
 	/*
 	 * If page is set encrypted in the page table, then update the RMP table to
 	 * add this page as private.
 	 */
 	if (enc)
-		early_snp_set_memory_private((unsigned long)__va(pa), pa, 1);
+		early_snp_set_memory_private((unsigned long)__va(d.pa), d.pa, 1);
 }
 
 static int __init early_set_memory_enc_dec(unsigned long vaddr,

