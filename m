Return-Path: <linux-tip-commits+bounces-4857-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CC9A858E1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CFB189957B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E02C376A;
	Fri, 11 Apr 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GDHK3C+X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GRfigaL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99022C3741;
	Fri, 11 Apr 2025 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365721; cv=none; b=m24T3IytD8NFka/UW+PCTgBbyzreYtgSK8ejATm1OM25fmOrELFkougChmJN3EZD2vAhJCehIkoBbvHOLjK0k/odgfyRF76HZMDPt8Z4fVf93HBWGzwivLP7HtoQn/j2dGe6F+nKCYspjjo0BFsHsFxO3LQ8SRhlBGQKwsVTBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365721; c=relaxed/simple;
	bh=9zlisABf3xKpB4pubXQJ/81a/QrmC4XQmjxyeBLSALk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uh9MFBhUPvegIE//tA+J9bxLbK4hVYpiNycYQUpWcAjgQG42bF8MrzlgcXKLDHBUVjYhS+LNOlK98LsQVWqJfDoX7d+HmFoNl2SwXiNc0rEjHtbKPvrRT9gErx6fDYxgHpNLsDZmqgJDOzMKnJFi363xLhSapLCKbwS+PFXyEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GDHK3C+X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GRfigaL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365718;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xa3NT1JOYEoj3U8aBsF4JKo2iQqHUARB/Os7j1akUmY=;
	b=GDHK3C+XGxuapuAurvg+BalH+z2Q/cPvO53OLhN3Y8OZiMwflE+u8BFslSKRWqWaVZ1WZ7
	swErIE0bQq4/Kj2XEpceeEZu+hTjHrmq14exUUV9dN8pDRv6rakiAWIhZ3Eur16c3Y3yap
	4TCE6ZvXL6WfVZZhnZnkpHcvbrifC9ITPpj305OeCod0vz4p+Gfvs5dzHrjYN0XRUp9jVG
	ousLzFX8Btxq0/IXz6oxgkoMd255Z7ObfPWrALATALuczWVCMMdd7dj/cOz14nSCT+kxfp
	Yzp6HJ/YC/YJyURhBLIgpfE1svrGh1kla2ovlDxNI2SHUuIvrfUWahh0r/DDng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365718;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xa3NT1JOYEoj3U8aBsF4JKo2iQqHUARB/Os7j1akUmY=;
	b=1GRfigaLSVJodf83t85cXv1PLNdowajDxab3ad+fe8fPWOQQpBs30B7OyBljFyLTOpnwT+
	pJfbsSr0SJ8roZDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Simplify try_get_text_poke_array()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-32-mingo@kernel.org>
References: <20250411054105.2341982-32-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571713.31282.15659803490337622749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     b6a25841c171c42b02d316a6bf784fb32e39c786
Gitweb:        https://git.kernel.org/tip/b6a25841c171c42b02d316a6bf784fb32e39c786
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Simplify try_get_text_poke_array()

There's no need to return a pointer on success - it's always
the same pointer.

Return a bool instead.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-32-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f909f4e..edc18be 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2475,15 +2475,14 @@ static struct smp_text_poke_array {
 
 static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
 
-static __always_inline
-struct smp_text_poke_array *try_get_text_poke_array(void)
+static __always_inline bool try_get_text_poke_array(void)
 {
 	atomic_t *refs = this_cpu_ptr(&text_poke_array_refs);
 
 	if (!raw_atomic_inc_not_zero(refs))
-		return NULL;
+		return false;
 
-	return &text_poke_array;
+	return true;
 }
 
 static __always_inline void put_text_poke_array(void)
@@ -2530,9 +2529,9 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 	 */
 	smp_rmb();
 
-	desc = try_get_text_poke_array();
-	if (!desc)
+	if (!try_get_text_poke_array())
 		return 0;
+	desc = &text_poke_array;
 
 	WARN_ON_ONCE(desc->vec != text_poke_array.vec);
 

