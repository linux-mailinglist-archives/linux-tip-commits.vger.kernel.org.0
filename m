Return-Path: <linux-tip-commits+bounces-3419-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93542A39798
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE01F3B6793
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6F4232364;
	Tue, 18 Feb 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uVVKe02D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zk9Maj+E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB723C8BA;
	Tue, 18 Feb 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871999; cv=none; b=GDj26q/lDGmqdjRNamhaEYuqGbmbFqkxmTt2s9lD54YXbI6b0SbghSK/Lz6iPHhS66aIMDb3eGd7fSMl83XLpGo7i76QymGtSvF0gdc8NyCmr0q1PI48WgpNLbklyr8sP2t0E95lLwWGqiWCQLuC/T3Cy5M7xucD2mbLqb5nE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871999; c=relaxed/simple;
	bh=FTp3Y9CVp5p95Vm0xwXBYrW7zbXXomqTXkEZOkU14Ek=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zr/LwWByehmMYm+DJxyMgPppFBBbxAgX/ORccH27vHTLRyEtJqiF23QP1pNf1d0zu8ZR0koYWWqX3qXfBammYd4hTCI9uVBxU/8lqYHj+wliBOwKo6Z7zx75TMiyE+i9zfHQqC40KmjACAmbiwfzUzeXNrFYYS47I0hDdKd+hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uVVKe02D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zk9Maj+E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6jD067ZyIpP87+5MdXKmL95r/P4X0gItCP9RALX0G4=;
	b=uVVKe02Di2RoPa9jtxyhLfRIAsw64BFedI2iLPELvR19vUQdCHjOwm3jCju1TWycmdkT0F
	DxMdI/ZXrYSv16nRRD4PZDbflKZMnVNudwV0/SNC7QFz20sJMSZGckvl6E5RaZp0W9puZ9
	cHt2k83V/cx25hFG9Q/00CKRuwejaUOh01Vgv/7AN48KxG6gUYF5LqYtrw/g0OZjorD8uh
	Q87XYfJqF60M5LZrDiTGm6dkcStEArlvGiLnDzlcjQSkHxyO9Wwr2HpVNJX2F8dFaUMB/K
	9hP47sHTvyPlcv3H/Ft6TzPIQs/Htr9dJgZ1YLBPeJx4lWoOloQoK7xodvq4JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6jD067ZyIpP87+5MdXKmL95r/P4X0gItCP9RALX0G4=;
	b=zk9Maj+E8hjuWdLiDta3hl2pz2JmzKLC6kZOhbh2FN7uiFmyL9dIei62bn+QuYQU2T7pdn
	MbDuzxpSky4F0aBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] fork: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C174111145b945391e48936d6debcd43caec3e406=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C174111145b945391e48936d6debcd43caec3e406=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199578.10177.8118877370735336778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     91b7be704dd4991bb6ec8bb67480993e82a673bb
Gitweb:        https://git.kernel.org/tip/91b7be704dd4991bb6ec8bb67480993e82a673bb
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:32 +01:00

fork: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/174111145b945391e48936d6debcd43caec3e406.1738746821.git.namcao@linutronix.de

---
 kernel/fork.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a..e27fe5d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1891,8 +1891,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
 	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
-	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	sig->real_timer.function = it_real_fn;
+	hrtimer_setup(&sig->real_timer, it_real_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 #endif
 
 	task_lock(current->group_leader);

