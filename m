Return-Path: <linux-tip-commits+bounces-4848-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4996A858D7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D31F9A6169
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CEA2BD5BB;
	Fri, 11 Apr 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PhpWBxop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YBjepKek"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29872BD591;
	Fri, 11 Apr 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365713; cv=none; b=d0k5/WDvq4lHKzw59MrARxLD4PwdpH+OEFz3OKi6+3AFP3tKdiHqkW6rIUfBD75lFBObYApA76DlMlNIkpDtU7zr1x0YbTeH64Q8qyI8dnUOJG4BDa7/mtgNQ8K6xPk9y/9Cw1J5CPFwefQxzaTZUAzqVKAbJrEey5KrWfFRIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365713; c=relaxed/simple;
	bh=/SxXB/6mlneRurIRS9U3vxeXmhpC+jpGzcRVoKnGue4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p1JfelpDgrBsBRTNwkszoUL2LCmVHGA5+XJKBqiZlgPbzyBGRR+6TMaK1yOJLXDk2eD9uCq/ensncN2vtUPaA0TvATzeGXuXK+uiEoIDD45FYbPUpWbsMcRWfMFThPY2ZueiaoW/8vl0lVlq3QwBP0iQVyxK+pIdRH33tgobVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PhpWBxop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YBjepKek; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EbdYF3jT/9PhrBa8iWmVin2FDRS16Vusg6n/jf3BMM=;
	b=PhpWBxopFe42z7b3VUu4ir98Guxc6mVw+BWRVNSYuguRPk98RlNRU7bIrAeHljPAgN0/1h
	Ic/IP0EB2VucjCA+4odEYd3gjhPWg+PAAyc4XU40OuBo3G6UIVGo0kjNONcYsB1CuhevGs
	p5b9YOv6kJvIFesZwvqLUMwJdOnhty0rP4tdWzLVsGU9CKGKKuQfrdW99NfIxO9SK29iyH
	Q9xMN2DLpwQIshX9TXed4M2UwhCpKD08Ffd+wYHDm7c9UwLhkEbDSe2JRSjkB9fP10eCGH
	JMGn5HxVpT7Uf6XXixhCfpzIHX0ujJj+cHg2eb2qHYINYJTpSkH8FMUmn5OvGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EbdYF3jT/9PhrBa8iWmVin2FDRS16Vusg6n/jf3BMM=;
	b=YBjepKekaZSFvphgxlMTkBw3HnYN/R5Ky69WIHi5HjR1KXZwBI4IKmy5y80P1Dsuu91kee
	qbd77VjDqbNW54Dg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Simplify text_poke_addr_ordered()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-42-mingo@kernel.org>
References: <20250411054105.2341982-42-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436570792.31282.14816566853577109032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     0e67e587e2e07be8d6775a1444e679c6afbc87f4
Gitweb:        https://git.kernel.org/tip/0e67e587e2e07be8d6775a1444e679c6afbc87f4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Simplify text_poke_addr_ordered()

 - Use direct 'void *' pointer comparison, there's no
   need to force the type to 'unsigned long'.

 - Remove the 'tp' local variable indirection

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-42-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e4c51d8..a747b08 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2838,8 +2838,6 @@ static void __smp_text_poke_batch_add(void *addr, const void *opcode, size_t len
  */
 static bool text_poke_addr_ordered(void *addr)
 {
-	struct smp_text_poke_loc *tp;
-
 	WARN_ON_ONCE(!addr);
 
 	if (!text_poke_array.nr_entries)
@@ -2851,8 +2849,7 @@ static bool text_poke_addr_ordered(void *addr)
 	 * is violated and we must first flush all pending patching
 	 * requests:
 	 */
-	tp = &text_poke_array.vec[text_poke_array.nr_entries-1];
-	if ((unsigned long)text_poke_addr(tp) > (unsigned long)addr)
+	if (text_poke_addr(text_poke_array.vec + text_poke_array.nr_entries-1) > addr)
 		return false;
 
 	return true;

