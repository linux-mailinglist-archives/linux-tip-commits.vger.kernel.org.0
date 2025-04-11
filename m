Return-Path: <linux-tip-commits+bounces-4839-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD2EA858B6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8253B44FE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8B29B218;
	Fri, 11 Apr 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wY8FGbAi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVchnHS8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CD29AAF8;
	Fri, 11 Apr 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365703; cv=none; b=JsjHFd7Qf0ffArHmnDGHQplsUGeZXjvMnSojMvfQGrkS7npYLHJCvu5jQ0eF9koXnlPSSF8D7JJhK0C4+JBfVIEQT0BEyCFYi4HMfK2mDoZM5/SNXFfTrzcYi+fkR26q3HUx4YxOmpSZJbdZFEazoMH01PZgW9HKY4ptOpCwLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365703; c=relaxed/simple;
	bh=zdE+1FMycnNNXP9+Q8eOdiLlfxQWUDvY7P0Hyj94e2s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BaQY42IdZRupDxEYI7EEWhOAqa1AtSZqCI8nFeglndzbSRzugUjKmPtaU7Ct03UelXWH13aOgD6XouWzbIgJPCU1w/+7QRgGuHLX+p3ynOY1CNB21sUNBg7u+R62KSS/Os+AIt9Rsbbs14a4njytnylkpWBaxSTxzswUhg4IdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wY8FGbAi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVchnHS8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MEr+6elri4MPmVZ3uxxEhR2vufhK3qxNFvw+om5aS0=;
	b=wY8FGbAih0HQjRLhsBJ/9aP2NwypRLFLfXrdtbF/DUs6+SNrAopQ/G3Ndepkp8pP8LMxuZ
	ItfhCMy3d0IhOXGHvjOf/lPzDj1oduS7ibM0qZF4BAWNtbHQcOpgrvMEkU5nclxwEvThid
	8bQHF04lG41+yoDT+DrfoZ5SHahTKyuwON+gc4daww+vOtx7qpkc7JxCqltYmLlV0Ck+t8
	XQhMl7Z3jQWmY6X+auwu36xKP2GhFVBQf7Ylk3K3t0KeOuDAqiEWwB87UdBxiUSxZfL042
	9KwerSY+sumU4/uQm2m78QuDk+I50V90/VnCGUl0pSyVBKxS6eFlOUccAvL2qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MEr+6elri4MPmVZ3uxxEhR2vufhK3qxNFvw+om5aS0=;
	b=zVchnHS8hExxxFG2cFy2hsku33pXhepPmW2y/g0SMjAE3FsFdGquHOWCHGUdOuVEfpC7Bj
	KHHSsVQTSnI8v3Dw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Update the comments in
 smp_text_poke_batch_process()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-51-mingo@kernel.org>
References: <20250411054105.2341982-51-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436569950.31282.8103696921214555081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     dac0d7542782bae98a4d8cedde3028a07f1915d2
Gitweb:        https://git.kernel.org/tip/dac0d7542782bae98a4d8cedde3028a07f1915d2
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:41:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Update the comments in smp_text_poke_batch_process()

 - Capitalize 'INT3' consistently,

 - make it clear that 'sync cores' means an SMP sync to all CPUs,

 - fix typos and spelling.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-51-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c0be066..9ee6f87 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2561,24 +2561,26 @@ out_put:
 
 /**
  * smp_text_poke_batch_process() -- update instructions on live kernel on SMP
- * @text_poke_array.vec:		vector of instructions to patch
- * @text_poke_array.nr_entries:	number of entries in the vector
  *
- * Modify multi-byte instruction by using int3 breakpoint on SMP.
- * We completely avoid stop_machine() here, and achieve the
- * synchronization using int3 breakpoint.
+ * Input state:
+ *  text_poke_array.vec: vector of instructions to patch
+ *  text_poke_array.nr_entries: number of entries in the vector
+ *
+ * Modify multi-byte instructions by using INT3 breakpoints on SMP.
+ * We completely avoid using stop_machine() here, and achieve the
+ * synchronization using INT3 breakpoints and SMP cross-calls.
  *
  * The way it is done:
  *	- For each entry in the vector:
- *		- add a int3 trap to the address that will be patched
- *	- sync cores
+ *		- add an INT3 trap to the address that will be patched
+ *	- SMP sync all CPUs
  *	- For each entry in the vector:
  *		- update all but the first byte of the patched range
- *	- sync cores
+ *	- SMP sync all CPUs
  *	- For each entry in the vector:
- *		- replace the first byte (int3) by the first byte of
+ *		- replace the first byte (INT3) by the first byte of the
  *		  replacing opcode
- *	- sync cores
+ *	- SMP sync all CPUs
  */
 static void smp_text_poke_batch_process(void)
 {
@@ -2606,13 +2608,13 @@ static void smp_text_poke_batch_process(void)
 	cond_resched();
 
 	/*
-	 * Corresponding read barrier in int3 notifier for making sure the
+	 * Corresponding read barrier in INT3 notifier for making sure the
 	 * text_poke_array.nr_entries and handler are correctly ordered wrt. patching.
 	 */
 	smp_wmb();
 
 	/*
-	 * First step: add a int3 trap to the address that will be patched.
+	 * First step: add a INT3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < text_poke_array.nr_entries; i++) {
 		text_poke_array.vec[i].old = *(u8 *)text_poke_addr(&text_poke_array.vec[i]);
@@ -2685,7 +2687,7 @@ static void smp_text_poke_batch_process(void)
 	}
 
 	/*
-	 * Third step: replace the first byte (int3) by the first byte of
+	 * Third step: replace the first byte (INT3) by the first byte of the
 	 * replacing opcode.
 	 */
 	for (do_sync = 0, i = 0; i < text_poke_array.nr_entries; i++) {

