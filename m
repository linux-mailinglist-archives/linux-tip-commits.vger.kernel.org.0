Return-Path: <linux-tip-commits+bounces-3344-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6529A2D6B4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Feb 2025 15:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3543A4936
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Feb 2025 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D35248160;
	Sat,  8 Feb 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNwJRzvS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QKYvm0k1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FFC1991BF;
	Sat,  8 Feb 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739026307; cv=none; b=P4r4tP6Ym0/spzXuSgtO16OTcFCn97Iz2o7/EqRNZtoqnNVkw0Eq68Imrib66JeI61l6ZC8a2G0xe3yB7pbf8ZH3dEE0LNhKizfjY6bkE3wVURJz96aATHK6baajffiV/EQRy0AUhRNk+gArg9s3HSv4aYKFtT/XQe+yHGupdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739026307; c=relaxed/simple;
	bh=4udUPyJpyxlTaSLJ3iqavDulpU/MfqnI7dL3Lgq9lCQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OVqe+I0efbm2jyQBbOmr8Z0QrnYaYGWSt9EBOumDdPIOWxJY+uKQLjPfOeS2+kLDPIUU4qAAEWmLVU191pVIIWWaK//nju4hjOBDnm6N5AkkTt/i3ydGGBa+JOAVObE0MZQVRNBiK9te4hG2+8nT9P7x23AQ3hJfJZtoubUEtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNwJRzvS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKYvm0k1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Feb 2025 14:51:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739026298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k5x46N5tH/tWSfQXaLsOUFQPw7PtViFEIwoDxlejKE=;
	b=rNwJRzvST3dKqSawltYE7rxxk5c1VTof7AV7m0HrNLcEEdJ5/ALWitQ4I1XnIkUMcNV8AC
	XiW44j3q19VDzhahahlVzHha293hZ5NXAXVTAEoQqgAb/I0+M5ipEkf8/x/8lVtdSRpkAw
	G4nSbCOmQ2YrzVs7QFz5uQRj6DmXsseFDJgPfDvZih+mCmC9vxuBuxqP0NCceATmE4dJyk
	W2jCc0wr7cpmjEJuNlclVnDGf48kjaOft8HxHzwXc7/0V/5CDcaYlJnFQ4gBzkVnU8t7TW
	Wt0FqcjO9ixhJaVQ9UrQ4QAAauOvWZMhQLcymOmV7lEnF/Al7rHoUxQN8O2y9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739026298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k5x46N5tH/tWSfQXaLsOUFQPw7PtViFEIwoDxlejKE=;
	b=QKYvm0k1Y6fV/YKJdklqCXg4/A14Cxf6W0mc+57/eKy+utpDwplL7igdVnN/jekTLumh2j
	TBSXaw29HFzYBAAQ==
From: "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched: Clarify wake_up_q()'s write to task->wake_q.next
Cc: Jann Horn <jannh@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250129-sched-wakeup-prettier-v1-1-2f51f5f663fa@google.com>
References: <20250129-sched-wakeup-prettier-v1-1-2f51f5f663fa@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173902629795.10177.6552765671236398998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     bcc6244e13b4d4903511a1ea84368abf925031c0
Gitweb:        https://git.kernel.org/tip/bcc6244e13b4d4903511a1ea84368abf925031c0
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Wed, 29 Jan 2025 20:53:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 08 Feb 2025 15:43:12 +01:00

sched: Clarify wake_up_q()'s write to task->wake_q.next

Clarify that wake_up_q() does an atomic write to task->wake_q.next, after
which a concurrent __wake_q_add() can immediately overwrite
task->wake_q.next again.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250129-sched-wakeup-prettier-v1-1-2f51f5f663fa@google.com
---
 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e5a6bf..8931d9b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1055,9 +1055,10 @@ void wake_up_q(struct wake_q_head *head)
 		struct task_struct *task;
 
 		task = container_of(node, struct task_struct, wake_q);
-		/* Task can safely be re-inserted now: */
 		node = node->next;
-		task->wake_q.next = NULL;
+		/* pairs with cmpxchg_relaxed() in __wake_q_add() */
+		WRITE_ONCE(task->wake_q.next, NULL);
+		/* Task can safely be re-inserted now. */
 
 		/*
 		 * wake_up_process() executes a full barrier, which pairs with

