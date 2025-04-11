Return-Path: <linux-tip-commits+bounces-4837-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CAFA858BB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9841B8456A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EA929AB18;
	Fri, 11 Apr 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnECotrQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lm8in20g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809A2147E7;
	Fri, 11 Apr 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365702; cv=none; b=RGUpD2KlHCYiqBJZgUR2ElmG+dgQXo5E6ilmTVMehUWc+xsgyufQd1JEQR/ocIX+ZPE2v5Vp0xEBSOl8QlRjnrvQ1bnn4tUCXctliEOD26/lAh//TrREZMBg+AIdYFTTrUURvGktAWQL0E8vv+aDaFzMSJbnIHyvWu0zb4KvPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365702; c=relaxed/simple;
	bh=Nom8+jGsmJ/se9Im8VOHJoRLQX6g6xTrYI5vdT475pY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JoR/a3u6Z6t01bRIKrsrrtY7dbxbtfG8FtZdZzoFrgvOg+QG7m4YoecNmD5nen1ujaL+FuqEJu43j+LfAMxO1Mzj/ETaj1grzSBtDoJ/byvHZ5p+8usGsTytGhLgJ/oi1MwpBqYATS+/V/nX3ArvMv1W9YQ4lk2cyJqJBZMKMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnECotrQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lm8in20g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8H7LRlp7eXLaHXHHs/UzWo3XfvXfKe2924rgpMVaON8=;
	b=gnECotrQtm/qT+SmA8N6IdsSoixEt8Z/HohHlzBpS9sXD0GBrhjLQtimv+ZQ7RR5+JlWj0
	dITqxUHBMvRpsQRybHYz+/AJQ2fz6IK45Q4hjEvdQdzWBgKBljk0HyqZ8Q9mYzN049LoGN
	MEZCjMMNjAy62+lWrJfNMwHGX1zFqaXoiIrK5MrgherM7AxSV/wMMy3jWERWjeed9BN5dp
	xbzg1L2dJhEiA09T8go75WWc9100OjPL67ovuIuk+YxAQjhq2XnLllRyF7sdN8+kKz62d+
	MXZ8x99xFTxOKoUGg4z6z2GOl7vzvfdp6V/2MoKQt28DlyucwvxLQ78CRQolzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8H7LRlp7eXLaHXHHs/UzWo3XfvXfKe2924rgpMVaON8=;
	b=lm8in20g5c9qTIQEuacrXP4julUV1vHlw6of8gyB/UvkzCHgI8QsZwUAZh07JlKyeaifLp
	4fTL5BXGu4CJjJBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Add comment about noinstr
 expectations
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-53-mingo@kernel.org>
References: <20250411054105.2341982-53-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436569740.31282.7734944498179192811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     4f9534719e524affb1aa8e0ff0c8b30c1c65e574
Gitweb:        https://git.kernel.org/tip/4f9534719e524affb1aa8e0ff0c8b30c1c65e574
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:41:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Add comment about noinstr expectations

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-53-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 231b2ac..604dd60 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2447,6 +2447,11 @@ static struct smp_text_poke_array {
 
 static DEFINE_PER_CPU(atomic_t, text_poke_array_refs);
 
+/*
+ * These four __always_inline annotations imply noinstr, necessary
+ * due to smp_text_poke_int3_handler() being noinstr:
+ */
+
 static __always_inline bool try_get_text_poke_array(void)
 {
 	atomic_t *refs = this_cpu_ptr(&text_poke_array_refs);

