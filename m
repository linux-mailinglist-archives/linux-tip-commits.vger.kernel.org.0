Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEDD7D5161
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Oct 2023 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjJXNU6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Oct 2023 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjJXNUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Oct 2023 09:20:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DE10E5;
        Tue, 24 Oct 2023 06:20:50 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:20:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153649;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/33YqcWY5VD1riO4uCxfHce6JOJnAKqF5C2JA5Vw18=;
        b=ZJVq0c9EZDvcaMHSUU/c1+WLr0mN7MaVDwEwTCXMmkAnRZHBc+JPlqhvRjim2bf/XDJZG3
        uu6ElCKsQ2bbAeAkIoFOHYyr/bcJG3ZTZFvKJwT3TvQT15k7XP842mvKtVOnEllFChPLY1
        AUeToqs5Sn97XfgQKwGOUh/txGmyA6mrQwVT8aVC9DuKMyiHS3dOjmuIyfV8bM7gEZ7vDE
        dN6c9IaMP2EpppBp267QzPZPW+h/inI7CNMN7CzbiVlrJCqtuVX5ldbESMa5op8iqziLQh
        ZA44vCNIVey2yNEok1r5VE3YWm/sT2KnRZmmSVeKsNkjJRbwzinYLSfofrhsjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153649;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/33YqcWY5VD1riO4uCxfHce6JOJnAKqF5C2JA5Vw18=;
        b=f/qj2GnEYhXS9VZK2fajSt+Fy2vkoNaqCaDABUaks1mLmJe8DsMAbnOEjOgQKODcliqAjd
        2gcGbeDk6PXvUFAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Prepare for minimal revision check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211724.079611170@linutronix.de>
References: <20231017211724.079611170@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815364859.3135.1392271485663377022.tip-bot2@tip-bot2>
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

Commit-ID:     9407bda845dd19756e276d4f3abc15a20777ba45
Gitweb:        https://git.kernel.org/tip/9407bda845dd19756e276d4f3abc15a20777ba45
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:24:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:55 +02:00

x86/microcode: Prepare for minimal revision check

Applying microcode late can be fatal for the running kernel when the
update changes functionality which is in use already in a non-compatible
way, e.g. by removing a CPUID bit.

There is no way for admins which do not have access to the vendors deep
technical support to decide whether late loading of such a microcode is
safe or not.

Intel has added a new field to the microcode header which tells the
minimal microcode revision which is required to be active in the CPU in
order to be safe.

Provide infrastructure for handling this in the core code and a command
line switch which allows to enforce it.

If the update is considered safe the kernel is not tainted and the annoying
warning message not emitted. If it's enforced and the currently loaded
microcode revision is not safe for late loading then the load is aborted.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211724.079611170@linutronix.de
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++-
 arch/x86/Kconfig                                | 23 +++++++++++++++-
 arch/x86/kernel/cpu/microcode/amd.c             |  3 ++-
 arch/x86/kernel/cpu/microcode/core.c            | 19 +++++++++----
 arch/x86/kernel/cpu/microcode/intel.c           |  3 ++-
 arch/x86/kernel/cpu/microcode/internal.h        |  2 +-
 6 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a..d762e17 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3275,6 +3275,11 @@
 
 	mga=		[HW,DRM]
 
+	microcode.force_minrev=	[X86]
+			Format: <bool>
+			Enable or disable the microcode minimal revision
+			enforcement for the runtime microcode loader.
+
 	min_addr=nn[KMG]	[KNL,BOOT,IA-64] All physical memory below this
 			physical address is ignored.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index db75120..cadea3f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1326,7 +1326,28 @@ config MICROCODE_LATE_LOADING
 	  is a tricky business and should be avoided if possible. Just the sequence
 	  of synchronizing all cores and SMT threads is one fragile dance which does
 	  not guarantee that cores might not softlock after the loading. Therefore,
