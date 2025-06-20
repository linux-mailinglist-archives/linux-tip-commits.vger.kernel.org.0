Return-Path: <linux-tip-commits+bounces-5877-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F878AE21A0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 19:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73B44C15FB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF82BF3EB;
	Fri, 20 Jun 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7FyjgrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Naw2kSI3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33F1DC075;
	Fri, 20 Jun 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442072; cv=none; b=Tpc/PMqTkVXOZ2RgLjtsh+9J2V0MOyDNgIEVYnJ9bP+sGGIH8R6NWwf2Vo8E4biaecGQiXEWLJeADjWC8oenywZiGqt2kHepwrEysUGdGJrvYsWsiSsJWiCdA+idARMGYx8Y1rhJt7MHsU27s88vZtKU1M+0qBhrmwjQKohNHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442072; c=relaxed/simple;
	bh=3AOITwQtdLNcGHqTsIj4mSgyifucL4YYBlRM/I0eweA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Fyj3ECRRYEaO49YxBIlPA8+R7Zqc4zQ0EDGqtSZVZBghJ0O7uwIwAPGGK1r6gGP0ZKstF7H0fWwRwSDDf1CWvlAi+E2HUKJxz/uQrfIA2vcmKxnsnwt/P2xWQc4TPekUKsetYPzJ70Qz8QPyUnFA9ep0bD6DLvdV0gDOwO1KYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7FyjgrF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Naw2kSI3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 17:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750442069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BVBjjX1hbRfc8ehGh7/c987HLQFk/Q8im+szf4eY5+E=;
	b=k7FyjgrFw5oh3/rBRqZs4czqkMq09AVrq4WUfsI7vxok/gw7Ru6DiMvr4Y1ECbHNvNr5Qo
	loTJLs5QuJphncdDplEgOw6o377idIsWLOmWfmhO93Z/TTi+7jYh9NwEM/Do4/Yfbsoshi
	S5ywER/Hq6xIXrnIUGO3ZREU4ym3wJKyFOZzRHFFYuvA8HaWgBfpEmP5DuEk7ZdoMJVBAp
	YqIPqzjf3/VZbd0DTXDOfs+d/f3CH8SeTKWx/xs2Y+c2xHI7I5NHnaAQx34vKJQW3TzRt+
	p06CeIpn7EgYZOE4ziZxr1qp+faFSzHh9/oFF5XITvmwSwTh2H6DOplEfguzHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750442069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BVBjjX1hbRfc8ehGh7/c987HLQFk/Q8im+szf4eY5+E=;
	b=Naw2kSI3hYK2YxRjKFNM/OXXYlMlYq0Nnr1qD4rvdaxeVLlsn66LMkbge2IHiVZNYDzotb
	o/Ll/9Xazw0AoHDA==
From: "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/efi: Move runtime service initialization to arch/x86
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175044206817.406.15116962193585235583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     ce2c403c26c1ed0e28fc541ab30fe13ff50236be
Gitweb:        https://git.kernel.org/tip/ce2c403c26c1ed0e28fc541ab30fe13ff50236be
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Fri, 20 Jun 2025 16:53:12 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 20 Jun 2025 10:48:50 -07:00

x86/efi: Move runtime service initialization to arch/x86

The EFI call in start_kernel() is guarded by #ifdef CONFIG_X86. Move
the thing to the arch_cpu_finalize_init() path on x86 and get rid of
the #ifdef in start_kernel().

No functional change intended.

Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/all/20250620135325.3300848-5-kirill.shutemov%40linux.intel.com
---
 arch/x86/kernel/cpu/common.c | 7 +++++++
 init/main.c                  | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8feb8fd..4f430be 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
+#include <linux/efi.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -2530,6 +2531,12 @@ void __init arch_cpu_finalize_init(void)
 	fpu__init_cpu();
 
 	/*
+	 * This needs to follow the FPU initializtion, since EFI depends on it.
+	 */
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		efi_enter_virtual_mode();
+
+	/*
 	 * Ensure that access to the per CPU representation has the initial
 	 * boot CPU configuration.
 	 */
diff --git a/init/main.c b/init/main.c
index 225a582..f9f401b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -53,7 +53,6 @@
 #include <linux/cpuset.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
-#include <linux/efi.h>
 #include <linux/tick.h>
 #include <linux/sched/isolation.h>
 #include <linux/interrupt.h>
@@ -1068,10 +1067,6 @@ void start_kernel(void)
 
 	pid_idr_init();
 	anon_vma_init();
-#ifdef CONFIG_X86
-	if (efi_enabled(EFI_RUNTIME_SERVICES))
-		efi_enter_virtual_mode();
-#endif
 	thread_stack_cache_init();
 	cred_init();
 	fork_init();

