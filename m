Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209CC7D51AB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Oct 2023 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjJXNXR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Oct 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbjJXNWH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Oct 2023 09:22:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3001BCD;
        Tue, 24 Oct 2023 06:21:10 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKhylzGwPR4NNFxOnl5caVmfoa9RIyVxVYebk8HUwpw=;
        b=M+Q4yOuL6SGFk/7x4ICwZOTI051zL/ebTj/w5s8WUNJVSR2bOVr3YEhhSHsFIZsIddTlvR
        qhCQ7MY2arwjodAEEta1uYx9K1a9J60bDLNoAex2bU+zhs1g8/O8Hd6/miSX0pAEJDbVz3
        sIL+Hh6lLXHjSki1DrnkbsbO9K7IE0YHws/a7kSfKfLziHvf2We5K1xx6qaUJfn7ipqWV8
        eQ/yzmfrWiiucShzHGKNUnuHPCLULThtXIyPDL3j+PwYvW2Ka6+zypPbTLIq9tmb9PRi/f
        z7yTv62cYdtLaBrehIkwRflZoxUo+U6kBO9rLARI5XajT5TICPdE1TAdcEm7Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKhylzGwPR4NNFxOnl5caVmfoa9RIyVxVYebk8HUwpw=;
        b=JHp7ZSCJS8FTXD2Th5Syew2TXlQriPS1fdBDKS65N+yNS3MBCu2+lgtZo9lxuLS0fBg2AN
        GUijdK4NmwEc96Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Simplify early loading
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211722.629085215@linutronix.de>
References: <20231017211722.629085215@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815366813.3135.7231468028179208027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     dd5e3e3ca6ac011582a9f3f987493bf6741568c0
Gitweb:        https://git.kernel.org/tip/dd5e3e3ca6ac011582a9f3f987493bf6741568c0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:43 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:02:36 +02:00

x86/microcode/intel: Simplify early loading

The early loading code is overly complicated:

  - It scans the builtin/initrd for microcode not only on the BSP, but also
    on all APs during early boot and then later in the boot process it
    scans again to duplicate and save the microcode before initrd goes
    away.

    That's a pointless exercise because this can be simply done before
    bringing up the APs when the memory allocator is up and running.

 - Saving the microcode from within the scan loop is completely
   non-obvious and a left over of the microcode cache.

   This can be done at the call site now which makes it obvious.

Rework the code so that only the BSP scans the builtin/initrd microcode
once during early boot and save it away in an early initcall for later
use.

  [ bp: Test and fold in a fix from tglx ontop which handles the need to
    distinguish what save_microcode() does depending on when it is
    called:

     - when on the BSP during early load, it needs to find a newer
       revision than the one currently loaded on the BSP

     - later, before SMP init, it still runs on the BSP and gets the BSP
       revision just loaded and uses that revision to know which patch
       to save for the APs. For that it needs to find the exact one as
       on the BSP.
   ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211722.629085215@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c     |   6 +-
 arch/x86/kernel/cpu/microcode/intel.c    | 163 ++++++++++------------
 arch/x86/kernel/cpu/microcode/internal.h |   3 +-
 3 files changed, 79 insertions(+), 93 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index a46df14..de3eb97 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -42,7 +42,7 @@
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
-static bool dis_ucode_ldr = true;
+bool dis_ucode_ldr = true;
 
 bool initrd_gone;
 
@@ -186,10 +186,6 @@ static int __init save_microcode_in_initrd(void)
 	int ret = -EINVAL;
 
 	switch (c->x86_vendor) {
-	case X86_VENDOR_INTEL:
-		if (c->x86 >= 6)
-			ret = save_microcode_in_initrd_intel();
-		break;
 	case X86_VENDOR_AMD:
 		if (c->x86 >= 0x10)
 			ret = save_microcode_in_initrd_amd(cpuid_eax(1));
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index d6ff6eb..9b66144 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -32,8 +32,10 @@
 
 static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
+#define UCODE_BSP_LOADED	((struct microcode_intel *)0x1UL)
+
 /* Current microcode patch used in early patching on the APs. */
-static struct microcode_intel *intel_ucode_patch __read_mostly;
+static struct microcode_intel *ucode_patch_va __read_mostly;
 
 /* last level cache size per core */
 static unsigned int llc_size_per_core __ro_after_init;
@@ -240,22 +242,30 @@ int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type)
 }
 EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
 
-static void save_microcode_patch(void *data, unsigned int size)
+static void update_ucode_pointer(struct microcode_intel *mc)
 {
-	struct microcode_header_intel *p;
+	kfree(ucode_patch_va);
+
+	/*
+	 * Save the virtual address for early loading and for eventual free
+	 * on late loading.
+	 */
+	ucode_patch_va = mc;
+}
 
