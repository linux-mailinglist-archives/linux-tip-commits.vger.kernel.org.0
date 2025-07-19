Return-Path: <linux-tip-commits+bounces-6145-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82937B0B120
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039D6189D7C1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA472874E7;
	Sat, 19 Jul 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtPqPRYI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gxeZcygA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF93286D7A;
	Sat, 19 Jul 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946820; cv=none; b=O9evlvTrvEKaSfCQDkAef6ZA/1sXrs27rt0ex1pLglf66o13YoOpbX0wU9BZ1SDYqTeCym0N0ktqCkIG6c3X/rcLdEtfQ8CrGauyHvUC2WU2jkcQoV9YrXiCmMCrK106ExXUbnCg/wHxKciy3iPMvCPJkvXG9Bfb3B4EXx+dR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946820; c=relaxed/simple;
	bh=+XNnycT+4t91eENTsaQuafCpqSOcOqrmnMk/bJTdNcY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b8MRJ+aMrhUi882qHHoboK+aJfMIEjww2pqXcsXbw9rDskT9pXnyylYkLHTMu+5ie9PU1lHTdBSPPjivCp+HtY+Kyp6GJIDsuJVKce0GXSS++EurWKixI66NCtBW1w1r9HxTaEihK6WAC1jM9SaaT+5EjWKeX16ljVM/QOJaynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtPqPRYI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gxeZcygA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HATm2OTrgN6iugAtrwejj2SsLy3nULcnGF4hGiwQC4=;
	b=ZtPqPRYIvnpLg3V93uGe6WtCtwFO9UfHV3UejLhd18WQ9CpbOKbPO0BxQq0ltO5rCOvlhZ
	wHQrmt36U4vY1hs8asyYox9ACOdJ+0+cmeCRXrpCu/Uw4eCbviwyEgXNz31mw3e+CwW/ko
	MLXmhhwsxsdcThMzdI6ToitKooD7GUOrHhF1AphyLkQdb/V8O6/Y6e+KX0brQiCoiWQV2Y
	WUKl8+3KALfV28q0mpnLhnKRXl4bHdYmOhQPCLjrARj/G4B5SgP5EONHz0wz28Rql85viu
	oYuvE+v1Lw2ZidcJ/We50iES1VfBX4obWCCer7TfwGdC76mPMnwCOs49Spfd6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HATm2OTrgN6iugAtrwejj2SsLy3nULcnGF4hGiwQC4=;
	b=gxeZcygAiCGiJGzrZgVdKpIdERO3cER9YfMTJh+nH7FmClewW0kHUbdsCNqw6Y3Y7DBgVG
	Ys34qthZIyHRRIAA==
From: "tip-bot2 for Ran Xiaokai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Remove redundant #ifdefs
Cc: Ran Xiaokai <ran.xiaokai@zte.com.cn>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250704015218.359754-1-ranxiaokai627@163.com>
References: <20250704015218.359754-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294680978.1420.2040008372420129741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1dfe5ea6dbb3e03073f5426d65394694683b8692
Gitweb:        https://git.kernel.org/tip/1dfe5ea6dbb3e03073f5426d65394694683=
b8692
Author:        Ran Xiaokai <ran.xiaokai@zte.com.cn>
AuthorDate:    Fri, 04 Jul 2025 01:52:18=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Mon, 14 Jul 2025 21:57:29 -07:00

locking/mutex: Remove redundant #ifdefs

hung_task_{set,clear}_blocker() is already guarded by
CONFIG_DETECT_HUNG_TASK_BLOCKER in hung_task.h, So remove
the redudant check of #ifdef.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250704015218.359754-1-ranxiaokai627@163.com
---
 kernel/locking/mutex.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a39eccc..d4210dc 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -191,9 +191,7 @@ static void
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
-#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
-#endif
 	debug_mutex_add_waiter(lock, waiter, current);
=20
 	list_add_tail(&waiter->list, list);
@@ -209,9 +207,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_wa=
iter *waiter)
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
=20
 	debug_mutex_remove_waiter(lock, waiter, current);
-#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	hung_task_clear_blocker();
-#endif
 }
=20
 /*

