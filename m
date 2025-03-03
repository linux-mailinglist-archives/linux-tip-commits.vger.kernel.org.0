Return-Path: <linux-tip-commits+bounces-3767-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D4A4BC6A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBABB3AAAAA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9621F3B9C;
	Mon,  3 Mar 2025 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MPPd7/yT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8w5dIlaS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93541F12E0;
	Mon,  3 Mar 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997933; cv=none; b=GRVYa9DWSPT//nKklYvLkSOnldAk6o84jRvNzvZ/KVKnavqecbZTWO7GeLX28u1p0mANC5KVoqKE4Kx7J10Xe2Aha8HZS8QrqVzVy+hCTu8dlgatu+jSWgzj/sMVI2Aal0bBEsKN1MYNBwAEERGmoRwFFPiDs3Ag732u4nwSQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997933; c=relaxed/simple;
	bh=kGYMUpuEe4v0OtuLM1ufIIeZ0amApqLgtKA7RXKSX5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n5Aml2mh2bLbO56R8JUPnE35AShE3hYk4t/30vO92ZJ2nR4My8jpDwn08/Q2SmP543dNq9alUrt1HlDOUQgOM5+k2zvsiNxaXdUuXFv4x8tUmbGe3aC7JeS3jSOo2p+zEl4+dpjE+PFL3X+x7rMMe2Ubj+TeQKaCpPzp/xUwKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MPPd7/yT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8w5dIlaS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:32:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740997929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fP5Yte40JRLx9nLoznLYmIPBoeg9UHM3QmMQ6tutJyY=;
	b=MPPd7/yToCuX+x1mAWGs898MYyUFZMi+pHT5T5GuJWfkaOU4DDdmouz8yGbLY2dww70Mf9
	RriuQ4gAIJOMNIhI5fvoK0DC2/5rIweEv2lD3tCMSxM/sGatHv21tdfO9I64Pa7hBzatsp
	oCqR4HZuBiuny90mwPFM2taM26RrsPSg0xtLsr2CMFmbNj1Cb0OLaaHXpnOy6WI3aWQpuw
	S5bxxr6AV1Ya/KGG6k0Si4pKntScFzaV4XkEIspcau7tyz81+Yfej0lamXg0ZHC5ZZi1WW
	apQPFKQftj4lpUWJ/T+xl7YDXBXMU9kRJ3CrwGJ3ZULSqgzFG2vPVNceooPB7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740997929;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fP5Yte40JRLx9nLoznLYmIPBoeg9UHM3QmMQ6tutJyY=;
	b=8w5dIlaSAuWRXCVcj45E/wWPS1UTaIGg1bMjvk7iTeCSs9WFtRK/aadrZpIqRJJlWp8iTv
	f1yxT3Rg496kihCQ==
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
Message-ID: <174099792896.10177.9724987016541581477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     21d96cea578f83e43ec9016e5bba8703b290c748
Gitweb:        https://git.kernel.org/tip/21d96cea578f83e43ec9016e5bba8703b290c748
Author:        Saket Kumar Bhaskar <skb99@linux.ibm.com>
AuthorDate:    Mon, 03 Mar 2025 14:54:51 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 11:23:15 +01:00

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

