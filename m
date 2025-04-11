Return-Path: <linux-tip-commits+bounces-4876-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C02CA85903
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B273617C650
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03324DC48;
	Fri, 11 Apr 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4J9xCpS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u5F+VT0K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCE238C05;
	Fri, 11 Apr 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365739; cv=none; b=uRulslCmo5us6Aez7f/WWmMBbNFVyzFR6Y6bQ0cLDHACS8ZoV2xFyrnl5Xaxor9Bbvm/PiUqUzZTFeU1tV1Wk2dRAO2mxzNv5v2E1Qg9DdUhbxA6sh1O8nXZfcNXhm74snc/2MXCWYrL7jomA9JJxndAR8Dmy+uXwEucco8gGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365739; c=relaxed/simple;
	bh=DJidsfI4Q7RQ6Zf7xq3lEUiPMuFzCxyupkaBWm/Nybo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qco1UWymZlu0vQZQyKJgreu92Uccb6ZU/X7ROFksEJc/fpVguL4DVZRYGQ7cdAqlFjryBIDpkzc2KK9fKw+Cc8fjUTSKlTTyGB025ve4j5A73N07y0ywOJ8nN/R36vuihtv4yK+nSrkJ7g1DddoOGQ2f0wy/31qkl9kZKko4Dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4J9xCpS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u5F+VT0K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365736;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0jWDP6nk0vr7zIt7Wef1fiUEjrCAvliiQjNrZaVIzI=;
	b=q4J9xCpSLDMSk7vGhjWL0qWa5bq5SKKToF/mgA+mK5uEizK35oCHstPp0QqA5++Vy+beCJ
	oXvrhkhs1uOcd7b0szAZgrRrxzD9SStJKZA5bv8/3zDD4maREJXaHtcMEEhwm8z9MXJauE
	alwqtfSMEXqopo0Tzp9NI1ayvSr5hcwbHJCz964Ay/ZniCTKzaqTDQWQQZVOhP9hVb1RO5
	khA32mPCaFb5dxbjA3dUAqewVb+DwTbVTbp98+jY6WB4ltGp2pLHZwlfamQDzU+LI3HjqF
	nU9JMfixEetSR8Qc2jzWY1Kjky3Edux6POjvNUryiyD8H0xi1Q2ZHrx1xvOR6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365736;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0jWDP6nk0vr7zIt7Wef1fiUEjrCAvliiQjNrZaVIzI=;
	b=u5F+VT0KafTB9Iz1KcGrxlGSLvTZYDNND1U7cEci9VlSfU+TlB2UXx2Hec0l2cYt2OkOBB
	YIhuW+sE4MIYdXAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Rename 'bp_desc' to 'int3_desc'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-11-mingo@kernel.org>
References: <20250411054105.2341982-11-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573563.31282.1791266698572481634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     e84c31b9c9ac75ceaa2597bce021c529e76edd26
Gitweb:        https://git.kernel.org/tip/e84c31b9c9ac75ceaa2597bce021c529e76edd26
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'bp_desc' to 'int3_desc'

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-11-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 62d7444..c6d0ca3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2478,7 +2478,7 @@ struct text_poke_int3_vec {
 
 static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
 
-static struct text_poke_int3_vec bp_desc;
+static struct text_poke_int3_vec int3_desc;
 
 static __always_inline
 struct text_poke_int3_vec *try_get_desc(void)
@@ -2488,7 +2488,7 @@ struct text_poke_int3_vec *try_get_desc(void)
 	if (!raw_atomic_inc_not_zero(refs))
 		return NULL;
 
-	return &bp_desc;
+	return &int3_desc;
 }
 
 static __always_inline void put_desc(void)
@@ -2527,7 +2527,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
-	 * bp_desc with non-zero refcount:
+	 * int3_desc with non-zero refcount:
 	 *
 	 *	text_poke_array_refs = 1		INT3
 	 *	WMB			RMB
@@ -2630,12 +2630,12 @@ static void smp_text_poke_batch_process(struct text_poke_loc *tp, unsigned int n
 
 	lockdep_assert_held(&text_mutex);
 
-	bp_desc.vec = tp;
-	bp_desc.nr_entries = nr_entries;
+	int3_desc.vec = tp;
+	int3_desc.nr_entries = nr_entries;
 
 	/*
 	 * Corresponds to the implicit memory barrier in try_get_desc() to
-	 * ensure reading a non-zero refcount provides up to date bp_desc data.
+	 * ensure reading a non-zero refcount provides up to date int3_desc data.
 	 */
 	for_each_possible_cpu(i)
 		atomic_set_release(per_cpu_ptr(&text_poke_array_refs, i), 1);

