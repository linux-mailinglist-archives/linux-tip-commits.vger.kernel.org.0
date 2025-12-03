Return-Path: <linux-tip-commits+bounces-7591-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9ACA0E2B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 071953007289
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5865030F811;
	Wed,  3 Dec 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1OmGghV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SIQT6ArY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6729313E0E;
	Wed,  3 Dec 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785958; cv=none; b=lzUMdNc4K7fCECSnTAkrAWTuW4zqbOj0rYF64TWVroGbi74aRUijfuXprRtJ6SS/TLJY1H7LuOwnN9tpTFgiBPXxvR/1QTxJeWgO0sB7CbMejly3Fh5Q2CIimMs6+PV7UT0hufcz7HVHwEAyJNcI2X4rjoGTMi6teraYmrNd4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785958; c=relaxed/simple;
	bh=w0lEf1OXcurbpopOAcM4eekI78km1JoDvQ8b1vvmZzk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZzJkibAS8av2IyYCJftZYflFtw9YzDep360gACFjt/rwdyvxDzmKIY1vj6OZ4HhgmRmnKc+CIJ/zWagfD/BTBgWp/iDejiWJlVIaxMlKoXbJVmirEJSOHNGoYgZXMMA40j9VLDaZiPNKSZvXpGe68U9pqRlZ3mByfHqtVjnRh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1OmGghV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SIQT6ArY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:19:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764785955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ahwK9ZQp7nrlekfY0hvJfgIcrwzqOv8BKFP83QZ4PZE=;
	b=n1OmGghVCbsxkwnKwa7I4wyfhemQJHJOLhjeN1t/RLR+tMxH79G07nZQ1YeFaQa/UsyQns
	aXlBIOJYmsbDqoNHtfOPsqk5piXbC8cVQwKgFoJt2w6VN1uN7VZmE383Jkdc5y2HXljHpW
	eod+MjMKZmktVXqnTLmCP/Y5th7ZvWTaBfZYVpNg2vGVSZDfd8QQqCh2PDAlkKnfkZ2mO8
	QQkiaOG8GMN0lCmpuJDxYoTyYk+XoSRS5Km2afOqSRs16wI3kviQ3vcDsr5e8whM0yheC4
	nfiyPbNBUa1Zr5qlwbuH3hMc5UB/+TCJGM9KkE+q7zWnj7OWUx7Z8PNM72hkLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764785955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ahwK9ZQp7nrlekfY0hvJfgIcrwzqOv8BKFP83QZ4PZE=;
	b=SIQT6ArY3w33TOybnKUIGqgKH1suB1WKZQNj8YIRnK9VlKHWu+8b3DEV0hC6qOjH3J6Go7
	zRyox8LExmrfZJCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/headers: Remove whitespace noise from
 kernel/sched/sched.h
Cc:
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478595428.498.13816176784792752599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0c8e9f4ec5a36b0376f322ef8bd8ef62cba72d0d
Gitweb:        https://git.kernel.org/tip/0c8e9f4ec5a36b0376f322ef8bd8ef62cba=
72d0d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 19:03:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:05:02 +01:00

sched/headers: Remove whitespace noise from kernel/sched/sched.h

A single case of space-Tab noise snuck in recently.

Fixes: 36569780b0d6 ("sched: Change nr_uninterruptible type to unsigned long")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8590113..cb80666 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1165,7 +1165,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned long 		nr_uninterruptible;
+	unsigned long		nr_uninterruptible;
=20
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	struct task_struct __rcu	*donor;  /* Scheduling context */

