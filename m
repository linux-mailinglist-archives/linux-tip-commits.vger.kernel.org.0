Return-Path: <linux-tip-commits+bounces-7250-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7D5C2FD79
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A5C3AA003
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8C8322A25;
	Tue,  4 Nov 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LHnJ3ny9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vn9wXf+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF6321420;
	Tue,  4 Nov 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244266; cv=none; b=AsEklC2EN7Y21VLlsJZqEUsunDRdzUVTdLwv8D6bQMfEKeJQ8KfJzc19DKdSS6e+3YYLRMJosE5I+FIDAWMNel5+qWFZWYDTx3Rbc+FtSCHIpgQ4DK2hIAaAbdb3l2pUjUMpkJuVtocZwngq3JYYkYqL953wWmZ1K4D3odGRt4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244266; c=relaxed/simple;
	bh=9t2keLGlWylOObYbQV8viJOfikud50u8TQ/p8iSJcAs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cZVjoYj3mFmHFpWVKRZT1Daerwjk9yF6OR3c/cR9bWdNWwzB9zs7tcMoG6ns72WpVxTtUpKK54qhgJcMjVqsu+e/rG15x1gEdj7NoRAifElLl1VD0XR8h0Z8zfiZfCskGPRabFF8GUggVR+q6c/Wb9OD4TN2xg4dTId4WvigaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LHnJ3ny9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vn9wXf+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPj2vIeUhPrLjR57tLKUb8/FUbjvl/KUk8QH7pNMrEU=;
	b=LHnJ3ny9g6h1tHR2gR3TgSDz84lcMr/r50O33A2/24NayCfI81Fwg+uLJIdBdn0vKWo3zZ
	pAzh00ToYCFT0URiwV/MammSKEu8IRdtWH6ReLVgJftE88OYT97IBPfbY1/4b22hVnLMH7
	m3pjPRSW1Tw11VOXCfiGP+W/IVq6n1DHRynDi8lHvQCUrCaOEVodPgC+UUFtf/3HRTSox2
	h46/Hpc52CNj4TEEP7udaXuWeKxn6JsBH+Ci7eFBcCXmTn6hoA1nYZt1K1V2tTupQdAfbk
	wrFcwTixK/yS9MFIWH65YvhUwIgmmBvOs+rv+bje5uRW4PbQhAAVJpN6EKf5uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPj2vIeUhPrLjR57tLKUb8/FUbjvl/KUk8QH7pNMrEU=;
	b=0vn9wXf++LdzaR/pjUzIBDLnwSN1e/sqn0ZXu9lvWvr9jyOBqKMthU9HeQi+Vf3D6MqOXV
	oJUyRuZLdGd7bUBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Move algorithm comment to top
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.149519580@linutronix.de>
References: <20251027084306.149519580@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224426080.2601451.9036759120278947883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     77f19e4d4fc90a9364f5055a4daf8b98a76cb303
Gitweb:        https://git.kernel.org/tip/77f19e4d4fc90a9364f5055a4daf8b98a76=
cb303
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:29:52 +01:00

rseq: Move algorithm comment to top

Move the comment which documents the RSEQ algorithm to the top of the file,
so it does not create horrible diffs later when the actual implementation
is fed into the mincer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.149519580@linutronix.de
---
 kernel/rseq.c | 119 ++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 60 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 246319d..51fafc4 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -8,6 +8,65 @@
  * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
