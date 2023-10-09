Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53647BDBFA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Oct 2023 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376630AbjJIMak (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 9 Oct 2023 08:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376452AbjJIMaK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 9 Oct 2023 08:30:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C6B11C;
        Mon,  9 Oct 2023 05:29:58 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYIMDAsGBhcntMiDEu1df9dT9eAW1OZanq+2WzOeN3o=;
        b=OiW5Z/x+8DoDJpReFR0vO5prGDXaKga1v/CXFqgHXhZN7VqXBHKLKAr7ZbI3xWz9TXEpqH
        33jpi0CU//Z0yoCcTu3Xu2cwUvsoR42OI2Gs5xLMtXETJDibYhZuVf1iTgFuNkVzr18TAq
        RuHRcuiCkHuDopnYF1oAMbNMto9D+g1HfgXMTGCFit/Co4kzsM9T5SUS2fmPrXCA28G4q7
        plJcOXlPkcBNvj05Hfxq4t4PHo6rXPBNHP17+NBlHD8Uy3zWNWTy2H/FiNqrwRhy1PBEr/
        Dw5MpEsEnnKMPGD0Gi4jJtJcqK2fHm3LDfxR5JUb4iYx1bjeMsJgrJdLCbu8mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYIMDAsGBhcntMiDEu1df9dT9eAW1OZanq+2WzOeN3o=;
        b=IQK8fK+gS9EhEwA2T+b07Hi1pF0ODno15xPbCLMbx6rXAxkx+PBupODqCbvUxD22wjSFTw
        gfEk2JCQZUaaRNAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/32: Move early loading after paging enable
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1356075872-3054-1-git-send-email-fenghua.yu@intel.com>
References: <1356075872-3054-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <169685459686.3135.15065440043035911736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     3f320038de388fac90a402625cabd613c2797557
Gitweb:        https://git.kernel.org/tip/3f320038de388fac90a402625cabd613c2797557
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:35 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Oct 2023 17:06:16 +02:00

x86/microcode/32: Move early loading after paging enable

32-bit loads microcode before paging is enabled. The commit which
introduced that has zero justification in the changelog. The cover letter
has slightly more content, but it does not give any technical justification
either:

  "The problem in current microcode loading method is that we load a
   microcode way, way too late; ideally we should load it before turning
   paging on.  This may only be practical on 32 bits since we can't get to
   64-bit mode without paging on, but we should still do it as early as at
   all possible."

Handwaving word salad with zero technical content.

Someone claimed in an offlist conversation that this is required for curing
the ATOM erratum AAE44/AAF40/AAG38/AAH41. That erratum requires an
microcode update in order to make the usage of PSE safe. But during early
boot PSE is completely irrelevant and it is evaluated way later.

Neither is it relevant for the AP on single core HT enabled CPUs as the
microcode loading on the AP is not doing anything.

On dual core CPUs there is a theoretical problem if a split of an
executable large page between enabling paging including PSE and loading the
microcode happens. But that's only theoretical, it's practically irrelevant
because the affected dual core CPUs are 64bit enabled and therefore have
paging and PSE enabled before loading the microcode on the second core. So
why would it work on 64-bit but not on 32-bit?

The erratum:

  "AAG38 Code Fetch May Occur to Incorrect Address After a Large Page is
   Split Into 4-Kbyte Pages

   Problem: If software clears the PS (page size) bit in a present PDE
   (page directory entry), that will cause linear addresses mapped through
   this PDE to use 4-KByte pages instead of using a large page after old
   TLB entries are invalidated. Due to this erratum, if a code fetch uses
   this PDE before the TLB entry for the large page is invalidated then it
   may fetch from a different physical address than specified by either the
   old large page translation or the new 4-KByte page translation. This
   erratum may also cause speculative code fetches from incorrect addresses."

The practical relevance for this is exactly zero because there is no
splitting of large text pages during early boot-time, i.e. between paging
enable and microcode loading, and neither during CPU hotplug.

IOW, this load microcode before paging enable is yet another voodoo
programming solution in search of a problem. What's worse is that it causes
at least two serious problems:

 1) When stackprotector is enabled then the microcode loader code has the
    stackprotector mechanics enabled. The read from the per CPU variable
    __stack_chk_guard is always accessing the virtual address either
    directly on UP or via FS on SMP. In physical address mode this results
    in an access to memory above 3GB. So this works by chance as the
    hardware returns the same value when there is no RAM at this physical
    address. When there is RAM populated above 3G then the read is by
    chance the same as nothing changes that memory during the very early
    boot stage. That's not necessarily true during runtime CPU hotplug.

 2) When function tracing is enabled, then the relevant microcode loader
    functions and the functions invoked from there will call into the
    tracing code and evaluate global and per CPU variables in physical
    address mode. What could potentially go wrong?

