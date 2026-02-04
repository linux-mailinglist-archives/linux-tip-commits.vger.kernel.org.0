Return-Path: <linux-tip-commits+bounces-8201-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L34HklJg2m0kwMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8201-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 14:27:37 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA6E668D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 14:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 864E5300A589
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Feb 2026 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F3E3F23BD;
	Wed,  4 Feb 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="anGqIy26";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwP5H7lH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6632389DEB;
	Wed,  4 Feb 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211643; cv=none; b=uk6HVc6IiUxAbfWnyWir2gD14p+d8I8jUoCrwDdqty5AvmU/BgWvvBOIQBwMMtgu77mIyHFppDcMcn84+1uNa98ELPlu5IuTgcU+gwo9XD08ychgwBMDaWlNl8jlX+lGCnukz+SNyc3WaR7VLmUAUK9tdDAQ+yGPnzVlFunK4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211643; c=relaxed/simple;
	bh=bFZa0fw+BVQpWB/9Q/qv0y7wUP4TSUFFzadRDkeGcao=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pPQuEF654+3aUeV8Ym+9RMuo334TMUoVLdEEHp9HFO/W8vchMDeZCDmP7EWtRWE7Atzkpy03NtEQPB0aXB8HwMCvIquwi5uTKsBDXwAkBO6HJaJkDA87U4m+kKoItQ42dWZh78PVdeRtDTCL5eIaBvEkkziGudSKoA+ukRyNE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=anGqIy26; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwP5H7lH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Feb 2026 13:27:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770211641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3ifc3View4b7wUtyU183vKGEfSwfu8/EQ8H03Nz5WQ=;
	b=anGqIy26vQWtO0CmJyENQq88zee5wkFbl2IiVKnr3ews1li9a4RmgE6sYfg0ggccFoa6Bq
	emQEtIxRnJSqq1aLG/PCWrEsj3fDlf7ovOZYUNK/r+Q9Z9J3t7yLFtNjMJhekiZLfltucb
	Q1DCo5RApsxbyIh7+2sMf0+j3SOQaQCJJyz0Hsf1+m9U1qm6xsrrPr9pnAjPM9IVyCPv7S
	cOdpN5oKFDOx1rSAXFHvIbic60V/scCSlH/z6bR8uv0MHgs940eA6B9ZjDAqkjq0haesV9
	tuVUlUf4S8rlo2CFRs4MvdEt0crpdUXSJi2aGsmHUfPu25faMsEIRY3EYP/GzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770211641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3ifc3View4b7wUtyU183vKGEfSwfu8/EQ8H03Nz5WQ=;
	b=AwP5H7lHoPuZy0K692iQ0BRun5HNyCm1T+fq5JyVVqxoak9c/Sq7DTcz7k8fRAjs45bJl3
	LiahsegIgrOpKvDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/mmcid: Drop per CPU CID immediately when
 switching to per task mode
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260201192835.032221009@kernel.org>
References: <20260201192835.032221009@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177021164006.2495410.14369942157446625184.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8201-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:email,msgid.link:url,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 87FA6E668D
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     007d84287c7466ca68a5809b616338214dc5b77b
Gitweb:        https://git.kernel.org/tip/007d84287c7466ca68a5809b616338214dc=
5b77b
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Mon, 02 Feb 2026 10:39:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Feb 2026 12:21:12 +01:00

sched/mmcid: Drop per CPU CID immediately when switching to per task mode

When a exiting task initiates the switch from per CPU back to per task
mode, it has already dropped its CID and marked itself inactive. But a
leftover from an earlier iteration of the rework then reassigns the per
CPU CID to the exiting task with the transition bit set.

That's wrong as the task is already marked CID inactive, which means it is
inconsistent state. It's harmless because the CID is marked in transit and
therefore dropped back into the pool when the exiting task schedules out
either through preemption or the final schedule().

Simply drop the per CPU CID when the exiting task triggered the transition.

Fixes: fbd0e71dc370 ("sched/mmcid: Provide CID ownership mode fixup functions=
")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20260201192835.032221009@kernel.org
---
 kernel/sched/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8580283..8549849 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10727,8 +10727,14 @@ void sched_mm_cid_exit(struct task_struct *t)
 			scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
 				if (!__sched_mm_cid_exit(t))
 					return;
-				/* Mode change required. Transfer currents CID */
-				mm_cid_transit_to_task(current, this_cpu_ptr(mm->mm_cid.pcpu));
+				/*
+				 * Mode change. The task has the CID unset
+				 * already. The CPU CID is still valid and
+				 * does not have MM_CID_TRANSIT set as the
+				 * mode change has just taken effect under
+				 * mm::mm_cid::lock. Drop it.
+				 */
+				mm_drop_cid_on_cpu(mm, this_cpu_ptr(mm->mm_cid.pcpu));
 			}
 			mm_cid_fixup_cpus_to_tasks(mm);
 			return;

