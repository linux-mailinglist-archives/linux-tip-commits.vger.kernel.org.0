Return-Path: <linux-tip-commits+bounces-8226-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO+yBs0rnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8226-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:28:29 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A225174E05
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFA5C303D4F2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB71361DD9;
	Mon, 23 Feb 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wSxk2+IO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+mEEgysl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17E361DB5;
	Mon, 23 Feb 2026 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842327; cv=none; b=hIvk63+N+hpO4Xuz5U9jbuOVNusuW9ubHstIr2eeCkzV3wRz1RjRUZGwo9BVGG4uMt6GwdGzPJMKmt83Yol5KifGejb2XhkpuAhjwjwZxtjz4n3b89XP+gqovj/IMNnef3+5KaxidX8d+d1o/9cICrgH9msT7TRryMWaYsbVYcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842327; c=relaxed/simple;
	bh=QQnPsBY5PC7TynoEeeZPMydMNO3m3PBx9vaKBbcYg+0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gouB7eF78cFG+XQB4RM35GiTvwE6KYgoAEx6cZ6FT7QHZ7V9l3TQRNhDbE1q9lJEHtXnrlMbGcirS9EXTFo7GOVhITLax1fIhmTwkG97gXCCbSH25HzvKOHDJl9MCkEvKVr9rv4Q5dG0WU6dfrKxcp+UhLRYYsgG3tBlzYFzQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wSxk2+IO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+mEEgysl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CXpX+zGcXETxALtukNo/raJON0dkExFy9vFghem0QhM=;
	b=wSxk2+IOcE8+kmkBB0eds8opZQPdogUH2nn9DreW1bBFUuqWvxtTIMfiEEMSgcmB5o6XPa
	e1ttGuGJ2XFZY2AwVkB2P4JW7CVrkl/Yby3V3Eqa7wGd7kRSVEDl4LQbGYEM/mXHrEEy7I
	ZmdRv40/h0KF34bBWMtkar5utbSb6xdmeodPL7NyXXW3pxa6Vx3DWa33F13AEGnkIDk0WS
	kuljFSht5khpxDxhR8w/NU6PzXwdxZnhnLYzjEeLH7JABuFeiNOx9HXLGt9mUaILFHoBu9
	/uecG4pkqkUvvV72UIqtRV1DjU82OZsB4Q4kqh6BHTRt12oOMVx6z65P0/3h0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CXpX+zGcXETxALtukNo/raJON0dkExFy9vFghem0QhM=;
	b=+mEEgysl/NPDken2GN++1fUJjHEDkN84il+N3ytnt0bJnh/GLD+xn1cqi+xnKtPI7qY5gR
	GA+FNhHJ2s2iuWAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/fair: Only set slice protection at pick time
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184232368.1647592.16351138592976953143.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8226-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amperecomputing.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,msgid.link:url,amd.com:email]
X-Rspamd-Queue-Id: 4A225174E05
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     bcd74b2ffdd0a2233adbf26b65c62fc69a809c8e
Gitweb:        https://git.kernel.org/tip/bcd74b2ffdd0a2233adbf26b65c62fc69a8=
09c8e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 23 Jan 2026 16:49:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:18 +01:00

sched/fair: Only set slice protection at pick time

We should not (re)set slice protection in the sched_change pattern
which calls put_prev_task() / set_next_task().

Fixes: 63304558ba5d ("sched/eevdf: Curb wakeup-preemption")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260219080624.561421378%40infradead.org
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 56dddd4..f2b46c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5445,7 +5445,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se, int flags)
 }
=20
 static void
-set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
+set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, bool first)
 {
 	clear_buddies(cfs_rq, se);
=20
@@ -5460,7 +5460,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_ent=
ity *se)
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
=20
-		set_protect_slice(cfs_rq, se);
+		if (first)
+			set_protect_slice(cfs_rq, se);
 	}
=20
 	update_stats_curr_start(cfs_rq, se);
@@ -8978,13 +8979,13 @@ again:
 				pse =3D parent_entity(pse);
 			}
 			if (se_depth >=3D pse_depth) {
-				set_next_entity(cfs_rq_of(se), se);
+				set_next_entity(cfs_rq_of(se), se, true);
 				se =3D parent_entity(se);
 			}
 		}
=20
 		put_prev_entity(cfs_rq, pse);
-		set_next_entity(cfs_rq, se);
+		set_next_entity(cfs_rq, se, true);
=20
 		__set_next_task_fair(rq, p, true);
 	}
@@ -13598,7 +13599,7 @@ static void set_next_task_fair(struct rq *rq, struct =
task_struct *p, bool first)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
=20
-		set_next_entity(cfs_rq, se);
+		set_next_entity(cfs_rq, se, first);
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		account_cfs_rq_runtime(cfs_rq, 0);
 	}

