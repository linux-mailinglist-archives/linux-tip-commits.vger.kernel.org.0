Return-Path: <linux-tip-commits+bounces-6245-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E6B22519
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Aug 2025 12:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1683620A3F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Aug 2025 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9B22ECE89;
	Tue, 12 Aug 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KwrGeR76";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+PHWYcV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B82ECD0C;
	Tue, 12 Aug 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996324; cv=none; b=kxCJjl17AtQurBjp1iKh1/mCWSEJsTAkhsFBZ6JOL+clr5hWz8zm2KhUIArU309sqHSfNvv53eqvtkp8kw39zraOMbQaVbn/gOkMQ0NlgbhAHW/tLtAZ43a+NuepvQM7jQtpsw17VGiy10eYxHkfenDmUmuTPviz2Fziqp5bCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996324; c=relaxed/simple;
	bh=5Chwcx07yUdx2v7mWHQTY/+BYLsTXCNuCqgAARYanSI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=onyS3pt8IzcST7fg0z8hXCqN/mtYzKDMhkwemO4wRQvefcHebW8z8rldMrCHDSbFZs1euax3K2KKa8a0KpT0ri4RaPOfsour3jg8dxL6VBFQyrP1PlCAEyRkMDppJf0JBYiTq5tmnWcKXDVx+RtUmypS2p2jR/JCRF1FkRXVSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KwrGeR76; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+PHWYcV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Aug 2025 10:58:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754996321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLZPiTUpHfbV66JrjGOLII+fvlLiiW80PM0N5wTW3Zg=;
	b=KwrGeR76OsQn+/mMMQR185dXJMy5L5G93eZLR4BbnWacfx/rkbvb0woQjh8PIpZyvqpWGx
	vh1UtzGAc2b1e8N/vEx6WLoMQh2c4sORiGKOSEjTB6rFvuHU9Wmlm/dY6e+WmP+GyvBErg
	hxWzNYb1dzLASiMQqeeCCGukmZ6ebcchKcH8gf5fLhTnYqRIVXwyg0H3abEhP1hzjJ4t5j
	QsH536HiqifdE/HW5g5G/3O1Nfhky7p4ThLnfTQefvVxQZmsCKFygVGl8q2I987OWisEB4
	yQDvv1YPyh5xRq7dhSn9lM/Lxp/PpD26usoC3dvudMGAJInmvyfTDRzxXciQFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754996321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLZPiTUpHfbV66JrjGOLII+fvlLiiW80PM0N5wTW3Zg=;
	b=l+PHWYcVr+fvBXuTQafLLRjqHUjhH1Ncbn6cFisKZ+vzOaZYoPnKpmU7eLxKjH1ZBmLCXc
	6ZEngGNtIgMqlsBg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/sev: Improve handling of writes to intercepted TSC MSRs
Cc: Sean Christopherson <seanjc@google.com>,
 Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250722074853.22253-1-nikunj@amd.com>
References: <20250722074853.22253-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175499631833.1420.8242908162869935320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5eb1bcdb6a8c088514019c3a9bda5d565beed1af
Gitweb:        https://git.kernel.org/tip/5eb1bcdb6a8c088514019c3a9bda5d565be=
ed1af
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Tue, 22 Jul 2025 13:18:53 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 12 Aug 2025 12:33:58 +02:00

x86/sev: Improve handling of writes to intercepted TSC MSRs

Currently, when a Secure TSC enabled SNP guest attempts to write to the
intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel response
incorrectly implies a VMM configuration error, when in fact it is the usual
VMM configuration to intercept writes to read-only MSRs, unless explicitly
documented.

Modify the intercepted TSC MSR #VC handling:
* Write to GUEST_TSC_FREQ will generate a #GP instead of terminating the
  guest
* Write to MSR_IA32_TSC will generate a #GP instead of silently ignoring it

However, continue to terminate the guest when reading from intercepted
GUEST_TSC_FREQ MSR with Secure TSC enabled, as intercepted reads indicate an
improper VMM configuration for Secure TSC enabled SNP guests.

  [ bp: simplify comment. ]

Fixes: 38cc6495cdec ("x86/sev: Prevent GUEST_TSC_FREQ MSR interception for Se=
cure TSC enabled guests")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/20250722074853.22253-1-nikunj@amd.com
---
 arch/x86/coco/sev/vc-handle.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index faf1fce..c3b4acb 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -371,29 +371,30 @@ static enum es_result __vc_handle_msr_caa(struct pt_reg=
s *regs, bool write)
  * executing with Secure TSC enabled, so special handling is required for
  * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
  */
-static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool=
 write)
+static enum es_result __vc_handle_secure_tsc_msrs(struct es_em_ctxt *ctxt, b=
ool write)
 {
+	struct pt_regs *regs =3D ctxt->regs;
 	u64 tsc;
=20
 	/*
-	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
-	 * Terminate the SNP guest when the interception is enabled.
+	 * Writing to MSR_IA32_TSC can cause subsequent reads of the TSC to
+	 * return undefined values, and GUEST_TSC_FREQ is read-only. Generate
+	 * a #GP on all writes.
 	 */
-	if (regs->cx =3D=3D MSR_AMD64_GUEST_TSC_FREQ)
-		return ES_VMM_ERROR;
+	if (write) {
+		ctxt->fi.vector =3D X86_TRAP_GP;
+		ctxt->fi.error_code =3D 0;
+		return ES_EXCEPTION;
+	}
=20
 	/*
-	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads of the TSC
-	 *         to return undefined values, so ignore all writes.
-	 *
-	 * Reads: Reads of MSR_IA32_TSC should return the current TSC value, use
-	 *        the value returned by rdtsc_ordered().
+	 * GUEST_TSC_FREQ read should not be intercepted when Secure TSC is
+	 * enabled. Terminate the guest if a read is attempted.
 	 */
-	if (write) {
-		WARN_ONCE(1, "TSC MSR writes are verboten!\n");
-		return ES_OK;
-	}
+	if (regs->cx =3D=3D MSR_AMD64_GUEST_TSC_FREQ)
+		return ES_VMM_ERROR;
=20
+	/* Reads of MSR_IA32_TSC should return the current TSC value. */
 	tsc =3D rdtsc_ordered();
 	regs->ax =3D lower_32_bits(tsc);
 	regs->dx =3D upper_32_bits(tsc);
@@ -416,7 +417,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, st=
ruct es_em_ctxt *ctxt)
 	case MSR_IA32_TSC:
 	case MSR_AMD64_GUEST_TSC_FREQ:
 		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-			return __vc_handle_secure_tsc_msrs(regs, write);
+			return __vc_handle_secure_tsc_msrs(ctxt, write);
 		break;
 	default:
 		break;

