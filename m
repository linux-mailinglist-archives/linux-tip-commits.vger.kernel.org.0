Return-Path: <linux-tip-commits+bounces-7791-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA52CF48DB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8947130AB2CF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DEC33DEF3;
	Mon,  5 Jan 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iPbUw8x0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="acpnrDNg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07433A9D2;
	Mon,  5 Jan 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628461; cv=none; b=rAn/dIiilX4gfA2tGxeiotYxg5+6L7vRAgvefqQOL7rDMkknAN/jMoqISPBv1/EYhiCpGpMP1bllpeExwFxVEFufVkGU1Flxq9C5KWRFcJ+Z8XBjSpWg1ng4ajuDx2IwvyEmixmEWmwsWH4RGtg+LRBUGoePaljRMKGMITTnlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628461; c=relaxed/simple;
	bh=5CLC/8i0QYlmUXp6O8EHOkDxTAJdroYArL2acQDsfhk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oiM6oZuDTAzVTGaTJV4IgorgkEnGTIKQep7PVoCYUF8feuZfTyuNkmP0tZjAuQ/FiqTHvUSelnqBkj8+ObC/+EHssDg4LGwiqLvGg72V2Pbg19FCF0/x7qbALWXpV8UzalFqcDcdlSG32LTFb3GqmnIwoPBrjjJXkPCqOmldUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iPbUw8x0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=acpnrDNg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyE3XCDgeXp2gzLqg1L1CKLEVVXj0H0vv/+jVbbmcRo=;
	b=iPbUw8x0Z8uHhIvSbMmzLbdT3zSI06M7mmtQWCmHsMCVuYcXsTjLV8Vs1kET2lXMDy5ts2
	+YQHnF9RCfSjsWZnZs6k7pI/hJWqaiAJ5+xmrHEi4MlpG1PLigcW4HoXYWz/e7bkh2e/4I
	Gc5+0tbfyBYCo1ePoCKSwtmxeZooNsfccnYvxlKScMJCXq9ESivRi8qInqHW9NdWlOp+MI
	obvU1EGUwvy3nSCL6rb601tOc7SmXGEvYmWUooLLxq7C774xvVeffIyVFVXSTsKQmgMCey
	yZrsdeoD1+HfaSr1FaV38WOLMTF3zWcEGmjnLwi78t3hZ1wYZqwXk2P7bw3J7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyE3XCDgeXp2gzLqg1L1CKLEVVXj0H0vv/+jVbbmcRo=;
	b=acpnrDNgUv43oJcv1XQg3QyHtTmC+Lr/QR3uHD7YFuq88UVz2CDyqcwdJSUd0xCsCKDJHO
	NkW6qobLviquXUDw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Enable context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-31-elver@google.com>
References: <20251219154418.3592607-31-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762845638.510.4042540741478938936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0eaa911f890812a7868a44bbfd656636b2c7caf8
Gitweb:        https://git.kernel.org/tip/0eaa911f890812a7868a44bbfd656636b2c=
7caf8
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:35 +01:00

kcsan: Enable context analysis

Enable context analysis for the KCSAN subsystem.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-31-elver@google.com
---
 kernel/kcsan/Makefile |  2 ++
 kernel/kcsan/report.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index a45f3df..824f30c 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+CONTEXT_ANALYSIS :=3D y
+
 KCSAN_SANITIZE :=3D n
 KCOV_INSTRUMENT :=3D n
 UBSAN_SANITIZE :=3D n
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index e95ce7d..11a48b7 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -116,6 +116,7 @@ static DEFINE_RAW_SPINLOCK(report_lock);
  * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
  */
 static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
+	__must_hold(&report_lock)
 {
 	struct report_time *use_entry =3D &report_times[0];
 	unsigned long invalid_before;
@@ -366,6 +367,7 @@ static int sym_strcmp(void *addr1, void *addr2)
=20
 static void
 print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned l=
ong reordered_to)
+	__must_hold(&report_lock)
 {
 	stack_trace_print(stack_entries, num_entries, 0);
 	if (reordered_to)
@@ -373,6 +375,7 @@ print_stack_trace(unsigned long stack_entries[], int num_=
entries, unsigned long=20
 }
=20
 static void print_verbose_info(struct task_struct *task)
+	__must_hold(&report_lock)
 {
 	if (!task)
 		return;
@@ -389,6 +392,7 @@ static void print_report(enum kcsan_value_change value_ch=
ange,
 			 const struct access_info *ai,
 			 struct other_info *other_info,
 			 u64 old, u64 new, u64 mask)
+	__must_hold(&report_lock)
 {
 	unsigned long reordered_to =3D 0;
 	unsigned long stack_entries[NUM_STACK_ENTRIES] =3D { 0 };
@@ -496,6 +500,7 @@ static void print_report(enum kcsan_value_change value_ch=
ange,
 }
=20
 static void release_report(unsigned long *flags, struct other_info *other_in=
fo)
+	__releases(&report_lock)
 {
 	/*
 	 * Use size to denote valid/invalid, since KCSAN entirely ignores
@@ -507,13 +512,11 @@ static void release_report(unsigned long *flags, struct=
 other_info *other_info)
=20
 /*
  * Sets @other_info->task and awaits consumption of @other_info.
- *
- * Precondition: report_lock is held.
- * Postcondition: report_lock is held.
  */
 static void set_other_info_task_blocking(unsigned long *flags,
 					 const struct access_info *ai,
 					 struct other_info *other_info)
+	__must_hold(&report_lock)
 {
 	/*
 	 * We may be instrumenting a code-path where current->state is already
@@ -572,6 +575,7 @@ static void set_other_info_task_blocking(unsigned long *f=
lags,
 static void prepare_report_producer(unsigned long *flags,
 				    const struct access_info *ai,
 				    struct other_info *other_info)
+	__must_not_hold(&report_lock)
 {
 	raw_spin_lock_irqsave(&report_lock, *flags);
=20
@@ -603,6 +607,7 @@ static void prepare_report_producer(unsigned long *flags,
 static bool prepare_report_consumer(unsigned long *flags,
 				    const struct access_info *ai,
 				    struct other_info *other_info)
+	__cond_acquires(true, &report_lock)
 {
=20
 	raw_spin_lock_irqsave(&report_lock, *flags);

