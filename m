Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F777AA5C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Aug 2023 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjHMR0l (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Aug 2023 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjHMR0f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Aug 2023 13:26:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC710FB;
        Sun, 13 Aug 2023 10:26:36 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691947594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWvLWho9WWUHKZwUmyCkRzD3s2DWSRguh4bEvBTawKY=;
        b=K1lt/eMYB6iCntA1AjPgZMVIWjhN1zZJOK1NXlsoVzZGgr58sLJhfnqYcc6LnL/p9TK/00
        E4awbV+sEoGnneFeKmdK/rnmlf1YATjgBzM8Yr3Kqqhgkllap3p4iNGt/GkDq9jPuylp5/
        foaQ+Y6rd+R4B20nhkykCQ7sS44J+4C8RRV6elnPjdPRamnMDSSoqEfi8LAyS4hcuqiyN6
        2UHWsDBJuRjVGXHbgKYKcihE1DVajGMvP40TGxDshZrMWWmSsSlZ+Pikwzym6bum6ZilfA
        2kjTI8gZSuf9sGgPHlmgqd6GKE9bC0iVnHCzNfAW5ysf099k+xYrVAY74ExbqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691947594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWvLWho9WWUHKZwUmyCkRzD3s2DWSRguh4bEvBTawKY=;
        b=h+Jft8ydvwENBCuZdLZ2Ua61eOMKa0XqwTj9vRSumi6s20wm8JVE5isUBFGRCVYqHXkDWy
        sdUL5yDsf4yKwVAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Hide the config knob
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230812195727.660453052@linutronix.de>
References: <20230812195727.660453052@linutronix.de>
MIME-Version: 1.0
Message-ID: <169194759403.27769.2355835959167552007.tip-bot2@tip-bot2>
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

Commit-ID:     e6bcfdd75d53390a67f67237f4eafc77d9772056
Gitweb:        https://git.kernel.org/tip/e6bcfdd75d53390a67f67237f4eafc77d9772056
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Aug 2023 20:37:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 13 Aug 2023 10:26:39 +02:00

x86/microcode: Hide the config knob

In reality CONFIG_MICROCODE is enabled in any reasonable configuration when
Intel or AMD support is enabled. Accommodate to reality.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230812195727.660453052@linutronix.de
---
 arch/x86/Kconfig                       | 38 +-------------------------
 arch/x86/include/asm/microcode.h       |  6 ++--
 arch/x86/include/asm/microcode_amd.h   |  2 +-
 arch/x86/include/asm/microcode_intel.h |  2 +-
 arch/x86/kernel/cpu/microcode/Makefile |  4 +--
 5 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7422db4..ae6503c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1308,44 +1308,8 @@ config X86_REBOOTFIXUPS
 	  Say N otherwise.
 
 config MICROCODE
-	bool "CPU microcode loading support"
-	default y
+	def_bool y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
-	help
-	  If you say Y here, you will be able to update the microcode on
-	  Intel and AMD processors. The Intel support is for the IA32 family,
-	  e.g. Pentium Pro, Pentium II, Pentium III, Pentium 4, Xeon etc. The
-	  AMD support is for families 0x10 and later. You will obviously need
-	  the actual microcode binary data itself which is not shipped with
-	  the Linux kernel.
-
-	  The preferred method to load microcode from a detached initrd is described
-	  in Documentation/arch/x86/microcode.rst. For that you need to enable
-	  CONFIG_BLK_DEV_INITRD in order for the loader to be able to scan the
-	  initrd for microcode blobs.
-
-	  In addition, you can build the microcode into the kernel. For that you
-	  need to add the vendor-supplied microcode to the CONFIG_EXTRA_FIRMWARE
-	  config option.
-
-config MICROCODE_INTEL
-	bool "Intel microcode loading support"
-	depends on CPU_SUP_INTEL && MICROCODE
-	default MICROCODE
-	help
-	  This options enables microcode patch loading support for Intel
-	  processors.
-
-	  For the current Intel microcode data package go to
-	  <https://downloadcenter.intel.com> and search for
-	  'Linux Processor Microcode Data File'.
-
-config MICROCODE_AMD
-	bool "AMD microcode loading support"
-	depends on CPU_SUP_AMD && MICROCODE
-	help
-	  If you select this option, microcode patch loading support for AMD
-	  processors will be enabled.
 
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 320566a..0deab6c 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -54,16 +54,16 @@ struct ucode_cpu_info {
 extern struct ucode_cpu_info ucode_cpu_info[];
 struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa);
 
-#ifdef CONFIG_MICROCODE_INTEL
+#ifdef CONFIG_CPU_SUP_INTEL
 extern struct microcode_ops * __init init_intel_microcode(void);
 #else
 static inline struct microcode_ops * __init init_intel_microcode(void)
 {
 	return NULL;
 }
-#endif /* CONFIG_MICROCODE_INTEL */
+#endif /* CONFIG_CPU_SUP_INTEL */
 
-#ifdef CONFIG_MICROCODE_AMD
+#ifdef CONFIG_CPU_SUP_AMD
 extern struct microcode_ops * __init init_amd_microcode(void);
 extern void __exit exit_amd_microcode(void);
 #else
diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index a995b76..58e9c83 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -43,7 +43,7 @@ struct microcode_amd {
 
 #define PATCH_MAX_SIZE (3 * PAGE_SIZE)
 
-#ifdef CONFIG_MICROCODE_AMD
+#ifdef CONFIG_CPU_SUP_AMD
 extern void load_ucode_amd_early(unsigned int cpuid_1_eax);
 extern int __init save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index f1fa979..a279dee 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -71,7 +71,7 @@ static inline u32 intel_get_microcode_revision(void)
 	return rev;
 }
 
-#ifdef CONFIG_MICROCODE_INTEL
+#ifdef CONFIG_CPU_SUP_INTEL
 extern void __init load_ucode_intel_bsp(void);
 extern void load_ucode_intel_ap(void);
 extern void show_ucode_info_early(void);
diff --git a/arch/x86/kernel/cpu/microcode/Makefile b/arch/x86/kernel/cpu/microcode/Makefile
index 34098d4..193d98b 100644
--- a/arch/x86/kernel/cpu/microcode/Makefile
+++ b/arch/x86/kernel/cpu/microcode/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 microcode-y				:= core.o
 obj-$(CONFIG_MICROCODE)			+= microcode.o
-microcode-$(CONFIG_MICROCODE_INTEL)	+= intel.o
-microcode-$(CONFIG_MICROCODE_AMD)	+= amd.o
+microcode-$(CONFIG_CPU_SUP_INTEL)	+= intel.o
+microcode-$(CONFIG_CPU_SUP_AMD)		+= amd.o
