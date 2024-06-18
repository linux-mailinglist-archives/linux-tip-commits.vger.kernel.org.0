Return-Path: <linux-tip-commits+bounces-1438-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4956190C84E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA111C22365
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F376520004C;
	Tue, 18 Jun 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsaCBGgI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vdvpuqkB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50E1FF810;
	Tue, 18 Jun 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703907; cv=none; b=nClvYQ16DYWXT6V4NO5HIouJ4+SVf8rY0ovFxppcF7VxGSnsNQZZ+t+lcmB9VheA+sudCfmJ5R1+T7YlYZhVR/ALDSgN5wAcVhNkELKe0w4EwUjW7Oh87OrX6sI4kSiC49pVWnrkBOtEywb9UTZGInrSylSn6y221AQclcdvX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703907; c=relaxed/simple;
	bh=KPimsJBAk/HjFdMFupG5IkSVE8lyyurP031VI3rSfnM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jEPWnBdLtEIbyoMUPofKXjZyftzrwZTywGBtmD2d1Fd+qDllh1m5r8PvWmI8DobMNLHxib23h2QUMH1dkTVlIkYuOnTLwCkfJA3DQj+9Ar+xJwLdhYPSRE6DKCP9hnKsEnt2qwsBUfV+xtudP7hyHh90jbO71zDQl/m23+VHypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jsaCBGgI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vdvpuqkB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:45:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEzQX94c1qTMxabKLRjjpYGbp+9Wlb6oTrCrXuEjayA=;
	b=jsaCBGgIOnyCS8gKIZUDro1lCLa/oUNIcpv6r5wCXJENGKnZBwM30PgtUI7Gg5GUQfYwex
	/44Yg6FyA0bSedaB/hqPfZ1wRP0B0WJHRnFA/MbLm5v4PgFkKViTT2iqbZqYVHkrT8rDpL
	t8z1FfrAyBmTuEswfVrCrUuV4TTHWya2Od/UFzy7XVHq5S4wvpRfeJy2LYmmkAQyhvD4Md
	FrdkWtViFtMgwpT0ANYc20Ihz/mCQ5kJCRy0K6U1kw9i9hwQTTFhZN0jRXnLBcJzgLfeeb
	zEZlEvZLXbOI70Y7XxlO0C3BFHoemymddYywWoYDhU8BCNA+oEipPrecGj8yXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEzQX94c1qTMxabKLRjjpYGbp+9Wlb6oTrCrXuEjayA=;
	b=vdvpuqkBPDTin/eJa9JukqJzbSqMvbhW9PLLPVLmVJg7ODGuvHPYR2WhMoMr7izJ5RtsZu
	ekMqRHb3ryVvbGAQ==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4c4017d8b94512d565de9ccb555b1a9f8983c69c=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C4c4017d8b94512d565de9ccb555b1a9f8983c69c=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870390039.10875.5914598456521790988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     fcd042e86422442f999feae96f34a408555be248
Gitweb:        https://git.kernel.org/tip/fcd042e86422442f999feae96f34a408555be248
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:47 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:37:54 +02:00

x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0

The PVALIDATE instruction can only be performed at VMPL0. If an SVSM is
present, it will be running at VMPL0 while the guest itself is then
running at VMPL1 or a lower privilege level.

In that case, use the SVSM_CORE_PVALIDATE call to perform memory
validation instead of issuing the PVALIDATE instruction directly.

