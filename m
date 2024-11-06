Return-Path: <linux-tip-commits+bounces-2756-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F89BE498
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FC21C21D46
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6121DE2C6;
	Wed,  6 Nov 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3bWxbn3T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jt7mvqZ4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4CB1DA622;
	Wed,  6 Nov 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890065; cv=none; b=dy/AbzprGSCK1iaTdXMyr0c0TxOK2+xggbOdv5KvjIf85sXagmKonRnpn7EqOo/S0PvajLwSAp8BuAf3agFnVgTCySSugaPHv+BF1HUYvrlbykFhe0glwE4cwU0vgqOSLD6GppDd8rxPSqI7nuTeKTBHdM56xnitNTlVbyvUtc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890065; c=relaxed/simple;
	bh=JAariSHFvtfO//5iJJB95MJtSZTrSQc0GI0d7GPbotI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a7zC/PUAoTjiCf4O6IQlrMGJTkrkJtKiI2ujqZPMhAusUg5T/pXnVZlMGD0Zvd4AmFrMisGYjNN0histkinKjxS3bSxcqmdp4qYoMBvFSz8YgD2OF7dPXbVBheA5OhQ4Tq27SW2D7chTr9Tk82cuBHsGKCoyk7XZ6cbiDYs4sL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3bWxbn3T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jt7mvqZ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWV+t4MCgokZ/ftgwmpIPFZrqvMJZI9ZE5l8vgBVPE=;
	b=3bWxbn3TXlZx+8fPaD3prAXLFCMucUR/mIkHjS7tzG646bDEtY1a+SU3uCF4KCd44TRWMT
	wwGi2bMHtAGntN8jaWUSYeLPZcEOCGwNpZAj8gE1fh2M4yjLb8PNilEUD781iKnEwybdgl
	svToe1j3cPV0Vbv8nY5hzN9POE37OK9Hg+1ky7mAaPGG/JNcurVUYnVOCL0dJrob7gi5sL
	LD6Pfe9djYFujEaH1vRLv9zXKodHnAJ1hfce/F/0asi0roF4qLMz/jvpiku8PgkIf/kMBi
	nhlxFHRdgkSQ074IwxC6fCUSloYyrjyBjlHxNL+PqXmbrCUAzaC+ELvK+bTkxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWV+t4MCgokZ/ftgwmpIPFZrqvMJZI9ZE5l8vgBVPE=;
	b=jt7mvqZ4NAVmhieewZN/IF4Kst5ujQ1+BgmpVrOQvpF1rF6r8DX+H+dJAWHSFrG/PMRs/E
	FJoJWx6ctZ5KKRBw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan, seqlock: Fix incorrect assumption in
 read_seqbegin()
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241104161910.780003-6-elver@google.com>
References: <20241104161910.780003-6-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089006070.32228.15660437792189899549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     183ec5f26b2fc97a4a9871865bfe9b33c41fddb2
Gitweb:        https://git.kernel.org/tip/183ec5f26b2fc97a4a9871865bfe9b33c41fddb2
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 04 Nov 2024 16:43:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:35 +01:00

kcsan, seqlock: Fix incorrect assumption in read_seqbegin()

During testing of the preceding changes, I noticed that in some cases,
current->kcsan_ctx.in_flat_atomic remained true until task exit. This is
obviously wrong, because _all_ accesses for the given task will be
treated as atomic, resulting in false negatives i.e. missed data races.

Debugging led to fs/dcache.c, where we can see this usage of seqlock:

	struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
	{
		struct dentry *dentry;
		unsigned seq;

		do {
			seq = read_seqbegin(&rename_lock);
			dentry = __d_lookup(parent, name);
			if (dentry)
				break;
		} while (read_seqretry(&rename_lock, seq));
	[...]

As can be seen, read_seqretry() is never called if dentry != NULL;
consequently, current->kcsan_ctx.in_flat_atomic will never be reset to
false by read_seqretry().

Give up on the wrong assumption of "assume closing read_seqretry()", and
rely on the already-present annotations in read_seqcount_begin/retry().

Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241104161910.780003-6-elver@google.com
---
 include/linux/seqlock.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 45eee0e..5298765 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -810,11 +810,7 @@ static __always_inline void write_seqcount_latch_end(seqcount_latch_t *s)
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	unsigned ret = read_seqcount_begin(&sl->seqcount);
-
-	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry() */
-	kcsan_flat_atomic_begin();
-	return ret;
+	return read_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -830,12 +826,6 @@ static inline unsigned read_seqbegin(const seqlock_t *sl)
  */
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
-	/*
-	 * Assume not nested: read_seqretry() may be called multiple times when
-	 * completing read critical section.
-	 */
-	kcsan_flat_atomic_end();
-
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 

