Return-Path: <linux-tip-commits+bounces-1740-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0389893944F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FBC1C218D0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0516E171074;
	Mon, 22 Jul 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJlDRPXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zx8xqXhn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67358200A3;
	Mon, 22 Jul 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676921; cv=none; b=HaZVQO77L95dyGsUjpR5CunSi7O5WRAiy7+RTE2nIQ4nJe9rtTKJpzmLkk3kaQV2Uq/jMZG/dWM1bYaBMmUj7ljE0VE/dx5uDQKfU0p+078T7Lajm5Uxa4AC8dAT1UCDX5b+X4P565kROEh8idajpaVxND+3YhJFFjMRnxAoGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676921; c=relaxed/simple;
	bh=X5WwcJBGJZXDBmGuRpw/Dh7nj39OVCD7V9HdUQaAMnM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TRrzHJFocqs8eJZAuQzBmwAPAPdCs66CBGq872EWmif63CvPJyQMIFLME8oiVJn7jevfLyxka/fdI18xa3RnyjRqEUIV+feWqw+ks/QwPBJzqXPKWJK6Ki/aAJyovgeEil+/977czgZUn6SvKcUJVExIYeT9e/Sg+2bgC0mszuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJlDRPXw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zx8xqXhn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jul 2024 19:35:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721676918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAKdQixtGqCuyvCEGHDgYk8NVUGS8bFYBPocywZq70M=;
	b=qJlDRPXw/tMeaxbM64hsz7iF4ymfacz5UDZQCq/E1cJnXAjn0K8um+h2TigdXY+sZcZaI0
	7xcAYrZbVwrkpicK6iv/wBnBI4RmTmwVV7SWHzBnAFSgifjfkhyQIeF3RRojCmGtpFvTnZ
	gmOHM2EWom2pT0FggfVAcf0fZmWnisFwWkZET3bEL5SBq9fFJL3Npv/cNvGvnNZhBvbhyb
	pNz34n2njQbvyxApEro5u/1QOdHROtKwQFzdoyEsm6CFd7tPd9iNAxjlR0zZ5UBC/FlwmE
	7JJ/eHxYbrtW3kq34DGEKTboGr+a4jUg34eMM2OzBEcdKlkfC+5M71kDQ/3/Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721676918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAKdQixtGqCuyvCEGHDgYk8NVUGS8bFYBPocywZq70M=;
	b=zx8xqXhnhLy/x2ylbC2fD5/pTME37JhnRSi7V9F1WIXSRPXzcP17e8TiPGQpuBM0LvcR7Z
	7cC3ADxc73RsfnAQ==
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
Message-ID: <172167691792.2215.3079215938469586868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f004bf9de057004f7ccea4239317aec2fbd8240b
Gitweb:        https://git.kernel.org/tip/f004bf9de057004f7ccea4239317aec2fbd8240b
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 Jul 2024 18:03:34 +02:00

timers/migration: Fix grammar in comment

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-8-757baa7803fe@linutronix.de

---
 kernel/time/timer_migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 9c15ae8..8d57f76 100644
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

