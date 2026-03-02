Return-Path: <linux-tip-commits+bounces-8338-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APejGTilpWngCwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8338-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 15:56:56 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F20851DB3F8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 15:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EBB2300458D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Mar 2026 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7F3FD13B;
	Mon,  2 Mar 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jptyvh3W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YS4Ebs7f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9422B8AB;
	Mon,  2 Mar 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463033; cv=none; b=dN+jXtoKSX5Y0mmKrceaMEvaOkaroHdPcvHcntXtKOeRqR1doF5JMnHtdr8U8ApHsTKax1TX0QVAbm5OrtksixWNNUiLIdrovHPJnc9HAFL7JcQsp1YR0qpFPDhe2DW9lHo3zUx1y95NkZl9/7qS2oTP5o/Ip40gViGf7LAQFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463033; c=relaxed/simple;
	bh=V65EW6ivqH9CAULjLrau1vnf5tTJwTeIAg8Kkyjdxbg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JBsBv0nsD2hD9OnsUApMk/iefFTPYH1erB+SYE6fNgRR9T2VNx6y4GfK0ZvLSuwU3OvFIvn7zLCdTGWFU/KBz+SuS4X6+tCw9g9isL3MB85HmH/SLyy/VDoPw+Z7TLsyp7d2l9UrJY337+hW3xtbEy/hvM8f5WN2taGjqH27hRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jptyvh3W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YS4Ebs7f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Mar 2026 14:50:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772463031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncSrw0JBMoXiNYJmA5/WtbgClBXm9wq/bIAnNaSlYwA=;
	b=jptyvh3WDsS5avHR+3bBOpjtztp5Rde39P+lKkXbH5Llfle8NDODY+UNhda+JFt4ShqNYT
	GI7Oneg+14kPFq4fQ1b7ryVR3Yy9a+pHlFeEu6/X8zgkFpfZxXSWubGUMglicQqznuWwwk
	BQbiq1sUETvjd0U+a6cKxX15vwIAtrVw2e69juTyAjOTAOFHc8tp++FS3vaUyBbiM6vJAJ
	SykW4/t8pS+ENLQxOnASlzKnptXRCAXbPP7Zp5jHNj592LHzwCyNYq9yS+xV5VdlIblD9F
	f3RwtWkH4rNZG8uJBdxnnvKGSe2VoJvcdJkhxzA0VbaEzzQD0qff8n/9XcolhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772463031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncSrw0JBMoXiNYJmA5/WtbgClBXm9wq/bIAnNaSlYwA=;
	b=YS4Ebs7f7Qd9IBHp6oUVI2ECQrCbrCF1waQOU2MArPtvUPrCMV1v0oHAXVyxnVEFN2g/O2
	WjSlYpDSx4p4O+Dw==
From: "tip-bot2 for Xie Yuanbin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make raw_spin_rq_unlock() inline
Cc: Xie Yuanbin <qq570070308@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216164950.147617-3-qq570070308@gmail.com>
References: <20260216164950.147617-3-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177246302945.1647592.345441883755932235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F20851DB3F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8338-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,infradead.org:email,linutronix.de:dkim,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2ad9b46d0a53bcadf2092626fcfd2d96e9b22001
Gitweb:        https://git.kernel.org/tip/2ad9b46d0a53bcadf2092626fcfd2d96e9b=
22001
Author:        Xie Yuanbin <qq570070308@gmail.com>
AuthorDate:    Tue, 17 Feb 2026 00:49:49 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Mar 2026 15:41:01 +01:00

sched: Make raw_spin_rq_unlock() inline

raw_spin_rq_unlock() is short, and is called in some hot code paths
such as finish_lock_switch.

Make raw_spin_rq_unlock() inline to optimize performance.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260216164950.147617-3-qq570070308@gmail.com
---
 kernel/sched/core.c  |  5 -----
 kernel/sched/sched.h |  9 ++++++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1e6ebc2..c39e9b4 100644
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
index fbde83c..fd36ae3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1609,15 +1609,18 @@ extern void raw_spin_rq_lock_nested(struct rq *rq, in=
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

