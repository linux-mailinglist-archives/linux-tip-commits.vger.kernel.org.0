Return-Path: <linux-tip-commits+bounces-4526-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E919A6EDC1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20125189BC61
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0236B256C75;
	Tue, 25 Mar 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l1tMbxtD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXAD+Bs8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56531256C66;
	Tue, 25 Mar 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898524; cv=none; b=UpPslpWWwbTa97IpJvvOtYgORFfqcQr5+BThwHzG27w9LLh956+d7rgsdNQZqxwqziBCIDxvlx67jZfEmtxBW8kAjgv0Ah6yJiK8QIKCZb/CX0n4ESFFspmKfF3mS3ejbYHZ+7CYB4lhVUpbwHkAVC4oVmcIImpZasjJB7t0cV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898524; c=relaxed/simple;
	bh=CEtHLEkmzCcv4miis5NYvBNgXdEMUwVjsDuJ5LzH6sI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K2UwOowIJ7vUVfUzFf3SRVQebV/eFtwCrF95mx97b9B0lR2XFgDUUZEE0gP3Km93/s1NXpKK9BKvqekuSnGmWGdfdgNm1MwK4Zk6MC06hBfp9sBiBo3HJ1GLQB150bZZozSk00AZidSIzc6GXUXnJ8gGhxCCzdnL1mo1I4KWInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l1tMbxtD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXAD+Bs8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 10:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742898521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ70zDa/hcEixoh5UB085NEKBQjAhjInv0sylEtcbTw=;
	b=l1tMbxtDB1iwnoSa6ywKigvP1m9ZMc5eAukdWkqd/2RvCmE2dQPFYGkObhEg9+mHU9WrD3
	tK6iVaHjJYxRIo6Lk+hpgQN7EiBRnNlehCdPKxxFzZCBv2sm4bPF0b4EbV4B+66DrnBR12
	U4f8Ro9OfXP93M7GYGt4F27c1UfaJFgEXNF8NEQPdzWG9ek9sbmdhYARpszbNQ5XDGa7vx
	TZF+qF2Ygt536mK1Uv3jz5IUSaRULXxTDJRJYHBh/HzW8FrOWG6gNZ5bC1gdzgoZDZxn02
	Sp9ECWKUkVKKPhF22VJH5LXEq3Lpjs1GFz2lthpMtVr/O7QEUmqtIJjFq8WvkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742898521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ70zDa/hcEixoh5UB085NEKBQjAhjInv0sylEtcbTw=;
	b=GXAD+Bs8aNjKGsd2IAHBbgK8pQZ70bzO+IYbA+bV0V5gMMZCgJWtHxVkqAtF4IN0Ph4AHJ
	+5/9fpEQNv376NDQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Adjust XSAVE buffer size calculation
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250320234301.8342-4-chang.seok.bae@intel.com>
References: <20250320234301.8342-4-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289852113.14745.4146028191063980814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     a6842ee9b5be3223cdb0c8fee3f6d71c274f68ba
Gitweb:        https://git.kernel.org/tip/a6842ee9b5be3223cdb0c8fee3f6d71c274f68ba
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 20 Mar 2025 16:42:54 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 11:21:20 +01:00

x86/fpu/xstate: Adjust XSAVE buffer size calculation

The current xstate size calculation assumes that the highest-numbered
xstate feature has the highest offset in the buffer, determining the size
based on the topmost bit in the feature mask. However, this assumption is
not architecturally guaranteed -- higher-numbered features may have lower
offsets.

With the introduction of the xfeature order table and its helper macro,
xstate components can now be traversed in their positional order. Update
the non-compacted format handling to iterate through the table to
determine the last-positioned feature. Then, set the offset accordingly.

Since size calculation primarily occurs during initialization or in
non-critical paths, looping to find the last feature is not expected to
have a meaningful performance impact.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250320234301.8342-4-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1e22103..93f9401 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -581,13 +581,20 @@ static bool __init check_xstate_against_struct(int nr)
 static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
 	unsigned int topmost = fls64(xfeatures) -  1;
-	unsigned int offset = xstate_offsets[topmost];
+	unsigned int offset, i;
 
 	if (topmost <= XFEATURE_SSE)
 		return sizeof(struct xregs_state);
 
-	if (compacted)
+	if (compacted) {
 		offset = xfeature_get_offset(xfeatures, topmost);
+	} else {
+		/* Walk through the xfeature order to pick the last */
+		for_each_extended_xfeature_in_order(i, xfeatures)
+			topmost = xfeature_uncompact_order[i];
+		offset = xstate_offsets[topmost];
+	}
+
 	return offset + xstate_sizes[topmost];
 }
 

