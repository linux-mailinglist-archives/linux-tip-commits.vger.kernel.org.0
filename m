Return-Path: <linux-tip-commits+bounces-3670-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1FAA45ED9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6773B1A28
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6696421506E;
	Wed, 26 Feb 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kTjPyL3q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PBM3DaTN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114B215785;
	Wed, 26 Feb 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572107; cv=none; b=e8+Ay6UpHSD3ju9qzh4i6EQ+jt2QB1ESatAnqRNOzx6A9Wc2DAVvlzSSoC/PzZdPpekfKUz7gjjgCAujryB56NJdIpZj3r77MPTlBdapueopY0oh6luWfD/7nTpll5ehrI9fo2Kh0wreUj+ji/v1yYIY2Mu43vtUK/Uq/1pi5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572107; c=relaxed/simple;
	bh=CI/x7cZ650TSKEUBceLQERMWrh7HSZUA1AUoUNhHSns=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WuBHZS3X0WXfeXhuNo5ZOe5XW1ECbOi1LXbG+Y68aJFR9OOPD3CeV2KyGJsHLlJJ0WXD0ehUCR9bcK0mepW6eQG8hIWWT4wKM1pGJEB71f+kNzTcxpBqQbIkMYnOGlG+x17/38lkZq4GbvI44MjRu/LJWbDOE2P6O/OQMKUTCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kTjPyL3q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PBM3DaTN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZzB53QHmMmsfW5kzZagHwgEdYP4EveGloYBEbE/KAA=;
	b=kTjPyL3qgYs1kQIPLbbKBygqX5ZAfCgmz4Ar4/Xd7VhiQjljjZnPZV8eDHGHYRtNExJK0P
	6kX78qOi0w547BKfdMi1U8JDjT3lP7XKyjV5BqMktZt2ZIeWwt04ExxxdFlgdLIx9d9EOy
	2UAkz25RpgZCGzlOZq8Ya9LzLo9x+Ln45OXIIBddAjMyIAOMJJY3es8rpQFUsyVx9qHwjB
	ET9MgT+3zWGw8lWM3kXDw5KdgzdcyCyyON35V83dmaZEtfkl7c5qGtS7Xy5uUe4UPJkZkS
	4LwO/2e6qofVNSNSVp5qNsM44PIFAkC4ewyP1EEi4ZpcK0knD3Wb38EA3SGGlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZzB53QHmMmsfW5kzZagHwgEdYP4EveGloYBEbE/KAA=;
	b=PBM3DaTNELeBOr60xjfmb58hoG1Sx65P5ZOZGCCEDLjM05dyeKXWZnwdFb86b1Fh7iWENw
	lhWSBhjs5YS50HAA==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86/avx: Add AVX tests
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-10-chang.seok.bae@intel.com>
References: <20250226010731.2456-10-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057210260.10177.17899873701396575344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     bfc98dbcb3c75c6e2eb1dcf389d02a8c2419c41c
Gitweb:        https://git.kernel.org/tip/bfc98dbcb3c75c6e2eb1dcf389d02a8c2419c41c
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:29 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:30 +01:00

selftests/x86/avx: Add AVX tests

Add xstate testing specifically for those vector register states,
validating kernel's context switching and ensuring ABI compliance.
Use the established xstate testing framework.

Alternatively, this invocation could be placed directly in
xstate.c::main(). However, the current test file naming convention, which
clearly specifies the tested area, seems reasonable. Adding avx.c
considerably aligns with that convention.

The test output should be like this for ZMM_Hi256 as an example:

  $ avx_64
  ...
  [RUN]   AVX-512 ZMM_Hi256: check context switches, 10 iterations, 5 threads.
  [OK]    No incorrect case was found.
  [RUN]   AVX-512 ZMM_Hi256: inject xstate via ptrace().
  [OK]    'xfeatures' in SW reserved area was correctly written
  [OK]    xstate was correctly updated.
  [RUN]   AVX-512 ZMM_Hi256: load xstate and raise SIGUSR1
  [OK]    'magic1' is valid
  [OK]    'xfeatures' in SW reserved area is valid
  [OK]    'xfeatures' in XSAVE header is valid
  [OK]    xstate delivery was successful
  [OK]    'magic2' is valid
  [RUN]   AVX-512 ZMM_Hi256: load new xstate from sighandler and check it after sigreturn
  [OK]    xstate was restored correctly

But systems without AVX-512 will look like:
  ...
  The kernel does not support feature number: 5
  The kernel does not support feature number: 6
  The kernel does not support feature number: 7

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-10-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/Makefile |  4 +++-
 tools/testing/selftests/x86/avx.c    | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/avx.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index f15efdc..28422c3 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -19,7 +19,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx lam test_shadow_stack
+			corrupt_xstate_header amx lam test_shadow_stack avx
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -133,4 +133,6 @@ $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
 
+$(OUTPUT)/avx_64: CFLAGS += -mno-avx -mno-avx512f
 $(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
+$(OUTPUT)/avx_64: EXTRA_FILES += xstate.c
diff --git a/tools/testing/selftests/x86/avx.c b/tools/testing/selftests/x86/avx.c
new file mode 100644
index 0000000..11d5367
--- /dev/null
+++ b/tools/testing/selftests/x86/avx.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE /* Required for inline xstate helpers */
+#include "xstate.h"
+
+int main(void)
+{
+	test_xstate(XFEATURE_YMM);
+	test_xstate(XFEATURE_OPMASK);
+	test_xstate(XFEATURE_ZMM_Hi256);
+	test_xstate(XFEATURE_Hi16_ZMM);
+}

