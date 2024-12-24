Return-Path: <linux-tip-commits+bounces-3113-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE59FBB81
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42841886DC6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A91C3C19;
	Tue, 24 Dec 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlChhLv9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WihUZiuh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175F1C3BEB;
	Tue, 24 Dec 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033636; cv=none; b=PSWSnJ9VEPMPY3ieHjmcLQ9wnES9uDlCHv8eXXAFEL8Qqwwurb/DDUWtFNGoxrhZD5s5NSiHx47QfIZIY4HiX0wjb4tlgektXBQZqeFoqWu12hKsN+4r1dP+xy+3jTDZVXm8Qd6aZpQ318gWRfjs1d8FaNGDZ/oTEveOgqLQGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033636; c=relaxed/simple;
	bh=nfiVYZmLYuMjl9UOH31SLIGSZsvXIJLMJmy+Z5Mie2s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cIt/uJvKrXCSRjHQtl8QjooLHaTGJhsAUQEaXUGwHW1lSYEA8BtlnHYcuAqiv+ILpMH1HgKkadkjd9umgevtk7BoTAb3bBnpeFCFP4G89z+LuAuMsXLjtGkJ0kpxLjSmNmzBaQWGeS05HnG0jVjS5AtctsHTl1vLQ1a1YNM85GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OlChhLv9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WihUZiuh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCj+Dm3203Vc8xPeIjYfLItOU8nao4Q+ia3dRR1XG2I=;
	b=OlChhLv9iHQLZ2eIQgwue9e/y+BJvDGQ00nXXQPwa9egXH5ziPrT6vh7tZLZuHGqTIqfrR
	DBDlE1u8teyPOhwkGUP6kaKDbcqOI4cZLbmHUfwq85NstoTsz/JPqNaP5vxJBtYwaj3X/i
	jQlnFZ1zpQUJx5kYiWa2+0ssQwQaiNRjyJu7oPt3FIMPotZ7eH9jD2VBW1WiAwMB96LRIt
	rJAfs1LVgqqc5ht81EmVX+OT5vU53dpLcJolOmipNQgylmhrhzgnvf4oZEiecA8/roz3jH
	vqn7SwxeauAPM7gtnoIiaR4L3PEbUYaiqiyf+8m88cGVJgkCptVyoHoZXxqX8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCj+Dm3203Vc8xPeIjYfLItOU8nao4Q+ia3dRR1XG2I=;
	b=WihUZiuh+DOhGgUJ50cyGs7Q4fYCxckVxVDNsZDGozhkLNhEDv/XHXqIfI+0R4MBm3zj2d
	yYyVDmIp0SVQHmBQ==
From: "tip-bot2 for Chen Ridong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] freezer, sched: report the frozen task stat as 'D'
Cc: Chen Ridong <chenridong@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 mkoutny@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241217004818.3200515-1-chenridong@huaweicloud.com>
References: <20241217004818.3200515-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503363300.399.9097986381691581562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2357a7f934ae01985b0b8b70c3ca59ea38b9ed5b
Gitweb:        https://git.kernel.org/tip/2357a7f934ae01985b0b8b70c3ca59ea38b=
9ed5b
Author:        Chen Ridong <chenridong@huawei.com>
AuthorDate:    Tue, 17 Dec 2024 00:48:18=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2024 17:47:20 +01:00

freezer, sched: report the frozen task stat as 'D'

Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
logic"), the frozen task stat was reported as 'D' in cgroup v1.
However, after rewriting core freezer logic, the frozen task stat is
reported as 'R'. This is confusing, especially when a task with stat of
'S' is frozen.

This can be reproduced as bellow step:
cd /sys/fs/cgroup/freezer/
mkdir test
sleep 1000 &
[1] 739         // task whose stat is 'S'
echo 739 > test/cgroup.procs
echo FROZEN > test/freezer.state
ps -aux | grep 739
root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000

As shown above, a task whose stat is 'S' was changed to 'R' when it was
frozen. To solve this issue, simply maintain the same reported state as
before the rewrite.

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Link: https://lore.kernel.org/r/20241217004818.3200515-1-chenridong@huaweiclo=
ud.com
---
 include/linux/sched.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 66b311f..6c98649 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1637,8 +1637,9 @@ static inline unsigned int __task_state_index(unsigned =
int tsk_state,
 	 * We're lying here, but rather than expose a completely new task state
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
+	 * Report the frozen task uninterruptible.
 	 */
-	if (tsk_state & TASK_RTLOCK_WAIT)
+	if ((tsk_state & TASK_RTLOCK_WAIT) || (tsk_state & TASK_FROZEN))
 		state =3D TASK_UNINTERRUPTIBLE;
=20
 	return fls(state);

