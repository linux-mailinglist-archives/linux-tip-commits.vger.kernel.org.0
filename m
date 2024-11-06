Return-Path: <linux-tip-commits+bounces-2760-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FDE9BE4A0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7DF285A79
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEAD1DE4EC;
	Wed,  6 Nov 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/bhVidz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTAkgfyu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AB1DE3CD;
	Wed,  6 Nov 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890068; cv=none; b=flwtwmSZCl7ivC99j5iZUHSMZr2Oot30pr+djZBaqWrlWgRnH/M4daFYK3mcJAlaCsl8anTbve3RpNOJigQYMr9PNX7V2euaRzq+2kEF0lFSfVH10+wmM7gzaSYOEJROhdHvlqZ8T/XbU50wCr2I5Hd0bgXKRPHmY82vUSAV/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890068; c=relaxed/simple;
	bh=EQjveyo27r/xz5MBvntCHY8/qlgjBSqyton0Z0ohYAM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gB5d3GS50D4djdk2piZZG2ryMtoL+/koo2xedfN+OaaRgFbybqG/LB5+BJWxo4B8ZEU4yr0alVeXYrG1oHKmuMRd78sFyo+lxZiP35hADkb8qT7V82li7PFG6diiSYKTnI2WNiMj90L4nCiYA44OoqTNndvW1pNk7rAKPSpNS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/bhVidz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTAkgfyu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7GH7JFuryniSsxcVRzLnhbo9X9D1GzTzG3uIFqnb3Q=;
	b=W/bhVidzaefkMLIrrkhR0y+fxqJxFQqPrkcLiWHRyS2mQDWnw/PMzAMJKPLNufc5AnB/wz
	HHgqJ+zVFm0itWIbK6SWW9brszGhOcjevUJkBHCkWtrx7L9C74btXCfN3oznm0TEKVz/qV
	cLt9/OfoSFBH3Gjt+FIrVijUzCJSQBbzgSWNpT2K5zYfbqP0U0vPlmsyon7ZvUU8udii6o
	Zb5+h7U6lNG2deBtIloju8ht5h20B8tj7TK729W9RzXqRfGV64MmTe7Id8mVCEhajQiMla
	hEKFeKYxNbs9OWi2ABNbpAyRin5eXHf6GX4QoYswZWoFEockTWPXCJB/BBno4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7GH7JFuryniSsxcVRzLnhbo9X9D1GzTzG3uIFqnb3Q=;
	b=XTAkgfyu/4vdy43oIBCcWK9JWbjYsNhrE3oWMcfCHTUs+V4eZuNDQTzCi5SaM+CaSsX4bA
	s1WOWNQt8g1a0VBA==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] time/sched_clock: Swap update_clock_read_data()
 latch writes
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241104161910.780003-2-elver@google.com>
References: <20241104161910.780003-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089006394.32228.1285388463688281244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1139c71df5ca29a36f08e3a08c7cee160db21ec1
Gitweb:        https://git.kernel.org/tip/1139c71df5ca29a36f08e3a08c7cee160db21ec1
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 04 Nov 2024 16:43:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:34 +01:00

time/sched_clock: Swap update_clock_read_data() latch writes

Swap the writes to the odd and even copies to make the writer critical
section look like all other seqcount_latch writers.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241104161910.780003-2-elver@google.com
---
 kernel/time/sched_clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 68d6c11..85595fc 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -119,9 +119,6 @@ unsigned long long notrace sched_clock(void)
  */
 static void update_clock_read_data(struct clock_read_data *rd)
 {
-	/* update the backup (odd) copy with the new data */
-	cd.read_data[1] = *rd;
-
 	/* steer readers towards the odd copy */
 	raw_write_seqcount_latch(&cd.seq);
 
@@ -130,6 +127,9 @@ static void update_clock_read_data(struct clock_read_data *rd)
 
 	/* switch readers back to the even copy */
 	raw_write_seqcount_latch(&cd.seq);
+
+	/* update the backup (odd) copy with the new data */
+	cd.read_data[1] = *rd;
 }
 
 /*

