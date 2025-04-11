Return-Path: <linux-tip-commits+bounces-4846-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34EA858CD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B459A2CA8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D429DB8C;
	Fri, 11 Apr 2025 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D1plfjaZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b7HF3JMM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998529CB36;
	Fri, 11 Apr 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365710; cv=none; b=GscLJvfNE2gWfPthroaOmS2ynkxlTtvb+GNEALE1uwyUa5TSbVEcpSjxQqhT0tL6KAIIe27olRmYMH2+cFDOwYB1RI0zlsthxLti6zL8WLUiqKJJjFG5rCRUO5YoKzZUhlJkwFLRPmSPEMhg3iqzKKX+pKd8MNuVIbvQI7HM6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365710; c=relaxed/simple;
	bh=nllYZBrTXodZWRzDOFb2QRGZwFmX/iebI7NbOtoIdZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bycrMJOyZ74AkGHFxDj7wfbJlMbsRCE5diOOs0ff1FmfA90YZTtArgwaknGETrD4+ztaLPxeyqyD2Tce8UVtNKXIsJARmI4wjEScSueSC77k/QpcW98oSD3/lGK+dqlaEx8k0GUBa5ly0289k3zYI/BIROdBcOaSGRQHetqncak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D1plfjaZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b7HF3JMM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9C4H87RYRr0XBIB3osHeuQWuFd01yqua5Js59xFV9O0=;
	b=D1plfjaZQtqXxsREilNsmWgSgSOR/XWSvhhCXExmkotcy+9BFuCTMZEILDZx7jfyDi0+mn
	UV4INNsDZ5qiTyx7Wh436jQ3Eg3wZ//vnjc1jLUDXcNIzpnFlVX+K7/Gkqhp5buJ/dLigP
	/SdO/MFsJcxAarALZAQD4vCV2m7RhFHkObmYMnFSJgKMNC0SvTcjC7jYvVNbRBbQMdrDwP
	gHf/6ppSLMLA0sGowYgoGJWVQuVALYm6mpQqA3qjDR8cWyr25PfDJQKKv0iR7ETPkJJymT
	840T0TAaVl8dCO3XMK4K8yzSVg+6nYa+15pp/IsoZHFWTe5m10ZENydVIPc+kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9C4H87RYRr0XBIB3osHeuQWuFd01yqua5Js59xFV9O0=;
	b=b7HF3JMM32qvTrRGYfDfWfaM374ZxoRleuttanAex6jH6uKrTLcGUOPW09dIIvckufAGbn
	EpJiqZjpWeFGfaBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Simplify and clean up patch_cmp()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-44-mingo@kernel.org>
References: <20250411054105.2341982-44-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436570648.31282.5757687380254711234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     3e6f47573ec3ed1d9dc50243fbcf50c87f740853
Gitweb:        https://git.kernel.org/tip/3e6f47573ec3ed1d9dc50243fbcf50c87f740853
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Simplify and clean up patch_cmp()

- No need to cast over to 'struct smp_text_poke_loc *', void * is just fine
  for a binary search,

- Use the canonical (a, b) input parameter nomenclature of cmp_func_t
  functions and rename the input parameters from (tp, elt) to
  (tpl_a, tpl_b).

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-44-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 14ca17d..f278655 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2498,13 +2498,11 @@ static __always_inline void *text_poke_addr(const struct smp_text_poke_loc *tp)
 	return _stext + tp->rel_addr;
 }
 
-static __always_inline int patch_cmp(const void *key, const void *elt)
+static __always_inline int patch_cmp(const void *tpl_a, const void *tpl_b)
 {
-	struct smp_text_poke_loc *tp = (struct smp_text_poke_loc *) elt;
-
-	if (key < text_poke_addr(tp))
+	if (tpl_a < text_poke_addr(tpl_b))
 		return -1;
-	if (key > text_poke_addr(tp))
+	if (tpl_a > text_poke_addr(tpl_b))
 		return 1;
 	return 0;
 }

