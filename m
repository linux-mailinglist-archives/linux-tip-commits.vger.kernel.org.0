Return-Path: <linux-tip-commits+bounces-3172-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9266FA03D71
	for <lists+linux-tip-commits@lfdr.de>; Tue,  7 Jan 2025 12:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886811652DF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  7 Jan 2025 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F2C1DC9AD;
	Tue,  7 Jan 2025 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2/N28c8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKKxo515"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665491D90D7;
	Tue,  7 Jan 2025 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248928; cv=none; b=GX0NXUOfEPYLdCa+pCgWMhZ1CuWviAglG3Gr86YWzKm+LRDHVE9q/Vhb1R53aHouU3dpih0wZYBXIrl7bDerwCpa9U9rle/R/T4az0M0pAgrSw3BMWm2u+6AtAXLwj8kyUv8nuQXTdJFE0M58shRl0BIlBVkVZCYSXZqR+yz9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248928; c=relaxed/simple;
	bh=unC66OizlissAgh1hhgc4sbAwDTt/9i0/vkL7/w3XR8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b086Ie1a/5XatbQIXiPArA7LE6qO+Z3w2WBpCGcigfJY+YRQrLJoFB05V2Df/zMsU8BePpo3MjGfX+pYJKaqLZQknELJ7I36LFI/LUeszwBCOUqddQMSoXeSPJk/ypnA6i9YAmK7ymTUkQjCLWjiLGP82PqmKyF2R2w+MKVoGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2/N28c8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKKxo515; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 07 Jan 2025 11:22:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736248922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sopNh0zHilup6cwRR5qsq35XxqzH3Qqbc0GLJ4sz9CU=;
	b=b2/N28c8W1h87S/4DEXTOcEPg1OqeudSrSjVMwedujsndVBdU8l81DVWe5APbyRPwz4i6+
	Pohi0Zk7TuKMoup9V0ESmzeTNioTLT9ShHYW07Lac8PyL3ESCSO370zERMuvWdud97pipW
	HdaBIuJPt1rD32dVzsTajkBpiAGyCFafRiprziIX3JEInG7ethwEk8MquM1Q2pwq4x6WV2
	DnIjreJ8beBN8eupPlAP5lPLRHLtfTK0TnFb+KntXBc0Ds6ZFQF21Fa42qZUwXkzQM56XR
	9PLK+FlmBw/dcyONLm4/71ko3jsBQoK2SY0cZs53fX9erFa94VUcwPjYBIGT/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736248922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sopNh0zHilup6cwRR5qsq35XxqzH3Qqbc0GLJ4sz9CU=;
	b=LKKxo5159XkrCukdHVyfALLyGz1WAAkeWxY/QWJzM36psxLdccMlpWpkpWz31FTz2QKmMs
	r4vf3lFVN5mLm1Bw==
From: "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/fpu: Check if shadow stack is active for ssp_get()
Cc: Christina Schimpe <christina.schimpe@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231204190709.3907254-1-rick.p.edgecombe@intel.com>
References: <20231204190709.3907254-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173624892156.399.16993232798659389013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9b9ab249c4b1babb0d36c9d4f3309cfb6901a15a
Gitweb:        https://git.kernel.org/tip/9b9ab249c4b1babb0d36c9d4f3309cfb6901a15a
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 04 Dec 2023 11:07:09 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 12:08:40 +01:00

x86/fpu: Check if shadow stack is active for ssp_get()

The shadow stack regset ->set() handler (ssp_set()) checks the regset
->active() handler (ssp_active()) to verify that shadow stack is active.  When
shadow stack is active, the XFEATURE_CET_USER xfeature will not be in the init
state because there is at least one bit set (SHSTK_EN). So ssp_set() should be
able to safely operate on the xfeature in the xsave buffer after checking
ssp_active(). If it finds it is in the init state anyway, it warns because an
unexpected situation has been encountered.

But ssp_get(), the regset_get() handler, doesn't check ssp_active(). This
was under the assumption that all the callers check the ->active()
handler. It is indeed normally the case, but Christina Schimpe reports that
and a warning like the following can be generated:

  WARNING: CPU: 5 PID: 1773 at arch/x86/kernel/fpu/regset.c:198 ssp_get+0x89/0xa0
  [...]
  Call Trace:
  <TASK>
  ? show_regs+0x6e/0x80
  ? ssp_get+0x89/0xa0
  ? __warn+0x91/0x150
  ? ssp_get+0x89/0xa0
  ? report_bug+0x19d/0x1b0
  ? handle_bug+0x46/0x80
  ? exc_invalid_op+0x1d/0x80
  ? asm_exc_invalid_op+0x1f/0x30
  ? __pfx_ssp_get+0x10/0x10
  ? ssp_get+0x89/0xa0
  ? ssp_get+0x52/0xa0
  __regset_get+0xad/0xf0
  copy_regset_to_user+0x52/0xc0
  ptrace_regset+0x119/0x140
  ptrace_request+0x13c/0x850
  ? wait_task_inactive+0x142/0x1d0
  ? do_syscall_64+0x6d/0x90
  arch_ptrace+0x102/0x300
  [...]

It turns out the PTRACE_GETREGSET path does not check ssp_active(). The issue
could be fixed by just removing the warning, but it would be nicer to rely
on a check of ssp_active() which is much easier to reason about than xsave
init state logic. So add a ssp_active() check in ssp_get() like there already
is in ssp_set().

Fixes: 2fab02b25ae7 ("x86: Add PTRACE interface for shadow stack")
Reported-by: Christina Schimpe <christina.schimpe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Christina Schimpe <christina.schimpe@intel.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20231204190709.3907254-1-rick.p.edgecombe@intel.com
---
 arch/x86/kernel/fpu/regset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6bc1eb2..887b0b8 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -190,7 +190,8 @@ int ssp_get(struct task_struct *target, const struct user_regset *regset,
 	struct fpu *fpu = &target->thread.fpu;
 	struct cet_user_state *cetregs;
 
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !ssp_active(target, regset))
 		return -ENODEV;
 
 	sync_fpstate(fpu);

