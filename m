Return-Path: <linux-tip-commits+bounces-4836-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED123A858AB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E623B171F38
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC124298CB8;
	Fri, 11 Apr 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+gCRK9h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ujqQkk3h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83F6AA7;
	Fri, 11 Apr 2025 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365700; cv=none; b=U6pxhQnJAwERCQDp0kUMmeDE4DYbVSFbN+9DgwBLaiUmsUXXHxDwCo1zmVgB6Cvfhu5ddCFhKf4KYOr1lyHw616OIN+CuaeDp30TxL39NFHsik2cXvR60Dwm2qdhX4g/7++ZDAkYMxi+gQuMKf2kNPa7lZsD/yIhN3z+Y/up//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365700; c=relaxed/simple;
	bh=axtsiOYOlshW4kRfzMxLIAgvdN5+7xyrGeTGnmMXano=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H68SwlmwC5fQQGvFp8FUKdyUHNQVQMDcNijek73+lgkZkHw+b4YYXMq4StkIZIPKk6wIgqZFDXwrhIecqEYw0rPYgTnX6zn8iiOyeSK8ZkG+3a/KYjHv37/YAETO14xu5XR7fngmGK7getkMi2fOSDHYCzbHzM8A7bSEKVeI684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+gCRK9h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ujqQkk3h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khNK1+dIeeTXNWpuarhfAV/U1UcHm5LL5kjf268oasw=;
	b=m+gCRK9hhHd4AsoYvBJPD6W+4ViQRFznGgIuLbQJUoXC6A8Wq9+ZYk9AZUeAcDvdpY5f7q
	pSpWh+bzLI43AvW2YasrYDdrz098eyVkph2RL0rPN+Vm44aP9pr90yK5SNxJTQG2KBIZdI
	9Nwpuk0xhMLyhTIzDa4G3ky77kae1gzs6IZz/8oG1aoXYn13En2S461mhdFZgFRzVNeKkv
	xMUnSsBKfiPm7lpI9kkQhADpt+lCQuNW0uNogM6RggqZlPrkMyEb8BZLc0YQO1ADjQeJFV
	Kt977DwcAC+eOEPWmu2SEu25Yz+piKFno3HOFOZ3wFKIVDaY11oLQWWiBxUBHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khNK1+dIeeTXNWpuarhfAV/U1UcHm5LL5kjf268oasw=;
	b=ujqQkk3h51+fHEfhym4WOgzQJwwLfFcAlV1KOmM4FK2Es4pBE/ne3hgVCendaPwexJ0goh
	yMUi0+bTLInUYlCQ==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Make
 smp_text_poke_batch_process() subsume smp_text_poke_batch_finish()
Cc: Nikolay Borisov <nik.borisov@suse.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-54-mingo@kernel.org>
References: <20250411054105.2341982-54-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436569614.31282.8985633286868904334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     23a76739d6afe6f98ccdb2517d7985b4335c7a3a
Gitweb:        https://git.kernel.org/tip/23a76739d6afe6f98ccdb2517d7985b4335c7a3a
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 11 Apr 2025 07:41:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Make smp_text_poke_batch_process() subsume smp_text_poke_batch_finish()

Simplify the alternatives interface some more by moving the
poke_batch_finish check into poke_batch_process and renaming the latter.
The net effect is one less function name to consider when reading the
code.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-54-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 604dd60..f785d23 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2434,7 +2434,7 @@ struct smp_text_poke_loc {
 	u8 len;
 	u8 opcode;
 	const u8 text[TEXT_POKE_MAX_OPCODE_SIZE];
-	/* see smp_text_poke_batch_process() */
+	/* see smp_text_poke_batch_finish() */
 	u8 old;
 };
 
@@ -2507,7 +2507,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
 		return 0;
 
 	/*
-	 * Discount the INT3. See smp_text_poke_batch_process().
+	 * Discount the INT3. See smp_text_poke_batch_finish().
 	 */
 	ip = (void *) regs->ip - INT3_INSN_SIZE;
 
@@ -2565,7 +2565,7 @@ out_put:
 }
 
 /**
- * smp_text_poke_batch_process() -- update instructions on live kernel on SMP
+ * smp_text_poke_batch_finish() -- update instructions on live kernel on SMP
  *
  * Input state:
  *  text_poke_array.vec: vector of instructions to patch
@@ -2587,12 +2587,15 @@ out_put:
  *		  replacing opcode
  *	- SMP sync all CPUs
  */
-static void smp_text_poke_batch_process(void)
+void smp_text_poke_batch_finish(void)
 {
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
 	int do_sync;
 
+	if (!text_poke_array.nr_entries)
+		return;
+
 	lockdep_assert_held(&text_mutex);
 
 	/*
@@ -2832,12 +2835,6 @@ static bool text_poke_addr_ordered(void *addr)
 	return true;
 }
 
-void smp_text_poke_batch_finish(void)
-{
-	if (text_poke_array.nr_entries)
-		smp_text_poke_batch_process();
-}
-
 /**
  * smp_text_poke_batch_add() -- update instruction on live kernel on SMP, batched
  * @addr:	address to patch
@@ -2854,7 +2851,7 @@ void smp_text_poke_batch_finish(void)
 void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	if (text_poke_array.nr_entries == TEXT_POKE_ARRAY_MAX || !text_poke_addr_ordered(addr))
-		smp_text_poke_batch_process();
+		smp_text_poke_batch_finish();
 	__smp_text_poke_batch_add(addr, opcode, len, emulate);
 }
 

