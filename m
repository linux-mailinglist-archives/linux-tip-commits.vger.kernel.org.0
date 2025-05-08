Return-Path: <linux-tip-commits+bounces-5485-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC9AAF80F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2371BC0C6A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CCF21ABAE;
	Thu,  8 May 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MgbzeNIA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6pImrTH5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9A22DA1E;
	Thu,  8 May 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700444; cv=none; b=QzcshEfbZlP9rB1S8JfTx8jt4zjZhXJtqPNKEKGYRNf/zKnQKVSEvvmddsu07odiynvItr2++33JpQ0rG7X934oW0hCrxFhtctE28WXnSil206JCMJY0mjfJQYEeDVo3quqzpNmdHqEsqw/b1zxD+Xpkpx2daBfAKFfAu73/eME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700444; c=relaxed/simple;
	bh=VCdjFDS77ttoqwl817Tw+FsrGK1xNtW3rx5GbVZnqMs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c25aOTOUJ8YT+N83a8Q6MT98qKdiVW7yLgQmkzky28X+0l9wLU7puld8e0tHBCym7Jds0gMg3U046j6MS/NlsZe+lwz4V/O+h9E+eo18ewPJQYD6yenz7Qk5jwK97mTdEbwx+6nwiDjEUCg2hd02QWo62lfw3/F1ezfNFHdyuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MgbzeNIA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6pImrTH5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:34:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700441;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cHj224tdbTypuPW1O8vu2hsaL3Xww5OUPZmqPviusc=;
	b=MgbzeNIAo4s2lN64kQ8F+5xQu4zK0Otbu1SDGe3Jcm9t1SSAJSgWqOCYhsH1qr4aB9PRld
	GGFh+llkOhaSi+mbI8tph56QQfyzrjsVsBzSlxMZUGEkscy4r4fgAkMTNMZAAWvbp48jTH
	vPliT1qx/l5bbeYfrXWfwR/HTFWo9M6+Z36f0Ymon1ILqWFw66Wdczn2mgYsgVksqtIj7S
	Pxqdx5Qbdx2wLHLYiwH+6Pxrat1XwGzcN2KcT8j8jLvnKVYWqHzIG6K4fWU8+YByeSY00v
	1FZ/RWbC7k+3l5UAWDdpoMm5v5nVo/UQa+IKtFMg2rtdFqybVULnkyX9dsfVUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700441;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cHj224tdbTypuPW1O8vu2hsaL3Xww5OUPZmqPviusc=;
	b=6pImrTH5nUXSQYUqrb1Z2StYl5VHZbhc93s5cRvehgPhMjmI/rAwIGSUeSjVQydaxb6IfT
	dWQIT7+he1LTAwDw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] rcuref: Provide rcuref_is_dead()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-2-bigeasy@linutronix.de>
References: <20250416162921.513656-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670044066.406.12184664540495493769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     3efa66ce6ee1b55ab687b316e48e1e9ddc1f780a
Gitweb:        https://git.kernel.org/tip/3efa66ce6ee1b55ab687b316e48e1e9ddc1f780a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:04 +02:00

rcuref: Provide rcuref_is_dead()

rcuref_read() returns the number of references that are currently held.
If 0 is returned then it is not safe to assume that the object ca be
scheduled for deconstruction because it is marked DEAD. This happens if
the return value of rcuref_put() is ignored and assumptions are made.

If 0 is returned then the counter transitioned from 0 to RCUREF_NOREF.
If rcuref_put() did not return to the caller then the counter did not
yet transition from RCUREF_NOREF to RCUREF_DEAD. This means that there
is still a chance that the counter will transition from RCUREF_NOREF to
0 meaning it is still valid and must not be deconstructed. In this brief
window rcuref_read() will return 0.

Provide rcuref_is_dead() to determine if the counter is marked as
RCUREF_DEAD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-2-bigeasy@linutronix.de
---
 include/linux/rcuref.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 6322d8c..2fb2af6 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -30,7 +30,11 @@ static inline void rcuref_init(rcuref_t *ref, unsigned int cnt)
  * rcuref_read - Read the number of held reference counts of a rcuref
  * @ref:	Pointer to the reference count
  *
- * Return: The number of held references (0 ... N)
+ * Return: The number of held references (0 ... N). The value 0 does not
+ * indicate that it is safe to schedule the object, protected by this reference
+ * counter, for deconstruction.
+ * If you want to know if the reference counter has been marked DEAD (as
+ * signaled by rcuref_put()) please use rcuread_is_dead().
  */
 static inline unsigned int rcuref_read(rcuref_t *ref)
 {
@@ -40,6 +44,22 @@ static inline unsigned int rcuref_read(rcuref_t *ref)
 	return c >= RCUREF_RELEASED ? 0 : c + 1;
 }
 
+/**
+ * rcuref_is_dead -	Check if the rcuref has been already marked dead
+ * @ref:		Pointer to the reference count
+ *
+ * Return: True if the object has been marked DEAD. This signals that a previous
+ * invocation of rcuref_put() returned true on this reference counter meaning
+ * the protected object can safely be scheduled for deconstruction.
+ * Otherwise, returns false.
+ */
+static inline bool rcuref_is_dead(rcuref_t *ref)
+{
+	unsigned int c = atomic_read(&ref->refcnt);
+
+	return (c >= RCUREF_RELEASED) && (c < RCUREF_NOREF);
+}
+
 extern __must_check bool rcuref_get_slowpath(rcuref_t *ref);
 
 /**

