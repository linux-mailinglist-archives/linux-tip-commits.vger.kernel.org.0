Return-Path: <linux-tip-commits+bounces-4851-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAA5A858E0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66F48C7BA7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD742BEC25;
	Fri, 11 Apr 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RENhFiDL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HUTgtI6C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B52BE7B8;
	Fri, 11 Apr 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365716; cv=none; b=PUX2VtP4Bd5a4L9AABo22MFVQ/E/53ZMYI8tzsPM9raD2WIgSN31dCu2ovOgHGpJz66mD2Z3+l9oEM+1gCNadSvzeJ9tMQv0hsBZsGOfJG2kMOywXnGCTViNp05RyBGEbyrdgZnDEe93PJv35NUZU73u6UL5a2dgAdx9NmGB1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365716; c=relaxed/simple;
	bh=gwMyvaChZ/E4yCgwsdGheTI885Vq2//BUqNOUOMXNyk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qFEveaHL1KQfbrXTenEuMG4LLmpgQqZjCkDNc2/1BtyNnHB/o8gHFMfp0LbSiAqLeEtgQraoZpxiLjp5tVWg/eyj+7LeADN4Rs+NtbRtUgRifcLDmzjv1leyorAg7ZOpJ2fVjXRUJpcdhs7X2HWuBNxn8IlAf/1LJWpdiQVQqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RENhFiDL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HUTgtI6C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKVmjgKrhsXeksb1ByarjUmlw9wnc3032mAQNCCHN1M=;
	b=RENhFiDL71ix5aNZnzpbd29wEdFbpDBgmwEtiUUyf+T5iOmROGg/9t2V8dzmRNfcRHb8ob
	MaeThmMq4Rgww4n0SswwWGBRYOR4IGMpAS7DdH9+LRdUs5kZuUluQQMSQOfyP3QjMtxjq6
	FAb8YYJuq/6xk2/e/qoFGWERl9ODY83xcdLFSzHd56kA22r87s3fG5J0SmNqG+dCxgpvaY
	gvWKP/Oxbz9rIcIshHlABi/al59XuMDz+0hg9qqM3Wy/Z0+vsroyu/599nNxdeoyayrBNZ
	oU3K7d9KZw8hEF7ITOzaSNteRp65GdWtc+qah5pmfdMkKWWzlaErxLKlZmodug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKVmjgKrhsXeksb1ByarjUmlw9wnc3032mAQNCCHN1M=;
	b=HUTgtI6CS1QD8XOPacNP2pul2RcYJt76WXWNLw5OA0KvCFvTdSecAvOkrrFFcprpk0OAqi
	SOu3wfFogtmiuACA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Add documentation for
 smp_text_poke_batch_add()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-39-mingo@kernel.org>
References: <20250411054105.2341982-39-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571165.31282.9373988080368433343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     cca3473956be6ca5c7ad5d2ced5516eb509c1936
Gitweb:        https://git.kernel.org/tip/cca3473956be6ca5c7ad5d2ced5516eb509c1936
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Add documentation for smp_text_poke_batch_add()

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-39-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a9726cc..b47ad08 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2873,6 +2873,19 @@ static void smp_text_poke_batch_flush(void *addr)
 	}
 }
 
+/**
+ * smp_text_poke_batch_add() -- update instruction on live kernel on SMP, batched
+ * @addr:	address to patch
+ * @opcode:	opcode of new instruction
+ * @len:	length to copy
+ * @emulate:	instruction to be emulated
+ *
+ * Add a new instruction to the current queue of to-be-patched instructions
+ * the kernel maintains. The patching request will not be executed immediately,
+ * but becomes part of an array of patching requests, optimized for batched
+ * execution. All pending patching requests will be executed on the next
+ * smp_text_poke_batch_finish() call.
+ */
 void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	smp_text_poke_batch_flush(addr);

