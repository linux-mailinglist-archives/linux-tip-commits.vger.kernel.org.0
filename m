Return-Path: <linux-tip-commits+bounces-2621-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DE79B31A6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 14:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4FA1F21779
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4022C1DBB13;
	Mon, 28 Oct 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jfctUK+A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsdJK5Qi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A7191F82;
	Mon, 28 Oct 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122119; cv=none; b=I0qxCDt6v5RGUmFmcGyWSIQPvc8OJZ7w0LUdEa576s3gNIztPweyLs4qzo9lSobkliebEVDWT6c1QnqYuL6rHcOCAdGhtkTQ7/VtGJPOGFQicnBAXN5SMb/sXVhBPIWpFiL0LF+D0CbI/44pLste986/65rIr63xCdGtkDO7nCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122119; c=relaxed/simple;
	bh=FfOtTeR/auU8m4QQ5/qPLZzm2zX1IScxEqxSMnEGVhs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SEJ6llLmMSaV9B08ZKD32bsisPH6eLYa3HesdN3WuJBF0wHRNAK4mu6isibjIVisNMYo9EEnzDb9hADAwE66hP6JK/xfEf6SJjfAZHprZXrwWntB3EsQKJFiJKjSxn6bV0IrmebpK95TW9fInWgzxb4XeR6aZ80vSvsX4HrlGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jfctUK+A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jsdJK5Qi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 13:28:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730122114;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4fsRrd14lXxAIgkEora+wBBF+LFp5IkLbbWqkL0FUU=;
	b=jfctUK+AFyXq9yqlnVpb0FQWv9P0sw9u5tZE0UmfDnGChKy9G3F7kXn124XbrQsXWDfzp+
	6BLnS1+zp/7KWDMHDKpLDxaLfbDmZyr29/8+jOx2QhzdtqCpJMa5DlUCqe60+/GHye5v5B
	cwmW3+L+1YKNbw/a20yKdWgMKoWsP+Ljhf0Smq7vWnK60mPJAtYhcjwEdr1Y3OUn3AZ6TK
	B1ZKOIcRfLVjc8CcQKRrz7ffnhAZU07V9TtJFYX54ZZKtbm8woOzOxdz9h5Pkfd1TF//tY
	JY2SXd9J7WqRLDATVI9LX3by+hXNp71NplPaCKNdduz9qrzZuHYzGQVr3txkDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730122114;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4fsRrd14lXxAIgkEora+wBBF+LFp5IkLbbWqkL0FUU=;
	b=jsdJK5QiP+onj21xaK9FVwCZdNzLdpRwRMgClzdbe2B1/hSWVywbPhTH9BjvAmyHUCzbVl
	4jRBHzH9IV8qWTAw==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix unnused variable warning
Cc: kernel test robot <lkp@intel.com>,
 Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <a1e9c342-01c9-44f0-a789-2c908e57942b@arm.com>
References: <a1e9c342-01c9-44f0-a789-2c908e57942b@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173012211371.1442.12715311796066756881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     23f1178ad706a1aa69ac3dfaa6559f1fb876c14e
Gitweb:        https://git.kernel.org/tip/23f1178ad706a1aa69ac3dfaa6559f1fb876c14e
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Fri, 25 Oct 2024 11:53:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 26 Oct 2024 09:28:37 +02:00

sched/uclamp: Fix unnused variable warning

uclamp_mutex is only used for CONFIG_SYSCTL or
CONFIG_UCLAMP_TASK_GROUP so declare it __maybe_unused.

Closes: https://lore.kernel.org/oe-kbuild-all/202410060258.bPl2ZoUo-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202410250459.EJe6PJI5-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a1e9c342-01c9-44f0-a789-2c908e57942b@arm.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 114adac..9bad282 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1399,7 +1399,7 @@ void set_load_weight(struct task_struct *p, bool update_load)
  * requests are serialized using a mutex to reduce the risk of conflicting
  * updates or API abuses.
  */
-static DEFINE_MUTEX(uclamp_mutex);
+static __maybe_unused DEFINE_MUTEX(uclamp_mutex);
 
 /* Max allowed minimum utilization */
 static unsigned int __maybe_unused sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;

