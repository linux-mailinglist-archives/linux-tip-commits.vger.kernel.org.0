Return-Path: <linux-tip-commits+bounces-2187-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBBE96F71B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 16:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29188286B22
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DF1D1F53;
	Fri,  6 Sep 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBgqdSZv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZLYFSjR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6571CF7AD;
	Fri,  6 Sep 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633680; cv=none; b=pRfIGJrdMKsDIjMeKeTazM6VHrAlfc4+pRkcgptb+NobkJw7EODi3P3syyUbYTGrqJJ/l3aZBYgWYEKPO/muCIvybhJvID9da1AmtEe8EeRb+YVruPdMZN2bWFBZYdI6Z3jMc/FMQk6b/vc6Om95e6m6K/ANpd2E0Z4MTM+e3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633680; c=relaxed/simple;
	bh=I2IXo5JX1nWdW3wWP3S67WH7TTkyf2dJ/xESNHbRH6k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=geglBAJod82O9fEEC/mO5jIgLYW2UdV1m66WAGFgVKcz+cyzSm77CHRVLyzzhNjrXpEe89SExUcaBF0PycVoF50yIyqKHuRPpJTWYGPxrAAuTyW+DwmyXjXLXwM6rUYm1pQ047HFvz0L9d8X+yYf3Q0KpUGbsPI9Y+zkUKGtE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBgqdSZv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZLYFSjR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 14:41:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725633676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvyospQqq5eWFG8TSwaFyeRVmw6xXYtnyMrZa7OM9co=;
	b=VBgqdSZvaCVG/MctE0PzhWMXG/Gu6CeMzMnkcFg1tPrJi/wYO9kydABitah8HzWAc16HsO
	c6DOQQdpvxhqpCmBkEOBd9ZpoQEqR2DOVnhdiyuCb/NylXbmcBbeEXVZ1wAAeykPwYa5CS
	6ZDa+JxruKJx8Qf8Tb8Xd+PHlPIjOlfIrrzD0g0wnoWfYaNFfjQ4kX3TkaiK+051nSZbq3
	PN+R8I4unNYBjxWQQqXa3s/uToHvGE9fOixBi3RlKSVrdj9/MxJmzsoMr1AaHfOEm0qNJ0
	IT2BZpTNJ05uxOI5f7WeBVt3TeAiio/gtLNr5Y+iGP7f0lPvmNS8mbsUhZ9YxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725633676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvyospQqq5eWFG8TSwaFyeRVmw6xXYtnyMrZa7OM9co=;
	b=rZLYFSjR7jx3iSzjxkgVxq3wMgLY/l7Dq7b8/2jvjDVzdAvdye0z5OUXbaETmBsVei9AuI
	2ehCUlra9Mnyr0BA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Replace pointless WARN_ON() in
 static_call_module_notify()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <8734mf7pmb.ffs@tglx>
References: <8734mf7pmb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172563367589.2215.12031127456853986653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     fe513c2ef0a172a58f158e2e70465c4317f0a9a2
Gitweb:        https://git.kernel.org/tip/fe513c2ef0a172a58f158e2e70465c4317f0a9a2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 11:08:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Sep 2024 16:29:22 +02:00

static_call: Replace pointless WARN_ON() in static_call_module_notify()

static_call_module_notify() triggers a WARN_ON(), when memory allocation
fails in __static_call_add_module().

That's not really justified, because the failure case must be correctly
handled by the well known call chain and the error code is passed
through to the initiating userspace application.

A memory allocation fail is not a fatal problem, but the WARN_ON() takes
the machine out when panic_on_warn is set.

Replace it with a pr_warn().

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8734mf7pmb.ffs@tglx
---
 kernel/static_call_inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 7bb0962..5259cda 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -453,7 +453,7 @@ static int static_call_module_notify(struct notifier_block *nb,
 	case MODULE_STATE_COMING:
 		ret = static_call_add_module(mod);
 		if (ret) {
-			WARN(1, "Failed to allocate memory for static calls");
+			pr_warn("Failed to allocate memory for static calls\n");
 			static_call_del_module(mod);
 		}
 		break;

