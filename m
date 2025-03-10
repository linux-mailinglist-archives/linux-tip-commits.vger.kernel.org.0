Return-Path: <linux-tip-commits+bounces-4097-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C24E7A58DE3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 09:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B87A4C83
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD17522332A;
	Mon, 10 Mar 2025 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0OWq1U2u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+WVlYUYX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FF13C690;
	Mon, 10 Mar 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594712; cv=none; b=tRLCu2rjazolNzLXPEmwQ4c53QJERt5oj0XHFlunYAh8U8qx9H9c3Og/JmDpVXheNYuEKPI0/5jXGfAkV1F+S2bu2nijhB+fdJcac1RRpSu+mJDzX9buqQ3MAA/McdsHQCwRTD9vCCXqxPDzRkwXhvuyap5mFBSLUR9YdGihJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594712; c=relaxed/simple;
	bh=kPizxzY2ocLZ92S12mq/hp0su0d+l88286uqpunxQsQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u9YZRXZtw+4vPzKBhSlwiUHav9/u23mOSpz9tgZaPJbDdm6L5sk0enLitw8KJndMjGqxnG+KyK0eIIu2XKu5wabrneT53sfdCLsXzI2Kbfc/RmQryY79LaPZdX/IjB/1Tp7SP3hS5pLk3GEQnMnEQFUeutUVE1NnylpT+erigkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0OWq1U2u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+WVlYUYX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 08:18:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741594709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPA2u7ZVdi4dMvZSt0uzHRf7eLVV4vql0NlFjCLEAf8=;
	b=0OWq1U2uOTxcaw/L4UbE8ilRhnDzLvCfQy/EoYt1kishIHwwPs5RiJxjsz9bY02gYWhhEp
	Q/eYqyPmH8L+es8mhoZnx3cH5v1gS+/gDxiTSqMo7ZuenEwkLV+ZFJpB9y1gEXU/THkxgV
	VlYuamtlKych2Nz/v8oPJJCMwZqHdnqzxsxw6Db7Gt/J4A+nWhpjLgonUGjHlApa0P90RI
	OpFnRfAoqibUSNoURVUEaZ9i0Dq7luYv7a9I8AA9tqe93jU0epoaEtTB2qA/+oJAgHI7nD
	vrLMn7+1PtgCu9XmvSEuVLpjXULrCSWl+orX2zdnNIzVpXozpcMelWzdlRQO2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741594709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPA2u7ZVdi4dMvZSt0uzHRf7eLVV4vql0NlFjCLEAf8=;
	b=+WVlYUYXBu9jTsZjiQ3XhxqTturQnyBLgb0Uh7gFY58xbw7FABNWleMGPHhHeuA3K7lGVq
	f5HKl0/TkGGpV7Bg==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Generate the <asm/cpufeaturemasks.h>
 header based on build config
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250305184725.3341760-3-xin@zytor.com>
References: <20250305184725.3341760-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174159470840.14745.16148394891407615288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7a7bd24a0ca02dfe68bd8a7a567b3da3b716bd8d
Gitweb:        https://git.kernel.org/tip/7a7bd24a0ca02dfe68bd8a7a567b3da3b716bd8d
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 05 Mar 2025 10:47:22 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 09:02:47 +01:00

x86/cpufeatures: Generate the <asm/cpufeaturemasks.h> header based on build config

Introduce an AWK script to auto-generate the <asm/cpufeaturemasks.h> header
with required and disabled feature masks based on <asm/cpufeatures.h>
and the current build config.

Thus for any CPU feature with a build config, e.g., X86_FRED, simply add:

  config X86_DISABLED_FEATURE_FRED
	def_bool y
	depends on !X86_FRED

to arch/x86/Kconfig.cpufeatures, instead of adding a conditional CPU
feature disable flag, e.g., DISABLE_FRED.

