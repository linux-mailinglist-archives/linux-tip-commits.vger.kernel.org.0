Return-Path: <linux-tip-commits+bounces-1428-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F005890B57E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FE61F23818
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FED81474B1;
	Mon, 17 Jun 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lHhMLLrn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/cmoQFvW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754613AD07;
	Mon, 17 Jun 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639244; cv=none; b=FrYJlKaadeDW+evbBnodMlc8088POvtH7ubKxS9gj8Al8knLh2/xUWCV9S7PHg4i68jOeVgYUitF5zDpHe4r1psJ2EQGt0GwmRM4O3x3J6y8fx4tsO0bhz9E9ERPafEXf4rsz8e2NH6y4SisxdS4P1MEGKDslM4gruiImOYZedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639244; c=relaxed/simple;
	bh=7z0wwXXRe7hyED1N1JH6waPt1Rwtuta3hOB9uIpqEz8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KFHR5VEUoB1vopnt0vMkb5RcRfW+kVvn2w6sF6zyboJHIDXQ3W36w2Ci/pPOP+SOvzwTmVypiaDqM7shN5jqlG9ogG9j7QC1fSzcA6v48ucfzzp2YgIYwrql14TAwqk4ib5MnsE9L1jbg/5kzbA7oPjpV236z8yi0AM5hGoA19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lHhMLLrn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/cmoQFvW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 15:47:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718639239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ugjvIQUWob18vnajV++FFgMQM2o0LA6mN+6s6J5lQ8=;
	b=lHhMLLrn63BG8O86//HFeiBQfcdWj8+kyRd/66S+p5U+j5MTuib6E3VTd/+zA2JArTl8um
	fcFKoHxa7rccx24nLqVzKsp13dM0EiGLjzdOXknm/vv7mWiOq0SejAhaVbAxHYGosoxkyj
	/LlXrETQI3985hlP3ga8SmQYxG0WiaAZtuSlQGJwx24pj4fVrGKIN3qaA1pCOyWn1wCWvp
	W0ODLCV9P98KnGfBHyE/yEXKf+eDGJi2B3VpOyy5MJS+Try77edtpla2WzMvt3gZ/29SaS
	3Hz1dwH148FNcYtrVrJNrgfpuX6UMFTSnEL0TjO4yhbYcAlZaz37d0VOfnTt+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718639239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ugjvIQUWob18vnajV++FFgMQM2o0LA6mN+6s6J5lQ8=;
	b=/cmoQFvWFtFZDYU0gcce+IbiINjBWlgOmDhrhwRLtEKPnqvoOZnQEIGATQOCaxqe6WQ3QD
	YOgI60ENbmmKjcCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: Clarify condition in
 static_key_fast_inc_not_disabled()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610124406.484973160@linutronix.de>
References: <20240610124406.484973160@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863923877.10875.962381023770157856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     695ef796467ed228b60f1915995e390aea3d85c6
Gitweb:        https://git.kernel.org/tip/695ef796467ed228b60f1915995e390aea3d85c6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 14:46:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Jun 2024 11:25:23 +02:00

jump_label: Clarify condition in static_key_fast_inc_not_disabled()

The second part of

      if (v <= 0 || (v + 1) < 0)

is not immediately obvious that it acts as overflow protection.

Check explicitely for v == INT_MAX instead and add a proper comment how
this is used at the call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240610124406.484973160@linutronix.de
---
 kernel/jump_label.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 1f05a19..4d06ec2 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -132,12 +132,15 @@ bool static_key_fast_inc_not_disabled(struct static_key *key)
 	/*
 	 * Negative key->enabled has a special meaning: it sends
 	 * static_key_slow_inc/dec() down the slow path, and it is non-zero
-	 * so it counts as "enabled" in jump_label_update().  Note that
-	 * atomic_inc_unless_negative() checks >= 0, so roll our own.
+	 * so it counts as "enabled" in jump_label_update().
+	 *
+	 * The INT_MAX overflow condition is either used by the networking
+	 * code to reset or detected in the slow path of
+	 * static_key_slow_inc_cpuslocked().
 	 */
 	v = atomic_read(&key->enabled);
 	do {
-		if (v <= 0 || (v + 1) < 0)
+		if (v <= 0 || v == INT_MAX)
 			return false;
 	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v + 1)));
 