Cure this and move the microcode loading after the early paging enable and
remove the gunk in the microcode loader which is required to handle
physical address mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/lkml/1356075872-3054-1-git-send-email-fenghua.yu@intel.com
Link: https://lore.kernel.org/r/20231002115902.096543357@linutronix.de
---
 arch/x86/include/asm/microcode.h         |   5 +-
 arch/x86/kernel/cpu/common.c             |  12 +--
 arch/x86/kernel/cpu/microcode/amd.c      | 103 ++++++--------------
 arch/x86/kernel/cpu/microcode/core.c     |  73 ++------------
 arch/x86/kernel/cpu/microcode/intel.c    | 116 +++-------------------
 arch/x86/kernel/cpu/microcode/internal.h |   2 +-
 arch/x86/kernel/head32.c                 |   3 +-
 arch/x86/kernel/head_32.S                |  10 +--
 arch/x86/kernel/smpboot.c                |  12 +--
 9 files changed, 71 insertions(+), 265 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index bbbe9d7..65ac490 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -68,11 +68,6 @@ static inline u32 intel_get_microcode_revision(void)
 
 	return rev;
 }
-
-void show_ucode_info_early(void);
-
-#else /* CONFIG_CPU_SUP_INTEL */
-static inline void show_ucode_info_early(void) { }
 #endif /* !CONFIG_CPU_SUP_INTEL */
 
 #endif /* _ASM_X86_MICROCODE_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4e5ffc8..bd631f1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2166,8 +2166,6 @@ static inline void setup_getcpu(int cpu)
 }
 
 #ifdef CONFIG_X86_64
-static inline void ucode_cpu_init(int cpu) { }
-
 static inline void tss_setup_ist(struct tss_struct *tss)
 {
 	/* Set up the per-CPU TSS IST stacks */
@@ -2178,16 +2176,8 @@ static inline void tss_setup_ist(struct tss_struct *tss)
 	/* Only mapped when SEV-ES is active */
 	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
 }
-
 #else /* CONFIG_X86_64 */
-
-static inline void ucode_cpu_init(int cpu)
-{
-	show_ucode_info_early();
-}
-
 static inline void tss_setup_ist(struct tss_struct *tss) { }
-
 #endif /* !CONFIG_X86_64 */
 
 static inline void tss_setup_io_bitmap(struct tss_struct *tss)
@@ -2243,8 +2233,6 @@ void cpu_init(void)
 	struct task_struct *cur = current;
 	int cpu = raw_smp_processor_id();
 
-	ucode_cpu_init(cpu);
-
 #ifdef CONFIG_NUMA
 	if (this_cpu_read(numa_node) == 0 &&
 	    early_cpu_to_node(cpu) != NUMA_NO_NODE)
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index bbd1dc3..ccca39f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -121,24 +121,20 @@ static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 
 /*
  * Check whether there is a valid microcode container file at the beginning
- * of @buf of size @buf_size. Set @early to use this function in the early path.
+ * of @buf of size @buf_size.
  */
