Return-Path: <linux-tip-commits+bounces-7112-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDAC24FBF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A471A270B6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A82E5B0D;
	Fri, 31 Oct 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIvQUdY1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gn6bSb8k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E682E2DD4;
	Fri, 31 Oct 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913335; cv=none; b=IW3HG9NGoZS5CODTbzxuCyr9/sYH6B1bJyTi3q8WQt8whiuY6T6b8uaEUzhnaMGdQfmmYwsFXzOcIbmrAIrlMOvgxpyzbCgHglacj8hnnaj0lp3yd3APtaIzPSR4yRBRKjLApWbubzNHaR+iut3jbjc7884QGdnFCl9g9Yiq3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913335; c=relaxed/simple;
	bh=np6LO3HGVADY/M6OpJ57XR9jCkojZJxJ/UcW9npkj3Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PBNSzBprY6COs7+OfUxnDWfaFVwFE3wsj0pcTP2w1WEMSDWjijSy7sBZEID4gNzXs9vnWDu/lG26o03M4K94j5tzF2QojYTHIxu82x78n4aQ3mbYoh8NUdZW1mm9tdiSx4xbucQR5tPOZtHbZoEndglAnGf5OQIANgSNJzopmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YIvQUdY1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gn6bSb8k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 12:22:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761913330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6wLh4rDXjBtesKjZaFsjJ4ExvDZv5xFjaWkySgbJbis=;
	b=YIvQUdY1B4HurPo3jHk6u0fO9yQmwgN2zROxJd901au9RGiNamCVBfPzUvbjpDoH4QKsu0
	WmTm/9RnCKqqRuSpUDgF2P7TIQiOj7UyrbVIxZGyg53zLkfeHongyWum8Mp8gTerunIQ3z
	YyJ0sSMdk4yinOUTEnkFpCBzGnxauuS2Saw7y888NxcHvYixHtTEzEOv6FSfLRYOAojrVe
	4ubI5LbrsQY4KGorWJZKF2FnzDSgmQziaCY+HvSHWApTByvaV3RTE9mYLXLwRf4no+G/gZ
	CiaBpchgBbkV+RuGEw/ksGnSahgfLjuJr14MJNDQJ5XRwG2GBDxtBpfYDNHiqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761913330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6wLh4rDXjBtesKjZaFsjJ4ExvDZv5xFjaWkySgbJbis=;
	b=gn6bSb8kRC4E76TTNnvDJ7SaLvU/zqCV5R9RtJjKLqz2lAGqkHxkUcLyiSxKzjGkxc2PRY
	NfTDvbviiNjTNBDA==
From: "tip-bot2 for John Allen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Include XSS value in GHCB CPUID request
Cc: John Allen <john.allen@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176191332874.2601451.1233005776687776033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     92ad6505a4b5e28afcc8cf5f4dd3fd137e58026b
Gitweb:        https://git.kernel.org/tip/92ad6505a4b5e28afcc8cf5f4dd3fd137e5=
8026b
Author:        John Allen <john.allen@amd.com>
AuthorDate:    Wed, 24 Sep 2025 20:08:52=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 30 Oct 2025 17:47:49 +01:00

x86/sev: Include XSS value in GHCB CPUID request

When a guest issues a CPUID instruction for Fn0000000D_x01, the hypervisor may
be intercepting the CPUID instruction and need to access the guest XSS value.
For SEV-ES, the XSS value is encrypted and needs to be included in the GHCB to
be visible to the hypervisor.

Signed-off-by: John Allen <john.allen@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://patch.msgid.link/all/20250924200852.4452-3-john.allen@amd.com/
---
 arch/x86/coco/sev/vc-shared.c | 11 +++++++++++
 arch/x86/include/asm/svm.h    |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index 9b01c9a..e2ac95d 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
=20
+#ifndef __BOOT_COMPRESSED
+#define has_cpuflag(f)                  boot_cpu_has(f)
+#endif
+
 static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 					    unsigned long exit_code)
 {
@@ -546,6 +550,13 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 		/* xgetbv will cause #GP - use reset value for xcr0 */
 		ghcb_set_xcr0(ghcb, 1);
=20
+	if (has_cpuflag(X86_FEATURE_SHSTK) && regs->ax =3D=3D 0xd && regs->cx =3D=
=3D 1) {
+		struct msr m;
+
+		raw_rdmsr(MSR_IA32_XSS, &m);
+		ghcb_set_xss(ghcb, m.q);
+	}
+
 	ret =3D sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
 	if (ret !=3D ES_OK)
 		return ret;
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 17f6c3f..0581c47 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -701,5 +701,6 @@ DEFINE_GHCB_ACCESSORS(sw_exit_info_1)
 DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
 DEFINE_GHCB_ACCESSORS(sw_scratch)
 DEFINE_GHCB_ACCESSORS(xcr0)
+DEFINE_GHCB_ACCESSORS(xss)
=20
 #endif

