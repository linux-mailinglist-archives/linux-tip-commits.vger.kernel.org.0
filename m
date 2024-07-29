Return-Path: <linux-tip-commits+bounces-1752-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E99493F09B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B771C219FE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D413C669;
	Mon, 29 Jul 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LyTauNN4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OT1X+OF6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8E768FD;
	Mon, 29 Jul 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244089; cv=none; b=an7fmSIZsDGNwp+ZCjjLLW1Wa51dTQ5TtOvKzDwnM26qwjM2faHQ32Pe8hH3ChHelXII4EllBli+ORuD4oHQsafg/x4zLS3AXYzP96Rt9MVWvOUJzCYxV7gKX5WzoujxTSuPgRnrUKwDjW7UvrBu2WXGBQIEHgrRCWaxGSdACnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244089; c=relaxed/simple;
	bh=GUVdNiibR3rVQBIXgCeAsy4Yg4Yj7mxDDgqj3xSnOi0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hTye7COIZe1fb5aHZSpIuDYapfJAUZpOWLWGHrXCTzKf05TIdvd1+tCtrPFwYz3Q2ugR995YZdyUsZ6Lq0dWRYPAwKDlcyUE9saY+PGn3DDu9f/9N0OzkswookbHfWGKlJVvd3BPNWgpK1RMqV8fwl++cmBKatXT4B1zf5hljr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LyTauNN4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OT1X+OF6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722244085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhERfHRH063glfjOkdo3hH6MSDcTZsybW3j8Bb83jvI=;
	b=LyTauNN4vdquUG4jBEDupSMwU4+mFHhmFRK5KdSHIayIgtpfOEE8tmVK5RoHSsBKbsa6Xg
	PXP1WBZSjOKD40aGiNFVdyrNdXmS4fzQxdzAEQNOkrXP9IxbJHrXmLE/oB3EpLM1i8YZdD
	RM1DyyRFDMKV49DD93Qzx+uW9YJUu/AUjzBQCNXFHBu/hTkByNOSFlgxSHovp7SPbcGh7m
	suh8ZjGaSP8oylmFXigjRpfpwxGeOhwSKqZiELWkgndTAzGJlcvQXUrWOVaNMmcjfl6BPp
	ikXIVZBiLiItxPjoFxySCHx8v2Kw32a1Tn202VxcidLnggpYuoxckzdzV+DT0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722244085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhERfHRH063glfjOkdo3hH6MSDcTZsybW3j8Bb83jvI=;
	b=OT1X+OF6wXq7GX5IuETQYBqHusHELMefrpzAWbYGcd4cA3cQN7Xl049HprBHgFIe5TdzJr
	SZ47RsLqKHgEr6Dg==
From: "tip-bot2 for Vignesh Balasubramanian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/elf: Add a new FPU buffer layout info to x86 core files
Cc: Jini Susan George <jinisusan.george@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Vignesh Balasubramanian <vigbalas@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240725161017.112111-2-vigbalas@amd.com>
References: <20240725161017.112111-2-vigbalas@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224408405.2215.14790360803921905917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ba386777a30b38dabcc7fb8a89ec2869a09915f7
Gitweb:        https://git.kernel.org/tip/ba386777a30b38dabcc7fb8a89ec2869a09915f7
Author:        Vignesh Balasubramanian <vigbalas@amd.com>
AuthorDate:    Thu, 25 Jul 2024 21:40:18 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jul 2024 10:45:43 +02:00

x86/elf: Add a new FPU buffer layout info to x86 core files

Add a new .note section containing type, size, offset and flags of every
xfeature that is present.

This information will be used by debuggers to understand the XSAVE layout of
the machine where the core file has been dumped, and to read XSAVE registers,
especially during cross-platform debugging.

The XSAVE layouts of modern AMD and Intel CPUs differ, especially since
Memory Protection Keys and the AVX-512 features have been inculcated into
the AMD CPUs.

Since AMD never adopted (and hence never left room in the XSAVE layout for)
the Intel MPX feature, tools like GDB had assumed a fixed XSAVE layout
matching that of Intel (based on the XCR0 mask).

Hence, core dumps from AMD CPUs didn't match the known size for the XCR0 mask.
This resulted in GDB and other tools not being able to access the values of
the AVX-512 and PKRU registers on AMD CPUs.

To solve this, an interim solution has been accepted into GDB, and is already
a part of GDB 14, see

  https://sourceware.org/pipermail/gdb-patches/2023-March/198081.html.

But it depends on heuristics based on the total XSAVE register set size
and the XCR0 mask to infer the layouts of the various register blocks
for core dumps, and hence, is not a foolproof mechanism to determine the
layout of the XSAVE area.

Therefore, add a new core dump note in order to allow GDB/LLDB and other
relevant tools to determine the layout of the XSAVE area of the machine where
the corefile was dumped.

The new core dump note (which is being proposed as a per-process .note
section), NT_X86_XSAVE_LAYOUT (0x205) contains an array of structures.

Each structure describes an individual extended feature containing
offset, size and flags in this format:

  struct x86_xfeat_component {
         u32 type;
         u32 size;
         u32 offset;
         u32 flags;
  };

