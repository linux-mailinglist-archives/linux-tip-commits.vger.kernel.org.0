Return-Path: <linux-tip-commits+bounces-4863-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F8FA858F2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAA81895BFA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53762D4B43;
	Fri, 11 Apr 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zMyr5ccf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BtIHEHpS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B52D3A66;
	Fri, 11 Apr 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365727; cv=none; b=MfWxlMxMUpKi5AW95p003dORuhjbSvmqdHKoKKaJmIKasMhXWcdWZiwPyh6tcZnGzNeuUbpJCOZkJoZIaJTMSmJFsbTGeiOleaCA0pKWzBYTkCrfBQ8jIV8qWupu+g8Q0ov8oEewV/dHBUC+atdANn72+PdoZ8nfr+8vs/On+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365727; c=relaxed/simple;
	bh=fNnfkcEA7iMO93xLAlTmZk2kFJa0f/eR2vsz5Nhpfgs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ItZ49+PlUL50RanXTNeD99/+pxdmX/BGFvxpvTYNzfacJajjWOVWc0Adm+tYeZ45T9J4nxuJskQ1oZQSUnu0Dot17Q2iG/EOlz4k7uPrVDF4QZwy43ZHQWFkbuvuWuqdagiVJ2GWNncJOKADaWeGjkzvjt2D4jF4jiLtoaAnuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zMyr5ccf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BtIHEHpS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qQ25lKZaS0nE1+DhNIjbkt6aLe1Ozz17IhtJ1lK5Ec=;
	b=zMyr5ccfoSUO6lzl9lTvV/2HATmqdJTftmw5ZZ37R1fYCkS8CX7WeKyuwv7frYmW4gSSAQ
	1YTakq0zP8bt+tnCyZtQjI3s4OtHZI5Rjz1qMVq9BJKrMyGEqMWejwOyj7/Uk8NajPFaqg
	AltOUg9V489Bu74dveK7RB93vf0ptBWfl2u2c6XUmNfmsagWElBQua+s5IzLUnuxYRKZ+V
	lN2rvtNC0N4jgXDuSOdW3XG1yWJpmW7OFsqzs5RE+wJec0MSNX0FDTnvHjnBBy00FM5Jos
	pESbEBRdPkasB/DsMg4y9mszEYv+ssLMFCm6TLCaiaLw4cuBDM7VffgXTNn/bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qQ25lKZaS0nE1+DhNIjbkt6aLe1Ozz17IhtJ1lK5Ec=;
	b=BtIHEHpSSK3aVF2DJAU0gPUe9MdRFPO46z/3m2Fyykl1u57OmJCfAaZuhzrkXriYtYMZhG
	Fp7jGI8Mgp+Ny3BQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Assert that
 smp_text_poke_int3_handler() can only ever handle 'tp_vec[]' based requests
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-26-mingo@kernel.org>
References: <20250411054105.2341982-26-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572309.31282.5104158311441856867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     476ad071c678d70623cdb14fadd21818f64cc45b
Gitweb:        https://git.kernel.org/tip/476ad071c678d70623cdb14fadd21818f64cc45b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Assert that smp_text_poke_int3_handler() can only ever handle 'tp_vec[]' based requests

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-26-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b4cb867..329f6ee 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2510,6 +2510,10 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 	return 0;
 }
 
+#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
+static struct smp_text_poke_loc tp_vec[TP_VEC_MAX];
+static int tp_vec_nr;
+
 noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_int3_vec *desc;
@@ -2534,6 +2538,8 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	if (!desc)
 		return 0;
 
+	WARN_ON_ONCE(desc->vec != tp_vec);
+
 	/*
 	 * Discount the INT3. See smp_text_poke_batch_process().
 	 */
@@ -2592,10 +2598,6 @@ out_put:
 	return ret;
 }
 
-#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
-static struct smp_text_poke_loc tp_vec[TP_VEC_MAX];
-static int tp_vec_nr;
-
 /**
  * smp_text_poke_batch_process() -- update instructions on live kernel on SMP
  * @tp:			vector of instructions to patch

