Return-Path: <linux-tip-commits+bounces-3627-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE4A45064
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 23:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C5D188F01E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856B221571;
	Tue, 25 Feb 2025 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MpD9HNve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UOXBp6L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DFE221562;
	Tue, 25 Feb 2025 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523267; cv=none; b=goI5Cdmj6bw4OQC4SzFe8P8H9bAwt06fNrmn0B2RzY0hApH9cAFJXKVWNaDccXOw39VRAg86dG92B3YuMJR68eYUKFm9gwUpM3UouiXWtJd5Ova6MRmKga37p+4re/BWSdqfR7PLyl9b9JigdcZGnW7jmgFrtzdpTqaj8N3AhHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523267; c=relaxed/simple;
	bh=sHLceq7Gkv7gtVOjZn9zflNF+6VX1dTX67XKwz8Pu0I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kG1jWIbLVHt4A6HvC9AaiMwPUUPsI3MxKqH3gk7R9H2s0O7cwQUI79IGZgJMjXTRJqpawwVHFUeeFhRrmtRjn+bvrYvw4RGeig7i3Nmeo7eu+cnF9bgUcGNs4zxJlGhtC7nJW674u4daw7tRwb0pork72YxTY4PImlhLyqmWQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MpD9HNve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UOXBp6L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 22:41:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740523263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NueTLAC6VsVDBBnGc27EBd8kAF48flEAgeAcX3ZY5f4=;
	b=MpD9HNve/RXGeLcDHwEoY9oyhVYSjhEcaq1RDq57ylD1sdqxLyDjzfik5zS+AJrRARYiG9
	Na9oriVSFMiYSUeUawyQQToSVCRyI0gLB3L/47QDPKeJorJ9zgyZtXNhe7jERZljxIByO9
	psI0WvcJHVzhI6GhdUdDVfZQh033wLtFgg83n2ryJie06DIXgz/Yy4rPyHKHcEboyQ2yal
	FHn4BM+SagS7E/612LVhfrXgBCd6Joe07XyUfxZmXnslbiylMEUH+6os0S1mlDuyRxyMqg
	Cb5tuhLWfIdm++Gz+ES15DiCHV5XSYyoeklpnLGiumLwjfpxVijr2LZ4CmzSXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740523263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NueTLAC6VsVDBBnGc27EBd8kAF48flEAgeAcX3ZY5f4=;
	b=0UOXBp6L+O3kHmGPa/HELfmMPTXv0AIdyjZfs7AdN6BejD/zlUvz5tXHcz9kN9OfhmEJMH
	LLYRbfHgRZIIcRCQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] uprobes: Remove too strict lockdep_assert()
 condition in hprobe_expire()
Cc: Breno Leitao <leitao@debian.org>, Andrii Nakryiko <andrii@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250225223214.2970740-1-andrii@kernel.org>
References: <20250225223214.2970740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174052326196.10177.3535848068595267390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f8c857238a392f21d5726d07966f6061007c8d4f
Gitweb:        https://git.kernel.org/tip/f8c857238a392f21d5726d07966f6061007c8d4f
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Tue, 25 Feb 2025 14:32:14 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 23:36:19 +01:00

uprobes: Remove too strict lockdep_assert() condition in hprobe_expire()

hprobe_expire() is used to atomically switch pending uretprobe instance
(struct return_instance) from being SRCU protected to be refcounted.
This can be done from background timer thread, or synchronously within
current thread when task is forked.

In the former case, return_instance has to be protected through RCU read
lock, and that's what hprobe_expire() used to check with
lockdep_assert(rcu_read_lock_held()).

But in the latter case (hprobe_expire() called from dup_utask()) there
is no RCU lock being held, and it's both unnecessary and incovenient.
Inconvenient due to the intervening memory allocations inside
dup_return_instance()'s loop. Unnecessary because dup_utask() is called
synchronously in current thread, and no uretprobe can run at that point,
so return_instance can't be freed either.

So drop rcu_read_lock_held() condition, and expand corresponding comment
to explain necessary lifetime guarantees. lockdep_assert()-detected
issue is a false positive.

Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250225223214.2970740-1-andrii@kernel.org
---
 kernel/events/uprobes.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index af53fbd..b4ca889 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -767,10 +767,14 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
 	enum hprobe_state hstate;
 
 	/*
-	 * return_instance's hprobe is protected by RCU.
-	 * Underlying uprobe is itself protected from reuse by SRCU.
+	 * Caller should guarantee that return_instance is not going to be
+	 * freed from under us. This can be achieved either through holding
+	 * rcu_read_lock() or by owning return_instance in the first place.
+	 *
+	 * Underlying uprobe is itself protected from reuse by SRCU, so ensure
+	 * SRCU lock is held properly.
 	 */
-	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
+	lockdep_assert(srcu_read_lock_held(&uretprobes_srcu));
 
 	hstate = READ_ONCE(hprobe->state);
 	switch (hstate) {