and in an independent manner, allowing for future extensions without depending
on hw arch specifics like CPUID etc.

  [ bp: Massage commit message, zap trailing whitespace. ]

Co-developed-by: Jini Susan George <jinisusan.george@amd.com>
Signed-off-by: Jini Susan George <jinisusan.george@amd.com>
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Vignesh Balasubramanian <vigbalas@amd.com>
Link: https://lore.kernel.org/r/20240725161017.112111-2-vigbalas@amd.com
---
 arch/x86/Kconfig                |  1 +-
 arch/x86/include/uapi/asm/elf.h | 16 ++++++-
 arch/x86/kernel/fpu/xstate.c    | 89 ++++++++++++++++++++++++++++++++-
 fs/binfmt_elf.c                 |  4 +-
 include/uapi/linux/elf.h        |  1 +-
 5 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/elf.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9..c15b4b3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,7 @@ config X86
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_EXTRA_ELF_NOTES
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/x86/include/uapi/asm/elf.h b/arch/x86/include/uapi/asm/elf.h
new file mode 100644
index 0000000..468e135
--- /dev/null
+++ b/arch/x86/include/uapi/asm/elf.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_X86_ELF_H
+#define _UAPI_ASM_X86_ELF_H
+
+#include <linux/types.h>
+
+struct x86_xfeat_component {
+	__u32 type;
+	__u32 size;
+	__u32 offset;
+	__u32 flags;
+} __packed;
+
+_Static_assert(sizeof(struct x86_xfeat_component) % 4 == 0, "x86_xfeat_component is not aligned");
+
+#endif /* _UAPI_ASM_X86_ELF_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026f..f3a2e59 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
+#include <linux/coredump.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/regset.h>
@@ -23,6 +24,8 @@
 #include <asm/prctl.h>
 #include <asm/elf.h>
 
+#include <uapi/asm/elf.h>
+
 #include "context.h"
 #include "internal.h"
 #include "legacy.h"
@@ -1838,3 +1841,89 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
+#ifdef CONFIG_COREDUMP
+static const char owner_name[] = "LINUX";
+
+/*
+ * Dump type, size, offset and flag values for every xfeature that is present.
+ */
+static int dump_xsave_layout_desc(struct coredump_params *cprm)
+{
+	int num_records = 0;
+	int i;
+
+	for_each_extended_xfeature(i, fpu_user_cfg.max_features) {
+		struct x86_xfeat_component xc = {
+			.type   = i,
+			.size   = xstate_sizes[i],
+			.offset = xstate_offsets[i],
+			/* reserved for future use */
+			.flags  = 0,
+		};
+
+		if (!dump_emit(cprm, &xc, sizeof(xc)))
+			return 0;
+
+		num_records++;
+	}
+	return num_records;
+}
+
+static u32 get_xsave_desc_size(void)
+{
+	u32 cnt = 0;
+	u32 i;
+
+	for_each_extended_xfeature(i, fpu_user_cfg.max_features)
+		cnt++;
+
+	return cnt * (sizeof(struct x86_xfeat_component));
+}
+
+int elf_coredump_extra_notes_write(struct coredump_params *cprm)
+{
+	int num_records = 0;
+	struct elf_note en;
+
+	if (!fpu_user_cfg.max_features)
+		return 0;
+
+	en.n_namesz = sizeof(owner_name);
+	en.n_descsz = get_xsave_desc_size();
+	en.n_type = NT_X86_XSAVE_LAYOUT;
+
+	if (!dump_emit(cprm, &en, sizeof(en)))
+		return 1;
+	if (!dump_emit(cprm, owner_name, en.n_namesz))
+		return 1;
+	if (!dump_align(cprm, 4))
+		return 1;
+
+	num_records = dump_xsave_layout_desc(cprm);
+	if (!num_records)
+		return 1;
+
+	/* Total size should be equal to the number of records */
+	if ((sizeof(struct x86_xfeat_component) * num_records) != en.n_descsz)
+		return 1;
+
+	return 0;
+}
+
+int elf_coredump_extra_notes_size(void)
+{
+	int size;
+
+	if (!fpu_user_cfg.max_features)
+		return 0;
+
+	/* .note header */
+	size  = sizeof(struct elf_note);
+	/*  Name plus alignment to 4 bytes */
+	size += roundup(sizeof(owner_name), 4);
+	size += get_xsave_desc_size();
+
+	return size;
+}
+#endif /* CONFIG_COREDUMP */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 19fa49c..01bcbe7 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2039,7 +2039,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	{
 		size_t sz = info.size;
 
-		/* For cell spufs */
+		/* For cell spufs and x86 xstate */
 		sz += elf_coredump_extra_notes_size();
 
 		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
@@ -2103,7 +2103,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!write_note_info(&info, cprm))
 		goto end_coredump;
 
-	/* For cell spufs */
+	/* For cell spufs and x86 xstate */
 	if (elf_coredump_extra_notes_write(cprm))
 		goto end_coredump;
 
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b54b313..e30a9b4 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -411,6 +411,7 @@ typedef struct elf64_shdr {
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
 /* Old binutils treats 0x203 as a CET state */
 #define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
+#define NT_X86_XSAVE_LAYOUT	0x205	/* XSAVE layout description */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */

