Return-Path: <linux-tip-commits+bounces-2822-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E59C03E2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 12:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321441F22E2D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55261F4723;
	Thu,  7 Nov 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ue9WTbM7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECBAvf8y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D131F5837;
	Thu,  7 Nov 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978792; cv=none; b=AfrGkE1p8CRbK6nVK7a53xJiAyuDeyTLqDg79UMCaX/kvQbwNL48FZYHke5HijDejTu3c7VYxyyBu/hvolh48rixhRA8SP7hkbLLis2yllRLS8d/Hdy25JVoBoRmuszX3Y7/lkQUm4cpfY043YySCo6YdGD/c3mNe0UQhMHWF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978792; c=relaxed/simple;
	bh=7DuPUN98nJ4Zqqxq+Mi0D96Rm9nP7aPOl6WBikw2qOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e62cQF0Mt3MnEm+bLisQX1t3BKlx0AkpwzYHqLQ8YrE98x79HPI8WSQGPHJVUa2qPWhQ/yt7QBUQlW/mRh3jp9lwdR3GflNNy52y1U5RH26udjAFjpjUXwTA+gW5SleSqZ4Jz2XaowyzzIsmGMAvTn6StdLMOdc8iKh0MVRcNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ue9WTbM7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ECBAvf8y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 11:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730978788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbi4HyInMekcZe9nIgNL3HzKsUgUxuQBUw/s2YAs954=;
	b=Ue9WTbM7VQXytpyUPKbg9a8fVh5LPFH24D5VHgGqUVkhvYM3bP+uW1OCV1Phi+FCTWeAcY
	ZHDMeB3PNGL+g+n+U7FY5X2cQuwQU2F/pgR8igtNRECqEbEiyg7jJcmURSXORhB0P23ZUA
	0DbjK8t0f0EQ4XDDqQxtfsm6uJKoNINsMuStQCEQGgdAV1MZ3CRgabHQxCIxfZMRrdOcan
	niFq42mBOLAKVk8N95qV0kV9Jo/E0buJx1e3QuCjROZ03vhvp0rvpBBLwYU/YCuRywLhY6
	1aYpFKpYJt9SAXDG+dwIvXnoA+ARQDykLosobhevPvD9r41srQzHzmPvITn0mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730978788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbi4HyInMekcZe9nIgNL3HzKsUgUxuQBUw/s2YAs954=;
	b=ECBAvf8yKJUQfyEV3ho4B6RRmrHcTaCbQsEMDpZvQIH8Tr1GdFNHOpyMzGrJpfOTEiOSll
	63VuIrHbvWqMpZCA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Cleanup vc_handle_msr()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local>
References: <20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173097878772.32228.7502497242147603547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8bca85cc1eb72e21a3544ab32e546a819d8674ca
Gitweb:        https://git.kernel.org/tip/8bca85cc1eb72e21a3544ab32e546a819d8674ca
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 06 Nov 2024 18:21:58 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 07 Nov 2024 12:10:01 +01:00

x86/sev: Cleanup vc_handle_msr()

Carve out the MSR_SVSM_CAA into a helper with the suggestion that
upcoming future users should do the same. Rename that silly exit_info_1
into what it actually means in this function - whether the MSR access is
a read or a write.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Link: https://lore.kernel.org/r/20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local
---
 arch/x86/coco/sev/core.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 97f445f..c5b0148 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1406,35 +1406,39 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	return 0;
 }
 
+/* Writes to the SVSM CAA MSR are ignored */
+static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
+{
+	if (write)
+		return ES_OK;
+
+	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
+	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+
+	return ES_OK;
+}
+
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	enum es_result ret;
-	u64 exit_info_1;
+	bool write;
 
 	/* Is it a WRMSR? */
-	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
-
-	if (regs->cx == MSR_SVSM_CAA) {
-		/* Writes to the SVSM CAA msr are ignored */
-		if (exit_info_1)
-			return ES_OK;
-
-		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
-		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+	write = ctxt->insn.opcode.bytes[1] == 0x30;
 
-		return ES_OK;
-	}
+	if (regs->cx == MSR_SVSM_CAA)
+		return __vc_handle_msr_caa(regs, write);
 
 	ghcb_set_rcx(ghcb, regs->cx);
-	if (exit_info_1) {
+	if (write) {
 		ghcb_set_rax(ghcb, regs->ax);
 		ghcb_set_rdx(ghcb, regs->dx);
 	}
 
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, write, 0);
 
-	if ((ret == ES_OK) && (!exit_info_1)) {
+	if ((ret == ES_OK) && !write) {
 		regs->ax = ghcb->save.rax;
 		regs->dx = ghcb->save.rdx;
 	}