-static bool verify_container(const u8 *buf, size_t buf_size, bool early)
+static bool verify_container(const u8 *buf, size_t buf_size)
 {
 	u32 cont_magic;
 
 	if (buf_size <= CONTAINER_HDR_SZ) {
-		if (!early)
-			pr_debug("Truncated microcode container header.\n");
-
+		pr_debug("Truncated microcode container header.\n");
 		return false;
 	}
 
 	cont_magic = *(const u32 *)buf;
 	if (cont_magic != UCODE_MAGIC) {
-		if (!early)
-			pr_debug("Invalid magic value (0x%08x).\n", cont_magic);
-
+		pr_debug("Invalid magic value (0x%08x).\n", cont_magic);
 		return false;
 	}
 
@@ -147,23 +143,20 @@ static bool verify_container(const u8 *buf, size_t buf_size, bool early)
 
 /*
  * Check whether there is a valid, non-truncated CPU equivalence table at the
- * beginning of @buf of size @buf_size. Set @early to use this function in the
- * early path.
+ * beginning of @buf of size @buf_size.
  */
-static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
+static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
 {
 	const u32 *hdr = (const u32 *)buf;
 	u32 cont_type, equiv_tbl_len;
 
-	if (!verify_container(buf, buf_size, early))
+	if (!verify_container(buf, buf_size))
 		return false;
 
 	cont_type = hdr[1];
 	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
-		if (!early)
-			pr_debug("Wrong microcode container equivalence table type: %u.\n",
-			       cont_type);
-
+		pr_debug("Wrong microcode container equivalence table type: %u.\n",
+			 cont_type);
 		return false;
 	}
 
@@ -172,9 +165,7 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
 	equiv_tbl_len = hdr[2];
 	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
 	    buf_size < equiv_tbl_len) {
-		if (!early)
-			pr_debug("Truncated equivalence table.\n");
-
+		pr_debug("Truncated equivalence table.\n");
 		return false;
 	}
 
@@ -183,22 +174,19 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
 
 /*
  * Check whether there is a valid, non-truncated microcode patch section at the
- * beginning of @buf of size @buf_size. Set @early to use this function in the
- * early path.
+ * beginning of @buf of size @buf_size.
  *
  * On success, @sh_psize returns the patch size according to the section header,
  * to the caller.
  */
 static bool
