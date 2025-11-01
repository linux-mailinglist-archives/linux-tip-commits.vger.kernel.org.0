Return-Path: <linux-tip-commits+bounces-7125-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F5C28692
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130F93A31DD
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D766202F9C;
	Sat,  1 Nov 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DFY2TlB9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OEq39/V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5D1A256B;
	Sat,  1 Nov 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026086; cv=none; b=pUFsEzFxNrV0iU28BbDaWy7f2ESe/tvIGICQ9c4MOEu1JK1ia7DDAcccfb5/d63/Vcq9kr7we7Hl0AM1jSVT38rw+fxPuU3/kP63R1E/Gt6bOavsstbl9aJToluC7DkyAdUIBcB7nMDfOENStMM7BmWQESbs1yi0rtoCCObHBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026086; c=relaxed/simple;
	bh=Y4mdNZAUZtyF/RPGTx3VgGK6Odqb2z7iu1jtjloaE2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dSJuskRxNL1I++zFI+bAq1fGf+8se/ODrRkK/TN0DrCtkIQIVVW0ilvhPP2BmujQw89fg9cXILRxNJvTsunXFBjkzQC+IlPK1aERG4Tt0FNoY8ITkK9Fb8J3MSRpmMqQylYe8J1VNl7f5C6CKniq1ipoh69hXGMvpGWP5VE39lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DFY2TlB9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OEq39/V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:41:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0b+i1Ha95xk1Ug/3PnLDPIVVy2VFAiAqDgQ1Hi3j60=;
	b=DFY2TlB9tak/rHTEzmwQS/jm3pkcGWVxtt7KsgvAPDfiY1Q2NITqi3RI9aNLZjA9spp5tM
	CM5cClIgPX59LpinSdef2J9Q9cWlYe5uUmo1VVtTZlolZz6tQIBsnGCh9+xZlKq8Ng3Oxs
	hEgPANHE8J+YIV4gbgEGsvd/0Adj07A6uhVv+CN6RjiI+Y/epqxRIP7ObG+C7lzUdHqSdh
	8QgsSIiM00QjQeH74GGi1K2ldubSIq8SGmN93lQwJ2Id8re3tvOWrfZ13I0BCsb/2pvRpa
	4GXEVD77r4Lbg4cKjoRcWaaX1vEVQBAQEUfY7hcBJMgCj33INGSAbO2Dh4i+Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0b+i1Ha95xk1Ug/3PnLDPIVVy2VFAiAqDgQ1Hi3j60=;
	b=4OEq39/VzAtrY3ym/DRSL2AP9LYUsxi8spupRnWEKWdON2G0IxkWvrYOVJ3gTMvICtlVzz
	3rlIuW3AQb/LoNCA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Remove dead code handling idle
 CPU checking for remote timers
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024132536.39841-7-frederic@kernel.org>
References: <20251024132536.39841-7-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202608092.2601451.8554494536186478242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ba14500e4bfcab5e841fbf8d7fcbbc80e98d6b9e
Gitweb:        https://git.kernel.org/tip/ba14500e4bfcab5e841fbf8d7fcbbc80e98=
d6b9e
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 24 Oct 2025 15:25:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:38:25 +01:00

timers/migration: Remove dead code handling idle CPU checking for remote time=
rs

Idle migrators don't walk the whole tree in order to find out if there
are timers to migrate because they recorded the next deadline to be
verified within a single check in tmigr_requires_handle_remote().

Remove the related dead code and data.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-7-frederic@kernel.org
---
 kernel/time/timer_migration.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 73d9b06..19ddfa9 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -504,11 +504,6 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
  * @now:		timer base monotonic
  * @check:		is set if there is the need to handle remote timers;
  *			required in tmigr_requires_handle_remote() only
- * @tmc_active:		this flag indicates, whether the CPU which triggers
- *			the hierarchy walk is !idle in the timer migration
- *			hierarchy. When the CPU is idle and the whole hierarchy is
- *			idle, only the first event of the top level has to be
- *			considered.
  */
 struct tmigr_walk {
 	u64			nextexp;
@@ -519,7 +514,6 @@ struct tmigr_walk {
 	unsigned long		basej;
 	u64			now;
 	bool			check;
-	bool			tmc_active;
 };
=20
 typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmig=
r_walk *);
@@ -1119,15 +1113,6 @@ static bool tmigr_requires_handle_remote_up(struct tmi=
gr_group *group,
 	 */
 	if (!tmigr_check_migrator(group, childmask))
 		return true;
-
-	/*
-	 * When there is a parent group and the CPU which triggered the
-	 * hierarchy walk is not active, proceed the walk to reach the top level
-	 * group before reading the next_expiry value.
-	 */
-	if (group->parent && !data->tmc_active)
-		return false;
-
 	/*
 	 * The lock is required on 32bit architectures to read the variable
 	 * consistently with a concurrent writer. On 64bit the lock is not
@@ -1172,7 +1157,6 @@ bool tmigr_requires_handle_remote(void)
 	data.now =3D get_jiffies_update(&jif);
 	data.childmask =3D tmc->groupmask;
 	data.firstexp =3D KTIME_MAX;
-	data.tmc_active =3D !tmc->idle;
 	data.check =3D false;
=20
 	/*

