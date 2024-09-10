Return-Path: <linux-tip-commits+bounces-2276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC5972BC4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32612865BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE743194080;
	Tue, 10 Sep 2024 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FrS26Hu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtQFPUQh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB47192B87;
	Tue, 10 Sep 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955774; cv=none; b=Ugx78e9Or+KX24Vn756nvibRJcK9bLEEA341zO9PgXjAkJ1uw1fi/qhGW/ztICITK0CdV+CS0c8Kd5JMf2Exrxw9NMefdSLYMwIASMOlxTox6Z02DRjpuufy/CcTSPZO6iWfxmXKDIp6Oy1EsIhXLGeQWmYUar3RAdTWaxPNjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955774; c=relaxed/simple;
	bh=DIr0WnIVrI+9kGGC8PiNRpV42OVTeGWazMIa2mNBOkI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cRIXg0Wtso8/+QkdjsFTLlTJb19uIBoFX9XPi5I2kGJximn4EA+xfiZZ0Uk5g86/f2rMQEi3v0s/I1yDaEjZcWtDbEaLriOoSw1we7nciXcC+5dwxy/r9DQwKVOnmpw5V0zArKXI7HavbtR78NzW3OzkCrUggxHB+K58N3TlxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3FrS26Hu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtQFPUQh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=k9MjOrWCqIuhkWHC8fzHTS1W9lYTNdUxsOViXgOK1FM=;
	b=3FrS26Hu9HPgMGFc7RjP/pTLlNl/wgeLPc6wjLLQVkbPQQ7akfiTaJyrnR69sv17Da6bUq
	+W9pyUaPh+ZpZWObtLHpwBuhWNppc6eNgQ0m5J1B8H86bxyvA7mUdckNROEw29nGmzdY9M
	74jeFwq1GMXUXdHkbJid3Hr1h7n7bwWkDYopYFt+FoLdRjPZUGV0j1eMqP/wfSELdHH27O
	9v2sz2UtG4ethA2AUWzxz/mEnN0k2hdz9qeHiMuCWInBarFXbhMGl1NG5zIuuKs78dKHFp
	4B3rbBdqNNKI9BTbFswVi5Ck/zD809tEuhKskbPqWKq3q2wiO5lFykBFambwpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=k9MjOrWCqIuhkWHC8fzHTS1W9lYTNdUxsOViXgOK1FM=;
	b=MtQFPUQhkKQbEp5JecgDRtv2xfi3TneDGp128mBQZb1hl0u8z4wK2h5IkyDrPEKHp1vlLb
	seZF8mkIG/0E1ECA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix sched_delayed vs sched_core
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576315.2215.18439028128450913806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c662e2b1e8cfc3b6329704dab06051f8c3ec2993
Gitweb:        https://git.kernel.org/tip/c662e2b1e8cfc3b6329704dab06051f8c3ec2993
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 05 Sep 2024 17:02:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:15 +02:00

sched: Fix sched_delayed vs sched_core

Completely analogous to commit dfa0a574cbc4 ("sched/uclamg: Handle
delayed dequeue"), avoid double dequeue for the sched_core entries.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2922fac..b4c5d83 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -259,6 +259,9 @@ static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
 
 void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
+	if (p->se.sched_delayed)
+		return;
+
 	rq->core->core_task_seq++;
 
 	if (!p->core_cookie)
@@ -269,6 +272,9 @@ void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 
 void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (p->se.sched_delayed)
+		return;
+
 	rq->core->core_task_seq++;
 
 	if (sched_core_enqueued(p)) {