-__verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize, bool early)
+__verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
 {
 	u32 p_type, p_size;
 	const u32 *hdr;
 
 	if (buf_size < SECTION_HDR_SIZE) {
-		if (!early)
-			pr_debug("Truncated patch section.\n");
-
+		pr_debug("Truncated patch section.\n");
 		return false;
 	}
 
@@ -207,17 +195,13 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize, bool early
 	p_size = hdr[1];
 
 	if (p_type != UCODE_UCODE_TYPE) {
-		if (!early)
-			pr_debug("Invalid type field (0x%x) in container file section header.\n",
-				p_type);
-
+		pr_debug("Invalid type field (0x%x) in container file section header.\n",
+			 p_type);
 		return false;
 	}
 
 	if (p_size < sizeof(struct microcode_header_amd)) {
-		if (!early)
-			pr_debug("Patch of size %u too short.\n", p_size);
-
+		pr_debug("Patch of size %u too short.\n", p_size);
 		return false;
 	}
 
@@ -269,7 +253,7 @@ static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size
  * 0: success
  */
 static int
-verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size, bool early)
+verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size)
 {
 	struct microcode_header_amd *mc_hdr;
 	unsigned int ret;
@@ -277,7 +261,7 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size, bool ea
 	u16 proc_id;
 	u8 patch_fam;
 
-	if (!__verify_patch_section(buf, buf_size, &sh_psize, early))
+	if (!__verify_patch_section(buf, buf_size, &sh_psize))
 		return -1;
 
 	/*
@@ -292,16 +276,13 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size, bool ea
 	 * size sh_psize, as the section claims.
 	 */
 	if (buf_size < sh_psize) {
-		if (!early)
-			pr_debug("Patch of size %u truncated.\n", sh_psize);
-
+		pr_debug("Patch of size %u truncated.\n", sh_psize);
 		return -1;
 	}
 
 	ret = __verify_patch_size(family, sh_psize, buf_size);
 	if (!ret) {
-		if (!early)
-			pr_debug("Per-family patch size mismatch.\n");
+		pr_debug("Per-family patch size mismatch.\n");
 		return -1;
 	}
 
@@ -309,8 +290,7 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size, bool ea
 
 	mc_hdr	= (struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
 	if (mc_hdr->nb_dev_id || mc_hdr->sb_dev_id) {
-		if (!early)
-			pr_err("Patch-ID 0x%08x: chipset-specific code unsupported.\n", mc_hdr->patch_id);
+		pr_err("Patch-ID 0x%08x: chipset-specific code unsupported.\n", mc_hdr->patch_id);
 		return -1;
 	}
 
@@ -337,7 +317,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 	u16 eq_id;
 	u8 *buf;
 
-	if (!verify_equivalence_table(ucode, size, true))
+	if (!verify_equivalence_table(ucode, size))
 		return 0;
 
 	buf = ucode;
@@ -364,7 +344,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		u32 patch_size;
 		int ret;
 
-		ret = verify_patch(x86_family(desc->cpuid_1_eax), buf, size, &patch_size, true);
+		ret = verify_patch(x86_family(desc->cpuid_1_eax), buf, size, &patch_size);
 		if (ret < 0) {
 			/*
 			 * Patch verification failed, skip to the next container, if
@@ -456,14 +436,8 @@ static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
 {
 	struct cont_desc desc = { 0 };
 	struct microcode_amd *mc;
-	u32 rev, dummy, *new_rev;
 	bool ret = false;
-
-#ifdef CONFIG_X86_32
-	new_rev = (u32 *)__pa_nodebug(&ucode_new_rev);
-#else
-	new_rev = &ucode_new_rev;
-#endif
+	u32 rev, dummy;
 
 	desc.cpuid_1_eax = cpuid_1_eax;
 
@@ -484,8 +458,8 @@ static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size)
 		return ret;
 
 	if (!__apply_microcode_amd(mc)) {
-		*new_rev = mc->hdr.patch_id;
-		ret      = true;
+		ucode_new_rev = mc->hdr.patch_id;
+		ret = true;
 	}
 
 	return ret;
@@ -514,26 +488,13 @@ static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
 
 static void find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data *ret)
 {
-	struct ucode_cpu_info *uci;
 	struct cpio_data cp;
-	const char *path;
-	bool use_pa;
-
-	if (IS_ENABLED(CONFIG_X86_32)) {
-		uci	= (struct ucode_cpu_info *)__pa_nodebug(ucode_cpu_info);
-		path	= (const char *)__pa_nodebug(ucode_path);
-		use_pa	= true;
-	} else {
-		uci     = ucode_cpu_info;
-		path	= ucode_path;
-		use_pa	= false;
-	}
 
 	if (!get_builtin_microcode(&cp, x86_family(cpuid_1_eax)))
-		cp = find_microcode_in_initrd(path, use_pa);
+		cp = find_microcode_in_initrd(ucode_path);
 
 	/* Needed in load_microcode_amd() */
-	uci->cpu_sig.sig = cpuid_1_eax;
+	ucode_cpu_info->cpu_sig.sig = cpuid_1_eax;
 
 	*ret = cp;
 }
@@ -562,7 +523,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	cp = find_microcode_in_initrd(ucode_path, false);
+	cp = find_microcode_in_initrd(ucode_path);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
 
@@ -738,7 +699,7 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	u32 equiv_tbl_len;
 	const u32 *hdr;
 
-	if (!verify_equivalence_table(buf, buf_size, false))
+	if (!verify_equivalence_table(buf, buf_size))
 		return 0;
 
 	hdr = (const u32 *)buf;
@@ -784,7 +745,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 	u16 proc_id;
 	int ret;
 
-	ret = verify_patch(family, fw, leftover, patch_size, false);
+	ret = verify_patch(family, fw, leftover, patch_size);
 	if (ret)
 		return ret;
 
@@ -918,7 +879,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 	}
 
 	ret = UCODE_ERROR;
-	if (!verify_container(fw->data, fw->size, false))
+	if (!verify_container(fw->data, fw->size))
 		goto fw_release;
 
 	ret = load_microcode_amd(c->x86, fw->data, fw->size);
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6cc7a2c..f76c2c1 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -90,10 +90,7 @@ static bool amd_check_current_patch_level(void)
 
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, lvl, dummy);
 
