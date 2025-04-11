Return-Path: <linux-tip-commits+bounces-4854-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5746A858CC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB19B7B1B49
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28242BF3D9;
	Fri, 11 Apr 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jq2pHYH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mioMzrFe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A152BEC36;
	Fri, 11 Apr 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365718; cv=none; b=bsXglySZ1Y6m985fE4qT4DLwAXUM0fWb7Zto22SGBiTQWEtnZsT6Vf9VSdNFViZKRoEd2HXaRd2/lHzIxqCpVuVni0pPhq7sK1PZcRNXWyAH7/BrlauapKNuo8j7eCVG/jQyyPYhTS8nE7R655BnFa804wga0M1AEakoDvrEy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365718; c=relaxed/simple;
	bh=2yFLRTZ9Wta/glBvItEjTlbcLcck1pQMOdJgsuylTHo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eT9MCAI5y/4kZtYhpCK9RqUD99kDI93L6sOfRmjKbbgAR84TqXoH/l/7fCuDZvIa3sDXvnEpCBj/IaI+zFPxUOPx1It0ZCh5DLHm8yx3AAfeGP2EOTh949Z1H72htjpHV5xJUSXLIymiWHHt4qOILgbMvOhJQFSOw/BYKoqqFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jq2pHYH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mioMzrFe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5co33rZWkxjbZ7+/fh4qtS2iR8hEy4oGLBuGsvV0PY=;
	b=0jq2pHYHc+lwic0uZSaGR34WHG+Om3e5FKyeNO9Vp77UZWpe3OMQlip4Hh9+4p9PkRAnrL
	/OWUB6CaK1q4PoyBH2/vF4IiiKDHy2dCtvij85kR9MPeLlBL8/IQ+u+V4x8L4+p1SWZlOW
	1J3g/+G3v80ZtVh6YrASulJWwx/QIgjiq9dVlaJYQTWxNcUHaxOdPysBpgm77Ew6e95HsY
	WqsoV81WzksicsAYwHvaLnW8okTVX7x+bhzs0jgjCdlPEeQFs9W/XfPR7zp/bGhLlUO6DF
	Hw+W4H1Xa68EkNp/TkP8pRd9mdc61yiTGZq/bogIJQ70PngSdPmdBw4rib7zMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5co33rZWkxjbZ7+/fh4qtS2iR8hEy4oGLBuGsvV0PY=;
	b=mioMzrFedNRDp1me8J+MlNggAn/B5visXckm1BY8H/gLuyz28/wWY7XYfkxUXfliNBJtBO
	T0wAl9B4W9ACeXAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Move the text_poke_array
 manipulation into text_poke_int3_loc_init() and rename it to
 __smp_text_poke_batch_add()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-36-mingo@kernel.org>
References: <20250411054105.2341982-36-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436571470.31282.15235999280241081672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     0e351aec2b0052d33d6e44ded622223043d4dcd5
Gitweb:        https://git.kernel.org/tip/0e351aec2b0052d33d6e44ded622223043d4dcd5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Move the text_poke_array manipulation into text_poke_int3_loc_init() and rename it to __smp_text_poke_batch_add()

This simplifies the code and code generation a bit:

   text	   data	    bss	    dec	    hex	filename
  14802	   1029	   4112	  19943	   4de7	alternative.o.before
  14784	   1029	   4112	  19925	   4dd5	alternative.o.after

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-36-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 08ac3c7..eb0da27 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2752,12 +2752,14 @@ static void smp_text_poke_batch_process(void)
 	}
 }
 
-static void text_poke_int3_loc_init(struct smp_text_poke_loc *tp, void *addr,
-			       const void *opcode, size_t len, const void *emulate)
+static void __smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
+	struct smp_text_poke_loc *tp;
 	struct insn insn;
 	int ret, i = 0;
 
+	tp = &text_poke_array.vec[text_poke_array.nr_entries++];
+
 	if (len == 6)
 		i = 1;
 	memcpy((void *)tp->text, opcode+i, len-i);
@@ -2873,12 +2875,8 @@ static void smp_text_poke_batch_flush(void *addr)
 
 void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct smp_text_poke_loc *tp;
-
 	smp_text_poke_batch_flush(addr);
-
-	tp = &text_poke_array.vec[text_poke_array.nr_entries++];
-	text_poke_int3_loc_init(tp, addr, opcode, len, emulate);
+	__smp_text_poke_batch_add(addr, opcode, len, emulate);
 }
 
 /**
@@ -2894,13 +2892,9 @@ void __ref smp_text_poke_batch_add(void *addr, const void *opcode, size_t len, c
  */
 void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct smp_text_poke_loc *tp;
-
 	/* Batch-patching should not be mixed with single-patching: */
 	WARN_ON_ONCE(text_poke_array.nr_entries != 0);
 
-	tp = &text_poke_array.vec[text_poke_array.nr_entries++];
-	text_poke_int3_loc_init(tp, addr, opcode, len, emulate);
-
+	__smp_text_poke_batch_add(addr, opcode, len, emulate);
 	smp_text_poke_batch_finish();
 }

