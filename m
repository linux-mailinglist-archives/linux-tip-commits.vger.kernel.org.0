Return-Path: <linux-tip-commits+bounces-4596-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AA2A76624
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 14:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD53E7A52FC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C331DD0F2;
	Mon, 31 Mar 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4NmOl/kx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZnZq5dp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661E1E47B4;
	Mon, 31 Mar 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424609; cv=none; b=p3aC/t/U1VqIJkpk2taeaHbWFIwjAjXyzCGgzDtRjlJjk+XNF6KUvaEBnyaNXAB9xZePFFXTy60jYaAKW89WIbmqzniltFB35Ye4NKu+6Q+8lejFlpqdl+BQkZ6cM6QCLESERxZ155Tuj7gp4nLw1ctTmYvlpnPvX9iff+Yu8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424609; c=relaxed/simple;
	bh=WO8ZQqAZReSaVbWo73PGM9LkH6tHhMGraGhSil3Rza0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oNGmnS8wIykkjyCVreEAWqTJuK/5qsM43TRp3ddCiROdxNfMby9eJnv6xEmyiEMe9BJVlxT/NPltbkxNe06vDhGn/1foTrW8gs4iBkKmVTjvKzWrUnBHn2b4LekWSkQ17jdCgM78gxD3uUh5ukBAhfugDHucLhCRfEoEpSWpfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4NmOl/kx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZnZq5dp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 31 Mar 2025 12:36:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743424604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giwiugG+XXEHLjqcoIjr2Z2Yo98Jv9GxUEFFjByCv/o=;
	b=4NmOl/kxltsbtxqh7G3NLQWvEJBaRQzZBM67GHfU6mwPBTVej7KAhXhATWPwZcZqO195CD
	HT9Xazw+Z/WDjl2GedTQOqNWNHPMN/AR8vSx9bTRMY0gb/DUF2SVc2563aHdG0Qc9JY6pS
	izzQE7rjAuAmEgwdBT13gkU3ywGUcwMIqUGYhAg/u8O/WEntELpCUDS7XAVOvg8RbgewRz
	UVfImiJ/O14pTCaqHEDVuEnAJUgpk0Z9Llwoup1LL7o5o60YJnJ6EnZth8Rs1110wvvWhE
	TDWOsd9SdBGdgEclVcvsc3a7FdV/J4rYO8H/kFIUzC3NXsPbpIJaWaKzYBJ7Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743424604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giwiugG+XXEHLjqcoIjr2Z2Yo98Jv9GxUEFFjByCv/o=;
	b=NZnZq5dp0Y+8LcRNusL3QKZuM39dDDoAmPZ3vVOh+VZ0EPiOpRhyn2gF4DjOMn1a9OWeOY
	Y3W0LoURJPPYfPBw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fred: Fix system hang during S4 resume with
 FRED enabled
Cc: Xi Pardee <xi.pardee@intel.com>, Todd Brandt <todd.e.brandt@intel.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250326062540.820556-1-xin@zytor.com>
References: <20250326062540.820556-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174342460045.14745.9243605913254959856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b578bfe07ae943937a2945a9f6ac4b497f4d4e09
Gitweb:        https://git.kernel.org/tip/b578bfe07ae943937a2945a9f6ac4b497f4d4e09
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Tue, 25 Mar 2025 23:25:40 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 31 Mar 2025 14:19:35 +02:00

x86/fred: Fix system hang during S4 resume with FRED enabled

During an S4 resume, the system first performs a cold power-on.  The
kernel image is initially loaded to a random linear address, and the
FRED MSRs are initialized.  Subsequently, the S4 image is loaded,
and the kernel image is relocated to its original address from before
the S4 suspend.  Due to changes in the kernel text and data mappings,
the FRED MSRs must be reinitialized with new values.

[ mingo: Rephrased & clarified the comments. ]

Reported-by: Xi Pardee <xi.pardee@intel.com>
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250326062540.820556-1-xin@zytor.com
---
 arch/x86/power/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 63230ff..70c8906 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
+#include <asm/fred.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -231,6 +232,25 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 */
 #ifdef CONFIG_X86_64
 	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+
+	/*
+	 * Restore FRED settings.
+	 *
+	 * FRED settings can be completely derived from
+	 * current kernel text and data data mappings, thus
+	 * nothing needs to be saved and restored.
+	 *
+	 * As such, simply re-initialize FRED to restore the FRED
+	 * settings. Note that any changes to text and data mappings
+	 * after S4 resume will generate different FRED configuration
+	 * values.
+	 *
+	 * Also, FRED RSPs setup needs to access per-CPU data structures.
+	 */
+	if (ctxt->cr4 & X86_CR4_FRED) {
+		cpu_init_fred_exceptions();
+		cpu_init_fred_rsps();
+	}
 #else
 	loadsegment(fs, __KERNEL_PERCPU);
 #endif