-	if (IS_ENABLED(CONFIG_X86_32))
-		levels = (u32 *)__pa_nodebug(&final_levels);
-	else
-		levels = final_levels;
+	levels = final_levels;
 
 	for (i = 0; levels[i]; i++) {
 		if (lvl == levels[i])
@@ -105,17 +102,8 @@ static bool amd_check_current_patch_level(void)
 static bool __init check_loader_disabled_bsp(void)
 {
 	static const char *__dis_opt_str = "dis_ucode_ldr";
-
-#ifdef CONFIG_X86_32
-	const char *cmdline = (const char *)__pa_nodebug(boot_command_line);
-	const char *option  = (const char *)__pa_nodebug(__dis_opt_str);
-	bool *res = (bool *)__pa_nodebug(&dis_ucode_ldr);
-
-#else /* CONFIG_X86_64 */
 	const char *cmdline = boot_command_line;
 	const char *option  = __dis_opt_str;
-	bool *res = &dis_ucode_ldr;
-#endif
 
 	/*
 	 * CPUID(1).ECX[31]: reserved for hypervisor use. This is still not
@@ -123,17 +111,17 @@ static bool __init check_loader_disabled_bsp(void)
 	 * that's good enough as they don't land on the BSP path anyway.
 	 */
 	if (native_cpuid_ecx(1) & BIT(31))
-		return *res;
+		return true;
 
 	if (x86_cpuid_vendor() == X86_VENDOR_AMD) {
 		if (amd_check_current_patch_level())
-			return *res;
+			return true;
 	}
 
 	if (cmdline_find_option_bool(cmdline, option) <= 0)
-		*res = false;
+		dis_ucode_ldr = false;
 
-	return *res;
+	return dis_ucode_ldr;
 }
 
 void __init load_ucode_bsp(void)
@@ -171,20 +159,11 @@ void __init load_ucode_bsp(void)
 		load_ucode_amd_early(cpuid_1_eax);
 }
 
-static bool check_loader_disabled_ap(void)
-{
-#ifdef CONFIG_X86_32
-	return *((bool *)__pa_nodebug(&dis_ucode_ldr));
-#else
-	return dis_ucode_ldr;
-#endif
-}
-
 void load_ucode_ap(void)
 {
 	unsigned int cpuid_1_eax;
 
-	if (check_loader_disabled_ap())
+	if (dis_ucode_ldr)
 		return;
 
 	cpuid_1_eax = native_cpuid_eax(1);
@@ -226,40 +205,31 @@ static int __init save_microcode_in_initrd(void)
 	return ret;
 }
 
-struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa)
+struct cpio_data find_microcode_in_initrd(const char *path)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long start = 0;
 	size_t size;
 
 #ifdef CONFIG_X86_32
-	struct boot_params *params;
-
-	if (use_pa)
-		params = (struct boot_params *)__pa_nodebug(&boot_params);
-	else
-		params = &boot_params;
-
-	size = params->hdr.ramdisk_size;
-
+	size = boot_params.hdr.ramdisk_size;
 	/*
 	 * Set start only if we have an initrd image. We cannot use initrd_start
 	 * because it is not set that early yet.
 	 */
 	if (size)
-		start = params->hdr.ramdisk_image;
+		start = boot_params.hdr.ramdisk_image;
 
-# else /* CONFIG_X86_64 */
+#else /* CONFIG_X86_64 */
 	size  = (unsigned long)boot_params.ext_ramdisk_size << 32;
 	size |= boot_params.hdr.ramdisk_size;
 
 	if (size) {
 		start  = (unsigned long)boot_params.ext_ramdisk_image << 32;
 		start |= boot_params.hdr.ramdisk_image;
-
 		start += PAGE_OFFSET;
 	}
-# endif
+#endif
 
 	/*
 	 * Fixup the start address: after reserve_initrd() runs, initrd_start
@@ -270,23 +240,10 @@ struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa)
 	 * initrd_gone is for the hotplug case where we've thrown out initrd
 	 * already.
 	 */
-	if (!use_pa) {
-		if (initrd_gone)
-			return (struct cpio_data){ NULL, 0, "" };
-		if (initrd_start)
-			start = initrd_start;
-	} else {
-		/*
-		 * The picture with physical addresses is a bit different: we
-		 * need to get the *physical* address to which the ramdisk was
-		 * relocated, i.e., relocated_ramdisk (not initrd_start) and
-		 * since we're running from physical addresses, we need to access
-		 * relocated_ramdisk through its *physical* address too.
-		 */
-		u64 *rr = (u64 *)__pa_nodebug(&relocated_ramdisk);
-		if (*rr)
-			start = *rr;
-	}
+	if (initrd_gone)
+		return (struct cpio_data){ NULL, 0, "" };
+	if (initrd_start)
+		start = initrd_start;
 
 	return find_cpio_data(path, (void *)start, size, NULL);
 #else /* !CONFIG_BLK_DEV_INITRD */
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 94dd6af..24a5c8b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -319,15 +319,8 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 	if (!intel_find_matching_signature(p->data, uci->cpu_sig.sig, uci->cpu_sig.pf))
 		return;
 
