Return-Path: <linux-tip-commits+bounces-6718-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720DCB9DF40
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 10:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E8E16A075
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 08:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48623D280;
	Thu, 25 Sep 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ui/3XRX9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yldHySCl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51A4C98;
	Thu, 25 Sep 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787307; cv=none; b=ZfBokk1CyieHWVrJHWTa6tJy549jjETLuVyp6lRDO0zq2xwgSd0ujnThTvTLHnAUBBhdt1imzedBVku3hchL4l0MhFqMEKnxBxIFzg1I9aK1BbUP4Jexv/gav9uahD7f0CCe1he0PF7Fu/I8t2qLaCUpZjyKPXqcPEg6s/E63Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787307; c=relaxed/simple;
	bh=376YXCaPhkGvdD1XXx1m5VpXrncKE0GzoRf3JOvPUOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ed5xX8o6jBb+LafWpmcn8zRlrFrUluPIJ5V8gHnc5nQfNYKwRl6apEsheYr5EKH7Grv8mhOAZtUySBztdAM+f3UjL80tSINEONgZkUBhlX5Notl6p6v4gCd2qIjTxP3wV4S1hBD3kTljPlZ+rjZy5ksZgPIoNa46mDunIDndvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ui/3XRX9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yldHySCl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 08:01:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758787303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BawZpDm9IlpBQpMe2tAtLR7Vgfb3JP8gjvbpA/KFhOc=;
	b=ui/3XRX96jhJF9d4ZL0TMXeqWadJX+EgLkdEQexyxri08ELttG1vsq3g59v2EGjsdG1hXl
	0vyaf9YKBZ55f0bMhMvFlr3HNcLIIY7dX2Lbn+w/rZ1U+7tXWmLw2cO2Zih4jT/RqV1RQX
	TB8C6veW5sykH5pXm3nsa2MLnr0XpLoV28hIpv976TcZW0Kp3naxTNZxG/j4Y4FJNB7/3P
	YwfNmz2Nm/8wAqIX/5fP6xjZBDSsSiuURkfdlmVdgOGd3PcVtSk+9fIrNXrzrxwlEEz7la
	6PMSYKzhC/JA42w03rWxi2P1SS+/hUfZAMWh03Ezbi9KG4uGeQTMgGK7DOJDlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758787303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BawZpDm9IlpBQpMe2tAtLR7Vgfb3JP8gjvbpA/KFhOc=;
	b=yldHySCl6Bylb9i/TRYWJAjeNbfaT4wQdVMxyDikBEr4USH2xkqcf29F35jId/yojvYMcP
	Sa7RpeupQBvsitAw==
From: "tip-bot2 for Menglong Dong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix some typos in include/linux/preempt.h
Cc: Menglong Dong <dongml2@chinatelecom.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250917060916.462278-5-dongml2@chinatelecom.cn>
References: <20250917060916.462278-5-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175878730155.709179.4136465336489093001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     45b7f780739a3145aeef24d2dfa02517a6c82ed6
Gitweb:        https://git.kernel.org/tip/45b7f780739a3145aeef24d2dfa02517a6c=
82ed6
Author:        Menglong Dong <menglong8.dong@gmail.com>
AuthorDate:    Wed, 17 Sep 2025 14:09:16 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Sep 2025 09:57:16 +02:00

sched: Fix some typos in include/linux/preempt.h

There are some typos in the comments of migrate in
include/linux/preempt.h:

  elegible -> eligible
  it's -> its
  migirate_disable -> migrate_disable
  abritrary -> arbitrary

Just fix them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/preempt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 92237c3..1022021 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -372,7 +372,7 @@ static inline void preempt_notifier_init(struct preempt_n=
otifier *notifier,
 /*
  * Migrate-Disable and why it is undesired.
  *
- * When a preempted task becomes elegible to run under the ideal model (IOW =
it
+ * When a preempted task becomes eligible to run under the ideal model (IOW =
it
  * becomes one of the M highest priority tasks), it might still have to wait
  * for the preemptee's migrate_disable() section to complete. Thereby suffer=
ing
  * a reduction in bandwidth in the exact duration of the migrate_disable()
@@ -387,7 +387,7 @@ static inline void preempt_notifier_init(struct preempt_n=
otifier *notifier,
  * - a lower priority tasks; which under preempt_disable() could've instantly
  *   migrated away when another CPU becomes available, is now constrained
  *   by the ability to push the higher priority task away, which might itsel=
f be
- *   in a migrate_disable() section, reducing it's available bandwidth.
+ *   in a migrate_disable() section, reducing its available bandwidth.
  *
  * IOW it trades latency / moves the interference term, but it stays in the
  * system, and as long as it remains unbounded, the system is not fully
@@ -399,7 +399,7 @@ static inline void preempt_notifier_init(struct preempt_n=
otifier *notifier,
  * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
  * number of primitives into becoming preemptible, they would also allow
  * migration. This turns out to break a bunch of per-cpu usage. To this end,
- * all these primitives employ migirate_disable() to restore this implicit
+ * all these primitives employ migrate_disable() to restore this implicit
  * assumption.
  *
  * This is a 'temporary' work-around at best. The correct solution is getting
@@ -407,7 +407,7 @@ static inline void preempt_notifier_init(struct preempt_n=
otifier *notifier,
  * per-cpu locking or short preempt-disable regions.
  *
  * The end goal must be to get rid of migrate_disable(), alternatively we ne=
ed
- * a schedulability theory that does not depend on abritrary migration.
+ * a schedulability theory that does not depend on arbitrary migration.
  *
  *
  * Notes on the implementation.

