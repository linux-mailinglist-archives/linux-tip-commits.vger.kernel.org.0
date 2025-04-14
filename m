Return-Path: <linux-tip-commits+bounces-4965-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2706FA878E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD7718925B2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E5D25DAF4;
	Mon, 14 Apr 2025 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFFPWah5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jLy6sJAl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450D2580EE;
	Mon, 14 Apr 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616096; cv=none; b=W78/mE+LvwjMmq2p24fixkGp5IbUgSEInr1vmi1951PTpyYSc3bo32rJk+ibVKhI1Prjm1tTFGUAn1UwEofLUv4Lo4FF7tpsIoIMz7MWo/OpkWLAm0xRKLnse7q9Ztg/rs3g5NwuzAugB2fbJGh6P01NVYp3Oe/HpN9M2cfaqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616096; c=relaxed/simple;
	bh=DZYAmT/pJtBi18vFcKYuSHA3k8HsFksRwWU/Q0zmwLI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pZcV0dZXo1YOfXEboAIVUZ1vEGuyaNwIPA9QiZmEZZadbMMH0dzBJ4Cc19miReVALA2jXJeHoKp0KLl0dmajieReWcwCro+m+QZwfvBry7EhaIIG3AMqfrZaJbemqDk8DS9vvo+OXLlh5OYhnaZeHzrtYq4CHqqVHGqhsoH8qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jFFPWah5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jLy6sJAl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPID64twDeF3WaFbDll0v5ocfwGCf88dWqqFpLLKMH0=;
	b=jFFPWah5Sse0K8mmFadtdOlt7XumSCfK05RmJbzS+4NuM4OFa5AJoqRDqUtNesew18DjzS
	MvzSSytWHO93DXnCIOUaxWFAcmGj6hL0aW9+Q+UBZf/A7Bq+mZBx5cr0s9W/EBpSfkbp5d
	uduqZoqBcC4VAeCVnnDTudV3RtW/5rHoyWAp+L9K2Ku+q0aHg/C7sOCGFWae1a3q89lSn4
	jmHvEvvWbQt/5grYkQZZjA2dc/kKWIPK8lToEe8JXTqGXVveoDsawl2XwkCUs1JICh2F3J
	SZGNTszcV917Q32Grb73ECjVt7xkbo5sWIm2tW+sODqqVB3/aM070SoSIFQe4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPID64twDeF3WaFbDll0v5ocfwGCf88dWqqFpLLKMH0=;
	b=jLy6sJAlhojmYmESyTefj9RSYlp/N8YP3cWjnMqlwiFKFPlxCUZ8TvtTxsSQwkXUqQwTKS
	5wNERWol4Ne+z6Aw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu/xstate: Adjust XSAVE buffer size calculation
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
Message-ID: <174461609199.31282.6064961107706936166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     a758ae2885eacaa68e4de9a01539a242a6bbb403
Gitweb:        https://git.kernel.org/tip/a758ae2885eacaa68e4de9a01539a242a6bbb403
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 20 Mar 2025 16:42:54 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

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
 