=20
+/*
+ * Restartable sequences are a lightweight interface that allows
+ * user-level code to be executed atomically relative to scheduler
+ * preemption and signal delivery. Typically used for implementing
+ * per-cpu operations.
+ *
+ * It allows user-space to perform update operations on per-cpu data
+ * without requiring heavy-weight atomic operations.
+ *
+ * Detailed algorithm of rseq user-space assembly sequences:
+ *
+ *                     init(rseq_cs)
+ *                     cpu =3D TLS->rseq::cpu_id_start
+ *   [1]               TLS->rseq::rseq_cs =3D rseq_cs
+ *   [start_ip]        ----------------------------
+ *   [2]               if (cpu !=3D TLS->rseq::cpu_id)
+ *                             goto abort_ip;
+ *   [3]               <last_instruction_in_cs>
+ *   [post_commit_ip]  ----------------------------
+ *
+ *   The address of jump target abort_ip must be outside the critical
+ *   region, i.e.:
+ *
+ *     [abort_ip] < [start_ip]  || [abort_ip] >=3D [post_commit_ip]
+ *
+ *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
+ *   userspace that can handle being interrupted between any of those
+ *   instructions, and then resumed to the abort_ip.
+ *
+ *   1.  Userspace stores the address of the struct rseq_cs assembly
+ *       block descriptor into the rseq_cs field of the registered
+ *       struct rseq TLS area. This update is performed through a single
+ *       store within the inline assembly instruction sequence.
+ *       [start_ip]
+ *
+ *   2.  Userspace tests to check whether the current cpu_id field match
+ *       the cpu number loaded before start_ip, branching to abort_ip
+ *       in case of a mismatch.
+ *
+ *       If the sequence is preempted or interrupted by a signal
+ *       at or after start_ip and before post_commit_ip, then the kernel
+ *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
+ *       ip to abort_ip before returning to user-space, so the preempted
+ *       execution resumes at abort_ip.
+ *
+ *   3.  Userspace critical section final instruction before
+ *       post_commit_ip is the commit. The critical section is
+ *       self-terminating.
+ *       [post_commit_ip]
+ *
+ *   4.  <success>
+ *
+ *   On failure at [2], or if interrupted by preempt or signal delivery
+ *   between [1] and [3]:
+ *
+ *       [abort_ip]
+ *   F1. <failure>
+ */
+
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -98,66 +157,6 @@ static int rseq_validate_ro_fields(struct task_struct *t)
 	unsafe_put_user(value, &t->rseq->field, error_label)
 #endif
=20
-/*
- *
- * Restartable sequences are a lightweight interface that allows
- * user-level code to be executed atomically relative to scheduler
- * preemption and signal delivery. Typically used for implementing
- * per-cpu operations.
- *
- * It allows user-space to perform update operations on per-cpu data
- * without requiring heavy-weight atomic operations.
- *
- * Detailed algorithm of rseq user-space assembly sequences:
- *
- *                     init(rseq_cs)
- *                     cpu =3D TLS->rseq::cpu_id_start
- *   [1]               TLS->rseq::rseq_cs =3D rseq_cs
- *   [start_ip]        ----------------------------
- *   [2]               if (cpu !=3D TLS->rseq::cpu_id)
- *                             goto abort_ip;
- *   [3]               <last_instruction_in_cs>
- *   [post_commit_ip]  ----------------------------
- *
- *   The address of jump target abort_ip must be outside the critical
- *   region, i.e.:
- *
- *     [abort_ip] < [start_ip]  || [abort_ip] >=3D [post_commit_ip]
- *
- *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
- *   userspace that can handle being interrupted between any of those
- *   instructions, and then resumed to the abort_ip.
- *
- *   1.  Userspace stores the address of the struct rseq_cs assembly
- *       block descriptor into the rseq_cs field of the registered
- *       struct rseq TLS area. This update is performed through a single
- *       store within the inline assembly instruction sequence.
- *       [start_ip]
- *
- *   2.  Userspace tests to check whether the current cpu_id field match
- *       the cpu number loaded before start_ip, branching to abort_ip
- *       in case of a mismatch.
- *
- *       If the sequence is preempted or interrupted by a signal
- *       at or after start_ip and before post_commit_ip, then the kernel
- *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
- *       ip to abort_ip before returning to user-space, so the preempted
- *       execution resumes at abort_ip.
- *
- *   3.  Userspace critical section final instruction before
- *       post_commit_ip is the commit. The critical section is
- *       self-terminating.
- *       [post_commit_ip]
- *
- *   4.  <success>
- *
- *   On failure at [2], or if interrupted by preempt or signal delivery
- *   between [1] and [3]:
- *
- *       [abort_ip]
- *   F1. <failure>
- */
-
 static int rseq_update_cpu_node_id(struct task_struct *t)
 {
 	struct rseq __user *rseq =3D t->rseq;

