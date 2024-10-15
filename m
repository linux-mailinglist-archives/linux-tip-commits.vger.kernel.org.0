Return-Path: <linux-tip-commits+bounces-2467-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA50B99FB98
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A325287760
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1741FF029;
	Tue, 15 Oct 2024 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x5VJ15Wv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7hkE1xB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D581FDFA0;
	Tue, 15 Oct 2024 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032092; cv=none; b=KQ/cjyDdX2CZuT5nSWgQwC27UGuD9m6V1Yjd0ny9JwnGARmIQUJIMjL5WGwMz35sfwA8uKkaVO5FkTw/58PwZUeRnE5iD3iGq80b135mmAUkE5Ono3brcRoByORa/PL6fZnLkpMpSHJmOK33rGkSzHSzVDYmxvZ5sg6H7/Kqz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032092; c=relaxed/simple;
	bh=oi45r7RDbVvy950VjEOBHhsGuAIpNfnKGbGEhC59dRI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m8PjgKE8CSu/tbn2AR8FVSDt5SleOmHc1c/xGQ4O+xFkdk6EqpHO4Th2L4n7PIEVBlP/gmNpKXUXqbMa9XQFb6ury7yr+F4Dbl6M6v7D6T7VjLpGaknonC3ZkV9qpf4O7j5xyuGFpnN2thoGWaFAQ9iwuIzhc75xpkAvX7TkNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x5VJ15Wv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7hkE1xB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuyNZDzGrSrfg+Y8beCknm2ldT7YVd1H0qcwLg+VycY=;
	b=x5VJ15WvJx3+1J9mRyCrxVFCJEATuxZuWO5DeJ8Hoyf2na8JaAdhys92p0Me5/7M1rJ7MA
	Il1myulzMslYu8bQhlDq60HJBoEqOpwyJ9UJxCoMcTilkV86m4akJy4WJFYlYnYdm9Wk8s
	9CEtn0RW5i51mutiKuBsBsUgnZ4FAzrp0a65cHUw3+F9/YfG/8reaxzCxr3kOVl7TfvXPf
	OGYpGPgTEX05ppqX3hjyl0n88LXzFTZjEk8SoLhYhmRJwkIFleeP5lwG/tI+4Ghs9l4LiE
	YK0V17TLYCnSs6Lta3m9EvVr4bmCG0Olcgpsi9tET315wIh8yOs8cqheFKr2jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuyNZDzGrSrfg+Y8beCknm2ldT7YVd1H0qcwLg+VycY=;
	b=Z7hkE1xBAjHylP0S7elMkDi3o860H+Tbx01nXN5RTEnmao3e2fxhDDP4vwt+urzXQCrPVk
	2GV9LXX787ZKQ4Ag==
From: "tip-bot2 for Wang Jinchao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Remove '%' from numeric constant in
 kernel-doc comment
Cc: Wang Jinchao <wangjinchao@xfusion.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009022135.92400-2-wangjinchao@xfusion.com>
References: <20241009022135.92400-2-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208822.1442.229181676984989871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a849881a9e5426cb4fa00660529bc501718ef85b
Gitweb:        https://git.kernel.org/tip/a849881a9e5426cb4fa00660529bc501718ef85b
Author:        Wang Jinchao <wangjinchao@xfusion.com>
AuthorDate:    Wed, 09 Oct 2024 10:21:35 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:30:26 +02:00

time: Remove '%' from numeric constant in kernel-doc comment

Change %0 to 0 in kernel-doc comments. %0 is not valid.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241009022135.92400-2-wangjinchao@xfusion.com

---
 kernel/time/time.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 642647f..5984d4a 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -866,7 +866,7 @@ struct timespec64 timespec64_add_safe(const struct timespec64 lhs,
  *
  * Handles compat or 32-bit modes.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_timespec64(struct timespec64 *ts,
 		   const struct __kernel_timespec __user *uts)
@@ -897,7 +897,7 @@ EXPORT_SYMBOL_GPL(get_timespec64);
  * @ts: input &struct timespec64
  * @uts: user's &struct __kernel_timespec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_timespec64(const struct timespec64 *ts,
 		   struct __kernel_timespec __user *uts)
@@ -944,7 +944,7 @@ static int __put_old_timespec32(const struct timespec64 *ts64,
  *
  * Handles X86_X32_ABI compatibility conversion.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_old_timespec32(struct timespec64 *ts, const void __user *uts)
 {
@@ -963,7 +963,7 @@ EXPORT_SYMBOL_GPL(get_old_timespec32);
  *
  * Handles X86_X32_ABI compatibility conversion.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_old_timespec32(const struct timespec64 *ts, void __user *uts)
 {
@@ -979,7 +979,7 @@ EXPORT_SYMBOL_GPL(put_old_timespec32);
  * @it: destination &struct itimerspec64
  * @uit: user's &struct __kernel_itimerspec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct __kernel_itimerspec __user *uit)
@@ -1002,7 +1002,7 @@ EXPORT_SYMBOL_GPL(get_itimerspec64);
  * @it: input &struct itimerspec64
  * @uit: user's &struct __kernel_itimerspec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_itimerspec64(const struct itimerspec64 *it,
 			struct __kernel_itimerspec __user *uit)
@@ -1024,7 +1024,7 @@ EXPORT_SYMBOL_GPL(put_itimerspec64);
  * @its: destination &struct itimerspec64
  * @uits: user's &struct old_itimerspec32
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_old_itimerspec32(struct itimerspec64 *its,
 			const struct old_itimerspec32 __user *uits)
@@ -1043,7 +1043,7 @@ EXPORT_SYMBOL_GPL(get_old_itimerspec32);
  * @its: input &struct itimerspec64
  * @uits: user's &struct old_itimerspec32
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_old_itimerspec32(const struct itimerspec64 *its,
 			struct old_itimerspec32 __user *uits)

