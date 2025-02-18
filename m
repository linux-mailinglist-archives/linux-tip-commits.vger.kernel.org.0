Return-Path: <linux-tip-commits+bounces-3516-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E07A39BE2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A26188F87E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54524817E;
	Tue, 18 Feb 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T8qQ90/+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hkPIDA1T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AD2475D2;
	Tue, 18 Feb 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880718; cv=none; b=s6HKyW9y4IDn1gYvQum2wZS6+Q8xmHblEqmiCrdNsJxSsVZkxpyH/j/t8DjiaxjYaSKTZ5gd85PIKaG7sjwIl6HcL0h/lAOEPlpUxmKjYUx6b4xcJZkxwd78aC3/BK7M5UTBzUPinfpiwZnhzQaNJ965Q8X4z0vRzO8YwXsgtB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880718; c=relaxed/simple;
	bh=d/hAqTN2Nl0wnWaRWeyEC5IAob8Kn2Dhbyfj8x2cUZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ksHIbA0XX5+LolAN1/sVV7ASS5bo3YbGumangn0Ra0JI5FD/UzstN8C7jEXo6po2F0hbPSdZMOc7ZYN5DswK0NynuOx33ilxVy4PZ0hDyoG0OlCmfAjEQrS+WArti/2ZZNjsle7HmMFmVulrcGDhb4uJlvr7PXquxldT58A/UzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T8qQ90/+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hkPIDA1T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKsEEweMg6g5WBJqOkpNCVYduswFCF9/GLIziovH87U=;
	b=T8qQ90/+LpoxmQv3VSsiksTYv3Nhi6xyFi/HmTZcJWRceUREpFQdv+3IfaXQUmXiBu1v1u
	YUMCotQ51FAZINvI090Ntm1K0jW+6nIFMkAhwCdobw/ljvuwGyOhC2KBMvmbES2ZlVsuMX
	xI0Z/aKLDAiM6lmonOHNMUnf6Sp71X7BzpGgQovlsVQ7lPWKA4KJDGFaTSGv2hu4lc/s18
	oqmNSuRjVw8/u1ZJh7ctb+iXhpFMtFnBpqLmf7mbawG183vsXkFslpKYvo0OtgIszciQas
	27rXW325eiF75cRZHLfsZdzqpdxfutYORzMpRuAAGigKEOjI8aQeRUIOjlQ/bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKsEEweMg6g5WBJqOkpNCVYduswFCF9/GLIziovH87U=;
	b=hkPIDA1TQD2ZR86LeF9zJhjni/5T288aGo4XSL2cTONZv7AV5S0gPUWqkEWg+7e/gNejY9
	JpiNRx3RaI5t15Bg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/stackprotector: Remove stack protector test scripts
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-3-brgerst@gmail.com>
References: <20250123190747.745588-3-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988071350.10177.5052919294216712163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     0ee2689b9374d6fd5f43b703713a532278654749
Gitweb:        https://git.kernel.org/tip/0ee2689b9374d6fd5f43b703713a532278654749
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:34 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:14:47 +01:00

x86/stackprotector: Remove stack protector test scripts

With GCC 8.1 now the minimum supported compiler for x86, these scripts
are no longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-3-brgerst@gmail.com
---
 arch/x86/Kconfig                          | 11 +----------
 scripts/gcc-x86_32-has-stack-protector.sh |  8 --------
 scripts/gcc-x86_64-has-stack-protector.sh |  4 ----
 3 files changed, 1 insertion(+), 22 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311..6595b35 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -285,7 +285,7 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
-	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
+	select HAVE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
@@ -426,15 +426,6 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
-config CC_HAS_SANE_STACKPROTECTOR
-	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
-	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC) $(CLANG_FLAGS))
-	help
-	  We have to make sure stack protector is unconditionally disabled if
-	  the compiler produces broken code or if it does not let us control
-	  the segment on 32-bit kernels.
-
 menu "Processor type and features"
 
 config SMP
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
deleted file mode 100755
index 9459ca4..0000000
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# This requires GCC 8.1 or better.  Specifically, we require
-# -mstack-protector-guard-reg, added by
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
deleted file mode 100755
index f680bb0..0000000
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"

