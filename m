Return-Path: <linux-tip-commits+bounces-3067-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A19F2050
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBEB7A1037
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD41194C61;
	Sat, 14 Dec 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EYAO+eoW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="88xneihg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6627D170A13;
	Sat, 14 Dec 2024 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734201431; cv=none; b=lcGVpkn7ZXR1qolH1lm5mo0Wt78wVlJIO9eC5Rg8/Xpe1ou1Cnjc+ophMG/BPnEuUeplxeuU90mfVFVhwzEO+SIy9lvS7MJkK+s+4DTJHtvliViyv2PtqZk3dDVbQrzxC6PvAvku19MkE8+svuJW5U0PUQddVaWRwOSy29rNnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734201431; c=relaxed/simple;
	bh=LbQDi8GAKDl3pJsmJVCxCPxDrkL3g1Uasb/pt8nmaIA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zxtgdnbez/I8HYA+eKtTv3exi8/Sfd391TIKmhDC+hVS8f3AEDmQzP3fU57glk4dfyZasG5SeQC+uFmxoGycqrGbk43U+F1NSp32Nz3D9ZixrXN9tqBCiB22jtt7u8hxtQ7wrHh+kITv3T7s/HlYY/dr9RwG7lzU6cOK8lNqy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EYAO+eoW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=88xneihg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:36:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734201420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vry1JOP3aeCzMon5dhVkNRlsax/2MViLRjIOC5CsSRs=;
	b=EYAO+eoWzXlSpA1KmKRwe55Xn2LKp+1plGnqNPRg1vT0V9KjatFz/llNTX5NPkMvLqwHzb
	Kk57UbWcoEAkWVllgVYHB8CEhkq/28AVR1weCA9t8CgvI2Jj5VwubkX8ykR8/maLe6r2am
	W0pCxcR728/56COy0Gr+5Jlon2NamrBKI2RhLJ5kU/8dHu/m1+A8QtfDk882LxF/ynLikZ
	IbiEMGo6+PLtaHXu+BxIqS89fIp2fk5Nu4TIi2VfbXsC5KUzimQg80ECb6cyMOf8Uy5wBs
	GAM3BS2yl4ORgJtBUdIl70Q8URHhGOAMAriSMg39wNPnyyt5+ISZ21h/5KUZkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734201420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vry1JOP3aeCzMon5dhVkNRlsax/2MViLRjIOC5CsSRs=;
	b=88xneihgYHDGU2NIJTtlsCCvIMVQBBSez0cMLgrfx3WOLq5ct8y6l1QnhPFa3lsn9/3poO
	OX89ue05A7E9a+Aw==
From: "tip-bot2 for Vineeth Pillai (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/dlserver: Fix dlserver time accounting
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241213032244.877029-2-vineeth@bitbyteword.org>
References: <20241213032244.877029-2-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420141940.412.2402151057795884747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c7f7e9c73178e0e342486fd31e7f363ef60e3f83
Gitweb:        https://git.kernel.org/tip/c7f7e9c73178e0e342486fd31e7f363ef60e3f83
Author:        Vineeth Pillai (Google) <vineeth@bitbyteword.org>
AuthorDate:    Thu, 12 Dec 2024 22:22:37 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 13 Dec 2024 12:57:35 +01:00

sched/dlserver: Fix dlserver time accounting

dlserver time is accounted when:
 - dlserver is active and the dlserver proxies the cfs task.
 - dlserver is active but deferred and cfs task runs after being picked
   through the normal fair class pick.

dl_server_update is called in two places to make sure that both the
above times are accounted for. But it doesn't check if dlserver is
active or not. Now that we have this dl_server_active flag, we can
consolidate dl_server_update into one place and all we need to check is
whether dlserver is active or not. When dlserver is active there is only
two possible conditions:
 - dlserver is deferred.
 - cfs task is running on behalf of dlserver.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Signed-off-by: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # ROCK 5B
Link: https://lore.kernel.org/r/20241213032244.877029-2-vineeth@bitbyteword.org
---
 kernel/sched/fair.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 97ee48c..53a4f78 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1159,8 +1159,6 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
 	trace_sched_stat_runtime(p, delta_exec);
 	account_group_exec_runtime(p, delta_exec);
 	cgroup_account_cputime(p, delta_exec);
-	if (p->dl_server)
-		dl_server_update(p->dl_server, delta_exec);
 }
 
 static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
@@ -1237,11 +1235,16 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		update_curr_task(p, delta_exec);
 
 		/*
-		 * Any fair task that runs outside of fair_server should
-		 * account against fair_server such that it can account for
-		 * this time and possibly avoid running this period.
+		 * If the fair_server is active, we need to account for the
+		 * fair_server time whether or not the task is running on
+		 * behalf of fair_server or not:
+		 *  - If the task is running on behalf of fair_server, we need
+		 *    to limit its time based on the assigned runtime.
+		 *  - Fair task that runs outside of fair_server should account
+		 *    against fair_server such that it can account for this time
+		 *    and possibly avoid running this period.
 		 */
-		if (p->dl_server != &rq->fair_server)
+		if (dl_server_active(&rq->fair_server))
 			dl_server_update(&rq->fair_server, delta_exec);
 	}
 

