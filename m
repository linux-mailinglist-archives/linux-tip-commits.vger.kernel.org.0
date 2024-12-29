Return-Path: <linux-tip-commits+bounces-3147-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935539FDE2F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 29 Dec 2024 10:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C9F7A116B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 29 Dec 2024 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10D8494;
	Sun, 29 Dec 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FR4yY6W/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u7xxKPWu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE626ADD;
	Sun, 29 Dec 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735463906; cv=none; b=ebVnB71m0aE1A6EzxQSKe9GAAJ8+dywPFbwL7HEI9lG77PayLquGYoNmXLFWhxR3HgQjpT5Lyh/eHKc0h6FkHEswVD34nnYz0FBw1SsPi8kirAXrGr/QsTc0qUbp09a+28utEty1aKGKbh3Hich7+c3GhFE7+06WSH371fpg7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735463906; c=relaxed/simple;
	bh=DZgs4XuSQ7KAkRTMrAps1p4c2dWUla0psASMTVapRYU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i8Beg6U2tHQ+zo9cXrjwYpFE3ADw2kVZCiBXgOCmkYszCb1eOd1RY9U3mXL3C5W0ZKoFEHvhjtWGFojz25TTPLs1UrdHlY0GnkV93vAaX5bsy9rvT2K5WAc3hWTDtWeGxojAWFb1h2xrjr//vqOxNpdO0I4XbLqm2if/c8E84iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FR4yY6W/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u7xxKPWu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 29 Dec 2024 09:18:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735463902;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP66kNIT/Pa2fCOkO+Uq9/AJaYw8cQJobOEsxNIqTDs=;
	b=FR4yY6W/ciTGzm3vfDSFxYxaBO80UQsAtSm9Qu81D0qnT3z6KncH7+u2P3W+MBYrBALG/g
	kTQPL076geZlV/yzCcspNlZUXh9kADObnM0VLD26ZP9+HjQZl1ghz1kt0FMd5427JK2Zi+
	6WnNGVNAaj3sODXqVrtgbif7PH4nQOXpnQyahBIQwxb3Maoh6o18dOEHNJv0bthpTO1SwZ
	+ngap0WKq+U4VUCEVxbw6n2YJGC6uZ+tU3mnrSPP3/3bZtr3Ez3l+K0wTR7wGXqiXGkVTj
	De3wV5GvKP1No0rZjWOneTZBPXaqGR5HTFWtAydUsU9dMzHj/wHcph7mAQCTsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735463902;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP66kNIT/Pa2fCOkO+Uq9/AJaYw8cQJobOEsxNIqTDs=;
	b=u7xxKPWu0CFNX7bGqVQWWJKmfcLpiJeVD4XNu78YE+pI0SzTIVpsGpM3R6O0k8QJP2RjQU
	QWzn8cueqptb7CAA==
From: "tip-bot2 for Chen Ridong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] freezer, sched: Report frozen tasks as 'D' instead of 'R'
Cc: Chen Ridong <chenridong@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>, mkoutny@suse.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241217004818.3200515-1-chenridong@huaweicloud.com>
References: <20241217004818.3200515-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173546390206.399.11436272113063109060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f718faf3940e95d5d34af9041f279f598396ab7d
Gitweb:        https://git.kernel.org/tip/f718faf3940e95d5d34af9041f279f59839=
6ab7d
Author:        Chen Ridong <chenridong@huawei.com>
AuthorDate:    Tue, 17 Dec 2024 00:48:18=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 29 Dec 2024 10:14:20 +01:00

freezer, sched: Report frozen tasks as 'D' instead of 'R'

Before commit:

  f5d39b020809 ("freezer,sched: Rewrite core freezer logic")

the frozen task stat was reported as 'D' in cgroup v1.

However, after rewriting the core freezer logic, the frozen task stat is
reported as 'R'. This is confusing, especially when a task with stat of
'S' is frozen.

This bug can be reproduced with these steps:

	$ cd /sys/fs/cgroup/freezer/
	$ mkdir test
	$ sleep 1000 &
	[1] 739         // task whose stat is 'S'
	$ echo 739 > test/cgroup.procs
	$ echo FROZEN > test/freezer.state
	$ ps -aux | grep 739
	root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000

As shown above, a task whose stat is 'S' was changed to 'R' when it was
frozen.

To solve this regression, simply maintain the same reported state as
before the rewrite.

[ mingo: Enhanced the changelog and comments ]

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Link: https://lore.kernel.org/r/20241217004818.3200515-1-chenridong@huaweiclo=
ud.com
---
 include/linux/sched.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 66b311f..64934e0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1637,8 +1637,9 @@ static inline unsigned int __task_state_index(unsigned =
int tsk_state,
 	 * We're lying here, but rather than expose a completely new task state
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
+	 * Report frozen tasks as uninterruptible.
 	 */
-	if (tsk_state & TASK_RTLOCK_WAIT)
+	if ((tsk_state & TASK_RTLOCK_WAIT) || (tsk_state & TASK_FROZEN))
 		state =3D TASK_UNINTERRUPTIBLE;
=20
 	return fls(state);