-	p = kmemdup(data, size, GFP_KERNEL);
-	if (!p)
-		return;
+static void save_microcode_patch(struct microcode_intel *patch)
+{
+	struct microcode_intel *mc;
 
-	kfree(intel_ucode_patch);
-	/* Save for early loading */
-	intel_ucode_patch = (struct microcode_intel *)p;
+	mc = kmemdup(patch, get_totalsize(&patch->hdr), GFP_KERNEL);
+	if (mc)
+		update_ucode_pointer(mc);
 }
 
-/* Scan CPIO for microcode matching the boot CPU's family, model, stepping */
-static struct microcode_intel *scan_microcode(void *data, size_t size,
-					      struct ucode_cpu_info *uci, bool save)
+/* Scan blob for microcode matching the boot CPUs family, model, stepping */
+static __init struct microcode_intel *scan_microcode(void *data, size_t size,
+						     struct ucode_cpu_info *uci,
+						     bool save)
 {
 	struct microcode_header_intel *mc_header;
 	struct microcode_intel *patch = NULL;
@@ -273,35 +283,35 @@ static struct microcode_intel *scan_microcode(void *data, size_t size,
 		if (!intel_find_matching_signature(data, uci->cpu_sig.sig, uci->cpu_sig.pf))
 			continue;
 
-		/* BSP scan: Check whether there is newer microcode */
-		if (!save && cur_rev >= mc_header->rev)
-			continue;
-
-		/* Save scan: Check whether there is newer or matching microcode */
-		if (save && cur_rev != mc_header->rev)
+		/*
+		 * For saving the early microcode, find the matching revision which
+		 * was loaded on the BSP.
+		 *
+		 * On the BSP during early boot, find a newer revision than
+		 * actually loaded in the CPU.
+		 */
+		if (save) {
+			if (cur_rev != mc_header->rev)
+				continue;
+		} else if (cur_rev >= mc_header->rev) {
 			continue;
+		}
 
 		patch = data;
 		cur_rev = mc_header->rev;
 	}
 
-	if (size)
-		return NULL;
-
-	if (save && patch)
-		save_microcode_patch(patch, mc_size);
-
-	return patch;
+	return size ? NULL : patch;
 }
 
-static int apply_microcode_early(struct ucode_cpu_info *uci)
+static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc;
 	u32 rev, old_rev, date;
 
 	mc = uci->mc;
 	if (!mc)
-		return 0;
+		return UCODE_NFOUND;
 
 	/*
 	 * Save us the MSR write below - which is a particular expensive
@@ -327,17 +337,17 @@ static int apply_microcode_early(struct ucode_cpu_info *uci)
 
 	rev = intel_get_microcode_revision();
 	if (rev != mc->hdr.rev)
-		return -1;
+		return UCODE_ERROR;
 
 	uci->cpu_sig.rev = rev;
 
 	date = mc->hdr.date;
 	pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
 		     old_rev, rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
-	return 0;
+	return UCODE_UPDATED;
 }
 
-static bool load_builtin_intel_microcode(struct cpio_data *cp)
+static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
 	struct firmware fw;
@@ -359,89 +369,71 @@ static bool load_builtin_intel_microcode(struct cpio_data *cp)
 	return false;
 }
 
-int __init save_microcode_in_initrd_intel(void)
+static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *uci, bool save)
 {
-	struct ucode_cpu_info uci;
 	struct cpio_data cp;
 
-	/*
-	 * initrd is going away, clear patch ptr. We will scan the microcode one
-	 * last time before jettisoning and save a patch, if found. Then we will
-	 * update that pointer too, with a stable patch address to use when
-	 * resuming the cores.
-	 */
-	intel_ucode_patch = NULL;
-
 	if (!load_builtin_intel_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
 	if (!(cp.data && cp.size))
-		return 0;
+		return NULL;
 
-	intel_cpu_collect_info(&uci);
+	intel_cpu_collect_info(uci);
 
-	scan_microcode(cp.data, cp.size, &uci, true);
-	return 0;
+	return scan_microcode(cp.data, cp.size, uci, save);
 }
 
 /*
- * @res_patch, output: a pointer to the patch we found.
+ * Invoked from an early init call to save the microcode blob which was
+ * selected during early boot when mm was not usable. The microcode must be
+ * saved because initrd is going away. It's an early init call so the APs
+ * just can use the pointer and do not have to scan initrd/builtin firmware
+ * again.
  */
