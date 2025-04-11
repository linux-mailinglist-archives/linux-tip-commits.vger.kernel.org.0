Return-Path: <linux-tip-commits+bounces-4850-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A42DA858C4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B497B06C5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3B62BE7BF;
	Fri, 11 Apr 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBseLV7e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="irP3dDtI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1552BD5B3;
	Fri, 11 Apr 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365715; cv=none; b=g8Ao14pwbgNZTk1BVicRzSM4YQHhRVogNC9tQkdju38gdDItJwJAoIv0FmUvcFlPMDS7DdLvRL6k6dQixOA4SZM+yjUISq01LUlXh6NK44LiFob8MylY0l0k9gnyuJM1GuVwOgxIZVJH58XTWrcyRDjVbcdbh+hJxXq/WR9WN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365715; c=relaxed/simple;
	bh=yLMOlTSoQA4CgV3c8sURJmZi5VNuRQGVDaaQ3Qbeu+g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mCaZxBkGSP/Vo2F+lZERPVervFKIPes6hUAiQpi1LVgzH6NzXPtijMxn+vQ2uAhX2Uv0vc1Rx4hSvTkGH0YaIMNg5MvhHOiPR4Y67CDcY8DOaTK+yOIaIBVLe+IoYIqz5AXyPYOKxSoMRy20x61IhPCOnnycyjyKClsJJViKrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OBseLV7e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=irP3dDtI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okwoo7jasjDrHu0wt10vwxxwmGP+unLWY29pPALunFI=;
	b=OBseLV7eMUGIWH7qJW1zIXnpgjFHlyJJZHkrwP9Ik2ilmUprIZmdfsP+kJSq2d0q0XizkZ
	JhLJeZH+nj+i0nY8R+XiHWidNplWElr0cR9hIf+Q4cpMXnkwTCCd8I7fSC/LQoQvduubl1
	bQ2TOB6b1Ii/ygSgqWi4X0469jVOvqSTveFVJzOqS/f59JvyCCDyS7gek5ER0XBjurwlEc
	PHttQKRs8CRUR2FcwJucGXt50UpI0H2JcFlbWQkF+P0LB4DhdFi9yweO8Lm5HIcROrUCD0
	vhtitklnu1SPRaFGCATZtagkcPSPBMxCEvsto8NlhaN4aj/4woDjzPG9ILklFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okwoo7jasjDrHu0wt10vwxxwmGP+unLWY29pPALunFI=;
	b=irP3dDtIhSWr06P+G1HWkVME3EmjX5GaIoCu/P3/zZN/rdYLyOcWUZDuiTqFMkKYfXcWSD
	3qejwoktDx7ubkCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Move text_poke_array
 completion from smp_text_poke_batch_finish() and smp_text_poke_batch_flush()
 to smp_text_poke_batch_process()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-40-mingo@kernel.org>
References: <20250411054105.2341982-40-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571089.31282.13083237359357215357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     7fbadb50d95a8bbc0de720e0857c77d4f13ddcaf
Gitweb:        https://git.kernel.org/tip/7fbadb50d95a8bbc0de720e0857c77d4f13ddcaf
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Move text_poke_array completion from smp_text_poke_batch_finish() and smp_text_poke_batch_flush() to smp_text_poke_batch_process()

Simplifies the code and improves code generation a bit:

   text	   data	    bss	    dec	    hex	filename
  14769	   1017	   4112	  19898	   4dba	alternative.o.before
  14742	   1017	   4112	  19871	   4d9f	alternative.o.after

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-40-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b47ad08..556a82f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2750,6 +2750,9 @@ static void smp_text_poke_batch_process(void)
 		if (unlikely(!atomic_dec_and_test(refs)))
 			atomic_cond_read_acquire(refs, !VAL);
 	}
+
+	/* They are all completed: */
+	text_poke_array.nr_entries = 0;
 }
 
 static void __smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
@@ -2857,20 +2860,16 @@ static bool text_poke_addr_ordered(void *addr)
 
 void smp_text_poke_batch_finish(void)
 {
-	if (text_poke_array.nr_entries) {
+	if (text_poke_array.nr_entries)
 		smp_text_poke_batch_process();
-		text_poke_array.nr_entries = 0;
-	}
 }
 
 static void smp_text_poke_batch_flush(void *addr)
 {
 	lockdep_assert_held(&text_mutex);
 
-	if (text_poke_array.nr_entries == TP_ARRAY_NR_ENTRIES_MAX || !text_poke_addr_ordered(addr)) {
+	if (text_poke_array.nr_entries == TP_ARRAY_NR_ENTRIES_MAX || !text_poke_addr_ordered(addr))
 		smp_text_poke_batch_process();
-		text_poke_array.nr_entries = 0;
-	}
 }
 
 /**