Lastly, the generated required and disabled feature masks will be added to
their corresponding feature masks for this particular compile-time
configuration.

  [ Xin: build integration improvements ]
  [ mingo: Improved changelog and comments ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250305184725.3341760-3-xin@zytor.com
---
 arch/x86/Makefile                  | 15 +++++-
 arch/x86/boot/cpucheck.c           |  3 +-
 arch/x86/boot/cpuflags.c           |  1 +-
 arch/x86/boot/mkcpustr.c           |  3 +-
 arch/x86/include/asm/Kbuild        |  1 +-
 arch/x86/include/asm/cpufeature.h  |  1 +-
 arch/x86/include/asm/cpufeatures.h |  8 +---
 arch/x86/kernel/verify_cpu.S       |  4 +-
 arch/x86/tools/cpufeaturemasks.awk | 81 +++++++++++++++++++++++++++++-
 9 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100755 arch/x86/tools/cpufeaturemasks.awk

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8120085..420f086 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -265,6 +265,21 @@ archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
 ###
+# <asm/cpufeaturemasks.h> header generation
+
+cpufeaturemasks.hdr := arch/x86/include/generated/asm/cpufeaturemasks.h
+cpufeaturemasks.awk := $(srctree)/arch/x86/tools/cpufeaturemasks.awk
+cpufeatures_hdr := $(srctree)/arch/x86/include/asm/cpufeatures.h
+targets += $(cpufeaturemasks.hdr)
+quiet_cmd_gen_featuremasks = GEN     $@
+      cmd_gen_featuremasks = $(AWK) -f $(cpufeaturemasks.awk) $(cpufeatures_hdr) $(KCONFIG_CONFIG) > $@
+
+$(cpufeaturemasks.hdr): $(cpufeaturemasks.awk) $(cpufeatures_hdr) $(KCONFIG_CONFIG) FORCE
+	$(shell mkdir -p $(dir $@))
+	$(call if_changed,gen_featuremasks)
+archprepare: $(cpufeaturemasks.hdr)
+
+###
 # Kernel objects
 
 libs-y  += arch/x86/lib/
diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index 0aae4d4..f82de8d 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -22,10 +22,11 @@
 # include "boot.h"
 #endif
 #include <linux/types.h>
+#include <asm/cpufeaturemasks.h>
 #include <asm/intel-family.h>
 #include <asm/processor-flags.h>
-#include <asm/required-features.h>
 #include <asm/msr-index.h>
+
 #include "string.h"
 #include "msr.h"
 
diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index d75237b..0cabdac 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -3,7 +3,6 @@
 #include "bitops.h"
 
 #include <asm/processor-flags.h>
-#include <asm/required-features.h>
 #include <asm/msr-index.h>
 #include "cpuflags.h"
 
diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
index da0ccc5..22d730b 100644
--- a/arch/x86/boot/mkcpustr.c
+++ b/arch/x86/boot/mkcpustr.c
@@ -12,8 +12,6 @@
 
 #include <stdio.h>
 
-#include "../include/asm/required-features.h"
-#include "../include/asm/disabled-features.h"
 #include "../include/asm/cpufeatures.h"
 #include "../include/asm/vmxfeatures.h"
 #include "../kernel/cpu/capflags.c"
@@ -23,6 +21,7 @@ int main(void)
 	int i, j;
 	const char *str;
 
+	printf("#include <asm/cpufeaturemasks.h>\n\n");
 	printf("static const char x86_cap_strs[] =\n");
 
 	for (i = 0; i < NCAPINTS; i++) {
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 58f4dde..4566000 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -8,6 +8,7 @@ generated-y += syscalls_x32.h
 generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
+generated-y += cpufeaturemasks.h
 
 generic-y += early_ioremap.h
 generic-y += fprobe.h
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index e955da3..d54db88 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -9,6 +9,7 @@
 #include <asm/asm.h>
 #include <linux/bitops.h>
 #include <asm/alternative.h>
+#include <asm/cpufeaturemasks.h>
 
 enum cpuid_leafs
 {
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 8770dc1..c0462be 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -2,14 +2,6 @@
 #ifndef _ASM_X86_CPUFEATURES_H
 #define _ASM_X86_CPUFEATURES_H
 
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#include <asm/required-features.h>
-#endif
-
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#include <asm/disabled-features.h>
-#endif
-
 /*
  * Defines x86 CPU feature bits
  */
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index 1258a58..37ad437 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -29,8 +29,12 @@
  */
 
 #include <asm/cpufeatures.h>
+#include <asm/cpufeaturemasks.h>
 #include <asm/msr-index.h>
 
+#define SSE_MASK	\
+	(REQUIRED_MASK0 & ((1<<(X86_FEATURE_XMM & 31)) | (1<<(X86_FEATURE_XMM2 & 31))))
+
 SYM_FUNC_START_LOCAL(verify_cpu)
 	pushf				# Save caller passed flags
 	push	$0			# Kill any dangerous flags
diff --git a/arch/x86/tools/cpufeaturemasks.awk b/arch/x86/tools/cpufeaturemasks.awk
new file mode 100755
index 0000000..59757ca
--- /dev/null
+++ b/arch/x86/tools/cpufeaturemasks.awk
@@ -0,0 +1,81 @@
+#!/usr/bin/awk
+#
+# Convert cpufeatures.h to a list of compile-time masks
+# Note: this blithely assumes that each word has at least one
+# feature defined in it; if not, something else is wrong!
+#
+
+BEGIN {
+	printf "#ifndef _ASM_X86_CPUFEATUREMASKS_H\n";
+	printf "#define _ASM_X86_CPUFEATUREMASKS_H\n\n";
+
+	file = 0
+}
+
+FNR == 1 {
+	++file;
+
+	# arch/x86/include/asm/cpufeatures.h
+	if (file == 1)
+		FS = "[ \t()*+]+";
+
+	# .config
+	if (file == 2)
+		FS = "=";
+}
+
+# Create a dictionary of sorts, containing all defined feature bits
+file == 1 && $1 ~ /^#define$/ && $2 ~ /^X86_FEATURE_/ {
+	nfeat = $3 * $4 + $5;
+	feat = $2;
+	sub(/^X86_FEATURE_/, "", feat);
+	feats[nfeat] = feat;
+}
+file == 1 && $1 ~ /^#define$/ && $2 == "NCAPINTS" {
+	ncapints = int($3);
+}
+
+# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] = on | off
+file == 2 && $1 ~ /^CONFIG_X86_(REQUIRED|DISABLED)_FEATURE_/ {
+	on = ($2 == "y");
+	if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3)
+		featstat[fs[2], fs[3]] = on;
+}
+
+END {
+	sets[1] = "REQUIRED";
+	sets[2] = "DISABLED";
+
+	for (ns in sets) {
+		s = sets[ns];
+
+		printf "/*\n";
+		printf " * %s features:\n", s;
+		printf " *\n";
+		fstr = "";
+		for (i = 0; i < ncapints; i++) {
+			mask = 0;
+			for (j = 0; j < 32; j++) {
+				feat = feats[i*32 + j];
+				if (featstat[s, feat]) {
+					nfstr = fstr " " feat;
+					if (length(nfstr) > 72) {
+						printf " *   %s\n", fstr;
+						nfstr = " " feat;
+					}
+					fstr = nfstr;
+					mask += (2 ^ j);
+				}
+			}
+			masks[i] = mask;
+		}
+		printf " *   %s\n */\n", fstr;
+
+		for (i = 0; i < ncapints; i++)
+			printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
+
+		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
+	}
+
+	printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";
+}

