Return-Path: <linux-tip-commits+bounces-4197-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E0A5FD20
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35712189488D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00CA268C55;
	Thu, 13 Mar 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGMcw9C0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="71JIjgit"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA8201025;
	Thu, 13 Mar 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885882; cv=none; b=Z5zXdLBnPxqDx2/2ws3onzksknK0F9XVYwuKmDy63OdateAS18F/gjhakMe+Wv1q9Mk7dGhfY5y4dOUu7/lvH2INjyYpsGnI5KXKDR0ld9tYzBRiUzndCzzSryst01ZvAwSh7yzPGVNbiNkC5ERGUvdBKwIU7IbiugY5jBqDxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885882; c=relaxed/simple;
	bh=V6xYhvY4mBS66kvGhJN6I3RfAY3jgAjyR72egKJ/Gno=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KfepL7pvECfu6RhY/HnNGLD4Fygry6nwx/6hzxR7lnqsJdRVyKTieVeeD2r+hB4iDtkKu6GVc+WzMsSCHGcZ+b9c1a2wrobIT+xCK6ixn1r8kQTTOGMDs1HSjZcryGR74KLdrkrvKtON9qqIcbkMyuzXAFo9dWRzYXtajlHVjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VGMcw9C0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=71JIjgit; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 17:11:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741885878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OjHvXX4Rziu1PEWPugjSF5IAIiCZyri+g30Vn5c8Gc=;
	b=VGMcw9C0b0sEsd3kxyODtgt6SK82RwvIV/awBl8d7qC5Ac6OLaZk7c/DYCBQUMdpV638H2
	sgIAg+R15K4FrIhrPWR1am0CGpUrJCYi08zLU8Ogn1JObwFUQ6T5mxeGNWUMtOQs1y+Y46
	WGUESmmNxpzwXYlzTV6LknPW8ZZfKCdLCV97iSl4KuY3xVFyXnWRmRISXwuVOxLYnffpIj
	Em/G/cC0PuTfjpzbQajRgRTN8t6jsxLAfBhVlRpFim5kJo972ClCRYUW9VZqoW6rusM7YZ
	lqZRae/mNLcs84u7FTGMrQ5VIHZfHI9fSMnNnE+qj/gPqd+hXzB3z2sK6UeHsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741885878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OjHvXX4Rziu1PEWPugjSF5IAIiCZyri+g30Vn5c8Gc=;
	b=71JIjgitOngWR6694DOd2OhdgS0EREEcy2Dq4AFVFZppIwUzHB8Vyj1SQh4T5htnMo6f4A
	QqIEauMM7zmprnAg==
From: "tip-bot2 for Akihiro Suda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/pkeys: Disable PKU when running on Apple Virtualization
Cc: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>
References: <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174188587437.14745.4194287281354290889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0457ee8d3da0e497c42ca68b7c3c70e9b39cba98
Gitweb:        https://git.kernel.org/tip/0457ee8d3da0e497c42ca68b7c3c70e9b39cba98
Author:        Akihiro Suda <suda.gitsendemail@gmail.com>
AuthorDate:    Wed, 12 Mar 2025 19:09:26 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Mar 2025 17:59:46 +01:00

x86/pkeys: Disable PKU when running on Apple Virtualization

Protection keys seem broken on Apple Virtualization, they produce this warning:

  WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/xstate.c:1003 get_xsave_addr_user+0x28/0x40
  (...)
  Call Trace:
   <TASK>
   ? get_xsave_addr_user+0x28/0x40
   ? __warn.cold+0x8e/0xea
   ? get_xsave_addr_user+0x28/0x40
   ? report_bug+0xff/0x140
   ? handle_bug+0x3b/0x70
   ? exc_invalid_op+0x17/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? get_xsave_addr_user+0x28/0x40
   copy_fpstate_to_sigframe+0x1be/0x380
   ? __put_user_8+0x11/0x20
   get_sigframe+0xf1/0x280
   x64_setup_rt_frame+0x67/0x2c0
   arch_do_signal_or_restart+0x1b3/0x240
   syscall_exit_to_user_mode+0xb0/0x130
   do_syscall_64+0xab/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Work it around by applying a quirk: look up 'Apple Vz' in the
ACPI FADT table in setup_pku() and disabling PKU.

Tested on macOS 13.5.1 running on MacBook Pro 2020 with
Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz.

[ mingo: Fixed !ACPI build bug, updated the comments and the changelog. ]

Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://github.com/lima-vm/lima/issues/3334
Link: https://lore.kernel.org/r/20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp
---
 arch/x86/kernel/cpu/common.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b..c1bab70 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
+#include <linux/acpi.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -510,12 +511,23 @@ static __init int x86_nofsgsbase_setup(char *arg)
 __setup("nofsgsbase", x86_nofsgsbase_setup);
 
 /*
- * Protection Keys are not available in 32-bit mode.
+ * Protection Keys are not available in 32-bit mode and in
+ * certain virtual guest environments.
  */
 static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
+#ifdef CONFIG_ACPI
+	/*
+	 * OSPKE seems broken on Apple Virtualization:
+	 */
+	if (!memcmp(acpi_gbl_FADT.header.oem_table_id, "Apple Vz", 8)) {
+		pr_info("pku: disabled on Apple Virtualization platform (Intel) due to a bug\n");
+		pku_disabled = true;
+	}
+#endif
+
 	if (c == &boot_cpu_data) {
 		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
 			return;

