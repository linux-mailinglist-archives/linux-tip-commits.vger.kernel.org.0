Return-Path: <linux-tip-commits+bounces-5480-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A9AAF804
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB349E1E19
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C221ABA8;
	Thu,  8 May 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="svLyJTAN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hO6lAxRH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07272153CB;
	Thu,  8 May 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700442; cv=none; b=AZg/NSQpMCnJnXZfJW72eM6k0WEA1Gc2vHvdFG/by/7s7tSJhP73qMU2gnlMWNooDezUh30ZS5phz09aUiXPeRYIyuWG+OalgBMzd6wyX1iph8BuZ8AO2otKEvemNudbpgkgzoYT/UTq81dQe89FcBLlXkwUdCIQbKCcQonx/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700442; c=relaxed/simple;
	bh=E3gTllr6M/bSxgfEWpyw0C9KFSbOix/pX2MysmWgCQs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h2j7y2yWtkWU6EVopG2Ycr9pNIqYGRticHa4mwOWaJh+L3C7Yi3X8ekczJ5CtbbP6df8iNGCDgi+4AVbRWxUye6LqYGMfR8UVaCYCPn7RQk99xmJMrBwWUWShCzxS7cpKI9DvnpGCqEj12AMIbOKjGaHAtMtSfwl/feTHL7lJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=svLyJTAN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hO6lAxRH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErtzgTdqvJrBSVxY3pVGHaa6HrQHUQ+PJ1JbBc1xP5s=;
	b=svLyJTANMd2DNmT/+PViuEe1AfLiZda19geynwgomjIIYU4lFAcw+s2AbcgVrmcgbywZ8q
	b/Ce1vblgEXU6K5H+IvfaHk5fQjsOOPOK3jkGeOuWjjkWClPhO5zvezk1+veAEMl8BLSP8
	7bfcufyzFqiT2RBC9XP5PEE7FJ4SvTDpgykqHw3o57c3NJU6PlswW4C7l3NAga4ccG1mx/
	g5iilBfwPyqND/WFFp6/T6KFowyuaGQtoayhlhCEax1clB9NIxB6z82WPtc75bvaoyfh3f
	iC205EYa+3eiFtcTg3hRfu0tLD++NgUmB9yW5VzjwToyza/AjLNGClpBPJLrVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErtzgTdqvJrBSVxY3pVGHaa6HrQHUQ+PJ1JbBc1xP5s=;
	b=hO6lAxRHaGyh80ZvVQuZ1JCPvq2C+/i06dPuHPYPwjd1qclY1HHo8RQ2OkmaQPQtaepgyX
	nP3dCZBAuhHUG2Cw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Create private_hash() get/put class
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-8-bigeasy@linutronix.de>
References: <20250416162921.513656-8-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043627.406.8429793484565476771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     d854e4e7850e6d3ed24f863a877abc2279d60506
Gitweb:        https://git.kernel.org/tip/d854e4e7850e6d3ed24f863a877abc2279d60506
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 18:29:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:06 +02:00

futex: Create private_hash() get/put class

This gets us:

  fph = futex_private_hash(key) /* gets fph and inc users */
  futex_private_hash_get(fph)   /* inc users */
  futex_private_hash_put(fph)   /* dec users */

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-8-bigeasy@linutronix.de
---
 kernel/futex/core.c  | 12 ++++++++++++
 kernel/futex/futex.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 56a5653..6a1d6b1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -107,6 +107,18 @@ late_initcall(fail_futex_debugfs);
 
 #endif /* CONFIG_FAIL_FUTEX */
 
+struct futex_private_hash *futex_private_hash(void)
+{
+	return NULL;
+}
+
+bool futex_private_hash_get(struct futex_private_hash *fph)
+{
+	return false;
+}
+
+void futex_private_hash_put(struct futex_private_hash *fph) { }
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 77d9b35..bc76e36 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -206,10 +206,18 @@ extern struct futex_hash_bucket *futex_hash(union futex_key *key);
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 
+extern struct futex_private_hash *futex_private_hash(void);
+extern bool futex_private_hash_get(struct futex_private_hash *fph);
+extern void futex_private_hash_put(struct futex_private_hash *fph);
+
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
 	     if (_T) futex_hash_put(_T),
 	     futex_hash(key), union futex_key *key);
 
+DEFINE_CLASS(private_hash, struct futex_private_hash *,
+	     if (_T) futex_private_hash_put(_T),
+	     futex_private_hash(), void);
+
 /**
  * futex_match - Check whether two futex keys are equal
  * @key1:	Pointer to key1

