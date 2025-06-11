Return-Path: <linux-tip-commits+bounces-5773-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3C6AD5A2F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CADC1E0CEA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A46A1C8606;
	Wed, 11 Jun 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qaab39/p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzJEP0FE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B71C6FE9;
	Wed, 11 Jun 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654943; cv=none; b=u0MbprMvlpvetkJkX2Fa7rT5x+Az00lizxZfbTHzpgArcRdCeOyjmyXjhZOFwBir7t9wz0bFZe3alU3WWgzwtwQxkvyRP5fGqU/1HeSXIbMEF59tHruDhXeZK6Djw64T1eXd3Wq27kz9+U+sjfPmC73d8UgLyJKzZwiR/KNtmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654943; c=relaxed/simple;
	bh=032bhY7AgZpJmvzjgqpVwjt4tQt+F+MwrCwmvM6koLY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=eq+uqNeeqcr2lp+v0zYXck3GQIYmSVhg9CR48VwBOILbGgiejndCxA1FWLanArPcvXouo6Rp0sOnj98ire/AwaeZ4Sxa0/7thisKdAw7W+g9Wt54ejhITf9mIv42mmSiAGFZQsoCU+vc2pEYIROVvqvxm1NncJFEsSMi8b4Xyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qaab39/p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzJEP0FE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 15:15:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749654940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YoIfmvcRvHtmdybdTEQ9WBjWfBIgG87qTRkyrDtq+Lc=;
	b=Qaab39/pbsbs5+Kk/myO2odjK3Nj7XgSN/PwOYnVhjsY6JtAHLsk2Hl84xmX8iSZT0wSGy
	DE6i+Ur6eAbwk10fLYGDroY9WXlMrrbx59SUsTtXxYRy0zBdEvTKzawNoTrpB09d/IX2M7
	YvElnAY7JQgs+VbLJ7czehhEOEV6E+vum34Vjg9oOe7mz2puBqxHqidiBclrPI4e0I54Qf
	gm54jA4M/3NbM6rCtnxh2YXYpmXraZAgew3ONz42RoVrNZs+CV0zVXmkuMBB6BIyskNVpy
	TSZz29M30RF4rjFbGo/3vk4/Q191pL4vyouX++nc643ukRGbBq7sj5P1Ri1stQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749654940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YoIfmvcRvHtmdybdTEQ9WBjWfBIgG87qTRkyrDtq+Lc=;
	b=EzJEP0FE0NtGL0U7A6Bv7tFAmWMcN/pHA0XKrouiaFndtybBkGe8802WsH2rraBAkunTRj
	KCTHGlzpxbonoyBg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] futex: Verify under the lock if hash can be replaced
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174965493896.406.142707070957914445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     b9163c452ae0d155c39f4549b56fae7eb34c59af
Gitweb:        https://git.kernel.org/tip/b9163c452ae0d155c39f4549b56fae7eb34c59af
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 02 Jun 2025 13:00:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 17:08:37 +02:00

futex: Verify under the lock if hash can be replaced

Once the global hash is requested there is no way back to switch back to
the per-task private hash. This is checked at the begin of the function.

It is possible that two threads simultaneously request the global hash
and both pass the initial check and block later on the
mm::futex_hash_lock. In this case the first thread performs the switch
to the global hash. The second thread will also attempt to switch to the
global hash and while doing so, accessing the nonexisting slot 1 of the
struct futex_private_hash.
The same applies if the hash is made immutable: There is no reference
counting and the hash must not be replaced.

Verify under mm_struct::futex_phash that neither the global hash nor an
immutable hash in use.

Tested-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/all/aDwDw9Aygqo6oAx+@ly-workstation/
Fixes: bd54df5ea7cad ("futex: Allow to resize the private local hash")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250610104400.1077266-5-bigeasy@linutronix.de/
---
 kernel/futex/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b652d2f..33b3643 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1629,6 +1629,16 @@ again:
 		mm->futex_phash_new = NULL;
 
 		if (fph) {
+			if (cur && !cur->hash_mask) {
+				/*
+				 * If two threads simultaneously request the global
+				 * hash then the first one performs the switch,
+				 * the second one returns here.
+				 */
+				free = fph;
+				mm->futex_phash_new = new;
+				return -EBUSY;
+			}
 			if (cur && !new) {
 				/*
 				 * If we have an existing hash, but do not yet have

