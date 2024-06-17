Return-Path: <linux-tip-commits+bounces-1427-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0090B57D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4B51F2300C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EECD1474BD;
	Mon, 17 Jun 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHRm7Krk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xcjaRF7S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97623146D7F;
	Mon, 17 Jun 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639244; cv=none; b=N87yIDe0j0oPT5rIDUJ89vkkTCxJxctJynYgT+8ZQm4d3ilDPzMFwK1fZLNpQbvZc1661b44VjzkWGvAM7r7nMiZhzHvoz4YoXjmjoocCWtYiTGky1vAJqquEc+/lm++jeyadmX9ZhScCzrh5Sx9V5aKG4//s+NBvsWv+txEVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639244; c=relaxed/simple;
	bh=0+TukSkR8ps+vsbC7H5Lvw1gS9BL+qkXTAcatIEkfsM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HRAhwgVp8WkE3qhrDW4MezoPiLbd/limqzixe7k8a7VXrK2MdtzWuMzuddazMbkUa9elkRTiXcePDImF82WPrWOxRosCT1j3XvopR9nEPixOipzHVy8k81CnaWfGya3a76bx4dxZqOHbJjDfeSBatu9IQaHbGdlVp3ac9aUg8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RHRm7Krk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xcjaRF7S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 15:47:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718639238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pQRYUOs473EqpQDRpZrtCiEut7g38dXzlHkM6Ny080=;
	b=RHRm7KrkpoF45OuoZncfiRX1tT1Poy2dfG3DmjnCm4wK+a6knlq3pw5ELi8auczy0p0WMG
	8EjwIoryKT4H06OEZHuoXBxyTUB3aJJUdLKOaH3QljeM9G6mDYBFYZxgKHYDpNlguJJ8OJ
	mjsdkCMreb4gzKXzlmTByJCAgmBkrMmR5wX2pCchsbA9hWlF2sZh7byGhIN8F+p6jMeOxH
	HmUZiV9zaNXoqu6+ov+tCBBEQ1xqPMLohstYjD/jPzNdrZX6tm1P6V47dFbU8a+xwEoj/y
	z4EHr/fHlUlO+ZH0+vpkNp+TFqIjYiHfhtXXRH2kdFD+iyugkUDoEV5kY/MMmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718639238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pQRYUOs473EqpQDRpZrtCiEut7g38dXzlHkM6Ny080=;
	b=xcjaRF7SQp/1UaffLlDx9DMpRIaGTHioMReGfejuvNw5xQcfzefHeYsdPJOpRe3S84IMB+
	8y5SQJNlCzDzBUBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: Simplify and clarify
 static_key_fast_inc_cpus_locked()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610124406.548322963@linutronix.de>
References: <20240610124406.548322963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863923833.10875.7483503098942580848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9bc2ff871f00437ad2f10c1eceff51aaa72b478f
Gitweb:        https://git.kernel.org/tip/9bc2ff871f00437ad2f10c1eceff51aaa72b478f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 14:46:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Jun 2024 11:25:24 +02:00

jump_label: Simplify and clarify static_key_fast_inc_cpus_locked()

Make the code more obvious and add proper comments to avoid future head
scratching.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240610124406.548322963@linutronix.de
---
 kernel/jump_label.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 4d06ec2..4ad5ed8 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -162,22 +162,24 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 	if (static_key_fast_inc_not_disabled(key))
 		return true;
 
-	jump_label_lock();
-	if (atomic_read(&key->enabled) == 0) {
-		atomic_set(&key->enabled, -1);
+	guard(mutex)(&jump_label_mutex);
+	/* Try to mark it as 'enabling in progress. */
+	if (!atomic_cmpxchg(&key->enabled, 0, -1)) {
 		jump_label_update(key);
 		/*
-		 * Ensure that if the above cmpxchg loop observes our positive
-		 * value, it must also observe all the text changes.
+		 * Ensure that when static_key_fast_inc_not_disabled() or
+		 * static_key_slow_try_dec() observe the positive value,
+		 * they must also observe all the text changes.
 		 */
 		atomic_set_release(&key->enabled, 1);
 	} else {
-		if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key))) {
-			jump_label_unlock();
+		/*
+		 * While holding the mutex this should never observe
+		 * anything else than a value >= 1 and succeed
+		 */
+		if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key)))
 			return false;
-		}
 	}
-	jump_label_unlock();
 	return true;
 }
 

