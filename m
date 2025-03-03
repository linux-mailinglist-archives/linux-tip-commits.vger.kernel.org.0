Return-Path: <linux-tip-commits+bounces-3800-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F536A4C055
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 13:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD883A4C14
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E220F091;
	Mon,  3 Mar 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UdsKB73+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A8h9Mi+W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781341D5CD9;
	Mon,  3 Mar 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004973; cv=none; b=sb0TU5OQd2tpzrfAmnrL1K+KI9rrA9GAIstUE7/tDkpJQeFT5H6rcnJ9YV9ho6ciFzk+6HqoGFre8fjWh28QtsjI8sSdVEuel3E+SGkjjX3FQmH5DHC9bxdl/kxcFIZgwQYll5zXtQwndcEcO61rDr5jZgQl6kbx8skpv6c7vPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004973; c=relaxed/simple;
	bh=6lusOCn+ROHsGmbxokxLsp+Hs93kWrIaHcH38fT8fB4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ten44luwTfpWnkJJnqpDHcqUByQ5DU13V+mrnq/vANuB0qqmjKWPKpWzzGpB4ieCGV3cX6MKpeXVJ2GiJZOCRzCr0iANUTk9sQGvwzNYhInyUZ90jlmJhrHPIFrEH1vRSXCstScVnYKBmZCGEmDlxSK83hIpZLs82OOj2kUcCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UdsKB73+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A8h9Mi+W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 12:29:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741004970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVmmSVKudusSQcnn4AbIPCJUjlVut9Xt8X65JHMLRFk=;
	b=UdsKB73+/ummF+qaQzOS6z67CAYVTDXc7XJds2OYxnpPCDaJjh710wCvyk04L3xttkciX9
	fbBx7U6LZ2Rn1AHKLgBbXCsuYpeo5LciHqKwVG8t9bLIULDSxVYgtyZ7AZ1E4pcb68IwKE
	6lVr6j4JF2FUISEq41LENLV+LwXThya+PW65RIZR9DlXTEHKVoLnAXSb9GZRyPmG+CBpXc
	phoKcAW01iUOWLaqFaU72KBXJ2lQKCi5gIZ+6+U4viUTd354zCPaZbMdPXuw2xfiJ5Lcss
	3JmwRXPjX+5cgKVmuirZ06FmCdEFMQk7U49EbSqSdVuv48pEtRglRA26B1LPvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741004970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVmmSVKudusSQcnn4AbIPCJUjlVut9Xt8X65JHMLRFk=;
	b=A8h9Mi+WZ0OyTxZhXlXPU71VOutYZ0iMHA2NmoSR16Ole3ViXrVl2SIrs73jz0MeVXAHHW
	WQm1/qPOKgse0uCg==
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
Message-ID: <174100496958.10177.3915853493662082319.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4118628d0ce005e5651174b9d5fc0209a8d49ee0
Gitweb:        https://git.kernel.org/tip/4118628d0ce005e5651174b9d5fc0209a8d49ee0
Author:        Saket Kumar Bhaskar <skb99@linux.ibm.com>
AuthorDate:    Mon, 03 Mar 2025 14:54:51 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 13:24:12 +01:00

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

