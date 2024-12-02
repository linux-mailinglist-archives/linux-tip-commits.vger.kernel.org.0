Return-Path: <linux-tip-commits+bounces-2899-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1109E002A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 974ECB271C8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E111FDE35;
	Mon,  2 Dec 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bMKkiYU9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dwVqdROb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4C1FDE23;
	Mon,  2 Dec 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138054; cv=none; b=FTy/ik4cOMhEx8ZM07VjbVfNOP7WTJdp7NBqaIWWZUPWhLE02QbO5avna4912CX3AOkX24HmKOttaQ62Ix82x4HZqOEqacAmDXMHgSUL2Wu+zBaZjKMZcoeQmEIYvy24vj3ML5Hop1oZLsoMpqvZ1I4lI0az3RN1Qp5boSFOhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138054; c=relaxed/simple;
	bh=5rUuCE03D/YfBP6wDhi4s9wzDCI3fLHcc3MqcTVpT3c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=loMcFvZsI6MN3g3tJ7nba1hkzVDS+IP1a0MGRxLqmxP7yd/+rq8QJB1j9kVZDmZ0bMi3yzspg20j/AtO+EsS9rpFNjicS8K8E0Kmz9hLJhZ2sVOiVz3yDkcvR+8CaMDLFTMQx7UFJdn1snDY55syifAVS6p1HHG0gPtEZVr6w1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bMKkiYU9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dwVqdROb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbmXCmRuCL+3db+FK15nT8E9qMXHnv6z4GDFXGJ5bHY=;
	b=bMKkiYU9lI3ajSsuzR1Og4VcdMq8EKfHXOscZGmaodBeYMgb8tc2SZpiNYUNULThhQWdYT
	rDOVUUIyPH7TYjT8ja4S5e4LUEfn+DsQyIk2JhDS4j396W2B8qHb86UBVDJBl6iuSdXdrD
	VU4tyV1ucrI2EL1jJgXn0L8KCBKQdrSTqCLq/LoHBMaY2a2B3jP1BfFRirbbIltMv2T45r
	tAtyO02kftrl369s5iSlFeq5Z2PggfM6rQ1wwcJuowq7Q6MTAYPZTpm6PdZlAFk5K28J6r
	0OeEy7lJYIMIFz8ryDu/WDBG7mJHvDIUza/wrmYddd0B7Hl2dwd6Vbv9pY7zQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbmXCmRuCL+3db+FK15nT8E9qMXHnv6z4GDFXGJ5bHY=;
	b=dwVqdRObHUAFNcgX6fjtF81Mzh6IYBKQ4DxJuKmrDzkkBc7Ux06mn1sUv717EJFkkjakKr
	arjmJp/3LgM5WPBg==
From: "tip-bot2 for Suren Baghdasaryan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] mm: introduce mmap_lock_speculate_{try_begin|retry}
Cc: Peter Zijlstra <peterz@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241122174416.1367052-3-surenb@google.com>
References: <20241122174416.1367052-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805013.412.5462710038573020957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     03a001b156d2da186a5618de242750d06bf81e2d
Gitweb:        https://git.kernel.org/tip/03a001b156d2da186a5618de242750d06bf81e2d
Author:        Suren Baghdasaryan <surenb@google.com>
AuthorDate:    Fri, 22 Nov 2024 09:44:16 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:38 +01:00

mm: introduce mmap_lock_speculate_{try_begin|retry}

Add helper functions to speculatively perform operations without
read-locking mmap_lock, expecting that mmap_lock will not be
write-locked and mm is not modified from under us.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Link: https://lkml.kernel.org/r/20241122174416.1367052-3-surenb@google.com
---
 include/linux/mmap_lock.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 9715326..45a21fa 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm)
 {
 	seqcount_init(&mm->mm_lock_seq);
@@ -87,11 +88,39 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
 	do_raw_write_seqcount_end(&mm->mm_lock_seq);
 }
 
-#else
+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	/*
+	 * Since mmap_lock is a sleeping lock, and waiting for it to become
+	 * unlocked is more or less equivalent with taking it ourselves, don't
+	 * bother with the speculative path if mmap_lock is already write-locked
+	 * and take the slow path, which takes the lock.
+	 */
+	return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
+}
+
+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
+{
+	return read_seqcount_retry(&mm->mm_lock_seq, seq);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
-#endif
+
+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	return false;
+}
+
+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
+{
+	return true;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {

