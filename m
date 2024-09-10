Return-Path: <linux-tip-commits+bounces-2291-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E8973182
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73192899F7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0292194082;
	Tue, 10 Sep 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oemBf7qJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8TGZbSO+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED6190074;
	Tue, 10 Sep 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962878; cv=none; b=XWY6LE0ArBlF3znDnBrXHk/KRmfLY4wXu7Fy2cjp3ALhfuaKV8jq6noJjdhOfrxjGdSae809YC5ISQDUvG2SkMXn4+PIhWqgtsHI96tA+gHC5+0vMUlWe/2l5CXIUbo7BA2hVRrPOlEoqyZnFqUramlnZ/W9926w4OxONyAbrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962878; c=relaxed/simple;
	bh=HXGIXvT4Mg1JvBWlDUbtIpYtc/x4rAIrhQ0pteKJ3Kc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=X5FW/aM3JWzzM3h9FEHZL6fZBE/+VtGI4a4DmWjDahDH69G6EuMOJtJKMaoCv9hnOFMG507oAZm6m63zgKUSpyUcQqZtCc34pJsKM3rVyGvvrKUXPXiKRzQPbYCRSvQ7yDrqRQtNXs3kCcB/S4ggt7UtEgz3r5G4vtybKACCtGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oemBf7qJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8TGZbSO+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 10:07:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725962875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gRZ4wIfeScH7aLTw7CdBGX4GJDjEr4b+V75YJtLxfxA=;
	b=oemBf7qJIPlHs3+NbS4QQRJkEM9Lx4eh4tla2i5QteS2kIQulCrg0sSkMIccDim95/Uotc
	mzaq1TOpLUB4hSecccnn2a/lCs0h+XTuMGtL/tM9rN66IqQEIyC0qYjS0VnPHr2FAcMEZF
	UBkro8wA3ZUgZ80S2yGMs6jKpdUxKCD//XmyHCljCwozju+TZQMZSB1ZM+GP9Io4uViS08
	l+fZsVRhI7/QjuyrULw/Fgki80zYcbQz72J2yNCCLJW7iaKxS3wDM7BcdOGfqX0tZRToNJ
	3Ndz05zmMJOOB6OqKVA7ACpU24O6Yhzn+Er/OLuQ6GSL8ZTfMyXaaP0CGpio/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725962875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gRZ4wIfeScH7aLTw7CdBGX4GJDjEr4b+V75YJtLxfxA=;
	b=8TGZbSO+x7kq8WEkI08qYrklJgxHHWyZmZOF33wJNqWxN3ryziNNnxZ75HCI8ttg3JSl4l
	NJA9/WNQBLVkcEAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] jump_label: Fix static_key_slow_dec() yet again
Cc: "Darrick J. Wong" <djwong@kernel.org>, Klara Modin <klarasmodin@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172596287428.2215.9084766148871764323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     1d7f856c2ca449f04a22d876e36b464b7a9d28b6
Gitweb:        https://git.kernel.org/tip/1d7f856c2ca449f04a22d876e36b464b7a9d28b6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 09 Sep 2024 12:50:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 11:57:27 +02:00

jump_label: Fix static_key_slow_dec() yet again

While commit 83ab38ef0a0b ("jump_label: Fix concurrency issues in
static_key_slow_dec()") fixed one problem, it created yet another,
notably the following is now possible:

  slow_dec
    if (try_dec) // dec_not_one-ish, false
    // enabled == 1
                                slow_inc
                                  if (inc_not_disabled) // inc_not_zero-ish
                                  // enabled == 2
                                    return

    guard((mutex)(&jump_label_mutex);
    if (atomic_cmpxchg(1,0)==1) // false, we're 2

                                slow_dec
                                  if (try-dec) // dec_not_one, true
                                  // enabled == 1
                                    return
    else
      try_dec() // dec_not_one, false
      WARN

Use dec_and_test instead of cmpxchg(), like it was prior to
83ab38ef0a0b. Add a few WARNs for the paranoid.

Fixes: 83ab38ef0a0b ("jump_label: Fix concurrency issues in static_key_slow_dec()")
Reported-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/jump_label.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 6dc76b5..93a822d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -168,7 +168,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 		jump_label_update(key);
 		/*
 		 * Ensure that when static_key_fast_inc_not_disabled() or
-		 * static_key_slow_try_dec() observe the positive value,
+		 * static_key_dec_not_one() observe the positive value,
 		 * they must also observe all the text changes.
 		 */
 		atomic_set_release(&key->enabled, 1);
@@ -250,7 +250,7 @@ void static_key_disable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-static bool static_key_slow_try_dec(struct static_key *key)
+static bool static_key_dec_not_one(struct static_key *key)
 {
 	int v;
 
@@ -274,6 +274,14 @@ static bool static_key_slow_try_dec(struct static_key *key)
 		 * enabled. This suggests an ordering problem on the user side.
 		 */
 		WARN_ON_ONCE(v < 0);
+
+		/*
+		 * Warn about underflow, and lie about success in an attempt to
+		 * not make things worse.
+		 */
+		if (WARN_ON_ONCE(v == 0))
+			return true;
+
 		if (v <= 1)
 			return false;
 	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
@@ -284,15 +292,27 @@ static bool static_key_slow_try_dec(struct static_key *key)
 static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	lockdep_assert_cpus_held();
+	int val;
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
+	val = atomic_read(&key->enabled);
+	/*
+	 * It should be impossible to observe -1 with jump_label_mutex held,
+	 * see static_key_slow_inc_cpuslocked().
+	 */
+	if (WARN_ON_ONCE(val == -1))
+		return;
+	/*
+	 * Cannot already be 0, something went sideways.
+	 */
+	if (WARN_ON_ONCE(val == 0))
+		return;
+
+	if (atomic_dec_and_test(&key->enabled))
 		jump_label_update(key);
-	else
-		WARN_ON_ONCE(!static_key_slow_try_dec(key));
 }
 
 static void __static_key_slow_dec(struct static_key *key)
@@ -329,7 +349,7 @@ void __static_key_slow_dec_deferred(struct static_key *key,
 {
 	STATIC_KEY_CHECK_USE(key);
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	schedule_delayed_work(work, timeout);

