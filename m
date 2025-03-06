Return-Path: <linux-tip-commits+bounces-4022-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD8A5473C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 11:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC691887395
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA51EDA3E;
	Thu,  6 Mar 2025 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2Pt+qUq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJ7DtnuC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E817E9;
	Thu,  6 Mar 2025 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255369; cv=none; b=JT6nlv560mQ5oPoOvWM1lKtMShgrRs0SYf96xWrXRHsEZbBMgbkw/jA7aTZH+q0bt0SIHCoFDKKnc0ia4xU8bZFhI9yMYVfr7mKSivDlRsK/ASLHXls16/geHZYqxIQ+iUXZro8KCqI5RdBQFsa9U07kE5HDuTA7S6Bm8inuPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255369; c=relaxed/simple;
	bh=OAZkdZE40/RK0vqmcq/gMyMNTym8wcfE31sks6j2O4s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HkbWq+CyzyBj6qBf6hQuZX+1FSSa2O+4bezwxXxYRfm7X4nhNU0LiT02Jt9JXPUO3TTLklwACHbi4knKlcUDSV6ZwOtC4Ii0+/m5+0+GHK/eZlrVaU/5hVg2J0qMnDFtQ/4iRbFiBpzM1Lg6em8dOPA6xRBO5nJvc7qUGDaZbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2Pt+qUq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJ7DtnuC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 10:02:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741255365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ov/RgVd8BFaTCc1hKcQOXWF/eM4LTkT6SJ9nWenpqbk=;
	b=A2Pt+qUqGGoVZtN5wUKBjdui4yVSHkO1qcP97irJ4x3srAKkl5ONYGWo8qIeDuaoSO3GtQ
	1vV9D79QTj+bRSzCiZARLKuDV4CqJlBBa8UNANygpi++otelFGtIjvOr5Jm+lvW1eP+8Po
	VgEipL7h5ONHyC8cljg0s1dWdnYNpJce4VkaWRVdEooQ2SfW6U18fBb+Iv06qn5ff3c6Cl
	YOjABAuE8baevo1hnmpjGyutb8vzL8K9+cLt2vtLuDc6G4hBusy3tl7yFGC2Tc+qP7ppd2
	8yEX94IKf4Q+B4BYsOSXmEWWb7rrQfz2q9JrIjOzcfiDEm+K8fe8ZofJrNNxlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741255365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ov/RgVd8BFaTCc1hKcQOXWF/eM4LTkT6SJ9nWenpqbk=;
	b=HJ7DtnuCuPci4mU+xVXRkA3gAcWW6iSzFR5XL5p241vcWKzEnpFrapox1z70pqDOf40rTV
	JLHoGbjMnwtOjFDg==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt: Update limit of sched_rt sysctl in
 documentation
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306052954.452005-3-sshegde@linux.ibm.com>
References: <20250306052954.452005-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174125536231.14745.5392833736932300438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b1536481c81fb604074da799e4f2d2038a1663f7
Gitweb:        https://git.kernel.org/tip/b1536481c81fb604074da799e4f2d2038a1663f7
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Thu, 06 Mar 2025 10:59:54 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 10:21:31 +01:00

sched/rt: Update limit of sched_rt sysctl in documentation

By default fair_server dl_server allocates 5% of the bandwidth to the root
domain. Due to this writing any value less than 5% fails due to -EBUSY:

  $ cat /proc/sys/kernel/sched_rt_period_us
  1000000

  $ echo 49999 > /proc/sys/kernel/sched_rt_runtime_us
  -bash: echo: write error: Device or resource busy

  $ echo 50000 > /proc/sys/kernel/sched_rt_runtime_us
  $

Since the sched_rt_runtime_us allows -1 as the minimum, put this
restriction in the documentation.

One should check average of runtime/period in
/sys/kernel/debug/sched/fair_server/cpuX/* for exact value.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20250306052954.452005-3-sshegde@linux.ibm.com
---
 Documentation/scheduler/sched-rt-group.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 80b05a3..ab46433 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -102,6 +102,9 @@ The system wide settings are configured under the /proc virtual file system:
   * sched_rt_period_us takes values from 1 to INT_MAX.
   * sched_rt_runtime_us takes values from -1 to sched_rt_period_us.
   * A run time of -1 specifies runtime == period, ie. no limit.
+  * sched_rt_runtime_us/sched_rt_period_us > 0.05 inorder to preserve
+    bandwidth for fair dl_server. For accurate value check average of
+    runtime/period in /sys/kernel/debug/sched/fair_server/cpuX/
 
 
 2.2 Default behaviour

