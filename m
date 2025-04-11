Return-Path: <linux-tip-commits+bounces-4883-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202BDA85913
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD514A2A25
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F6272F8B;
	Fri, 11 Apr 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCLTyebp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="186mQ6iH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47B25DEAF;
	Fri, 11 Apr 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365744; cv=none; b=IVU6uSYZDHj2m5SqigEZeMgPYviMUuZBpCiT/jRNmbBXZ5Sj8fPwb02qU3R5k5qe44B4DXIfOr+zYlnkBMmJqaVpjhIp1HmZcSbPuQ9QYiRypSuyIohZ+brHCkeZyF8IsnFlwIwhTwRdggdMQ7Zs1AS8wYt9MNTlCEcyZhC3eDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365744; c=relaxed/simple;
	bh=EAoez38zZG0R7Y+KYDRZ3blFrLv2Qr5jP9bcxT3t/TU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tJUuQADMdKZy+3V4yavTdqj443jfnBH8T03A9etbjVLkl8nfymINPewRKJrjR0E3YA+XKJDEO07aSqnuGB9uJa4DM6EP28AUPtvB9Uc/atvCKi0ZJDoEWYXIdfuZq6i/n/PBqQtrg2PWhClCNpQEkxyt9IrSBN+PGb6c2x093Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCLTyebp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=186mQ6iH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365740;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXcb8o4sH0qgiFdqrKLimWhVRXMSHUH3Uj+IUh1hbgE=;
	b=CCLTyebpfEe7etN/Ewy4F0PweGWJgaP/ixR5Le3vnC8NZlfolkiLN13i7BUZMpYBsrBUk6
	LoZ5qc585FTl2H9hZhnxSLDEooAXdHyE43zcH8oYe3tYIxIDvwxFHOfwFP08IEZBd5JxCf
	McD9qi+vIeO9mlmm1WRp2nRGHBpq7MBW3aQY8dOGqZi5NfSLNHcLRohEmWd8yyodFSlPZ1
	dRDeyFZI05Gcf1WjN4r17eKHLYd+aLbUU4oOFm1Uewr+KDRishN7cMO/jnygAfGRyEuvnT
	//d4Lv2MTvJ0/nSsvyBijIWbBYCzrwbTeyaPFZxr/cKrfMok8AozWkpacnJR1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365740;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXcb8o4sH0qgiFdqrKLimWhVRXMSHUH3Uj+IUh1hbgE=;
	b=186mQ6iHa5Ole8x6OALjoVhBy7mPIOZS3FTm4Cj20vmgCuH+4/2uEst5eDpOf4n2lzuNWK
	/TZJpgb+Qm7oPiBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'bp_refs' to
 'text_poke_array_refs'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-5-mingo@kernel.org>
References: <20250411054105.2341982-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436574009.31282.3755797281598835924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     28fb79092d9f7db3397e886d637d3006551693b3
Gitweb:        https://git.kernel.org/tip/28fb79092d9f7db3397e886d637d3006551693b3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'bp_refs' to 'text_poke_array_refs'

Make it clear that these reference counts lock access
to text_poke_array.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-5-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8edf7d3..9bd71c0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2476,14 +2476,14 @@ struct text_poke_int3_vec {
 	int nr_entries;
 };
 
-static DEFINE_PER_CPU(atomic_t, bp_refs);
+static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
 
 static struct text_poke_int3_vec bp_desc;
 
 static __always_inline
 struct text_poke_int3_vec *try_get_desc(void)
 {
-	atomic_t *refs = this_cpu_ptr(&bp_refs);
+	atomic_t *refs = this_cpu_ptr(&text_poke_array_refs);
 
 	if (!raw_atomic_inc_not_zero(refs))
 		return NULL;
@@ -2493,7 +2493,7 @@ struct text_poke_int3_vec *try_get_desc(void)
 
 static __always_inline void put_desc(void)
 {
-	atomic_t *refs = this_cpu_ptr(&bp_refs);
+	atomic_t *refs = this_cpu_ptr(&text_poke_array_refs);
 
 	smp_mb__before_atomic();
 	raw_atomic_dec(refs);
@@ -2529,9 +2529,9 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_desc with non-zero refcount:
 	 *
-	 *	bp_refs = 1		INT3
+	 *	text_poke_array_refs = 1		INT3
 	 *	WMB			RMB
-	 *	write INT3		if (bp_refs != 0)
+	 *	write INT3		if (text_poke_array_refs != 0)
 	 */
 	smp_rmb();
 
@@ -2638,7 +2638,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * ensure reading a non-zero refcount provides up to date bp_desc data.
 	 */
 	for_each_possible_cpu(i)
-		atomic_set_release(per_cpu_ptr(&bp_refs, i), 1);
+		atomic_set_release(per_cpu_ptr(&text_poke_array_refs, i), 1);
 
 	/*
 	 * Function tracing can enable thousands of places that need to be
@@ -2760,7 +2760,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * unused.
 	 */
 	for_each_possible_cpu(i) {
-		atomic_t *refs = per_cpu_ptr(&bp_refs, i);
+		atomic_t *refs = per_cpu_ptr(&text_poke_array_refs, i);
 
 		if (unlikely(!atomic_dec_and_test(refs)))
 			atomic_cond_read_acquire(refs, !VAL);

