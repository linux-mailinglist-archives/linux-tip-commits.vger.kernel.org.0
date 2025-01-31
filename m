Return-Path: <linux-tip-commits+bounces-3301-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E424A23BC4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jan 2025 11:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01EAB7A3A27
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jan 2025 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7730B15B111;
	Fri, 31 Jan 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="izD5uS5z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0lXXJ9C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ABD145A18;
	Fri, 31 Jan 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317650; cv=none; b=EE/yUeHoyBJN05WCcGMfiGLHk0eOCeOfxGgA8FjLENLHkUvqAUoWKikJUbsIOD+kZiNk8ab+6/1yxnpLCGwz3bdaYLvqfqWdGQSDCYckydYAoE8vc7bK9L+VEbcUAeN/ryYa28jPFtl2JkIhkWjprDFCLz2fsfH8f0hy86HnC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317650; c=relaxed/simple;
	bh=rUQ/O+gdOT0q1hpCuSJFA9OfjJHJwUe7r2CAWRi2mIU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tzWey1CSIRGqYYRH28OIn0qoKp/iRlbZF8BQomtIC6ILcwFj6nHyLk3f+7WxPoBLJStpKtplBRd/Y37Bbbo9QmyQJBwyBvlv3XZdnkcqPSvjHV6YnaSRlxrKoWMXJaDt48cgIXcX1PSrQoP0KxkXxTHymyggpgRPsAcgJ4G6RCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=izD5uS5z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f0lXXJ9C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Jan 2025 10:00:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738317645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GNV2BFndKAvf550rknPT3RVdujFWgTzrV4lmQrHLTQ=;
	b=izD5uS5zjIRWJuOdSaGIEgSu2+JHQzIoDBZkzhq4S3nluawOFDJQ9ww7twf4awdjJV3XbT
	dvsL2UpKIFNVU7rf0WSaOLJeMBg4YHO1MaIS4ubuWKVuiIx86uU5IpPV8VOqBfoOVy1CFM
	wq1jWzkd+sNMJtT0E48C9ZSRfJ0+9oR/KzQLV7uA+k420CePSJ0cLegwRvlhPpKLkHU2t+
	jAvezaudSbu1Ko/pLMTjl9oxLc9UITB4+oCV1Xvb3QDJ63cJJN2dNj+3Mopw1jualVd9k6
	4ZYo9J5kl/OVndVCB2eRXkwWShp4EipncYUqENFk0DLibDRBviiBLJ3jLHkO4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738317645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GNV2BFndKAvf550rknPT3RVdujFWgTzrV4lmQrHLTQ=;
	b=f0lXXJ9Cl1Dt4zhZ+t9URjkjTN2d2pLjrw6MZdaqqmkHzxbUjc2FBRH6+M/HJqwmWpZ8c0
	Jc+YuCa7M/h8R+CA==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/debug: Provide slice length for fair tasks
Cc: Christian Loehle <christian.loehle@arm.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <453349b1-1637-42f5-a7b2-2385392b5956@arm.com>
References: <453349b1-1637-42f5-a7b2-2385392b5956@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173831764238.31546.1518099689337964438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9065ce69754dece78606c8bbb3821449272e56bf
Gitweb:        https://git.kernel.org/tip/9065ce69754dece78606c8bbb3821449272e56bf
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Wed, 29 Jan 2025 17:59:44 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jan 2025 10:45:33 +01:00

sched/debug: Provide slice length for fair tasks

Since commit:

  857b158dc5e8 ("sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion")

... we have the userspace per-task tunable slice length, which is
a key parameter that is otherwise difficult to obtain, so provide
it in /proc/$PID/sched.

[ mingo: Clarified the changelog. ]

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/453349b1-1637-42f5-a7b2-2385392b5956@arm.com
---
 kernel/sched/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a1be00a..5b32d3c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1265,6 +1265,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
+	} else if (fair_policy(p->policy)) {
+		P(se.slice);
 	}
 #ifdef CONFIG_SCHED_CLASS_EXT
 	__PS("ext.enabled", task_on_scx(p));

