Return-Path: <linux-tip-commits+bounces-1593-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66317927D12
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 20:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53C01F24620
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3CA7344C;
	Thu,  4 Jul 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0wNcCVro";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cutM0pz2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A44962E;
	Thu,  4 Jul 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117976; cv=none; b=V/kEtBPAC0GzNU2nz1pZ6TdJaIPmk9E7p2DdneTqtwSbh0LNyMzA7QYb8PN0OQGbFCMoymk/ZoVvzRT81TJKubSmnHVAETJjF5oAVRDFfEvoDIkRN/RMv2XGOBv5ODvHB+ZgfPHeCf1rm2Mijfd8p1qQc6aR51nDqCTst/yNGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117976; c=relaxed/simple;
	bh=X2oSqWZdJWrR8wnNZNZT7RHldCwbVgyTInEsBl0IEx4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PFbec1vo/QSDDoGsCm6EJDG7XQdAYwvI320xdpTOmNiRKAqT8aUE4PG3mrrqSV6p+XEM/WDqHzWm5EcHhlk3EBre0B2rHql8Dh0K5TidcNc/Vwl/gu1ZFxtgl4Vg2iWV2Q2A6xTLZjApDiscR75N8hY+mvEXkCWo+/ZKSGToCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0wNcCVro; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cutM0pz2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Jul 2024 18:32:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720117973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okMXq/ozh97/UGleFCWrro3p4Qvqxr2CmducT06H44U=;
	b=0wNcCVroqTVqsFbY6OU66hQCzPDbIUvJxf5Ctnsfib0iATUMMsfkDuHr+JduLzEgst4AJ2
	Z8V00S83HNTPzvAKxP6dPU0ugIzrKkUVXRCDFGOQ+SAsKHl+3fgx8fMCF2RYl/JNkUpJvD
	yfCLYA21is6sfwq2gTzNNVizcrlN7BRHV4iUSuSxyJ+wqkEAyra/xNStLVvYgTRBMeW6n6
	d+nc9t4xUDkEV+ABeqX35Rmfs6YlXu2JIHsoidE77vXfaiZ/otSfsEV083RNS0EhcAn9x7
	2R1ZoJaNSepb9QGmPft/bVtxJFo1YbsM8UOdZCu36NU3swzZen8p9d6Jylo+rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720117973;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okMXq/ozh97/UGleFCWrro3p4Qvqxr2CmducT06H44U=;
	b=cutM0pz2TGXCnAOpmVVTt/dT7eY8s0qYekfE5MNvxR62XYzAEB01ym7acsm6NmMxWSiTNj
	Sj1hDLC7wI9wTtCg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Fix grammar in comment
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-tmigr-fixes-v3-8-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-8-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172011797280.2215.10987705574256890329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     746770499be55cf375a108a321a818b238182446
Gitweb:        https://git.kernel.org/tip/746770499be55cf375a108a321a818b238182446
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 12:18:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Jul 2024 20:24:57 +02:00

timers/migration: Fix grammar in comment



Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240701-tmigr-fixes-v3-8-25cd5de318fb@linutronix.de

---
 kernel/time/timer_migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index a2d156b..23c5bbc 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1368,7 +1368,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
  *			  the only one in the level 0 group; and if it is the
  *			  only one in level 0 group, but there are more than a
  *			  single group active on the way to top level)
- * * nextevt		- when CPU is offline and has to handle timer on his own
+ * * nextevt		- when CPU is offline and has to handle timer on its own
  *			  or when on the way to top in every group only a single
  *			  child is active but @nextevt is before the lowest
  *			  next_expiry encountered while walking up to top level.

