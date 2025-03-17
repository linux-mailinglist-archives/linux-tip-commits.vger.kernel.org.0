Return-Path: <linux-tip-commits+bounces-4251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7FA64A35
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED15188EC4E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED58236A7B;
	Mon, 17 Mar 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lshX1KW/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pq1c6Amt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5D2356CE;
	Mon, 17 Mar 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207655; cv=none; b=ESb6/oM7W299z84OedJCO5PaQFFNEASRXU0kxVowFITVJxmgStovSx6G6wzVpESukiwhgKez0ol2Z/TLL6wuxGhkkTwACsnPXB+xM7SU/zoEHL5CSKGhdx8Sp1c5NOwBEXNK7iZbEH2rX0Sip/3+u4sGnX5sWIxJE6aNaR1F1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207655; c=relaxed/simple;
	bh=HZShN4wlS7ms1Ft/uMt/q5h9b9+y/CEKi41ENckaZKs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GOknLOPaLcNWRioMyuTDsVTzeYCHWl7lWz9uQ5BWyXRL0A5QrpbAZxy1RowBGGfMx+6Ucp60hL1JYKou4nlExEv5qCgoAx+X7IwQykg/yrOEE6O3J5i6Qx4uQHWyF22zhOaNoNPg/ciDGN/mIae793zKDw8E2KpKOCvXwGsPzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lshX1KW/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pq1c6Amt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4XpulzWcwjcjbTJU9bdwjf2uibRkHORCrYvxbm3V/M=;
	b=lshX1KW/M2GGtcJ/Fcc19axJ9DJMcKp3FsMM1/GczjvGyOeA0ha9g6C52BRZAIu3wzvi9U
	RRJt6/sVuLHaMKQ4SRod/Bwhx+C007GMlEMNHJ7huvb+RHUDlpQts4Ge+hRtkkC0bPC9L+
	Z08mhlZtX64uxkMVajscpY2SM/1uF3MFQVslGIvB3nliB5IrPXcVwlAqhECMC8Dur/Mb8+
	dBdyyirvUwlZMoerlHPElteVVmTCnJTZpHYmzRO2v1yUdFNHBobIkHUva8NtkSaVPG5gL3
	0IRMOsgy05hb5+R8BMReAV/RrRJcMu0EVRJtDr2wtAxkQQgKlV2qeoG+g7TxxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4XpulzWcwjcjbTJU9bdwjf2uibRkHORCrYvxbm3V/M=;
	b=pq1c6AmtNCl1wnEzmHoipVMtOAGsSr0CpNJ+8sCcW2HPS1WdbHnl2IWUpzU8cYzITIJzu8
	sLsMh7Si/VF33xCg==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] locking/percpu-rwsem: Add guard support
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314172700.438923-2-kan.liang@linux.intel.com>
References: <20250314172700.438923-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220765152.14745.3454721970841815266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fdfda868ee3b5da1fbdb7710b731e09d8dd3a615
Gitweb:        https://git.kernel.org/tip/fdfda868ee3b5da1fbdb7710b731e09d8dd3a615
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Fri, 14 Mar 2025 10:26:55 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:36 +01:00

locking/percpu-rwsem: Add guard support

To simplify the usage of the percpu rw semaphore.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250314172700.438923-2-kan.liang@linux.intel.com
---
 include/linux/percpu-rwsem.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index c012df3..af7d75e 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
@@ -125,6 +126,13 @@ extern bool percpu_is_read_locked(struct percpu_rw_semaphore *);
 extern void percpu_down_write(struct percpu_rw_semaphore *);
 extern void percpu_up_write(struct percpu_rw_semaphore *);
 
+DEFINE_GUARD(percpu_read, struct percpu_rw_semaphore *,
+	     percpu_down_read(_T), percpu_up_read(_T))
+DEFINE_GUARD_COND(percpu_read, _try, percpu_down_read_trylock(_T))
+
+DEFINE_GUARD(percpu_write, struct percpu_rw_semaphore *,
+	     percpu_down_write(_T), percpu_up_write(_T))
+
 static inline bool percpu_is_write_locked(struct percpu_rw_semaphore *sem)
 {
 	return atomic_read(&sem->block);

