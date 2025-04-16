Return-Path: <linux-tip-commits+bounces-5007-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44056A8B335
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546251905FA8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7C233702;
	Wed, 16 Apr 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0AchbUY7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bcu90t32"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205B230BF3;
	Wed, 16 Apr 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791444; cv=none; b=MaRODbMaKhJCWA8QGB4vUpPqxTedNhms5W42Zd5036ZN8KETz0ECn1HLnoDeTNwywBY6W7bbSAZ27KNWBXEsak++fwCQoa+sZQvJrUynNG4czTotWBlMuIsruMTFg63Odeoa8Ry+ngDeMrCvf6ZJ1pJjCSSqH3JYa7WeMH5K/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791444; c=relaxed/simple;
	bh=rp7vCjXjkVnyUDG+KKQTldTVcuk3R4xfoXU6EBNfEFo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FxGu9dGHRh8yXVfa+nWoJSpR644qoB5BICLcg4E/t5louygAn4A47L3Hcicx2H9nABScNrlwnnm1pQzSx4HIMctns7ar8hVGW6HR9zLRDIjmDfsjEYvnkvgKR5LPJnvEi2xXJt49f866YH0EFkeODxbWDBfpDTj0a/32qYB+wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0AchbUY7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bcu90t32; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KO5Kb047S/M6Aq0yX/NRneqdjRruI6uXzeZafy/aUSw=;
	b=0AchbUY7KAj5/MduOm3wFM0DIAz+HfM5HrDlCJwlZpcIGKdih1/dC7ACRjQYIsaP9Wkx3I
	wjPdufBLuqLMMS6Avnf+wBEy2tNUbrgDd168EQRr3vty7DXTfG8HS2TLbEs+DiDlvP6Hr/
	alp84nG5vGT0zQtXG46oqT7srhZ/eSzlSdyY5kubiayTFePMONlxsnSLsUorOzH0oeczMx
	9eXdpPNNz0FeTq69IcFKzNvUv9boaH7dI9Mm3avKjpMDgengyyU9Tm0zvZG4AuHSatiHl8
	8kDqCiRWYlzrctcOzoOY9dCIaUv3T+M8326qV3nbC9hWN3ibpO95bOy+mu4dng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KO5Kb047S/M6Aq0yX/NRneqdjRruI6uXzeZafy/aUSw=;
	b=Bcu90t326D7k8+CtXw1LSakkIJcH82Z6ZQgIERT8bKyH9f5qKcuUF+kAfcLuAvCWbFjpV5
	o9sg7LfHvNXrpDBQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] selftests/x86/apx: Add APX test
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-6-chang.seok.bae@intel.com>
References: <20250416021720.12305-6-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479144000.31282.9481822905580060304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ab6f87ddd0c6d3fb114cdf897eb9839cbd429439
Gitweb:        https://git.kernel.org/tip/ab6f87ddd0c6d3fb114cdf897eb9839cbd429439
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:55 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 09:44:14 +02:00

selftests/x86/apx: Add APX test

The extended general-purpose registers for APX may contain random data,
which is currently assumed by the xstate testing framework. This allows
the testing of the new userspace feature using the common test code.

Invoke the test entry function from apx.c after enumerating the
state component and adding it to the support list

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250416021720.12305-6-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/Makefile |  3 ++-
 tools/testing/selftests/x86/apx.c    | 10 ++++++++++
 tools/testing/selftests/x86/xstate.c |  3 ++-
 tools/testing/selftests/x86/xstate.h |  2 ++
 4 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/x86/apx.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 28422c3..f703fcf 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -19,7 +19,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx lam test_shadow_stack avx
+			corrupt_xstate_header amx lam test_shadow_stack avx apx
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -136,3 +136,4 @@ $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/avx_64: CFLAGS += -mno-avx -mno-avx512f
 $(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
 $(OUTPUT)/avx_64: EXTRA_FILES += xstate.c
+$(OUTPUT)/apx_64: EXTRA_FILES += xstate.c
diff --git a/tools/testing/selftests/x86/apx.c b/tools/testing/selftests/x86/apx.c
new file mode 100644
index 0000000..d9c8d41
--- /dev/null
+++ b/tools/testing/selftests/x86/apx.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include "xstate.h"
+
+int main(void)
+{
+	test_xstate(XFEATURE_APX);
+}
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index 23c1d6c..97fe4bd 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -31,7 +31,8 @@
 	 (1 << XFEATURE_OPMASK)	|	\
 	 (1 << XFEATURE_ZMM_Hi256) |	\
 	 (1 << XFEATURE_Hi16_ZMM) |	\
-	 (1 << XFEATURE_XTILEDATA))
+	 (1 << XFEATURE_XTILEDATA) |	\
+	 (1 << XFEATURE_APX))
 
 static inline uint64_t xgetbv(uint32_t index)
 {
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 42af36e..e91e309 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -33,6 +33,7 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_16,
 	XFEATURE_XTILECFG,
 	XFEATURE_XTILEDATA,
+	XFEATURE_APX,
 
 	XFEATURE_MAX,
 };
@@ -59,6 +60,7 @@ static const char *xfeature_names[] =
 	"unknown xstate feature",
 	"AMX Tile config",
 	"AMX Tile data",
+	"APX registers",
 	"unknown xstate feature",
 };
 

