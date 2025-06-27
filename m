Return-Path: <linux-tip-commits+bounces-5937-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C9AEB7B5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Jun 2025 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E651C44B03
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Jun 2025 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7B29DB8F;
	Fri, 27 Jun 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kNfq05Kw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bj8Wugek"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB7524F;
	Fri, 27 Jun 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027446; cv=none; b=R9wkurvfMt0oi4xYowryhUY55mz0QrDLIRIK5Jf8/gqGbZnvVA4+bDfrQlTB+C/FuN9kByymo6yOtjeVHW740CjrSpNbnFYZNo7SSBI4IE+fR5WoOBhUWxQfvamPmJ+UdD6rlWlTVqRF2mqRQOWqs0kbYCmx0P2+FCgSJckCVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027446; c=relaxed/simple;
	bh=tPqD7lpNKtBZq2fnjCtdln3EGyIBusmFyGEYGF4soFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ryNtz1W8G3xnNVHXaGKhj9CmnmZoZ8N5XNH+D3Q2mzvrpyR3gJRqT6cNdqKO8gpPcgCADp5ygwkDe+iZ2mBzoFmkjtuWJ5upqchvUHmVAFXlQWDa/dYLuwjJ/4FTdV1HkkgQUrtkKX42dyCyj3KB4B6C8Ni0Hc0RPqGc58+BnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kNfq05Kw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bj8Wugek; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 27 Jun 2025 12:30:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751027442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zogBGtOsfthpizvbogRciEFuJA+7qVueBtxw/sQquSY=;
	b=kNfq05KwvZC5C3mvXu2dzYJZVprkvg+I3plREGXJdD6rEonbSeZOm5/aj3YfTELeIVpVuF
	gUb0FqCbygvBxO8rLjljZ38MO/rpS3dM+PjMjkaQ5SF0NhfbEqzVEQuoqPn4XZvdzhBKQB
	0YaDargaJLgpISrw0rOlxQZwnXlzsO2sUpBbxFHadBPaBniazYlNlCB3en3zuhD+T9yRWl
	ckcOZfYovKg6L1rPd5JTmoWRib80tF5OcNO3lFfw05zzLnkK6xk4f3IY3JaOOyjIosAalz
	iuvpzDk1SXkookbERTplFmMY9FpC9LP7KsvKirG/iiajTjwQa3BfMab5M6A6nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751027442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zogBGtOsfthpizvbogRciEFuJA+7qVueBtxw/sQquSY=;
	b=bj8WugekMk1g3zoi6hZ82Z0hnOemW3C6p+apxDvAN+y4OFLVGKWQyeEMGBdb8hOhsR8RGA
	l+XCsEW/hemrPoDg==
From: "tip-bot2 for Gerd Hoffmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Let sev_es_efi_map_ghcbs() map the CA pages too
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250626114014.373748-4-kraxel@redhat.com>
References: <20250626114014.373748-4-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175102744074.406.15128722963377307885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     a7549636f67f973474ebe1ad262acc2aa4d1327d
Gitweb:        https://git.kernel.org/tip/a7549636f67f973474ebe1ad262acc2aa4d1327d
Author:        Gerd Hoffmann <kraxel@redhat.com>
AuthorDate:    Thu, 26 Jun 2025 13:40:13 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 27 Jun 2025 14:07:10 +02:00

x86/sev: Let sev_es_efi_map_ghcbs() map the CA pages too

OVMF EFI firmware needs access to the CA page to do SVSM protocol calls. For
example, when the SVSM implements an EFI variable store, such calls will be
necessary.

So add that to sev_es_efi_map_ghcbs() and also rename the function to reflect
the additional job it is doing now.

  [ bp: Massage. ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250626114014.373748-4-kraxel@redhat.com
---
 arch/x86/coco/sev/core.c       | 17 +++++++++++++++--
 arch/x86/include/asm/sev.h     |  4 ++--
 arch/x86/platform/efi/efi_64.c |  4 ++--
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 8375ca7..46bd895 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1045,11 +1045,13 @@ int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
  * This is needed by the OVMF UEFI firmware which will use whatever it finds in
  * the GHCB MSR as its GHCB to talk to the hypervisor. So make sure the per-cpu
  * runtime GHCBs used by the kernel are also mapped in the EFI page-table.
+ *
+ * When running under SVSM the CA page is needed too, so map it as well.
  */
-int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
+int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd)
 {
+	unsigned long address, pflags, pflags_enc;
 	struct sev_es_runtime_data *data;
-	unsigned long address, pflags;
 	int cpu;
 	u64 pfn;
 
@@ -1057,6 +1059,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
+	pflags_enc = cc_mkenc(pflags);
 
 	for_each_possible_cpu(cpu) {
 		data = per_cpu(runtime_data, cpu);
@@ -1066,6 +1069,16 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 
 		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
 			return 1;
+
+		if (snp_vmpl) {
+			address = per_cpu(svsm_caa_pa, cpu);
+			if (!address)
+				return 1;
+
+			pfn = address >> PAGE_SHIFT;
+			if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags_enc))
+				return 1;
+		}
 	}
 
 	return 0;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fbb616f..a81769a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -446,7 +446,7 @@ static __always_inline void sev_es_nmi_complete(void)
 	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		__sev_es_nmi_complete();
 }
-extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd);
 extern void sev_enable(struct boot_params *bp);
 
 /*
@@ -554,7 +554,7 @@ static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
-static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline int sev_es_efi_map_ghcbs_cas(pgd_t *pgd) { return 0; }
 static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e7e8f77..b4409df 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -216,8 +216,8 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	 * When SEV-ES is active, the GHCB as set by the kernel will be used
 	 * by firmware. Create a 1:1 unencrypted mapping for each GHCB.
 	 */
-	if (sev_es_efi_map_ghcbs(pgd)) {
-		pr_err("Failed to create 1:1 mapping for the GHCBs!\n");
+	if (sev_es_efi_map_ghcbs_cas(pgd)) {
+		pr_err("Failed to create 1:1 mapping for the GHCBs and CAs!\n");
 		return 1;
 	}
 

