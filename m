Return-Path: <linux-tip-commits+bounces-8265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N7tEh3Kommy5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:57:33 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2891C25DC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03813301348A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F348428837;
	Sat, 28 Feb 2026 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bcJwCxH3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uUN4tNS1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F63612FA;
	Sat, 28 Feb 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276197; cv=none; b=Sqej42hWt1kOw2q7D5qBUpB7yxgpSfM2R9E/5sdejvL+osgQFD+hIVGdNsg6HabMiP/Ta3nWX04x7HGHUFlHH5HPdkp2RAn0nBhHCDg4ulj5hziLstmxtCbXt3YB42oc+iZ8r6WbqBpzwGpWNT133zx10eYk6EOOkgj4h0aWhuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276197; c=relaxed/simple;
	bh=+h12/3z1Htp4CgOy9wsIN+pRChV72WBXWiTIqMzmy1Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TG4pMtiB3h595LEHrOFBZFQGmQiBRlXcp3iecIOWGkVbeOvH+61caGmq8v8c5LceBcMpecd3PCGo0drn/7vcYnZEnloWBbEOXvEeVeiBoOZDkbWtSdK+YRlwOpjnx6i7irkZHchbZxEEXiKp+Py7A4dphJHgLbk7H+ED5XYVyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bcJwCxH3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uUN4tNS1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upocn0et6WhJugX9uUWhFEHQM5J3LfKmTcPhg5OTIIs=;
	b=bcJwCxH3cPZeAMQl5L442yHPuvEJSi0fS6vDa769Nr3Z+2qjfTynrIG5p0cOMFcg+qEmUu
	2l7W0Ng0Tkq4CvITpOF745CUbY+yyYGz8JOAYR4yTUu8840HDNHdHzRnulpBvkJiaGuEki
	ytkjDD0vpa6bo9iwVHr1ACuu8welBlWQkbQdf/bnJMCbOMyu+bvygfws0k0M7UE5eIYdcU
	Ic9knzypMltqpErOdeFmg+Y2R/seVAzo1YyA8cWIUb/Z0owPgUSkDliXo+10/3Xean2pKe
	4sRqddXyvUYWALip4EGAKGbvOzvXgWSS+2kgs24eD6q9ET+2/iQAEKgWWt7FHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upocn0et6WhJugX9uUWhFEHQM5J3LfKmTcPhg5OTIIs=;
	b=uUN4tNS1TtT9VqWutD3/lYlOBNylpIxkNOyetlBh9IUmsqanJ/yNACkZ1ephIUJMEqXFfr
	geB3Hkp/n0WrwJCA==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] signal: Fix the lock_task_sighand() annotation
Cc: Bart Van Assche <bvanassche@acm.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260225183244.4035378-3-bvanassche@acm.org>
References: <20260225183244.4035378-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227618811.1647592.16889875056035667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8265-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,infradead.org:email,linutronix.de:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: AB2891C25DC
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     39be7b21af24d1d2ed3b18caac57dd219fef226e
Gitweb:        https://git.kernel.org/tip/39be7b21af24d1d2ed3b18caac57dd219fe=
f226e
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Wed, 25 Feb 2026 10:32:42 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:19 +01:00

signal: Fix the lock_task_sighand() annotation

lock_task_sighand() may return NULL. Make this clear in its lock context
annotation.

Fixes: 04e49d926f43 ("sched: Enable context analysis for core.c and fair.c")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20260225183244.4035378-3-bvanassche@acm.org
---
 include/linux/sched/signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index a22248a..a4835a7 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -739,7 +739,7 @@ static inline int thread_group_empty(struct task_struct *=
p)
=20
 extern struct sighand_struct *lock_task_sighand(struct task_struct *task,
 						unsigned long *flags)
-	__acquires(&task->sighand->siglock);
+	__cond_acquires(nonnull, &task->sighand->siglock);
=20
 static inline void unlock_task_sighand(struct task_struct *task,
 						unsigned long *flags)

