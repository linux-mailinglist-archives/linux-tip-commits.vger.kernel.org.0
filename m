Return-Path: <linux-tip-commits+bounces-6470-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43144B439E2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21481C81F70
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC163019C4;
	Thu,  4 Sep 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hfS/ipkv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbf1akv4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1192301461;
	Thu,  4 Sep 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984864; cv=none; b=Z0hdhgAyMty22NGzifYw7tk7A8J6k/9rveLArAb8SuTyBwrQWRpSLdbo47+Ub6q6/HhNRjEuSAyX91sKWojQGKK0IiFesDbIYAt+KE6Q4Ufy9RNkTLW8I6fYPHmD7THDCibzsidqfMmJiyDzt4eKGZoDYX/NFebY1du8GG5DoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984864; c=relaxed/simple;
	bh=hHMVlK1JpUYAgFUNSafG9YxRyYxXOadxQ6yJjyoVf0Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YwLancAwGJmtx2ZdIlodgE33zxnhhAYww9gZAeNSDzwUdZhYWUPeVHSOe3RwnaiUr7KmVEFfV8k4l85n+MS/ekkuWToc/ujmOsepCFoEI2u9scbqo+B/eY0YzypiIDhRS0eItczPtIJGUOPoC3Qrp4v5rOP1v4qa83FaljBd0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hfS/ipkv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbf1akv4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGiGgqCDbAunCAM5CN45FAxzfHnIbAbDLmtCj9zxns8=;
	b=hfS/ipkvzGO/Kvd3fCrdtzVwqAdv5hZD4feCbquMM5aH2TF2b2uTIKrUhr6wBxcxddNBX4
	Qn5rVkZv14tuAiatrCOqjRqsnZQwJ4sQF0GrCSiMFO4XmjsoI/k3C3H/Lcs8AXl2awVvUW
	piaqD9K/tTG2MI6qoorZroK5lzGy6l4okozf98pOSSn5ZkxX+tgn4q7+Ux033mh4mAYLdT
	9WPxYxWgsw9OLl2OP1rPZkoaSv3kK7ROwfLAWhLF0CVSqsRGelBp59RMB/9bK16GyBS/f9
	uE5Uosy/5V9YDzhwvV1Pd3i7PipsbVxyAIZOrA9nDMi8UCJwWBl0NF6XVuPBRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGiGgqCDbAunCAM5CN45FAxzfHnIbAbDLmtCj9zxns8=;
	b=vbf1akv4eaoMPmiNpPB16+/6Lu0/cAAgzhXGUJuxE2iiToH3Cfeaob7J1wTOtJRhVQ2fBS
	3DneJQVDGnW/9MAw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-34-ardb+git@google.com>
References: <20250828102202.1849035-34-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698485957.1920.18150122817427945893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     68a501d7fd82454525797971c6a0005ceeb93153
Gitweb:        https://git.kernel.org/tip/68a501d7fd82454525797971c6a0005ceeb=
93153
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:13 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:59:09 +02:00

x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check

snp_vmpl will be assigned a non-zero value when executing at a VMPL other than
0, and this is inferred from a call to RMPADJUST, which only works when
running at VMPL0.

This means that testing snp_vmpl is sufficient, and there is no need to
perform the same check again.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-34-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 4873469..26aa389 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -406,30 +406,16 @@ void sev_enable(struct boot_params *bp)
 	 */
 	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
 		u64 hv_features;
-		int ret;
=20
 		hv_features =3D get_hv_features();
 		if (!(hv_features & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
=20
 		/*
-		 * Enforce running at VMPL0 or with an SVSM.
-		 *
-		 * Use RMPADJUST (see the rmpadjust() function for a description of
-		 * what the instruction does) to update the VMPL1 permissions of a
-		 * page. If the guest is running at VMPL0, this will succeed. If the
-		 * guest is running at any other VMPL, this will fail. Linux SNP guests
-		 * only ever run at a single VMPL level so permission mask changes of a
-		 * lesser-privileged VMPL are a don't-care.
+		 * Running at VMPL0 is required unless an SVSM is present and
+		 * the hypervisor supports the required SVSM GHCB events.
 		 */
-		ret =3D rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1);
-
-		/*
-		 * Running at VMPL0 is not required if an SVSM is present and the hypervis=
or
-		 * supports the required SVSM GHCB events.
-		 */
-		if (ret &&
-		    !(snp_vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
+		if (snp_vmpl && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
=20

