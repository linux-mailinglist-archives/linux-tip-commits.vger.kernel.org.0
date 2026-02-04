Return-Path: <linux-tip-commits+bounces-8200-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ej7MrNKg2m0kwMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8200-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 14:33:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F893E6784
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 14:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73FCE30F117C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Feb 2026 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820C3F23B6;
	Wed,  4 Feb 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIvrR6fu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBI9aQMJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D223F0761;
	Wed,  4 Feb 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211642; cv=none; b=HUv76Jr+ZQUPEkN/NcBFQVwdSDZQGKo2vTCyNuC71WGqcJw1CJIjMjQo/+DQyiq4iSsFryE3KomiTTLX6T1h6ovXXxb+QcLI5MVErBevGtcV4DifG1ZCXm93PuzElCBL3TLgkNZEwWtFHcpPO081FSN3rEndv54CPB6SjexPgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211642; c=relaxed/simple;
	bh=rfzGObmIeCxmt81QYQIpwDMneM+OOZMLdqj2+Qy8uek=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pLxf6rD6501jUuXRvARaj+vx1YyrR+vVi3ILKCxrk67tRIxU6Kt/7S60r5DF5CD9TrocnvyCX+ic0nTZNVByGGPdPAfY7jeXGghWjNYgwQia1YUKgYaX8v1AMtGUlQw4AiP4H2D12VPzjSysZuqjByo2ejxlVA2B7VYasxBWSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIvrR6fu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBI9aQMJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Feb 2026 13:27:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770211640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+yyqYxvfV2xVI57MuguJ00yKziguG1BXoO8J2ILgnQ=;
	b=hIvrR6fu0gt2ToesKEX7mXb7S9OfUbS4BIiw5Q9KaRa/oRpWDJ52OfvAGDPfZX4/6g7ccC
	WwagV4suvtBldeHPaest+y2zTJJYLZw8P/kSpFa0+pG65hFugfn+q2UHPsI3xgBtTkMWmQ
	GdiBz8GqOghOObEQbPISdqC9Qd7aEsu3QJPZz15+39UvUZOjPepnuokY3nATpuFVJY0tdP
	OePFTTyAVISH9wUAD753hD/soJjvWvyWH9yH7oAIf9UjVNcoKHlKhMqCIx+UNAKQcM6lbb
	w+cpNhHCf2/sd+yecN/Cjuo0MFFgCl+VzrhLmHbF5hLgP5eojhw3ZrVM3VzM8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770211640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+yyqYxvfV2xVI57MuguJ00yKziguG1BXoO8J2ILgnQ=;
	b=aBI9aQMJOud6YO6b3l7oVS/pK8mE65NvSjOjo4PW/xqvrXcNRffGz0YWcpyJihK1DnkgeI
	vYNlSj+/8sZ0unAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/mmcid: Optimize transitional CIDs when
 scheduling out
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260201192835.100194627@kernel.org>
References: <20260201192835.100194627@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177021163876.2495410.14698078484542619057.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8200-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,efficios.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:email,linutronix.de:dkim,infradead.org:email];
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
X-Rspamd-Queue-Id: 2F893E6784
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4463c7aa11a6e67169ae48c6804968960c4bffea
Gitweb:        https://git.kernel.org/tip/4463c7aa11a6e67169ae48c6804968960c4=
bffea
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Mon, 02 Feb 2026 10:39:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Feb 2026 12:21:12 +01:00

sched/mmcid: Optimize transitional CIDs when scheduling out

During the investigation of the various transition mode issues
instrumentation revealed that the amount of bitmap operations can be
significantly reduced when a task with a transitional CID schedules out
after the fixup function completed and disabled the transition mode.

At that point the mode is stable and therefore it is not required to drop
the transitional CID back into the pool. As the fixup is complete the
potential exhaustion of the CID pool is not longer possible, so the CID can
be transferred to the scheduling out task or to the CPU depending on the
current ownership mode.

The racy snapshot of mm_cid::mode which contains both the ownership state
and the transition bit is valid because runqueue lock is held and the fixup
function of a concurrent mode switch is serialized.

Assigning the ownership right there not only spares the bitmap access for
dropping the CID it also avoids it when the task is scheduled back in as it
directly hits the fast path in both modes when the CID is within the
optimal range. If it's outside the range the next schedule in will need to
converge so dropping it right away is sensible. In the good case this also
allows to go into the fast path on the next schedule in operation.

With a thread pool benchmark which is configured to cross the mode switch
boundaries frequently this reduces the number of bitmap operations by about
30% and increases the fastpath utilization in the low single digit
percentage range.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260201192835.100194627@kernel.org
---
 kernel/sched/sched.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f85fd6b..bd350e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3902,12 +3902,31 @@ static __always_inline void mm_cid_schedin(struct tas=
k_struct *next)
=20
 static __always_inline void mm_cid_schedout(struct task_struct *prev)
 {
+	struct mm_struct *mm =3D prev->mm;
+	unsigned int mode, cid;
+
 	/* During mode transitions CIDs are temporary and need to be dropped */
 	if (likely(!cid_in_transit(prev->mm_cid.cid)))
 		return;
=20
-	mm_drop_cid(prev->mm, cid_from_transit_cid(prev->mm_cid.cid));
-	prev->mm_cid.cid =3D MM_CID_UNSET;
+	mode =3D READ_ONCE(mm->mm_cid.mode);
+	cid =3D cid_from_transit_cid(prev->mm_cid.cid);
+
+	/*
+	 * If transition mode is done, transfer ownership when the CID is
+	 * within the convergence range to optimize the next schedule in.
+	 */
+	if (!cid_in_transit(mode) && cid < READ_ONCE(mm->mm_cid.max_cids)) {
+		if (cid_on_cpu(mode))
+			cid =3D cid_to_cpu_cid(cid);
+
+		/* Update both so that the next schedule in goes into the fast path */
+		mm_cid_update_pcpu_cid(mm, cid);
+		prev->mm_cid.cid =3D cid;
+	} else {
+		mm_drop_cid(mm, cid);
+		prev->mm_cid.cid =3D MM_CID_UNSET;
+	}
 }
=20
 static inline void mm_cid_switch_to(struct task_struct *prev, struct task_st=
ruct *next)