-static struct microcode_intel *__load_ucode_intel(struct ucode_cpu_info *uci)
+static int __init save_builtin_microcode(void)
 {
-	struct cpio_data cp;
-
-	/* try built-in microcode first */
-	if (!load_builtin_intel_microcode(&cp))
-		cp = find_microcode_in_initrd(ucode_path);
+	struct ucode_cpu_info uci;
 
-	if (!(cp.data && cp.size))
-		return NULL;
+	if (xchg(&ucode_patch_va, NULL) != UCODE_BSP_LOADED)
+		return 0;
 
-	intel_cpu_collect_info(uci);
+	if (dis_ucode_ldr || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return 0;
 
-	return scan_microcode(cp.data, cp.size, uci, false);
+	uci.mc = get_microcode_blob(&uci, true);
+	if (uci.mc)
+		save_microcode_patch(uci.mc);
+	return 0;
 }
+early_initcall(save_builtin_microcode);
 
+/* Load microcode on BSP from initrd or builtin blobs */
 void __init load_ucode_intel_bsp(void)
 {
-	struct microcode_intel *patch;
 	struct ucode_cpu_info uci;
 
-	patch = __load_ucode_intel(&uci);
-	if (!patch)
-		return;
-
-	uci.mc = patch;
-
-	apply_microcode_early(&uci);
+	uci.mc = get_microcode_blob(&uci, false);
+	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
+		ucode_patch_va = UCODE_BSP_LOADED;
 }
 
 void load_ucode_intel_ap(void)
 {
 	struct ucode_cpu_info uci;
 
-	if (!intel_ucode_patch) {
-		intel_ucode_patch = __load_ucode_intel(&uci);
-		if (!intel_ucode_patch)
-			return;
-	}
-
-	uci.mc = intel_ucode_patch;
-	apply_microcode_early(&uci);
+	uci.mc = ucode_patch_va;
+	if (uci.mc)
+		apply_microcode_early(&uci);
 }
 
+/* Reload microcode on resume */
 void reload_ucode_intel(void)
 {
-	struct ucode_cpu_info uci;
-
-	intel_cpu_collect_info(&uci);
-
-	uci.mc = intel_ucode_patch;
-	if (!uci.mc)
-		return;
+	struct ucode_cpu_info uci = { .mc = ucode_patch_va, };
 
-	apply_microcode_early(&uci);
+	if (uci.mc)
+		apply_microcode_early(&uci);
 }
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
@@ -478,7 +470,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	mc = intel_ucode_patch;
+	mc = ucode_patch_va;
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -538,8 +530,8 @@ out:
 static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	unsigned int curr_mc_size = 0, new_mc_size = 0;
 	int cur_rev = uci->cpu_sig.rev;
+	unsigned int curr_mc_size = 0;
 	u8 *new_mc = NULL, *mc = NULL;
 
 	while (iov_iter_count(iter)) {
@@ -589,7 +581,6 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 		vfree(new_mc);
 		cur_rev = mc_header.rev;
 		new_mc  = mc;
-		new_mc_size = mc_size;
 		mc = NULL;
 	}
 
@@ -603,11 +594,11 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 	if (!new_mc)
 		return UCODE_NFOUND;
 
-	vfree(uci->mc);
-	uci->mc = (struct microcode_intel *)new_mc;
-
 	/* Save for CPU hotplug */
-	save_microcode_patch(new_mc, new_mc_size);
+	save_microcode_patch((struct microcode_intel *)new_mc);
+	uci->mc = ucode_patch_va;
+
+	vfree(new_mc);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, cur_rev, uci->cpu_sig.rev);
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 6001da4..1cfc6ec 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -84,6 +84,7 @@ static inline unsigned int x86_cpuid_family(void)
 	return x86_family(eax);
 }
 
+extern bool dis_ucode_ldr;
 extern bool initrd_gone;
 
 #ifdef CONFIG_CPU_SUP_AMD
@@ -107,13 +108,11 @@ static inline void exit_amd_microcode(void) { }
 #ifdef CONFIG_CPU_SUP_INTEL
 void load_ucode_intel_bsp(void);
 void load_ucode_intel_ap(void);
-int save_microcode_in_initrd_intel(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
 #else /* CONFIG_CPU_SUP_INTEL */
 static inline void load_ucode_intel_bsp(void) { }
 static inline void load_ucode_intel_ap(void) { }
-static inline int save_microcode_in_initrd_intel(void) { return -EINVAL; }
 static inline void reload_ucode_intel(void) { }
 static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }
 #endif  /* !CONFIG_CPU_SUP_INTEL */