-	/*
-	 * Save for early loading. On 32-bit, that needs to be a physical
-	 * address as the APs are running from physical addresses, before
-	 * paging has been enabled.
-	 */
-	if (IS_ENABLED(CONFIG_X86_32))
-		intel_ucode_patch = (struct microcode_intel *)__pa_nodebug(p->data);
-	else
-		intel_ucode_patch = p->data;
+	/* Save for early loading */
+	intel_ucode_patch = p->data;
 }
 
 /*
@@ -420,66 +413,10 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 	return false;
 }
 
-static void print_ucode_info(int old_rev, int new_rev, unsigned int date)
-{
-	pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
-		     old_rev,
-		     new_rev,
-		     date & 0xffff,
-		     date >> 24,
-		     (date >> 16) & 0xff);
-}
-
-#ifdef CONFIG_X86_32
-
-static int delay_ucode_info;
-static int current_mc_date;
-static int early_old_rev;
-
-/*
- * Print early updated ucode info after printk works. This is delayed info dump.
- */
-void show_ucode_info_early(void)
-{
-	struct ucode_cpu_info uci;
-
-	if (delay_ucode_info) {
-		intel_cpu_collect_info(&uci);
-		print_ucode_info(early_old_rev, uci.cpu_sig.rev, current_mc_date);
-		delay_ucode_info = 0;
-	}
-}
-
-/*
- * At this point, we can not call printk() yet. Delay printing microcode info in
- * show_ucode_info_early() until printk() works.
- */
-static void print_ucode(int old_rev, int new_rev, int date)
-{
-	int *delay_ucode_info_p;
-	int *current_mc_date_p;
-	int *early_old_rev_p;
-
-	delay_ucode_info_p = (int *)__pa_nodebug(&delay_ucode_info);
-	current_mc_date_p = (int *)__pa_nodebug(&current_mc_date);
-	early_old_rev_p = (int *)__pa_nodebug(&early_old_rev);
-
-	*delay_ucode_info_p = 1;
-	*current_mc_date_p = date;
-	*early_old_rev_p = old_rev;
-}
-#else
-
-static inline void print_ucode(int old_rev, int new_rev, int date)
-{
-	print_ucode_info(old_rev, new_rev, date);
-}
-#endif
-
-static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
+static int apply_microcode_early(struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc;
-	u32 rev, old_rev;
+	u32 rev, old_rev, date;
 
 	mc = uci->mc;
 	if (!mc)
@@ -513,11 +450,9 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 
 	uci->cpu_sig.rev = rev;
 
-	if (early)
-		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
-	else
-		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
-
+	date = mc->hdr.date;
+	pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
+		     old_rev, rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
 	return 0;
 }
 
@@ -535,7 +470,7 @@ int __init save_microcode_in_initrd_intel(void)
 	intel_ucode_patch = NULL;
 
 	if (!load_builtin_intel_microcode(&cp))
-		cp = find_microcode_in_initrd(ucode_path, false);
+		cp = find_microcode_in_initrd(ucode_path);
 
 	if (!(cp.data && cp.size))
 		return 0;
