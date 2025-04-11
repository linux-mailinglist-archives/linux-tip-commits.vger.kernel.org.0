Return-Path: <linux-tip-commits+bounces-4861-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE217A858EF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4DF1892271
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45D2D3A6D;
	Fri, 11 Apr 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1ECufdW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xrGhHGfX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D62D1F6E;
	Fri, 11 Apr 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365726; cv=none; b=s/DiymTDzcZuw98FmuCbzEvc85gQwKsZadks22Ofd17bEw6eXog2wir3fZ8LxTAVPn5ADUy0JXmlnKcd+WkzZeGpGRt+FOgFLMzzAyaHROzhHaGZC2CVqo/j+1ygEB/LrjGpp7Ll/wkkr67vJs7/Vwnd7kvB/4luqeSbJOlSxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365726; c=relaxed/simple;
	bh=eTqRuJWN7IyOZNBZ0Bayss6jD7IUUPvHivXi8eymkP0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vtrm8M208EmU/4hfNxAvsG3ppAw02ZSG94IuTVy9jb6i6LTmjz1RqtBPXukENnsxcGUdGIAhNLFHcxvflMqZ2BbypumjwFCn6iDrrB1r4HWUJV94Ojl9XWkAy8Rc/+mIDEOfs9EaIymjqHDiIVkUAeJeqiJSLncvOvviY439mmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e1ECufdW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xrGhHGfX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwSQwX8s46U5hcZebl3ve4/nn4Deh369FkM9iHEtC1c=;
	b=e1ECufdWbfsghgbhr4MO/UVCqGoFRn6XhpCQs8Znn4B0+MXBujD2PkBR+rnMtqA1D2Yg7d
	r9DAL4Ucbx3PQY/0kp+Lj2xGkJmebjpLo0kwW3tA6UPdSuIicIsa6eKsY90BL1rIBAe1U+
	iHBEMeqmTOeDgsaGvcBjfc4GuQQhXMUYXz+DnYHwFqby/V8XA9d3K7z0b2GUKApr9sf9rp
	9mEmtd7978qgerTH/s24cHaOeJxlVRLX2rXy3EY3zhHAJ7WOS686r+OTJfx+FHlmMCgkDN
	Jps4mNm2/d8z22IqfTFsSCmbXLlEDc/DV+gaETZqEUiXRU+/Umi8m5HJjzmLPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwSQwX8s46U5hcZebl3ve4/nn4Deh369FkM9iHEtC1c=;
	b=xrGhHGfXDtbTtkhwPEHZeUS05Lf/KC3oEdI9FzX9jOpJE6xmxTXyWUHosRsKU7Lo0uLZxK
	Qik4oNadFbiYuDCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Assert input parameters in
 smp_text_poke_batch_process()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-27-mingo@kernel.org>
References: <20250411054105.2341982-27-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572218.31282.12342424097210847669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     37725b64a9912292841cea7e9aebfd0f084ed8c0
Gitweb:        https://git.kernel.org/tip/37725b64a9912292841cea7e9aebfd0f084ed8c0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Assert input parameters in smp_text_poke_batch_process()

At this point the 'tp' input parameter must always be the
global 'tp_vec' array, and 'nr_entries' must always be equal
to 'tp_vec_nr'.

Assert these conditions - which will allow the removal of
a layer of indirection between these values.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-27-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 329f6ee..4fa26a4 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2627,6 +2627,9 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 
 	lockdep_assert_held(&text_mutex);
 
+	WARN_ON_ONCE(tp != tp_vec);
+	WARN_ON_ONCE(nr_entries != tp_vec_nr);
+
 	int3_vec.vec = tp;
 	int3_vec.nr_entries = nr_entries;
 

