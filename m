Return-Path: <linux-tip-commits+bounces-4853-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A0EA858E5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953A99A7D34
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325722BEC57;
	Fri, 11 Apr 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lrQjhV1I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1yHrz77J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121B2BE7DD;
	Fri, 11 Apr 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365718; cv=none; b=eUNioIwLj7BIhr1GM8NILcLY9mK3GMkDsV5vE636pznrrwgVe9sM1NvV3MJizGIzS20fD2dtg2cCmU0ypyQZN8oNoTK71PfsL9o5jxy6We84t+oi06r7P4dfGO/qckDCRW/1BKZXd/RQFIvnD2fIaWuTBAEsJXi02dyEmkIJ3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365718; c=relaxed/simple;
	bh=DoLSbsFJBtDAxvWU29A+9c1ubRRf+7djn3x3MuKj5Ts=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cKKh9QvMMRPrvowyA9DgYui7lwDsFNYPNvw0R04yak85RiM6NbnRrPt3yK2of8FDtv3dy6KDTutC/pfPBA5RCj+lWZzR0VoIg448ZVc/0cYYEDyM6X4wvYhH4RyMsDLD1C1up4Q/isXkeOyOlSgEkLg1feaqvxwR1WMm8cvu3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lrQjhV1I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1yHrz77J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p76Y2rkAsEsuRwYB1KAR6Dkzg4a+z4ybIU3uXmFc0Do=;
	b=lrQjhV1I4kDZYYSckjurT6iRnkuf8KD1zuwbDP+mFrttmKnOPsCamMFNKH8NhRs/DLiAUI
	N/rl4b1NNsgN+gEDtkxPk2d2s9z1KmrlbrupIvrHu7H5v+bTFTR0RJCk4wD0P7T5pUSTko
	IfSmjsWaZ3xlfJW8BQGyEGMa22/jeEPN3dGmVjBANzVl5WBwkFV8zpsC3R/HE2QHLNOhco
	CcRKuhy3s7CHwTiydwNnh6VXa1DvjEdtFatM3eW8Ep+yJ3jeOOy84OEOORyLyeDJ9Pp0BK
	cL8y4vZoVlIgn7hDwyDLYSOCNVDSJNVlyTCbCjM1gtfXnzm0VkcfraK76ZIaRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p76Y2rkAsEsuRwYB1KAR6Dkzg4a+z4ybIU3uXmFc0Do=;
	b=1yHrz77JkfFiKkNTx5lFoD+xiJCkcvvQ4951oCgQrrbXCSRMlpAfsUFB14QC1bc84RMLSs
	IvSfLNuJQG5iAtAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Remove the mixed-patching
 restriction on smp_text_poke_single()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-37-mingo@kernel.org>
References: <20250411054105.2341982-37-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571304.31282.1653651524515280605.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     8a6a1b4e0ef15dab908a365588e06f23f9c0bad5
Gitweb:        https://git.kernel.org/tip/8a6a1b4e0ef15dab908a365588e06f23f9c0bad5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Remove the mixed-patching restriction on smp_text_poke_single()

At this point smp_text_poke_single(addr, opcode, len, emulate) is equivalent to:

	smp_text_poke_batch_add(addr, opcode, len, emulate);
	smp_text_poke_batch_finish();

So remove the restriction on mixing single-instruction patching
with multi-instruction patching.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-37-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index eb0da27..f0bb215 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2892,9 +2892,6 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
  */
 void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	/* Batch-patching should not be mixed with single-patching: */
-	WARN_ON_ONCE(text_poke_array.nr_entries != 0);
-
 	__smp_text_poke_batch_add(addr, opcode, len, emulate);
 	smp_text_poke_batch_finish();
 }

