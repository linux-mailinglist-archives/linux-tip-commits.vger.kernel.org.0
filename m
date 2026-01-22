Return-Path: <linux-tip-commits+bounces-8101-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN/yBYX7cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8101-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:27:17 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4D653D7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEED76616BA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4233E9592;
	Thu, 22 Jan 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3DKP/QDn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TEr6TVLl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6334404A;
	Thu, 22 Jan 2026 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076964; cv=none; b=ljqU1uU/JkVuc6WuHbzguIk2nlNRPk5FXe6CfHjA72cN5ITMI6DEyab4Jxip8O6uVBqugkz46arNYRx1F6Q/mHapQ12Spezvopxd4YdZtd2tTSo0TcQObI4ejjty5UhiUUD0JVUrBnn8UwKU5NZroiRcZvKsVDOeauyNi/5eqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076964; c=relaxed/simple;
	bh=LLYoCob5sFXru+W2IRtTs0P64VhCV+k+2hcn4jLTe2M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bdZK5iPlqwIhNrJHMBaaZ1TTTG5QPeNVls/2lXEah7zKrhkQ1xiOu07nmh4oznLv2nfWnHpq7oZ1Jt/SUhORTLx94N0GYBX2j/qDOQRPDMpXLHScY7U0+RuALGIp2+wKHVPtB3yY+X1idLi31v7MkFms2sZt1x9YCvLf3x15G4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3DKP/QDn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TEr6TVLl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GflMM/Dgmva+Ws7T65HtB/7GGU/j73L0Bhs86CoRDR8=;
	b=3DKP/QDnFkyGhQQiBF54b5hRKVqS7557YgwCKBzUQ5gDBXieNbW81lF6qaP/Oh7cyYoHW4
	0sqp3RPuJCm/EAkPBpgD/E6nzLNCGRFjnduU4qBU+ewhVEF5ln33i59okWcUw08QYi/u3C
	WwYO1FRD5GmLt8m9v0gex1gUBorm76ctSO55xF8ayDKkAmDy6kqCcw30gdKrtUByAlj4w6
	sCaa8pjrZuARhocmTmL8A8tKRpUvC9n+vpfAdGyBgs7y9jmny4ceg/x3C0bAcxgXkPx6Tz
	a+XVD7nco0fXpx1LYDD9xM9oPQM+b6DzRyIp6auyuvxLYnX/zzjsXK0VNEp0OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GflMM/Dgmva+Ws7T65HtB/7GGU/j73L0Bhs86CoRDR8=;
	b=TEr6TVLlSdg4nW2Mby5Myv/USM7mw3SyDvA+sOj75A2mvJOer2fQnM6x5xXdATEviJEcjV
	1jumHyJbF4+m9EAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Reset slice extension when scheduled
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155709.131081527@linutronix.de>
References: <20251215155709.131081527@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907696070.510.1804643664042823042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url,infradead.org:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,efficios.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8101-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: B7B4D653D7
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7ee58f98b59b0ec32ea8a92f0bc85cb46fcd3de3
Gitweb:        https://git.kernel.org/tip/7ee58f98b59b0ec32ea8a92f0bc85cb46fc=
d3de3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:18 +01:00

rseq: Reset slice extension when scheduled

When a time slice extension was granted in the need_resched() check on exit
to user space, the task can still be scheduled out in one of the other
pending work items. When it gets scheduled back in, and need_resched() is
not set, then the stale grant would be preserved, which is just wrong.

RSEQ already keeps track of that and sets TIF_RSEQ, which invokes the
critical section and ID update mechanisms.

Utilize them and clear the user space slice control member of struct rseq
unconditionally within the existing user access sections. That's just an
unconditional store more in that path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251215155709.131081527@linutronix.de
---
 include/linux/rseq_entry.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 8d04611..fc77b9d 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -102,9 +102,17 @@ static __always_inline bool rseq_arm_slice_extension_tim=
er(void)
 	return __rseq_arm_slice_extension_timer();
 }
=20
+static __always_inline void rseq_slice_clear_grant(struct task_struct *t)
+{
+	if (IS_ENABLED(CONFIG_RSEQ_STATS) && t->rseq.slice.state.granted)
+		rseq_stat_inc(rseq_stats.s_revoked);
+	t->rseq.slice.state.granted =3D false;
+}
+
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
 static inline bool rseq_slice_extension_enabled(void) { return false; }
 static inline bool rseq_arm_slice_extension_timer(void) { return false; }
+static inline void rseq_slice_clear_grant(struct task_struct *t) { }
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
=20
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, =
unsigned long csaddr);
@@ -391,8 +399,15 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, stru=
ct rseq_ids *ids,
 		unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
 		if (csaddr)
 			unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
+
+		/* Open coded, so it's in the same user access region */
+		if (rseq_slice_extension_enabled()) {
+			/* Unconditionally clear it, no point in conditionals */
+			unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+		}
 	}
=20
+	rseq_slice_clear_grant(t);
 	/* Cache the new values */
 	t->rseq.ids.cpu_cid =3D ids->cpu_cid;
 	rseq_stat_inc(rseq_stats.ids);
@@ -488,8 +503,17 @@ static __always_inline bool rseq_exit_user_update(struct=
 pt_regs *regs, struct t
 		 */
 		u64 csaddr;
=20
-		if (unlikely(get_user_inline(csaddr, &rseq->rseq_cs)))
-			return false;
+		scoped_user_rw_access(rseq, efault) {
+			unsafe_get_user(csaddr, &rseq->rseq_cs, efault);
+
+			/* Open coded, so it's in the same user access region */
+			if (rseq_slice_extension_enabled()) {
+				/* Unconditionally clear it, no point in conditionals */
+				unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+			}
+		}
+
+		rseq_slice_clear_grant(t);
=20
 		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
 			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
@@ -505,6 +529,8 @@ static __always_inline bool rseq_exit_user_update(struct =
pt_regs *regs, struct t
 	u32 node_id =3D cpu_to_node(ids.cpu_id);
=20
 	return rseq_update_usr(t, regs, &ids, node_id);
+efault:
+	return false;
 }
=20
 static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs =
*regs)

