Return-Path: <linux-tip-commits+bounces-1730-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D3937BFD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 20:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19601281A08
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EE146A73;
	Fri, 19 Jul 2024 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChxNjzdu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O4US0ZXd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CC39863;
	Fri, 19 Jul 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412374; cv=none; b=ZmLXI+hAjUiLBJDJYC6cPl/5bAyNi3UhlN2Gvj4QJoBZIzZ/ECigc1AzQR8DrKiGl92Wl8LlqM79A47H2478h2tOZVI3krKrmShQlIWJNIPeca9o69uyidpZVaAf43NhC/M2pHB1DHJcwjAb/x+V+4HfJRUKG9yfDLpLDzB/pso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412374; c=relaxed/simple;
	bh=UwI+Cdu95xw7189cHxLlZV4U0zTuoK2xL14taEPWzCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C0w4j3E1FR5htv/TP2ladGu75jqteJztoVHphF8dcbY6b8JB6fxOcVaFcUF1vistL6dsYDQbXD2IOVXXpHuQGTJbTA/MMcSW2nfTtDazP/YVSiH+H0I3HyhhDaj9d0DKH2y+ZIWnzSwfGpnF1YwbF5QPq/TK3bsTDFUX5/aPcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChxNjzdu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O4US0ZXd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Jul 2024 18:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721412371;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CQVwyAZeppAZDNu3ca37xWiY0N54K2rwFDLLcnb1l8=;
	b=ChxNjzduMqXF0MpDDonmnRTQL7OH+p7k//RI32yemmdvJlLhc2L3lXNKAbchswYSJo7Vsh
	mDAIogKy/wx/2ep/roTczzOho+1kqBPoa5qKMp8hFqyo9nhbkkRnEFEj92CEwZGDuPyWHB
	2yHXL7A8o7oqkUUGeypFP98ddbK+s6XsbDWFsA8dpR/+Ad1Q4NIEzPLaD+E/7l1B2nOIxJ
	UmB7GEAuMDshNwE8gHo5gtqy2LAlOM5XdVNGhzgMk7+qHAyhqjTxWyToAuQiCULTxRz+h0
	07+PknUfRpR801Fxgp95hy25mw1Bw4OYzycr5nBOw18aNqJZJyogq1FeNWw44w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721412371;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CQVwyAZeppAZDNu3ca37xWiY0N54K2rwFDLLcnb1l8=;
	b=O4US0ZXdWGKfZOzkEq76SEYSVqWjbgDTLKYKkfbkcORGIHeFJFmuRNk+trM+Lh+c3eTT5b
	Fi7W0Fq3uBT1l5Bg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Fix grammar in comment
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-tmigr-fixes-v4-8-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-8-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172141237098.2215.5533738947961326240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     bfb05c7ccd03d2838342d23bbcd587f203a98b88
Gitweb:        https://git.kernel.org/tip/bfb05c7ccd03d2838342d23bbcd587f203a98b88
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Jul 2024 19:58:02 +02:00

timers/migration: Fix grammar in comment

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-8-757baa7803fe@linutronix.de

---
 kernel/time/timer_migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 9b80e8a..fae0495 100644
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

