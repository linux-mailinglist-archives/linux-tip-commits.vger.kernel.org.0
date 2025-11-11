Return-Path: <linux-tip-commits+bounces-7304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9963BC4D77B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E53B14EDB6F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7770535A950;
	Tue, 11 Nov 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TqTx03gU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHgJmaUg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0B35A15E;
	Tue, 11 Nov 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861045; cv=none; b=SRukrx/j0CnbnLrZjsjnTWJNhfxYIeR/2eGeaxaqiG3sOQp4Ofqo4u8CI0PjZz9iSoz7uM7SWMqDrxG9Wa48DAeTm+uD0f6t2x/VxiizZ/zpO62CvdXQeQojXN8F46B5pDoAi9loMvsJVb386/8T1ul7oMFlx6zsdVfaWmSno7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861045; c=relaxed/simple;
	bh=ViECBRkTjNAo63ox96zmO3Y8dPuYCROJsqzbiyn+MrM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rIH5dXsuMf6CtBfrr9luY0CMOsb8t+kdCYCng3Ixq9rGsWz9e7jQ5OnudOJFuUsewivpXZ2thr3dy32EbwZ2Ez1wH0iE8azNt2Le6e6ipGxjkugrXJGsc8mNHMDFD0Z4Vg6RYXfrR6HmxeOODUzS42pLHP3agdHMw4o9soBKCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TqTx03gU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHgJmaUg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30m94jH1yu8E3ZTCgg56Epvjvrj7lWA/Qp13LurCg9U=;
	b=TqTx03gUb4xOFJWKqidQgb9KtIFSBfLEjie4U095SfnSAcLxMatgI+D1HGfx8gbXRjn7dO
	gzY2lm84M/4vdYlRw5JFUBq0WPO0zbU+hje+DNNQEwKZTLPPLzia6b2fjkeitnBi/YkoZJ
	hQropza56CB7yfm7un+sljiUzAgutg8DEpgRmHcTspZXlyggLrC8nAOzuu6s2Wngb+oAxL
	J3Xt22ZesUz+gQn3hw5JgS2IwsKvaCVMHo8HgLmiYhMIVE9QOIjGC1dAfP0+cqouD4ggX6
	1G5NBYDRe3z5NlOFrH7vl+49wds+4Jt6YDRUmK9HN3RxNp0lak9Wci3+VSzIPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30m94jH1yu8E3ZTCgg56Epvjvrj7lWA/Qp13LurCg9U=;
	b=GHgJmaUg75eq7G4lcOuRO319e4SqGVJ0Vq0qBbVEC9MDI84xmmjzm3Vw/JxXsx1Nksm7Kv
	RpBc7u1DsL36a4BA==
From: "tip-bot2 for Fernand Sieber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Optimize core cookie matching check
Cc: Fernand Sieber <sieberf@amazon.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105152538.470586-1-sieberf@amazon.com>
References: <20251105152538.470586-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286104123.498.6764400674538143303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7f829bde94b1c97b1804fa5860e066ea49dbfca3
Gitweb:        https://git.kernel.org/tip/7f829bde94b1c97b1804fa5860e066ea49d=
bfca3
Author:        Fernand Sieber <sieberf@amazon.com>
AuthorDate:    Wed, 05 Nov 2025 17:25:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:37 +01:00

sched/core: Optimize core cookie matching check

Early return true if the core cookie matches. This avoids the SMT mask
loop to check for an idle core, which might be more expensive on wide
platforms.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Link: https://patch.msgid.link/20251105152538.470586-1-sieberf@amazon.com
---
 kernel/sched/sched.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04e007..82e74e8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1432,6 +1432,9 @@ static inline bool sched_core_cookie_match(struct rq *r=
q, struct task_struct *p)
 	if (!sched_core_enabled(rq))
 		return true;
=20
+	if (rq->core->core_cookie =3D=3D p->core_cookie)
+		return true;
+
 	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
 		if (!available_idle_cpu(cpu)) {
 			idle_core =3D false;
@@ -1443,7 +1446,7 @@ static inline bool sched_core_cookie_match(struct rq *r=
q, struct task_struct *p)
 	 * A CPU in an idle core is always the best choice for tasks with
 	 * cookies.
 	 */
-	return idle_core || rq->core->core_cookie =3D=3D p->core_cookie;
+	return idle_core;
 }
=20
 static inline bool sched_group_cookie_match(struct rq *rq,