The validation of a single 4K page is now explicitly identified as such
in the function name, pvalidate_4k_page(). The pvalidate_pages()
function is used for validating 1 or more pages at either 4K or 2M in
size. Each function, however, determines whether it can issue the
PVALIDATE directly or whether the SVSM needs to be invoked.

  [ bp: Touchups. ]
  [ Tom: fold in a fix for Coconut SVSM:
    https://lore.kernel.org/r/234bb23c-d295-76e5-a690-7ea68dc1118b@amd.com  ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/4c4017d8b94512d565de9ccb555b1a9f8983c69c.1717600736.git.thomas.lendacky@amd.com
---
 arch/x86/boot/compressed/sev.c |  46 +++++-
 arch/x86/include/asm/sev.h     |  26 +++-
 arch/x86/kernel/sev-shared.c   | 248 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/sev.c          |  32 ++--
 4 files changed, 328 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c65820b..ce941a9 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -129,6 +129,34 @@ static bool fault_in_kernel_space(unsigned long address)
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+static struct svsm_ca *svsm_get_caa(void)
+{
+	return boot_svsm_caa;
+}
+
+static u64 svsm_get_caa_pa(void)
+{
+	return boot_svsm_caa_pa;
+}
+
+static int svsm_perform_call_protocol(struct svsm_call *call)
+{
+	struct ghcb *ghcb;
+	int ret;
+
+	if (boot_ghcb)
+		ghcb = boot_ghcb;
+	else
+		ghcb = NULL;
+
+	do {
+		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
+			   : svsm_perform_msr_protocol(call);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
 bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
@@ -145,8 +173,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * If private -> shared then invalidate the page before requesting the
 	 * state change in the RMP table.
 	 */
-	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(paddr, paddr, false);
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
@@ -161,8 +189,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
 	 */
-	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(paddr, paddr, true);
 }
 
 void snp_set_page_private(unsigned long paddr)
@@ -256,6 +284,16 @@ void sev_es_shutdown_ghcb(void)
 		error("SEV-ES CPU Features missing.");
 
 	/*
+	 * This denotes whether to use the GHCB MSR protocol or the GHCB
+	 * shared page to perform a GHCB request. Since the GHCB page is
+	 * being changed to encrypted, it can't be used to perform GHCB
+	 * requests. Clear the boot_ghcb variable so that the GHCB MSR
+	 * protocol is used to change the GHCB page over to an encrypted
+	 * page.
+	 */
+	boot_ghcb = NULL;
+
+	/*
 	 * GHCB Page must be flushed from the cache and mapped encrypted again.
 	 * Otherwise the running kernel will see strange cache effects when
 	 * trying to use that page.
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4145928..874295a 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -187,6 +187,31 @@ struct svsm_ca {
 #define SVSM_ERR_INVALID_PARAMETER		0x80000005
 #define SVSM_ERR_INVALID_REQUEST		0x80000006
 #define SVSM_ERR_BUSY				0x80000007
+#define SVSM_PVALIDATE_FAIL_SIZEMISMATCH	0x80001006
+
+/*
+ * The SVSM PVALIDATE related structures
+ */
+struct svsm_pvalidate_entry {
+	u64 page_size		: 2,
+	    action		: 1,
+	    ignore_cf		: 1,
+	    rsvd		: 8,
+	    pfn			: 52;
+};
+
+struct svsm_pvalidate_call {
+	u16 num_entries;
+	u16 cur_index;
+
+	u8 rsvd1[4];
+
+	struct svsm_pvalidate_entry entry[];
+};
+
+#define SVSM_PVALIDATE_MAX_COUNT	((sizeof_field(struct svsm_ca, svsm_buffer) -		\
+					  offsetof(struct svsm_pvalidate_call, entry)) /	\
+					 sizeof(struct svsm_pvalidate_entry))
 
 /*
  * SVSM protocol structure
@@ -207,6 +232,7 @@ struct svsm_call {
 
 #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
 #define SVSM_CORE_REMAP_CA		0
+#define SVSM_CORE_PVALIDATE		1
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b5110c6..7933c12 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -40,6 +40,10 @@ static u8 snp_vmpl __ro_after_init;
 static struct svsm_ca *boot_svsm_caa __ro_after_init;
 static u64 boot_svsm_caa_pa __ro_after_init;
 
+static struct svsm_ca *svsm_get_caa(void);
+static u64 svsm_get_caa_pa(void);
+static int svsm_perform_call_protocol(struct svsm_call *call);
+
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -1216,38 +1220,268 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
-static void pvalidate_pages(struct snp_psc_desc *desc)
+static inline void __pval_terminate(u64 pfn, bool action, unsigned int page_size,
+				    int ret, u64 svsm_ret)
+{
+	WARN(1, "PVALIDATE failure: pfn: 0x%llx, action: %u, size: %u, ret: %d, svsm_ret: 0x%llx\n",
+	     pfn, action, page_size, ret, svsm_ret);
+
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
+static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svsm_ret)
+{
+	unsigned int page_size;
+	bool action;
+	u64 pfn;
+
+	pfn = pc->entry[pc->cur_index].pfn;
+	action = pc->entry[pc->cur_index].action;
+	page_size = pc->entry[pc->cur_index].page_size;
+
+	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
+}
+
+static void svsm_pval_4k_page(unsigned long paddr, bool validate)
+{
+	struct svsm_pvalidate_call *pc;
+	struct svsm_call call = {};
+	unsigned long flags;
+	u64 pc_pa;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_local_irq_save();
+
+	call.caa = svsm_get_caa();
+
+	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	pc->num_entries = 1;
+	pc->cur_index   = 0;
+	pc->entry[0].page_size = RMP_PG_SIZE_4K;
+	pc->entry[0].action    = validate;
+	pc->entry[0].ignore_cf = 0;
+	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
+
+	/* Protocol 0, Call ID 1 */
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx = pc_pa;
+
+	ret = svsm_perform_call_protocol(&call);
+	if (ret)
+		svsm_pval_terminate(pc, ret, call.rax_out);
+
+	native_local_irq_restore(flags);
+}
+
+static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
+{
+	int ret;
+
+	/*
+	 * This can be called very early during boot, so use rIP-relative
+	 * references as needed.
+	 */
+	if (RIP_REL_REF(snp_vmpl)) {
+		svsm_pval_4k_page(paddr, validate);
+	} else {
+		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+		if (ret)
+			__pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret, 0);
+	}
+}
+
+static void pval_pages(struct snp_psc_desc *desc)
 {
 	struct psc_entry *e;
 	unsigned long vaddr;
 	unsigned int size;
 	unsigned int i;
 	bool validate;
+	u64 pfn;
 	int rc;
 
 	for (i = 0; i <= desc->hdr.end_entry; i++) {
 		e = &desc->entries[i];
 
-		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
+		pfn = e->gfn;
+		vaddr = (unsigned long)pfn_to_kaddr(pfn);
 		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
 
 		rc = pvalidate(vaddr, size, validate);
+		if (!rc)
+			continue;
+
 		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
 			unsigned long vaddr_end = vaddr + PMD_SIZE;
 
-			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
+			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE, pfn++) {
 				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 				if (rc)
-					break;
+					__pval_terminate(pfn, validate, RMP_PG_SIZE_4K, rc, 0);
 			}
+		} else {
+			__pval_terminate(pfn, validate, size, rc, 0);
 		}
