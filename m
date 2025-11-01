Return-Path: <linux-tip-commits+bounces-7130-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31036C2869E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5EE422887
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8A30100E;
	Sat,  1 Nov 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLPbJI/e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VU1e3ufa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9E2FF678;
	Sat,  1 Nov 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026092; cv=none; b=D94tF67/sMJfXOqQddaYTipALBabvZd5t/CpyDZyacii5OadWqVcnP7Aa1P59LptjRzEjGlC0pNrx/YFK8lfsqUnQWUTM9mqgT3vQ1X6+sIwNQdD3H0k8HX7OGw7V/VSZPYclD9gl4ao6903+qSepiEUlR8lnXhzerN2B95wHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026092; c=relaxed/simple;
	bh=szv9cNoEXcDtWr9nW2lkXi6QTpDCRZR9l/s5Q1+6sNA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oOZGiYjaP35E9tpmjuXHhIH6WtyeNqeKsiczzzVzeezSP3vwHquBnD/HxL00zRDKE0vfg3WDZ8Vbc/TbAT+pIS8BRW/NufwQrrLs/cB9Ho8lqHzoNxnKjVhb7N+CrtzQRUmRne6qiU1cKM378oy/5PJVjZuKEHfr8iYa9X5d0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLPbJI/e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VU1e3ufa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:41:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLLFM/2bZP1+rTxQQGnO5HuHmTcNu5wwhq7mne+71g0=;
	b=SLPbJI/enCKy0BIDtLeDUTY2PlnSgnnI1Uc5WjX8/chEd25BMSt7HF4+5nG4TXB4RYy6i4
	XKKkCRUeDA78y2Lx1imAajKmsY1nw/6dTF4tTrZUUoks1WC7uJTJ2SrS4YPKZ5kWQzgwFG
	0nLv58vehdqljDcEv+ifzjMQcjIR5l1ei0gccqOkCIwREaDZ3xZk2KLgGgSScgqhXhpBcJ
	YXKaqGsSFvCcdJZFFDgJLPYrHjU54hzDL9OsHs1OkVQtT5dsQ2X9wcWgy+cBTsiGztMTi+
	uZVCvaQ2JMXYmV9Fy0aockNqD9bkDINeFNmipZRQdr85d7CdiglaAh3HSUluzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLLFM/2bZP1+rTxQQGnO5HuHmTcNu5wwhq7mne+71g0=;
	b=VU1e3ufaBR5D+1RT+d2s9OP8v2vybVK1a7VKthZOXAeKCJkAE24jMbMaXCl5H+6jOY+r7a
	uQxluV9YEMhuHXCw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers/migration: Convert "while" loops to use "for"
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024132536.39841-2-frederic@kernel.org>
References: <20251024132536.39841-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202608781.2601451.1432013530667416309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6c181b5667eea3e6564d334443536a5974190e15
Gitweb:        https://git.kernel.org/tip/6c181b5667eea3e6564d334443536a59741=
90e15
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 24 Oct 2025 15:25:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:38:24 +01:00

timers/migration: Convert "while" loops to use "for"

Both the "do while" and "while" loops in tmigr_setup_groups() eventually
mimic the behaviour of "for" loops.

Simplify accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-2-frederic@kernel.org
---
 kernel/time/timer_migration.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc..1e371f1 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1642,22 +1642,23 @@ static void tmigr_connect_child_parent(struct tmigr_g=
roup *child,
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 {
 	struct tmigr_group *group, *child, **stack;
-	int top =3D 0, err =3D 0, i =3D 0;
+	int i, top =3D 0, err =3D 0;
 	struct list_head *lvllist;
=20
 	stack =3D kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
=20
-	do {
+	for (i =3D 0; i < tmigr_hierarchy_levels; i++) {
 		group =3D tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err =3D PTR_ERR(group);
+			i--;
 			break;
 		}
=20
 		top =3D i;
-		stack[i++] =3D group;
+		stack[i] =3D group;
=20
 		/*
 		 * When booting only less CPUs of a system than CPUs are
@@ -1667,16 +1668,18 @@ static int tmigr_setup_groups(unsigned int cpu, unsig=
ned int node)
 		 * be different from tmigr_hierarchy_levels, contains only a
 		 * single group.
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i - 1]))
+		if (group->parent || list_is_singular(&tmigr_level_list[i]))
 			break;
+	}
=20
-	} while (i < tmigr_hierarchy_levels);
-
-	/* Assert single root */
-	WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[=
top]));
+	/* Assert single root without parent */
+	if (WARN_ON_ONCE(i >=3D tmigr_hierarchy_levels))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_l=
ist[top])))
+		return -EINVAL;
=20
-	while (i > 0) {
-		group =3D stack[--i];
+	for (; i >=3D 0; i--) {
+		group =3D stack[i];
=20
 		if (err < 0) {
 			list_del(&group->list);

