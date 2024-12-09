Return-Path: <linux-tip-commits+bounces-3027-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9BB9E9121
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2942814A7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F76E216E2D;
	Mon,  9 Dec 2024 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RpFlnue6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iyCd/7/m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7C216E29;
	Mon,  9 Dec 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742006; cv=none; b=V+VmmV4eLDvCHirw3rRlOFXne94fPDz/yd6ykTci4F9Ba8HHXChT9hMo0ZcVHlDJ1484K434A2pJANPhVGo5JwknH/9d0cNRt14IlTZMtUnJISEr6204kerAGCQh+cUHS/MP/Q152Z9M27XXebgrdxLaeAu5l3/8DAgjWidhOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742006; c=relaxed/simple;
	bh=mnnB4kbtUAxVkSHJqGWcIT9f3BKYtX+5dDqCA0zZU9c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=scywDidNwGBVwp7ATFAuYWEF18eZ2wvA7lCYgX/JIIJn/1WM3Ah6RVPjIdVK5T3Kmgib8QdQagYbYou4gFlXMfdVzpxqyApChuQb8qk8Jf8NwVF+YuqDvnTF9eAYhzNcPSSC8pnhjUzG/vOFx0YCyOYRjgby5D7KJhN28grSQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RpFlnue6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iyCd/7/m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDwpkU9iARjt40zeT+qIh5aJEYyq/XUOUd/x7L+HcYU=;
	b=RpFlnue6UwI4RC26xYjeb7PE9SUGyxK78KMv7dxfg16XBowzzw1/qbZQkQjtQ1sJf71EK+
	4l7F6WVh63PxC8tJZrgQi1/F+7OMNfupaINYlnbJ6wYNlVoi0/+XfL1osNBV6oO8gRBVxl
	N6x8DgzE2Tk0sQ1wDi0EJucZXklpH3548A3MMFl9QBOw2ioY0xlaiupkWcvHyOko2q/+Rg
	P5KvGW1IS3CNiVzMvW8JX6WTwRv9iqqO3ScIUoK5XkwD8XkVEFiKHDFbz+DBEqwQyN+kTC
	ApXXCmLWkKyIh84UjX5scfGUL96eDAO2gKqik3qoC+duF65Kru4f8sbO1bHTFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDwpkU9iARjt40zeT+qIh5aJEYyq/XUOUd/x7L+HcYU=;
	b=iyCd/7/mGGNRyxzx7e+tROdrr3PHdlEMGQcFaySGsVsGVrazcvH+JaV8AjA7RyIo+qHnQp
	UzAKyGuevIegwUAQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Mark m*_vruntime() with __maybe_unused
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202173546.634433-1-andriy.shevchenko@linux.intel.com>
References: <20241202173546.634433-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200200.412.6653082988469066581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     95d9fed3a2aea85fe9551c2f007e186d4abb4a2a
Gitweb:        https://git.kernel.org/tip/95d9fed3a2aea85fe9551c2f007e186d4abb4a2a
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 02 Dec 2024 19:35:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:13 +01:00

sched/fair: Mark m*_vruntime() with __maybe_unused

When max_vruntime() is unused, it prevents kernel builds with clang,
`make W=1` and CONFIG_WERROR=y:

kernel/sched/fair.c:526:19: error: unused function 'max_vruntime' [-Werror,-Wunused-function]
  526 | static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
      |                   ^~~~~~~~~~~~

Fix this by marking them with __maybe_unused (all cases for the sake of
symmetry).

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241202173546.634433-1-andriy.shevchenko@linux.intel.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04db7e4..b505d3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -523,7 +523,7 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
  * Scheduling class tree data structure manipulation methods:
  */
 
-static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
+static inline __maybe_unused u64 max_vruntime(u64 max_vruntime, u64 vruntime)
 {
 	s64 delta = (s64)(vruntime - max_vruntime);
 	if (delta > 0)
@@ -532,7 +532,7 @@ static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
 	return max_vruntime;
 }
 
-static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
+static inline __maybe_unused u64 min_vruntime(u64 min_vruntime, u64 vruntime)
 {
 	s64 delta = (s64)(vruntime - min_vruntime);
 	if (delta < 0)

