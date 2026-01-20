Return-Path: <linux-tip-commits+bounces-8077-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D87D3C5E4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jan 2026 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D775D5C0988
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jan 2026 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433443F0764;
	Tue, 20 Jan 2026 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VOf0nO/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgSSS/Xt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015F3F0762;
	Tue, 20 Jan 2026 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905073; cv=none; b=TZpQjsM0uWUcHh3wLhdJxT/4vVuPs3B3vfTp4E2GU76hwkhSj20COomlYAnaxIqXxwC2Rv4LrvtsIpJ+wvnfj4gBkHn/6GcwA5ocTbLTZbFzO2v5AmV4NiwC9Cnjk/nkDlFWe4QUkeRH5+U3yjzofDI773qEN0wVhMua7vVnLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905073; c=relaxed/simple;
	bh=GIloCwuIaYbUpUOFF9v+nfXRvbvk4DE9FI/z5QqAlTI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OE8nqmcsugIN6Usq+JMJ6OCNGVisOZEAjO3zwlCUu5It+/XS0m6pvDh/ZuCE9dkH2P3CsFl3gmaGMBxH870x/35ZUxgRJI17M8pQGSfgHwNZawkSnR03vBC91Bf1Ab82rFMMAecNXaBcbcsM+AbLeG73KnRxXR0zMVymYwW1KvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VOf0nO/8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgSSS/Xt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 10:31:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768905063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Esb2YsmLnUswFJezaI5ZanOqBMIqwQLwVoSV9a1SAE=;
	b=VOf0nO/8tqI/zarvkbuPPpeROfLyr/iGrNDpSH0waE2KAKogFKxh1E/wEZa/Zi6+EOnj4w
	iGV+ZU9HbrwFJWkIee7PVS+IPcn6l+VuIL8HRgereQ5bREUo7dcAPBo2Zv1JikXQtSIMvT
	wSUtOo4jJAJv4reCaJyXPKxjQ/EdidKtDohPvsGBnrxN/k610gpRDZ+JsAzu03uxaWJCNA
	cIFkPxGHPN15yCj4/R6ybWwKYyf2ywGxVOYJeU3gPE7ZPdPXfLxjXxspL15Zo3vlS8vRMn
	jKIn0wLlbux67SyzULLoxUQHBpqwMJbUXPd6Zef3350JLbhwLtHJIrIRVscLtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768905063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Esb2YsmLnUswFJezaI5ZanOqBMIqwQLwVoSV9a1SAE=;
	b=VgSSS/Xtjm2TgVt3TRJQMxVH0q5YKxyEi3gTulCstEwux6ek5kmkslbuUFimwmplQgAKta
	lE0AkgbFABDQTqBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Rename sev_es_ghcb_handle_msr() to __vc_handle_msr()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260119141310.29605-1-bp@kernel.org>
References: <20260119141310.29605-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176890506252.510.5051396859113147145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     9183c97e7e22591cfd258b5131493d5afcab4b08
Gitweb:        https://git.kernel.org/tip/9183c97e7e22591cfd258b5131493d5afca=
b4b08
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 19 Jan 2026 14:49:13 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 19 Jan 2026 15:23:48 +01:00

x86/sev: Rename sev_es_ghcb_handle_msr() to __vc_handle_msr()

Forgot to do that during the Secure AVIC review. :-\

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://patch.msgid.link/20260119141310.29605-1-bp@kernel.org
---
 arch/x86/coco/sev/core.c      | 4 ++--
 arch/x86/coco/sev/internal.h  | 2 +-
 arch/x86/coco/sev/vc-handle.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 379e0c0..a059e00 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -989,7 +989,7 @@ u64 savic_ghcb_msr_read(u32 reg)
 	ghcb =3D __sev_get_ghcb(&state);
 	vc_ghcb_invalidate(ghcb);
=20
-	res =3D sev_es_ghcb_handle_msr(ghcb, &ctxt, false);
+	res =3D __vc_handle_msr(ghcb, &ctxt, false);
 	if (res !=3D ES_OK) {
 		pr_err("Secure AVIC MSR (0x%llx) read returned error (%d)\n", msr, res);
 		/* MSR read failures are treated as fatal errors */
@@ -1019,7 +1019,7 @@ void savic_ghcb_msr_write(u32 reg, u64 value)
 	ghcb =3D __sev_get_ghcb(&state);
 	vc_ghcb_invalidate(ghcb);
=20
-	res =3D sev_es_ghcb_handle_msr(ghcb, &ctxt, true);
+	res =3D __vc_handle_msr(ghcb, &ctxt, true);
 	if (res !=3D ES_OK) {
 		pr_err("Secure AVIC MSR (0x%llx) write returned error (%d)\n", msr, res);
 		/* MSR writes should never fail. Any failure is fatal error for SNP guest =
*/
diff --git a/arch/x86/coco/sev/internal.h b/arch/x86/coco/sev/internal.h
index 039326b..b1d0c66 100644
--- a/arch/x86/coco/sev/internal.h
+++ b/arch/x86/coco/sev/internal.h
@@ -85,7 +85,7 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
 }
=20
-enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *=
ctxt, bool write);
+enum es_result __vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt, b=
ool write);
=20
 u64 get_hv_features(void);
=20
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index 43f264a..d98b5c0 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -404,7 +404,7 @@ static enum es_result __vc_handle_secure_tsc_msrs(struct =
es_em_ctxt *ctxt, bool=20
 	return ES_OK;
 }
=20
-enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *=
ctxt, bool write)
+enum es_result __vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt, b=
ool write)
 {
 	struct pt_regs *regs =3D ctxt->regs;
 	enum es_result ret;
@@ -448,7 +448,7 @@ enum es_result sev_es_ghcb_handle_msr(struct ghcb *ghcb, =
struct es_em_ctxt *ctxt
=20
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ct=
xt)
 {
-	return sev_es_ghcb_handle_msr(ghcb, ctxt, ctxt->insn.opcode.bytes[1] =3D=3D=
 0x30);
+	return __vc_handle_msr(ghcb, ctxt, ctxt->insn.opcode.bytes[1] =3D=3D 0x30);
 }
=20
 static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)

