Return-Path: <linux-tip-commits+bounces-2272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC3D972BB9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2163328AF1C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1F18FDD5;
	Tue, 10 Sep 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OuHGcLy/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJdGdjCV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7218FDC5;
	Tue, 10 Sep 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955771; cv=none; b=fMb0YEwtvjmANiwbAdEaxJUgE4G0ZJKy/xDQDjxYEWK8FbXSGS6bT0i/rCJUgBsz1LJEtxVn77uGHHU4BnZEatupC5hZyPzY8BseWp44g+XReyiP4E4KArzmbICDUrCcPbYhXvdqI6+5uqGP/88GYP92Rla9uhNtZ09ydqZFHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955771; c=relaxed/simple;
	bh=MkeYnlhdEESH2TrS9SFr8mlAOIX/Xz4Z/oUd5ak5aK8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TuKkOTmtXeR/cQ55MTIU7nWE9q3Df7EP5kWoXWMmjIttX9SqF3zApJIznYetGQeZN/175U3cOfRjfZ/j4IcUUlDh9FPST2JrBW9UvYeNPbaztaXIi9IqrGMll33QSoShtMUFAhyiptoS9nGhTtAWgNdeHGX/IcAHxSM5koQ/Z1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OuHGcLy/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJdGdjCV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HN4Nw0VxFB1571u5uytu8fVnj0sR/WNHFCDs8jJ+bDw=;
	b=OuHGcLy/silFVyOrQn1qpNfyNVvdAdplmTG/FDRYR9sKn6Ac8zYk/MExW1W8NK6pA8gQmx
	LW9wyNFwS0L9fIAjDfQBcmg156/G9r9G2QSF52DMb54JeuMsGCC50aMcNqHnanKzw2EfQ7
	BI4r8Dmlaqs0eXlx8PRVv77GneoVjNxALN3zcWK0CHsUnUrGF/SqR8fYJZRAUimhByB9Bw
	PXnKWILeFMeV3wtQ5h94KrusyToPJAxQAfHGs2oJdtuFC5FLms31kkTeC6T/6QANsrETYQ
	JyLC7HatPO0uJl5G9NUHrSIfJpvbpkBAv1fKAicB08jTNXqLvk593mIV8aiQGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HN4Nw0VxFB1571u5uytu8fVnj0sR/WNHFCDs8jJ+bDw=;
	b=mJdGdjCVZE1wMqe7kqRlQxRhLa2Dspgt0E82XePbtHo5lDtpzEUthTaSdpcxYjKeBKQo2M
	kU6FyLADo5DdLaAA==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Clarify nanoseconds in uapi
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813144348.1180344-3-christian.loehle@arm.com>
References: <20240813144348.1180344-3-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576164.2215.5427726851322207167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     478b58152034395024b692ea94af0d01810a6522
Gitweb:        https://git.kernel.org/tip/478b58152034395024b692ea94af0d01810a6522
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 13 Aug 2024 15:43:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:16 +02:00

sched/deadline: Clarify nanoseconds in uapi

Specify the time values of the deadline parameters of deadline,
runtime, and period as being in nanoseconds explicitly as they always
have been.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240813144348.1180344-3-christian.loehle@arm.com
---
 include/uapi/linux/sched/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 9066238..bf6e9ae 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -58,9 +58,9 @@
  *
  * This is reflected by the following fields of the sched_attr structure:
  *
- *  @sched_deadline	representative of the task's deadline
- *  @sched_runtime	representative of the task's runtime
- *  @sched_period	representative of the task's period
+ *  @sched_deadline	representative of the task's deadline in nanoseconds
+ *  @sched_runtime	representative of the task's runtime in nanoseconds
+ *  @sched_period	representative of the task's period in nanoseconds
  *
  * Given this task model, there are a multiplicity of scheduling algorithms
  * and policies, that can be used to ensure all the tasks will make their