+	}
+}
+
+static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
+					struct svsm_pvalidate_call *pc)
+{
+	struct svsm_pvalidate_entry *pe;
+
+	/* Nothing in the CA yet */
+	pc->num_entries = 0;
+	pc->cur_index   = 0;
+
+	pe = &pc->entry[0];
+
+	while (pfn < pfn_end) {
+		pe->page_size = RMP_PG_SIZE_4K;
+		pe->action    = action;
+		pe->ignore_cf = 0;
+		pe->pfn       = pfn;
+
+		pe++;
+		pfn++;
+
+		pc->num_entries++;
+		if (pc->num_entries == SVSM_PVALIDATE_MAX_COUNT)
+			break;
+	}
+
+	return pfn;
+}
+
+static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int desc_entry,
+				       struct svsm_pvalidate_call *pc)
+{
+	struct svsm_pvalidate_entry *pe;
+	struct psc_entry *e;
+
+	/* Nothing in the CA yet */
+	pc->num_entries = 0;
+	pc->cur_index   = 0;
+
+	pe = &pc->entry[0];
+	e  = &desc->entries[desc_entry];
+
+	while (desc_entry <= desc->hdr.end_entry) {
+		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
+		pe->ignore_cf = 0;
+		pe->pfn       = e->gfn;
+
+		pe++;
+		e++;
+
+		desc_entry++;
+		pc->num_entries++;
+		if (pc->num_entries == SVSM_PVALIDATE_MAX_COUNT)
+			break;
+	}
+
+	return desc_entry;
+}
+
+static void svsm_pval_pages(struct snp_psc_desc *desc)
+{
+	struct svsm_pvalidate_entry pv_4k[VMGEXIT_PSC_MAX_ENTRY];
+	unsigned int i, pv_4k_count = 0;
+	struct svsm_pvalidate_call *pc;
+	struct svsm_call call = {};
+	unsigned long flags;
+	bool action;
+	u64 pc_pa;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_local_irq_save();
+
+	/*
+	 * The SVSM calling area (CA) can support processing 510 entries at a
+	 * time. Loop through the Page State Change descriptor until the CA is
+	 * full or the last entry in the descriptor is reached, at which time
+	 * the SVSM is invoked. This repeats until all entries in the descriptor
+	 * are processed.
+	 */
+	call.caa = svsm_get_caa();
+
+	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	/* Protocol 0, Call ID 1 */
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx = pc_pa;
+
+	for (i = 0; i <= desc->hdr.end_entry;) {
+		i = svsm_build_ca_from_psc_desc(desc, i, pc);
+
+		do {
+			ret = svsm_perform_call_protocol(&call);
+			if (!ret)
+				continue;
 
-		if (rc) {
-			WARN(1, "Failed to validate address 0x%lx ret %d", vaddr, rc);
-			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+			/*
+			 * Check if the entry failed because of an RMP mismatch (a
+			 * PVALIDATE at 2M was requested, but the page is mapped in
+			 * the RMP as 4K).
+			 */
+
+			if (call.rax_out == SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
+			    pc->entry[pc->cur_index].page_size == RMP_PG_SIZE_2M) {
+				/* Save this entry for post-processing at 4K */
+				pv_4k[pv_4k_count++] = pc->entry[pc->cur_index];
+
+				/* Skip to the next one unless at the end of the list */
+				pc->cur_index++;
+				if (pc->cur_index < pc->num_entries)
+					ret = -EAGAIN;
+				else
+					ret = 0;
+			}
+		} while (ret == -EAGAIN);
+
+		if (ret)
+			svsm_pval_terminate(pc, ret, call.rax_out);
+	}
+
+	/* Process any entries that failed to be validated at 2M and validate them at 4K */
+	for (i = 0; i < pv_4k_count; i++) {
+		u64 pfn, pfn_end;
+
+		action  = pv_4k[i].action;
+		pfn     = pv_4k[i].pfn;
+		pfn_end = pfn + 512;
+
+		while (pfn < pfn_end) {
+			pfn = svsm_build_ca_from_pfn_range(pfn, pfn_end, action, pc);
+
+			ret = svsm_perform_call_protocol(&call);
+			if (ret)
+				svsm_pval_terminate(pc, ret, call.rax_out);
 		}
 	}
+
+	native_local_irq_restore(flags);
+}
+
+static void pvalidate_pages(struct snp_psc_desc *desc)
+{
+	if (snp_vmpl)
+		svsm_pval_pages(desc);
+	else
+		pval_pages(desc);
 }
 
 static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 51a0984..f1d11e7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -628,6 +628,19 @@ static inline struct svsm_ca *svsm_get_caa(void)
 		return RIP_REL_REF(boot_svsm_caa);
 }
 
