Return-Path: <linux-tip-commits+bounces-2362-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FDD9941EE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BE828D5BB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5020CCCB;
	Tue,  8 Oct 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjvd5G3p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WhmSgzCX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C551E7C35;
	Tue,  8 Oct 2024 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374186; cv=none; b=O4f1qzDJBSXrijD1S+CLjqryKHUcCGwbT16MviuP+9vVXZ0xYKYTy4rXztVbUiy+p3AwzE5hpJNQz86C5lS4CMZqd+qZPvEoyYVJGIkYKN3u/YaPXf8BdVa5f7P6qlafoRyhSZR8XXPymLCTZI8gwrfzSIJ30PedLDm27/whLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374186; c=relaxed/simple;
	bh=sY6uTHmigIpmqgUSPhA0wdIvRsGFIP2iTUCZgwU5JKU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mjcfb56fvO6UFZV9w7xClg6Q64Uqa1p2C62klC5ywlH1oBxgqnoAw2rbgWCvus4bhbFay6OdsvT85AT4eH6AyuOGuXdYCkkrnC57OLmCk8HoUzylBZkVXc9sSlxC88FdD1pLpEL1mLXQqGeMapckvtB/gSN4P2CUYWEcwJyt6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjvd5G3p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WhmSgzCX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4l8v2PRUpePxp2/Ga72fckaMJZ3LY17iafNAK1Zh+k0=;
	b=gjvd5G3pzEOESWMCLtq1S6ov4TwXmm0vr0AdK0xcjnbUI2UMpzJ6FbDtwvjeWJGBbA+FaO
	ktPgVRDtOSr4HOTWL9ADYvFZFOYMpkrjxQBJmi+cCOlYsgGAbyO5hGpYaMxbRvYyKOn2X/
	UlsfwLpH/gAkwi7XLsHgxR5vxLY8vKRjZnulAVlLO5MB8lHNm8t/YS+9H23/moiozEHES3
	+YnVfzgw811j609d6s7j625ZNxgxF36ldqtfHXcZa6AJzLbyQjdkKnQ9T8CF38vUMxxxcM
	DW38AiBfLKINa2AOCyN/fEQRRR4EwDDL57EmnBWasid7wQUi3jMbkSNRhsH4dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4l8v2PRUpePxp2/Ga72fckaMJZ3LY17iafNAK1Zh+k0=;
	b=WhmSgzCXyitcuMNRHGjckTb9xguH4dHCXdCiZjiF7DS7ty2DwCoV3TErSKcrHQQuQ6rzYQ
	rsjeqHpSjDfS7TAg==
From: "tip-bot2 for NeilBrown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add test_and_clear_wake_up_bit() and
 atomic_dec_and_wake_up()
Cc: NeilBrown <neilb@suse.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240925053405.3960701-5-neilb@suse.de>
References: <20240925053405.3960701-5-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837418287.1442.11736002136656262832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     52d633def56c10fe3e82a2c5d88c3ecb3f4e4852
Gitweb:        https://git.kernel.org/tip/52d633def56c10fe3e82a2c5d88c3ecb3f4e4852
Author:        NeilBrown <neilb@suse.de>
AuthorDate:    Wed, 25 Sep 2024 15:31:41 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:38 +02:00

sched: Add test_and_clear_wake_up_bit() and atomic_dec_and_wake_up()

There are common patterns in the kernel of using test_and_clear_bit()
before wake_up_bit(), and atomic_dec_and_test() before wake_up_var().

These combinations don't need extra barriers but sometimes include them
unnecessarily.

To help avoid the unnecessary barriers and to help discourage the
general use of wake_up_bit/var (which is a fragile interface) introduce
two combined functions which implement these patterns.

Also add store_release_wake_up() which supports the task of simply
setting a non-atomic variable and sending a wakeup.  This pattern
requires barriers which are often omitted.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240925053405.3960701-5-neilb@suse.de
---
 include/linux/wait_bit.h | 60 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 06ec99b..0272629 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -419,4 +419,64 @@ static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
 	wake_up_bit(word, bit);
 }
 
+/**
+ * test_and_clear_wake_up_bit - clear a bit if it was set: wake up anyone waiting on that bit
+ * @bit: the bit of the word being waited on
+ * @word: the address of memory containing that bit
+ *
+ * If the bit is set and can be atomically cleared, any tasks waiting in
+ * wait_on_bit() or similar will be woken.  This call has the same
+ * complete ordering semantics as test_and_clear_bit().  Any changes to
+ * memory made before this call are guaranteed to be visible after the
+ * corresponding wait_on_bit() completes.
+ *
+ * Returns %true if the bit was successfully set and the wake up was sent.
+ */
+static inline bool test_and_clear_wake_up_bit(int bit, unsigned long *word)
+{
+	if (!test_and_clear_bit(bit, word))
+		return false;
+	/* no extra barrier required */
+	wake_up_bit(word, bit);
+	return true;
+}
+
+/**
+ * atomic_dec_and_wake_up - decrement an atomic_t and if zero, wake up waiters
+ * @var: the variable to dec and test
+ *
+ * Decrements the atomic variable and if it reaches zero, send a wake_up to any
+ * processes waiting on the variable.
+ *
+ * This function has the same complete ordering semantics as atomic_dec_and_test.
+ *
+ * Returns %true is the variable reaches zero and the wake up was sent.
+ */
+
+static inline bool atomic_dec_and_wake_up(atomic_t *var)
+{
+	if (!atomic_dec_and_test(var))
+		return false;
+	/* No extra barrier required */
+	wake_up_var(var);
+	return true;
+}
+
+/**
+ * store_release_wake_up - update a variable and send a wake_up
+ * @var: the address of the variable to be updated and woken
+ * @val: the value to store in the variable.
+ *
+ * Store the given value in the variable send a wake up to any tasks
+ * waiting on the variable.  All necessary barriers are included to ensure
+ * the task calling wait_var_event() sees the new value and all values
+ * written to memory before this call.
+ */
+#define store_release_wake_up(var, val)					\
+do {									\
+	smp_store_release(var, val);					\
+	smp_mb();							\
+	wake_up_var(var);						\
+} while (0)
+
 #endif /* _LINUX_WAIT_BIT_H */

