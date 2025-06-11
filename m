Return-Path: <linux-tip-commits+bounces-5754-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D191AD4F90
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DE817403F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8CD25E834;
	Wed, 11 Jun 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJdS/oFE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+xxRVv/E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD325C804;
	Wed, 11 Jun 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633612; cv=none; b=Xf9zsvOeN+aWmT+eeWpF+Snj0gSQffiVwPVuGg8/yK7td6osNpq70FPPDIh5lJg2utViL2I/o7aNQnxebbfniThpsgUDNqGepdkHnaAV/GQlUd5PwfLlxDejT2NVJMdTaeTxZR84MVkob5tU+/ZRTFUsqagym9y14v/niG/8KtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633612; c=relaxed/simple;
	bh=Mg2f9Q8+ZY0LUb0gL2kekKNgbdryWgaDSx7Q2v3SObk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uimb5Ih+GcDiAnV1uhOLiXJBw8a/q33QGsnwb/JHr6RrUWn+6omqnJ0arPnZrQdZAlPoKX2taUuEHqalqdSmArnqe3G9isQG45FSM0fC+ie7HIAdBiDuGaCKIWjKspL9XTuVUUTe0s0vaFTLakc36d6BDq4i/XZFYJKfmB0AY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJdS/oFE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+xxRVv/E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:20:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749633608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75KjJ3CX/hln93EXJ0/qdLCBscoYCaubxDuoPuzpta8=;
	b=aJdS/oFEVHFTbKO8V9ljR4kyUifp7RwN3+jQ5SqN++LaHxk+OIvkENgsHoPwC0Mk9FGqat
	qYY5TPZKPPRHPWWOQIcnG7ynvZ8nuVoL9CtgL03tQJ7f+LB0xUNkoOQqd6cQdyl6uWf6lf
	leDOdg4SKihZwOQ0XXsMdqVWQ+3Tckn15+VRsvG7Jvjuzd0GU8Htqo+B6SssRo71K/MR1V
	tHXGFsCbAsEuzU8595GhvRJ657OkKv3dUkW1MD9dDp4w7sx0i4lczcKUIiY1Wz/JMYm/mA
	kuJ4XYyWDqnVM1meMl0BwHVYZPIWGBm/eKzIO06XrlXnf0T+/h6jW8FIPkspFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749633608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75KjJ3CX/hln93EXJ0/qdLCBscoYCaubxDuoPuzpta8=;
	b=+xxRVv/EoPTuJOQlKfVSnIUqHHBlu67FEc2rZIZs4cg34p1LQb8WYanCnBk6ZtAJdNvgdx
	5hX0s/lvJxlXNoCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] futex: Handle invalid node numbers supplied by user
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 syzbot+9afaf6749e3a7aa1bdf3@syzkaller.appspotmail.com,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528085521.1938355-4-bigeasy@linutronix.de>
References: <20250528085521.1938355-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963360765.406.1360605707570146966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     8337204c58899fe422db765b481711eb2d95eb0b
Gitweb:        https://git.kernel.org/tip/8337204c58899fe422db765b481711eb2d95eb0b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 28 May 2025 10:55:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:58 +02:00

futex: Handle invalid node numbers supplied by user

syzbot used a negative node number which was not rejected early and led
to invalid memory access in node_possible().

Reject negative node numbers except for FUTEX_NO_NODE.

[bigeasy: Keep the FUTEX_NO_NODE check]

Closes: https://lore.kernel.org/all/6835bfe3.a70a0220.253bc2.00b5.GAE@google.com/
Fixes: cec199c5e39bd ("futex: Implement FUTEX2_NUMA")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: syzbot+9afaf6749e3a7aa1bdf3@syzkaller.appspotmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250528085521.1938355-4-bigeasy@linutronix.de
---
 kernel/futex/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 565f971..b652d2f 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -583,8 +583,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 		if (futex_get_value(&node, naddr))
 			return -EFAULT;
 
-		if (node != FUTEX_NO_NODE &&
-		    (node >= MAX_NUMNODES || !node_possible(node)))
+		if ((node != FUTEX_NO_NODE) &&
+		    ((unsigned int)node >= MAX_NUMNODES || !node_possible(node)))
 			return -EINVAL;
 	}
 

