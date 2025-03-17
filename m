Return-Path: <linux-tip-commits+bounces-4241-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B4A647F4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C93018920A5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DBB226D10;
	Mon, 17 Mar 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hImXZK/o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="52jc0I0E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC16221DB1;
	Mon, 17 Mar 2025 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204747; cv=none; b=ZcQGQEgkyP3ryi+0g4ZXE+vy/RBmXeuIbNEx1OCNTalcts9P9KCbb+fP3lotjWjW0xaiKL3dhdsNSOD1Y9UxQdukf9uOs3t2R42VOw5dOREbMPSPIEAfQuAbWCw/eNxPKyXwBiHfg7k03dvIPm7AZ7kswtlrOhIlO8a2W/rzviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204747; c=relaxed/simple;
	bh=BI6T9LyTCOV7vudxhPBTRT2tBLkImbWKxIcSNNoRddo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sFA3JTSIZnL9piIm7FlbhhmTr/yEoQYmAmRQNvXKyJZah1mQFyvfdUKZMFaDIZXA0OiKUpg9ccOmh32uD+0uQRsLERlt2RhQQnpzJl0x6loTUnzT4liDRvJWC4ILBlvEtNuT0ipF3mlcujL+BU075B7fqxNnCKKHDpRUSgc4E2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hImXZK/o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=52jc0I0E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 09:45:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742204744;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEqTAuRDBlR1844FBT1o9xubZGZp1MqB5lfwarLylyY=;
	b=hImXZK/oJd+d7kszq5UehbiqwgQluNL0b2g6f+1hEUmxyBZjC1Kb86MmEApBW3iyp5Qrhh
	9oP/Njf3/kkzzSbnIzpGSAGVw0I7Ujh7dbNC0fUGoh3FN/NxrxSndC2UUOAIrvTk570Q9Y
	BHCIxTtLuOb6p8z4sSNDnFms5nOKA/9SciJCq2WNcpTNtn3O5LDSXyfqwN/qEHvwqF2NkK
	SV+3V+vXIknm+iE8dBfi1GSFtj5n/zicQol4lG/ymcyiCu41wbjvSdbEJRQYqMSrYISFvG
	p/SzbW/5wNQF5Kho7pXuNxPK2ruhGomUUcDM8EDpGFtT9j4Hse9ke+PJ6c2Fug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742204744;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEqTAuRDBlR1844FBT1o9xubZGZp1MqB5lfwarLylyY=;
	b=52jc0I0EX2CY1AKdihvfb52hJapvnKQexIIdo0/lpxK7/EfloI58ZTz8LYYrNSMiZ3vDiE
	SjfIe4P4bI2J9NCQ==
From: "tip-bot2 for Cyrill Gorcunov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Drop redundant memset() invocation
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Z9ctVxwaYOV4A2g4@grain>
References: <Z9ctVxwaYOV4A2g4@grain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220473522.14745.13008426913238808969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d1c3a3f1c9a1dfc2b41696b7903972f4b3fbcd02
Gitweb:        https://git.kernel.org/tip/d1c3a3f1c9a1dfc2b41696b7903972f4b3fbcd02
Author:        Cyrill Gorcunov <gorcunov@gmail.com>
AuthorDate:    Sun, 16 Mar 2025 22:58:15 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Mar 2025 10:38:49 +01:00

posix-timers: Drop redundant memset() invocation

Initially in commit 6891c4509c79 memset() was required to clear a variable
allocated on stack. Commit 2482097c6c0f removed the on stack variable and
retained the memset() despite the fact that the memory is allocated via
kmem_cache_zalloc() and therefore zereoed already.

Drop the redundant memset().

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/Z9ctVxwaYOV4A2g4@grain
---
 kernel/time/posix-timers.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2ca1c55..bc0bdf4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -526,7 +526,6 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	} else {
 		new_timer->it_sigev_notify     = SIGEV_SIGNAL;
 		new_timer->sigq.info.si_signo = SIGALRM;
-		memset(&new_timer->sigq.info.si_value, 0, sizeof(sigval_t));
 		new_timer->sigq.info.si_value.sival_int = new_timer->it_id;
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}

