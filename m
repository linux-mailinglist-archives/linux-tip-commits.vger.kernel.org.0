Return-Path: <linux-tip-commits+bounces-3199-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8749A0A3D5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Jan 2025 14:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE30716A705
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Jan 2025 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E8192D7C;
	Sat, 11 Jan 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENvDE16V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3+dimY5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D951EB2F;
	Sat, 11 Jan 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601689; cv=none; b=BgRlvY5d6fUhOrego5gLkLAqcBKMHs4UgLEINDReoZXf07KWaK2hNd+JurZTxxgYjhGqw1VB7afGrtHpIIt43+YYJbzy7nCSyp9qoGJ2kOfniHkz+9Z014IjTmEUHmK7QvP3t7pw5fQEeW0x1EvNNKTgNx2fCSFnjhndB/oD4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601689; c=relaxed/simple;
	bh=R7Yt9tAnOLi3UCYYK0C0Pff5kFguXKeqKD/mebRs5lw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IdWHGXsP6WDyOlaLOknYC1cgHKuF4qcc26McG6EvM9jsixMQ/azv1gTihpkwbHclxF/UKs0f+udby1n2xP4ivIWMT6n25fLhvp0BiH9zkmQdQk8PL6t70YrSctV5slTNrca5MSy4Z3+RC8clvcuUjRnTqNyYvVUpz0ySdHVhcAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENvDE16V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3+dimY5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 11 Jan 2025 13:21:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736601680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZOQEDh7aP7e3izsiFi6eeTrGM2r139v0l5fpS/OBWw=;
	b=ENvDE16VRAHdN/DAN1ovA2yURFSptt0cBUxfQL5VZDf47byAh+syLFS0m1vx9p5g1Pikxs
	cyVTgvRkJ7Ar9LmYBH3Te7t4GxUWB55OkB+5qOk9DWoi3NSlqKX7RgA8fsQifp4zrQj/VZ
	A4BuKdACM6H1gcw1/xyAKq5k7DrdW2mrz87AOlEl6QGiciRy+rOE40J6GSo5STt9M/ojNt
	uDB8LsMGDrvZmzJ20hbtQzl1x/FXy9e9iwfggYEUUK/r3FQEibWBcsujfp/y3Oo4PzMfH6
	ShhFkfpS48lmI6yRWkQTUyJ0gski9dVd6SngPjc5OBdW7uboeTGjFhu89c7B6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736601680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZOQEDh7aP7e3izsiFi6eeTrGM2r139v0l5fpS/OBWw=;
	b=L3+dimY5EJnEFMkZSLiEh4cqlHEFz8xCUkCY9ICNzaJ3kW4u7Xup90V44DeDk0Bqt4F4Ph
	8joMmPJpWWvFH9CQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] cleanup, tags: Create tags for the cleanup primitives
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250106102647.GB20870@noisy.programming.kicks-ass.net>
References: <20250106102647.GB20870@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173660167953.399.4769008465233152772.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a937f384c9da493e526ad896ef4e8054526d2941
Gitweb:        https://git.kernel.org/tip/a937f384c9da493e526ad896ef4e8054526d2941
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 06 Jan 2025 11:26:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jan 2025 18:16:48 +01:00

cleanup, tags: Create tags for the cleanup primitives

Oleg reported that it is hard to find the definition of things like:
__free(argv) without having to do 'git grep "DEFINE_FREE(argv,"'.

Add tag generation for the various macros in cleanup.h.

Notably 'DEFINE_FREE(argv, ...)' will now generate a 'cleanup_argv'
tag, while all the others, eg. 'DEFINE_GUARD(mutex, ...)' will
generate 'class_mutex' like tags.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250106102647.GB20870@noisy.programming.kicks-ass.net
---
 scripts/tags.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index b212363..7939aea 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -212,6 +212,13 @@ regex_c=(
 	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
 	'/^\<DECLARE_IDTENTRY[[:alnum:]_]*([^,)]*,[[:space:]]*\([[:alnum:]_]\+\)/\1/'
 	'/^\<DEFINE_IDTENTRY[[:alnum:]_]*([[:space:]]*\([[:alnum:]_]\+\)/\1/'
+	'/^\<DEFINE_FREE(\([[:alnum:]_]\+\)/cleanup_\1/'
+	'/^\<DEFINE_CLASS(\([[:alnum:]_]\+\)/class_\1/'
+	'/^\<EXTEND_CLASS(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]_]\+\)/class_\1\2/'
+	'/^\<DEFINE_GUARD(\([[:alnum:]_]\+\)/class_\1/'
+	'/^\<DEFINE_GUARD_COND(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]_]\+\)/class_\1\2/'
+	'/^\<DEFINE_LOCK_GUARD_[[:digit:]](\([[:alnum:]_]\+\)/class_\1/'
+	'/^\<DEFINE_LOCK_GUARD_[[:digit:]]_COND(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]_]\+\)/class_\1\2/'
 )
 regex_kconfig=(
 	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/\2/'