-	  use this at your own risk. Late loading taints the kernel too.
+	  use this at your own risk. Late loading taints the kernel unless the
+	  microcode header indicates that it is safe for late loading via the
+	  minimal revision check. This minimal revision check can be enforced on
+	  the kernel command line with "microcode.minrev=Y".
+
+config MICROCODE_LATE_FORCE_MINREV
+	bool "Enforce late microcode loading minimal revision check"
+	default n
+	depends on MICROCODE_LATE_LOADING
+	help
+	  To prevent that users load microcode late which modifies already
+	  in use features, newer microcode patches have a minimum revision field
+	  in the microcode header, which tells the kernel which minimum
+	  revision must be active in the CPU to safely load that new microcode
+	  late into the running system. If disabled the check will not
+	  be enforced but the kernel will be tainted when the minimal
+	  revision check fails.
+
+	  This minimal revision check can also be controlled via the
+	  "microcode.minrev" parameter on the kernel command line.
+
+	  If unsure say Y.
 
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 102aebc..9373ec0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -888,6 +888,9 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 	enum ucode_state ret = UCODE_NFOUND;
 	const struct firmware *fw;
 
+	if (force_minrev)
+		return UCODE_NFOUND;
+
 	if (c->x86 >= 0x15)
 		snprintf(fw_name, sizeof(fw_name), "amd-ucode/microcode_amd_fam%.2xh.bin", c->x86);
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 718d648..666d25b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -46,6 +46,9 @@
 static struct microcode_ops	*microcode_ops;
 bool dis_ucode_ldr = true;
 
+bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
+module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
+
 /*
  * Synchronization.
  *
@@ -531,15 +534,17 @@ static int load_cpus_stopped(void *unused)
 	return 0;
 }
 
-static int load_late_stop_cpus(void)
+static int load_late_stop_cpus(bool is_safe)
 {
 	unsigned int cpu, updated = 0, failed = 0, timedout = 0, siblings = 0;
 	unsigned int nr_offl, offline = 0;
 	int old_rev = boot_cpu_data.microcode;
 	struct cpuinfo_x86 prev_info;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
+	if (!is_safe) {
+		pr_err("Late microcode loading without minimal revision check.\n");
+		pr_err("You should switch to early loading, if possible.\n");
+	}
 
 	atomic_set(&late_cpus_in, num_online_cpus());
 	atomic_set(&offline_in_nmi, 0);
@@ -589,7 +594,9 @@ static int load_late_stop_cpus(void)
 		return -EIO;
 	}
 
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	if (!is_safe || failed || timedout)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
 	pr_info("load: updated on %u primary CPUs with %u siblings\n", updated, siblings);
 	if (failed || timedout) {
 		pr_err("load incomplete. %u CPUs timed out or failed\n",
@@ -679,7 +686,9 @@ static int load_late_locked(void)
 
 	switch (microcode_ops->request_microcode_fw(0, &microcode_pdev->dev)) {
 	case UCODE_NEW:
-		return load_late_stop_cpus();
+		return load_late_stop_cpus(false);
+	case UCODE_NEW_SAFE:
+		return load_late_stop_cpus(true);
 	case UCODE_NFOUND:
 		return -ENOENT;
 	default:
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 905ed3b..14aa4c6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -480,6 +480,9 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 	unsigned int curr_mc_size = 0;
 	u8 *new_mc = NULL, *mc = NULL;
 
+	if (force_minrev)
+		return UCODE_NFOUND;
+
 	while (iov_iter_count(iter)) {
 		struct microcode_header_intel mc_header;
 		unsigned int mc_size, data_size;
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 1a396fc..f8047b1 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -13,6 +13,7 @@ struct device;
 enum ucode_state {
 	UCODE_OK	= 0,
 	UCODE_NEW,
+	UCODE_NEW_SAFE,
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
@@ -88,6 +89,7 @@ static inline unsigned int x86_cpuid_family(void)
 }
 
 extern bool dis_ucode_ldr;
+extern bool force_minrev;
 
 #ifdef CONFIG_CPU_SUP_AMD
 void load_ucode_amd_bsp(unsigned int family);