@@ -551,21 +486,11 @@ int __init save_microcode_in_initrd_intel(void)
  */
 static struct microcode_intel *__load_ucode_intel(struct ucode_cpu_info *uci)
 {
-	static const char *path;
 	struct cpio_data cp;
-	bool use_pa;
-
-	if (IS_ENABLED(CONFIG_X86_32)) {
-		path	  = (const char *)__pa_nodebug(ucode_path);
-		use_pa	  = true;
-	} else {
-		path	  = ucode_path;
-		use_pa	  = false;
-	}
 
 	/* try built-in microcode first */
 	if (!load_builtin_intel_microcode(&cp))
-		cp = find_microcode_in_initrd(path, use_pa);
+		cp = find_microcode_in_initrd(ucode_path);
 
 	if (!(cp.data && cp.size))
 		return NULL;
@@ -586,30 +511,21 @@ void __init load_ucode_intel_bsp(void)
 
 	uci.mc = patch;
 
-	apply_microcode_early(&uci, true);
+	apply_microcode_early(&uci);
 }
 
 void load_ucode_intel_ap(void)
 {
-	struct microcode_intel *patch, **iup;
 	struct ucode_cpu_info uci;
 
-	if (IS_ENABLED(CONFIG_X86_32))
-		iup = (struct microcode_intel **) __pa_nodebug(&intel_ucode_patch);
-	else
-		iup = &intel_ucode_patch;
-
-	if (!*iup) {
-		patch = __load_ucode_intel(&uci);
-		if (!patch)
+	if (!intel_ucode_patch) {
+		intel_ucode_patch = __load_ucode_intel(&uci);
+		if (!intel_ucode_patch)
 			return;
-
-		*iup = patch;
 	}
 
-	uci.mc = *iup;
-
-	apply_microcode_early(&uci, true);
+	uci.mc = intel_ucode_patch;
+	apply_microcode_early(&uci);
 }
 
 static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
@@ -647,7 +563,7 @@ void reload_ucode_intel(void)
 
 	uci.mc = p;
 
-	apply_microcode_early(&uci, false);
+	apply_microcode_early(&uci);
 }
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index bf883aa..8843c32 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -44,7 +44,7 @@ struct microcode_ops {
 };
 
 extern struct ucode_cpu_info ucode_cpu_info[];
-struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa);
+struct cpio_data find_microcode_in_initrd(const char *path);
 
 #define MAX_UCODE_COUNT 128
 
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 246a609..bde27a3 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -19,6 +19,7 @@
 #include <asm/apic.h>
 #include <asm/io_apic.h>
 #include <asm/bios_ebda.h>
+#include <asm/microcode.h>
 #include <asm/tlbflush.h>
 #include <asm/bootparam_utils.h>
 
@@ -34,6 +35,8 @@ asmlinkage __visible void __init __noreturn i386_start_kernel(void)
 	/* Make sure IDT is set up before any exception happens */
 	idt_setup_early_handler();
 
+	load_ucode_bsp();
+
 	cr4_init_shadow();
 
 	sanitize_boot_params(&boot_params);
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index c931899..63f6ff4 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -118,11 +118,6 @@ SYM_CODE_START(startup_32)
 	movl %eax, pa(olpc_ofw_pgd)
 #endif
 
-#ifdef CONFIG_MICROCODE
-	/* Early load ucode on BSP. */
-	call load_ucode_bsp
-#endif
-
 	/* Create early pagetables. */
 	call  mk_early_pgtbl_32
 
@@ -157,11 +152,6 @@ SYM_FUNC_START(startup_32_smp)
 	movl %eax,%ss
 	leal -__PAGE_OFFSET(%ecx),%esp
 
-#ifdef CONFIG_MICROCODE
-	/* Early load ucode on AP. */
-	call load_ucode_ap
-#endif
-
 .Ldefault_entry:
 	movl $(CR0_STATE & ~X86_CR0_PG),%eax
 	movl %eax,%cr0
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 48e0406..1d33518 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -258,12 +258,9 @@ static void notrace start_secondary(void *unused)
 	cpu_init_exception_handling();
 
 	/*
-	 * 32-bit systems load the microcode from the ASM startup code for
-	 * historical reasons.
-	 *
-	 * On 64-bit systems load it before reaching the AP alive
-	 * synchronization point below so it is not part of the full per
-	 * CPU serialized bringup part when "parallel" bringup is enabled.
+	 * Load the microcode before reaching the AP alive synchronization
+	 * point below so it is not part of the full per CPU serialized
+	 * bringup part when "parallel" bringup is enabled.
 	 *
 	 * That's even safe when hyperthreading is enabled in the CPU as
 	 * the core code starts the primary threads first and leaves the
@@ -276,8 +273,7 @@ static void notrace start_secondary(void *unused)
 	 * CPUID, MSRs etc. must be strictly serialized to maintain
 	 * software state correctness.
 	 */
-	if (IS_ENABLED(CONFIG_X86_64))
-		load_ucode_ap();
+	load_ucode_ap();
 
 	/*
 	 * Synchronization point with the hotplug core. Sets this CPUs
