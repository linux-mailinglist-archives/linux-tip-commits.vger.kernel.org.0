Return-Path: <linux-tip-commits+bounces-4868-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435F0A85907
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716383B5690
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E083221275;
	Fri, 11 Apr 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChZjWtnw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P20WzG4i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12DE2E3374;
	Fri, 11 Apr 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365731; cv=none; b=SGHtvqy13IKEHMEUMR9BTqsJFuoiRiqBEVTT7ck0QGJHzJf+JW7vXH25G6ZGrtddWeRZ2wdi7ZAnR8B5WzxHRcaKYLnp3vBRNeUpzh2wMs0gcHMSmxuZV3JhvrZddh5wHthx/HZjCJCohOZTLru/7a2Gutx4Pe8SYkBto5qAooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365731; c=relaxed/simple;
	bh=B00N05TYwcwbZTZKIy20k4/dnHH8XcBWbbamlI0a/bA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=clL0imLd7XJ9tvlCkgsEGJ3VsjL6RqoY5lVy3FD+mXIXLSDgRS3WT7yzYwW9QOOebXa0IHKqCislibu+6LK9VEwGgqFZi2FB1dqT1bQBp1Y/rKUS64cp0p2Yg/uIQRG0Bq6QABT9XTSEsDFH388GLWJLscmzNT/vbCWTWKFSzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChZjWtnw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P20WzG4i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365728;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m/C+yqqRjwaArc8fEnLjTocgh5WI1ZZuk5FCQejvDI=;
	b=ChZjWtnwiLNKeh9JouipweO/tWM2A/FAW6UdqN+RhAMPowkHUf7HkZLY0OzDvrJSbDBuPJ
	wJBsc8ouqNXvAu3a2vDTtr5qMAPNUP9+590tAagmYgsZ+8iwloJwY2eFvmFL4QilTx196F
	Ylwonkng8S1PzgtlMQTR5hJiygbSIU/PH95mPIOY2Qvz2iUyIWU+X3jBA3ljqvTLcu/tCr
	nXZx1Bu6DI6MfVvbvEsO/emteG517UCIHeQ25VuhmBESRxalR/4g3b2BrywrAlvrngaX8h
	qGBWI+7XN/JpiEs+WwHQfalmQrl24jj72iA3SYdjdNz2VfTJKMCRgJg/zWk8iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365728;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m/C+yqqRjwaArc8fEnLjTocgh5WI1ZZuk5FCQejvDI=;
	b=P20WzG4im73Vzy121sU2NjNJMrqCyArRmckCkiNDTukZQuvHWx3yugDV4SRPEUOY0f+2nO
	zX/+IqrdgJhBElAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Rename 'int3_desc' to 'int3_vec'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-21-mingo@kernel.org>
References: <20250411054105.2341982-21-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572743.31282.14483128670941314417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     3bd7546ff24ecf9dbd74adf92b843eebd2862d1c
Gitweb:        https://git.kernel.org/tip/3bd7546ff24ecf9dbd74adf92b843eebd2862d1c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'int3_desc' to 'int3_vec'

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-21-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9abb8f0..b97abfb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2473,7 +2473,7 @@ struct text_poke_int3_vec {
 
 static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
 
-static struct text_poke_int3_vec int3_desc;
+static struct text_poke_int3_vec int3_vec;
 
 static __always_inline
 struct text_poke_int3_vec *try_get_desc(void)
@@ -2483,7 +2483,7 @@ struct text_poke_int3_vec *try_get_desc(void)
 	if (!raw_atomic_inc_not_zero(refs))
 		return NULL;
 
-	return &int3_desc;
+	return &int3_vec;
 }
 
 static __always_inline void put_desc(void)
@@ -2522,7 +2522,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
-	 * int3_desc with non-zero refcount:
+	 * int3_vec with non-zero refcount:
 	 *
 	 *	text_poke_array_refs = 1		INT3
 	 *	WMB			RMB
@@ -2625,12 +2625,12 @@ static void smp_text_poke_batch_process(struct smp_text_poke_loc *tp, unsigned i
 
 	lockdep_assert_held(&text_mutex);
 
-	int3_desc.vec = tp;
-	int3_desc.nr_entries = nr_entries;
+	int3_vec.vec = tp;
+	int3_vec.nr_entries = nr_entries;
 
 	/*
 	 * Corresponds to the implicit memory barrier in try_get_desc() to
-	 * ensure reading a non-zero refcount provides up to date int3_desc data.
+	 * ensure reading a non-zero refcount provides up to date int3_vec data.
 	 */
 	for_each_possible_cpu(i)
 		atomic_set_release(per_cpu_ptr(&text_poke_array_refs, i), 1);