+static u64 svsm_get_caa_pa(void)
+{
+	/*
+	 * Use rIP-relative references when called early in the boot. If
+	 * ->use_cas is set, then it is late in the boot and no need
+	 * to worry about rIP-relative references.
+	 */
+	if (RIP_REL_REF(sev_cfg).use_cas)
+		return this_cpu_read(svsm_caa_pa);
+	else
+		return RIP_REL_REF(boot_svsm_caa_pa);
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -800,7 +813,6 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 {
 	unsigned long paddr_end;
 	u64 val;
-	int ret;
 
 	vaddr = vaddr & PAGE_MASK;
 
@@ -808,12 +820,9 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	paddr_end = paddr + (npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
-		if (op == SNP_PAGE_STATE_SHARED) {
-			/* Page validation must be rescinded before changing to shared */
-			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
-				goto e_term;
-		}
+		/* Page validation must be rescinded before changing to shared */
+		if (op == SNP_PAGE_STATE_SHARED)
+			pvalidate_4k_page(vaddr, paddr, false);
 
 		/*
 		 * Use the MSR protocol because this function can be called before
@@ -835,12 +844,9 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
 			goto e_term;
 
-		if (op == SNP_PAGE_STATE_PRIVATE) {
-			/* Page validation must be performed after changing to private */
-			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
-				goto e_term;
-		}
+		/* Page validation must be performed after changing to private */
+		if (op == SNP_PAGE_STATE_PRIVATE)
+			pvalidate_4k_page(vaddr, paddr, true);
 
 		vaddr += PAGE_SIZE;
 		paddr += PAGE_SIZE;

