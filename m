Return-Path: <linux-tip-commits+bounces-4826-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCEA84180
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 13:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0888419E5EAF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 11:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD328134A;
	Thu, 10 Apr 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8qE6j/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NfXNAGq3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB021B18C;
	Thu, 10 Apr 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283579; cv=none; b=niriKVzzoS0aIcP4yrByG46sHIPlGglwtEqBcA20rBTFZCVZVrrZLzRodaDzemMVvqyf11gLqetTKKsANXVJBPz+wPw8U1vY/oslCziASDjE5ciKQ7UV1QY/lLLIOatzGKISMc/QIeR4NIWDpzvonHohkyp5cfO+EgOHVOaqiwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283579; c=relaxed/simple;
	bh=TY9VZEkhoIA1bml51acVq4uRanMdkxIyXPb0+8qaFXs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JalizzGwu3CmDS62m96Vu/fnfACuKwt10fEoZGuFN0MNAPsv/9+Zvw7s+Y74zVB8+BkQymt3pfPeXl66379znmDgKkGsU1q3dOYZYXgfdJdBjXbYyvxIOTmkWBDpeTxNfhXVGCCdTNFmytX7F2Y6jkpo1xKClmDKz/SDQ4e/tKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8qE6j/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NfXNAGq3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 11:12:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744283575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtkUbfWz2Wx1peuX0doAffJh2Q0pSR4Q6Bt3PWUs4Zg=;
	b=U8qE6j/uAXJvUJzF+sxfDAych30gc8L5AynsMX7mcE+gNrKP5PY2yp3Rgrsbpuzv9bEkc9
	jumZRDp9JdtS7Lb02T8oZ+PoDDzWRgfElrz2itE/en16T6tCiH+rYfExHLvppSFj3mYWsS
	j2gSraVZCa9aHS+v1wb6z+4MukGP+bMyyCYtfBURZS837JK3nClURoATRLldDDsT0MO0ib
	ET7HjhnpHqdAi/4MAfB3HyqRNy7MbH3MjbgFuW73ksLO6lSN7QYr+tlBkRqYRzdVAu9lEA
	2a7pRh9z22zCaYUXAzOCS07lKl7vyJMZ6LlrP+wz8Gta3tNckzq1n3+soS6k/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744283575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtkUbfWz2Wx1peuX0doAffJh2Q0pSR4Q6Bt3PWUs4Zg=;
	b=NfXNAGq3rxzij0Bx5/irwTrcKFzORpP/9laP87BUo2pzeSVxyluW+lrwJk5o8977Tri0Cr
	QV8Xb2qvaZDFwcAA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] selftests/kexec: Add x86_64 selftest for kexec-jump
 and exception handling
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250326142404.256980-5-dwmw2@infradead.org>
References: <20250326142404.256980-5-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174428356994.31282.2059699391686808432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     7615b94b6371dab5d7d8c1ca4f95ed3f866e1c51
Gitweb:        https://git.kernel.org/tip/7615b94b6371dab5d7d8c1ca4f95ed3f866e1c51
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Wed, 26 Mar 2025 14:16:04 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 12:17:14 +02:00

selftests/kexec: Add x86_64 selftest for kexec-jump and exception handling

Add a self test which exercises both the kexec-jump facility, and the
kexec exception handling.

Invoke a trivial payload which just does an int3 and returns,
flip-flopping its entry point for the next invocation between two
implementations of the same thing.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250326142404.256980-5-dwmw2@infradead.org
---
 tools/testing/selftests/kexec/Makefile           |  7 +-
 tools/testing/selftests/kexec/test_kexec_jump.c  | 72 +++++++++++++++-
 tools/testing/selftests/kexec/test_kexec_jump.sh | 42 +++++++++-
 3 files changed, 121 insertions(+)
 create mode 100644 tools/testing/selftests/kexec/test_kexec_jump.c
 create mode 100755 tools/testing/selftests/kexec/test_kexec_jump.sh

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 67fe7a4..e3000cc 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -8,6 +8,13 @@ ifeq ($(ARCH_PROCESSED),$(filter $(ARCH_PROCESSED),x86 ppc64le))
 TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 TEST_FILES := kexec_common_lib.sh
 
+include ../../../scripts/Makefile.arch
+
+ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
+TEST_PROGS += test_kexec_jump.sh
+test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
+endif
+
 include ../lib.mk
 
 endif
diff --git a/tools/testing/selftests/kexec/test_kexec_jump.c b/tools/testing/selftests/kexec/test_kexec_jump.c
new file mode 100644
index 0000000..fbce287
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_jump.c
@@ -0,0 +1,72 @@
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/kexec.h>
+#include <linux/reboot.h>
+#include <sys/reboot.h>
+#include <sys/syscall.h>
+
+asm(
+    "  .code64\n"
+    "  .data\n"
+    "purgatory_start:\n"
+
+    // Trigger kexec debug exception handling
+    "  int3\n"
+
+    // Set load address for next time
+    "  leaq purgatory_start_b(%rip), %r11\n"
+    "  movq %r11, 8(%rsp)\n"
+
+    // Back to Linux
+    "  ret\n"
+
+    // Same again
+    "purgatory_start_b:\n"
+
+    // Trigger kexec debug exception handling
+    "  int3\n"
+
+    // Set load address for next time
+    "  leaq purgatory_start(%rip), %r11\n"
+    "  movq %r11, 8(%rsp)\n"
+
+    // Back to Linux
+    "  ret\n"
+
+    "purgatory_end:\n"
+    ".previous"
+);
+extern char purgatory_start[], purgatory_end[];
+
+int main (void)
+{
+        struct kexec_segment segment = {};
+	int ret;
+
+	segment.buf = purgatory_start;
+	segment.bufsz = purgatory_end - purgatory_start;
+	segment.mem = (void *)0x400000;
+	segment.memsz = 0x1000;
+	ret = syscall(__NR_kexec_load, 0x400000, 1, &segment, KEXEC_PRESERVE_CONTEXT);
+	if (ret) {
+		perror("kexec_load");
+		exit(1);
+	}
+
+	ret = syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC);
+	if (ret) {
+		perror("kexec reboot");
+		exit(1);
+	}
+
+	ret = syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC);
+	if (ret) {
+		perror("kexec reboot");
+		exit(1);
+	}
+	printf("Success\n");
+	return 0;
+}
+
diff --git a/tools/testing/selftests/kexec/test_kexec_jump.sh b/tools/testing/selftests/kexec/test_kexec_jump.sh
new file mode 100755
index 0000000..6ae9770
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_jump.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Prevent loading a kernel image via the kexec_load syscall when
+# signatures are required.  (Dependent on CONFIG_IMA_ARCH_POLICY.)
+
+TEST="$0"
+. ./kexec_common_lib.sh
+
+# kexec requires root privileges
+require_root_privileges
+
+# get the kernel config
+get_kconfig
+
+kconfig_enabled "CONFIG_KEXEC_JUMP=y" "kexec_jump is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_jump is not enabled"
+fi
+
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"IMA architecture specific policy enabled"
+arch_policy=$?
+
+get_secureboot_mode
+secureboot=$?
+
+if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
+    log_skip "Secure boot and CONFIG_IMA_ARCH_POLICY are enabled"
+fi
+
+./test_kexec_jump
+if [ $? -eq 0 ]; then
+    log_pass "kexec_jump succeeded"
+else
+    # The more likely failure mode if anything went wrong is that the
+    # kernel just crashes. But if we get back here, sure, whine anyway.
+    log_fail "kexec_jump failed"
+fi

