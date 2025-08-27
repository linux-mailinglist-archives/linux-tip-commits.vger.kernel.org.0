Return-Path: <linux-tip-commits+bounces-6381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B65BB37AAB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCDF1B62693
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772F3148CF;
	Wed, 27 Aug 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Q6jAeyX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bvHBw3mO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD93148BB;
	Wed, 27 Aug 2025 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277139; cv=none; b=uptoPMLkUmSGdrwoRMF/bBTS8v4DF4bB/2O1Z9UXNmpkd5R3bZnnHN0dTscUftTmg4ag8Gjjy3IzdWgIVdbpeVF8tD4CzYhuDyGeuZ4sdIxFq3fmG0fELs2ZQtSNhT5+1aroHIXgCPqy3ZskN5P59im6Upnkz6OBAy6jItVBoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277139; c=relaxed/simple;
	bh=pi5LxpwMX8Rx9f1KQgmR7jQ5qTqEbXRhwaUbf9f4v/A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eo9kPuKrNqgUu9UM2tSXSdDn+I7qDlIOuMrZHhgPlNnSVMK2gaN/LRWEMY+u0zVy7sIqaShPh6ojpY+GVD5tPinWey3g281oZHvOK9JjktECTHQNEHwiAhBqyOjlvxHsy1lfd0HycA0K/Nkxa/V1fdNfFvsJfY6x+o2TKR+X03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Q6jAeyX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bvHBw3mO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277133;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x59VxfJDeU9E+F4dbvaWyjlhU3peDkbKsePZI5Mw2uM=;
	b=2Q6jAeyXXTZwT5+FlSPvi6kVHQuDLes50kx8oydvpb7Rgn/7X7ntMtFCY+74oxlGiOmcDh
	I7EOfIccQyw9vEweD/tJ6PR2IbPAbFPIHOUDgnfsguQ9RAbaThM9E4Uuaqurkzkf6tcZLc
	EKSz9FDkSVWyN2QXeO1FBDQIbDD3UH51ogZwd+YC3ov4CtG15RC0cCgNZxfh6kN7yjThic
	PG+2+5bexebksWgZbLVKTiEUyRJXyWxQsazNxTMOJMavgXZCmMcTYslWbN++sFHE5v6DOi
	/DPMH6f6A7T1TWdHEZQB2UIDj2v+aQP9p/DEHXvJVq4s8teF7Ks7alW+DVrMVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277133;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x59VxfJDeU9E+F4dbvaWyjlhU3peDkbKsePZI5Mw2uM=;
	b=bvHBw3mOGneqWZiqMaE1FDrRLwvqlMQR+o2uEXpfp1CEKTBeEQuFKHt2YwzO1XoXvglip7
	vr6Fk9w5scVU+/Cw==
From: "tip-bot2 for Yicong Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Don't count nr_running for
 dl_server proxy tasks
Cc: Yicong Yang <yangyicong@hisilicon.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627035420.37712-1-yangyicong@huawei.com>
References: <20250627035420.37712-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627713060.1920.2801355896821571010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     52d15521eb75f9b521744db675bee61025d2fa52
Gitweb:        https://git.kernel.org/tip/52d15521eb75f9b521744db675bee61025d=
2fa52
Author:        Yicong Yang <yangyicong@hisilicon.com>
AuthorDate:    Fri, 27 Jun 2025 11:54:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 10:46:01 +02:00

sched/deadline: Don't count nr_running for dl_server proxy tasks

On CPU offline the kernel stalled with below call trace:

  INFO: task kworker/0:1:11 blocked for more than 120 seconds.

cpuhp hold the cpu hotplug lock endless and stalled vmstat_shepherd.
This is because we count nr_running twice on cpuhp enqueuing and failed
the wait condition of cpuhp:

  enqueue_task_fair() // pick cpuhp from idle, rq->nr_running =3D 0
    dl_server_start()
      [...]
      add_nr_running() // rq->nr_running =3D 1
    add_nr_running() // rq->nr_running =3D 2
  [switch to cpuhp, waiting on balance_hotplug_wait()]
  rcuwait_wait_event(rq->nr_running =3D=3D 1 && ...) // failed, rq->nr_runnin=
g=3D2
    schedule() // wait again

It doesn't make sense to count the dl_server towards runnable tasks,
since it runs other tasks.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250627035420.37712-1-yangyicong@huawei.com
---
 kernel/sched/deadline.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 88c3bd6..f253012 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1851,7 +1851,9 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, struct=
 dl_rq *dl_rq)
 	u64 deadline =3D dl_se->deadline;
=20
 	dl_rq->dl_nr_running++;
-	add_nr_running(rq_of_dl_rq(dl_rq), 1);
+
+	if (!dl_server(dl_se))
+		add_nr_running(rq_of_dl_rq(dl_rq), 1);
=20
 	inc_dl_deadline(dl_rq, deadline);
 }
@@ -1861,7 +1863,9 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct=
 dl_rq *dl_rq)
 {
 	WARN_ON(!dl_rq->dl_nr_running);
 	dl_rq->dl_nr_running--;
-	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
+
+	if (!dl_server(dl_se))
+		sub_nr_running(rq_of_dl_rq(dl_rq), 1);
=20
 	dec_dl_deadline(dl_rq, dl_se->deadline);
 }

