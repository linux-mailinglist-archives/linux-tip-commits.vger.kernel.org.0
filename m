Return-Path: <linux-tip-commits+bounces-3487-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B66A398F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D8D1881FB3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F1248191;
	Tue, 18 Feb 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zjLZn/y1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cn+EX5FV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418D246350;
	Tue, 18 Feb 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874402; cv=none; b=payInJCBSSZKHvRc2qBD+WdKx8i9z0z60BAfjwwjXps20WlYwyL3lTCdWJtP0hDvWeycJuzgxQx6OTgfnoYy0xxWM3feJT1r2ULdrFN1128c0dWa2tsbZTMigQu9tC/75Aak9e2M/tSmFPkK4Dql2erJwnymIbUsHjwDq5FdfgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874402; c=relaxed/simple;
	bh=jtF4CZeil98ddzTUvhzlLtSy1H8cLzoCGESyR6Vv5Bo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RF1BojW5IKdNzz7QnMrX5NSKzAEDug4uKfD3mR9/RNgJx+YWL9bwXfnInselI5P6bIdBZQuFr/jPCOI6ewnxZKAqeDMAgsNnbGxqOqWWvPz4EIt1k0F1kcjLCXGxjH4bWUU9AOkzDPk1K9xVxh64/laNU6kwLnLBDIQiaNfY1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zjLZn/y1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cn+EX5FV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjTpZ8v5Tu24N/cbHZX45Zg49+jB8OoBIBGDm/dD1/I=;
	b=zjLZn/y1SNvkPcJn8ut43oymIPYgRoGb1csDSbLMy0pfHzTpKtZlfHcJyPWDN6xq9pppoL
	ZnzZN9OAedSW/0xK2mIg8L0+ALj4nUCNKn5K3D2l5i+FQQ/5u0WNTFu8hRSVCC0+uGt+52
	tIKUGQnNZa+XTRmLhXTKn/VR8qjgEeHWD0IC5FGO2wv+ovXLsrhITRC94mbghsANcMHZR/
	CxIfuBEC8fzpHBkFKyczllCICeCrobSIINP40lXdIvqD7bes357H3hF6TPvaRgXQZzGy17
	QyUG7IRp3CHyCxCaYzNTzPAu8oaO3TyFwWbHpElacT4rLi+Gzmu/Px/6B2iBOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjTpZ8v5Tu24N/cbHZX45Zg49+jB8OoBIBGDm/dD1/I=;
	b=Cn+EX5FVBXrjqpoSWrgo8eEglGZalx4Z4s/JFuOW7emuxVG6/9lLcQKYDKbXFSeh3pw4VB
	CUR2uQogzdYoH/Ag==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] pps: generators: pps_gen_parport: Switch to
 use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4bf3bb22e21f27c58bb28690d856df913431e693=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4bf3bb22e21f27c58bb28690d856df913431e693=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439899.10177.14766014245613260748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     5e55888e340a5209f8b3dba4d937c48c143719d1
Gitweb:        https://git.kernel.org/tip/5e55888e340a5209f8b3dba4d937c48c143719d1
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:03 +01:00

pps: generators: pps_gen_parport: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/4bf3bb22e21f27c58bb28690d856df913431e693.1738746904.git.namcao@linutronix.de

---
 drivers/pps/generators/pps_gen_parport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
index d46eed1..f5eeb4d 100644
--- a/drivers/pps/generators/pps_gen_parport.c
+++ b/drivers/pps/generators/pps_gen_parport.c
@@ -208,8 +208,7 @@ static void parport_attach(struct parport *port)
 
 	calibrate_port(&device);
 
-	hrtimer_init(&device.timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	device.timer.function = hrtimer_event;
+	hrtimer_setup(&device.timer, hrtimer_event, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	hrtimer_start(&device.timer, next_intr_time(&device), HRTIMER_MODE_ABS);
 
 	return;

