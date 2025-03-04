Return-Path: <linux-tip-commits+bounces-3874-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A9A4D75B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7063D188357D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9B20103B;
	Tue,  4 Mar 2025 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LvyV93ls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwfj6DPB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781B1FCF72;
	Tue,  4 Mar 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078631; cv=none; b=VbPhoXEHAATYkjMjPlICScrvZ3wU8sQgaT9LvCRsNZEND5fShHJRZEsZZ3HXp8KSysII5ciL+BFLk6/f/SkOO1bVfbsLd/7c4b8BnYxf6t6I9paP9b+T6xZj/4w6WKMn+egv7oEBMw958YhFX+7ddPPFhf/qoiKkokg6/zHhED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078631; c=relaxed/simple;
	bh=Mv+iQ1Tq4xLXDtAXupuNGLYRJMJALhXj1+iM5f1FIJA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aQq0aV7SGboRU0UOLjKruajCzVWloB2ZLRVv2SgmRjN6q2zDHbqPv+URGUGwzYRERcMC3zQuUW/DE12TN9qsjV0S7vGRlrpmUYBLYQScl+jLwwcNkn3flDhvUmU+F02ElceORa77wNzV+m+JeL7N/2oWGTB+h4LQkK8ln5yyWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LvyV93ls; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwfj6DPB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWegiVUaagVRntjHOtRXaR3JpJIw08JyWbRCddJ8gCc=;
	b=LvyV93ls4SZt8eX80UXNpPL/tZuEyyY1exH3FSekuFegckCf2GRBOCvkKoBhb9QxSgGRSl
	A/mX9JXy5rJO5hmPT5xsLiKoqf3ZRUIFziotilqqpN9ANterQJsU0Z0e7MqVOYs0kRLxPu
	OBvNyCopuiHkuB4GPDFfUuI0dZm1qgMIiglLmVzI2Q4e65xW4UtTF7lhNKVkEfeBKdnUDk
	5mySNJxxsX8FmcejQBfyk5QTlN00r8BnWA0J/pMzvWIKxllY0JvnV/EvgPcN0Go5OP3gyn
	mflZ0+mqnB/AG4s2XJJMpiNFk2WBC1Z6HckklWFuSrdLjK31xWbhXx31xckYoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWegiVUaagVRntjHOtRXaR3JpJIw08JyWbRCddJ8gCc=;
	b=bwfj6DPBPFE3gBJbO2dJR5EUO+LPp4zS5kp/slLZs3vL0wlaK7kBWasdgAmfpS+tupx46Z
	5dVSGFFeIdbL+LAA==
From: "tip-bot2 for Saket Kumar Bhaskar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Return EOPNOTSUPP for
 unsupported breakpoint type
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ian Rogers <irogers@google.com>, Frederic Weisbecker <fweisbec@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303092451.1862862-1-skb99@linux.ibm.com>
References: <20250303092451.1862862-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862797.14745.7983428300069881325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     061c991697062f3bf87b72ed553d1d33a0e370dd
Gitweb:        https://git.kernel.org/tip/061c991697062f3bf87b72ed553d1d33a0e370dd
Author:        Saket Kumar Bhaskar <skb99@linux.ibm.com>
AuthorDate:    Mon, 03 Mar 2025 14:54:51 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:42:13 +01:00

perf/hw_breakpoint: Return EOPNOTSUPP for unsupported breakpoint type

Currently, __reserve_bp_slot() returns -ENOSPC for unsupported
breakpoint types on the architecture. For example, powerpc
does not support hardware instruction breakpoints. This causes
the perf_skip BPF selftest to fail, as neither ENOENT nor
EOPNOTSUPP is returned by perf_event_open for unsupported
breakpoint types. As a result, the test that should be skipped
for this arch is not correctly identified.

To resolve this, hw_breakpoint_event_init() should exit early by
checking for unsupported breakpoint types using
hw_breakpoint_slots_cached() and return the appropriate error
(-EOPNOTSUPP).

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: https://lore.kernel.org/r/20250303092451.1862862-1-skb99@linux.ibm.com
---
 kernel/events/hw_breakpoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index bc4a610..8ec2cb6 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -950,9 +950,10 @@ static int hw_breakpoint_event_init(struct perf_event *bp)
 		return -ENOENT;
 
 	/*
-	 * no branch sampling for breakpoint events
+	 * Check if breakpoint type is supported before proceeding.
+	 * Also, no branch sampling for breakpoint events.
 	 */
-	if (has_branch_stack(bp))
+	if (!hw_breakpoint_slots_cached(find_slot_idx(bp->attr.bp_type)) || has_branch_stack(bp))
 		return -EOPNOTSUPP;
 
 	err = register_perf_hw_breakpoint(bp);

