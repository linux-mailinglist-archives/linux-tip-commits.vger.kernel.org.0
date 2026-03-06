Return-Path: <linux-tip-commits+bounces-8372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FhhDxNmqmk1QwEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 06:28:51 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7921BB5A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 06:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E13753025262
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2026 05:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54D368284;
	Fri,  6 Mar 2026 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjrRfTbl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hit9se6g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A136D4E2;
	Fri,  6 Mar 2026 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774925; cv=none; b=XO8vm4KVGEP3vBrvsdLhZvuUP/U365Q2jUY/4cbowrsPbXfpYtcpFzEniJKAGvlL6Ekuozn4Na9JWNw1NrzdIW7FwWK9QleAxVgdtdo/zOtouYylAsM8BcP5wPijemkKUCrxUapkG/2qASOOPbNHjvMQCNilQ3q9r7IGrVz/zwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774925; c=relaxed/simple;
	bh=1hDYMfvvh7BgnpVFfk9naHOD98kTD4+yZHKBa57n8cI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bvc3iUdmcqKUmH9I+g5IsNLrdvfKu0p7RudU6XF6Yu+ULG3XnVagQeOFftH7380/YDNICcrmYxp5fDZHKcxxL0d7Fy/FTCplcvrhytu/B9iXlXCxW/tVwl61m/6GeBoHE8leAlKDtqK6lq0KNMnGSIn8+8FHU5sJdnyiWbBca/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjrRfTbl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hit9se6g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Mar 2026 05:28:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772774920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar8GRWVvCsnNqTO3XlV9yo/HBzxDTIggyjNbpFvoMi0=;
	b=IjrRfTblhs43nXp5NJdQBw7X9hdbcp+yUFLXAC5Z0XpEZp7VdcBO/wVFJfXZZ1wo+S9yDI
	SWr0X/8PwDjLSPZzDlOYyTfNy9BxxFHiLKtUdfH6wXYiB0lFrYWUVqUlNauOae8aA28XFH
	V6BxzuFimD50EvkStkCju05jM4BJjKqHQ0cECpoV30zrFXwfYLuy73NymciifIQgDOKqRK
	hJKKgkNjZCqTD6k44MzBG8hbuvx2B0+HJOwQwQ7UgRQ42/QTh0pnpRv4SIBkiLmc7MT3Pp
	leGPRT4tQsfZy6E4q+QK4PXxbEpNqIa7c92zluLAKd0gcG7q9XL0OqGu3pnhjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772774920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar8GRWVvCsnNqTO3XlV9yo/HBzxDTIggyjNbpFvoMi0=;
	b=Hit9se6gI/oqXjfpgd81OSXx3J7Hmoi6OgXsTSMVkJVHlvw6rE/2y1JrKGgBnEujcadaUL
	TAKqNi9T1VmgpQBg==
From: "tip-bot2 for Xie Yuanbin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Inline raw_spin_rq_unlock()
Cc: Xie Yuanbin <qq570070308@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260216164950.147617-3-qq570070308@gmail.com>
References: <20260216164950.147617-3-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177277491880.1647592.6310554697701170716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CBE7921BB5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8372-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     54a66e431eeacf23e1dc47cb3507f2d0c068aaf0
Gitweb:        https://git.kernel.org/tip/54a66e431eeacf23e1dc47cb3507f2d0c06=
8aaf0
Author:        Xie Yuanbin <qq570070308@gmail.com>
AuthorDate:    Tue, 17 Feb 2026 00:49:49 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2026 06:21:48 +01:00

sched/headers: Inline raw_spin_rq_unlock()

raw_spin_rq_unlock() is short, and is called in some hot code paths
such as finish_lock_switch().

Inline raw_spin_rq_unlock() to micro-optimize performance a bit.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20260216164950.147617-3-qq570070308@gmail.com
---
 kernel/sched/core.c  |  5 -----
 kernel/sched/sched.h |  9 ++++++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfd280e..b59bab2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -687,11 +687,6 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	}
 }
=20
-void raw_spin_rq_unlock(struct rq *rq)
-{
-	raw_spin_unlock(rq_lockp(rq));
-}
-
 /*
  * double_rq_lock - safely lock two runqueues
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fa2237e..953d89d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1607,15 +1607,18 @@ extern void raw_spin_rq_lock_nested(struct rq *rq, in=
t subclass)
 extern bool raw_spin_rq_trylock(struct rq *rq)
 	__cond_acquires(true, __rq_lockp(rq));
=20
-extern void raw_spin_rq_unlock(struct rq *rq)
-	__releases(__rq_lockp(rq));
-
 static inline void raw_spin_rq_lock(struct rq *rq)
 	__acquires(__rq_lockp(rq))
 {
 	raw_spin_rq_lock_nested(rq, 0);
 }
=20
+static inline void raw_spin_rq_unlock(struct rq *rq)
+	__releases(__rq_lockp(rq))
+{
+	raw_spin_unlock(rq_lockp(rq));
+}
+
 static inline void raw_spin_rq_lock_irq(struct rq *rq)
 	__acquires(__rq_lockp(rq))
 {

