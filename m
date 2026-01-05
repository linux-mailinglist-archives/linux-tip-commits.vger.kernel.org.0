Return-Path: <linux-tip-commits+bounces-7796-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74136CF4ADE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A330A3032976
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2F2345CD0;
	Mon,  5 Jan 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WkDi7oF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8GDh4Nby"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C13446C6;
	Mon,  5 Jan 2026 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628466; cv=none; b=uXQDldfF3+cakcTkHnX+aMygnd33fA0M9Om1IexFS3PZOejJ2rLNAXgAdAxhvpocT3IuFZ5kMtzIBX2WMAcqoUrT/VINQFTPo12nj/b5KMTV0rMBoaRatw9s4jDMQmoBJmMZ/+vXj0SI5YBUxzDPzoGZMhomtd8DXB9jjjCZGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628466; c=relaxed/simple;
	bh=/1sOBlTpgBBYTWYds1WIUh67lSTk9Wum5lC9ltQyvgY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=chhQ/9VsgqxAOT8wKPR0BtWw88XeJXKVNtHiZGngboagHAGFMqexE8d49G0/0eYHIYGjZTjhtgv1GwFOxJnng0gSNu0ux0W4ULa+BH7fVSIftZ4LBc9pc/K5GE8URq1/1a8QA9svbQC4RPuA6HhEI20hrVAPq+YkUAwDLLxmYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WkDi7oF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8GDh4Nby; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL4TwgSWjQKJtF2W3MR6DZdH7z6zLTeJrBQfpX5nIUk=;
	b=0WkDi7oFkEIK/hRiE3HtbFKd9GSvomN5CHIZDn/J+XnAlrFpx0+n1zB/gp3ZTQNgEI5UU8
	y1/QmRraVOJBlq07Ss1AAT28H6mWWfuby0SaqXDA28f0LzGhYpN/FV2m/MEB+165apc4XB
	XAzY5ZpFbCCW4ly001yXFvkmjWth9IQKE3f8UKCys6vT5KtiNaGEegM7IdzGhRr8P3pp0u
	9EHEHL0zaig/03bC0940p5IQotuiwpDAK7jI3B+IXVN4vY0lavRZMr9HpHNmo09Fv6PCga
	E+SEBwAknnYwRfL7ApnfZWIuWjW35Fuy/6sp/IDFRAT3zFlFHoituDWiWTU+Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL4TwgSWjQKJtF2W3MR6DZdH7z6zLTeJrBQfpX5nIUk=;
	b=8GDh4NbyrPjtvMpGUjnZQyj7rB+mFOJCgFVBgkDMD3xbVQEy0RhGc4V5RKcGHpy8/WTtC3
	JMRTqvKk21fxhPBg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] compiler: Let data_race() imply disabled context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-27-elver@google.com>
References: <20251219154418.3592607-27-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846088.510.2120927185812788776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3635ad878242487fc3e8165d0329aedb118e4608
Gitweb:        https://git.kernel.org/tip/3635ad878242487fc3e8165d0329aedb118=
e4608
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:34 +01:00

compiler: Let data_race() imply disabled context analysis

Many patterns that involve data-racy accesses often deliberately ignore
normal synchronization rules to avoid taking a lock.

If we have a lock-guarded variable on which we do a lock-less data-racy
access, rather than having to write context_unsafe(data_race(..)),
simply make the data_race(..) macro imply context-unsafety. The
data_race() macro already denotes the intent that something subtly
unsafe is about to happen, so it should be clear enough as-is.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-27-elver@google.com
---
 include/linux/compiler.h    | 2 ++
 lib/test_context-analysis.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 04487c9..110b28d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -190,7 +190,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, i=
nt val,
 #define data_race(expr)							\
 ({									\
 	__kcsan_disable_current();					\
+	disable_context_analysis();					\
 	auto __v =3D (expr);						\
+	enable_context_analysis();					\
 	__kcsan_enable_current();					\
 	__v;								\
 })
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 2dc4044..1c5a381 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -92,6 +92,8 @@ static void __used test_raw_spinlock_trylock_extra(struct t=
est_raw_spinlock_data
 {
 	unsigned long flags;
=20
+	data_race(d->counter++); /* no warning */
+
 	if (raw_spin_trylock_irq(&d->lock)) {
 		d->counter++;
 		raw_spin_unlock_irq(&d->lock);

